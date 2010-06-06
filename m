From: sundar.iyer@stericsson.com (Sundar R Iyer)
Date: Sun, 6 Jun 2010 19:12:12 +0530
Subject: [PATCH v3 1/2] regulator: add support for regulators on the ab8500 MFD
Message-ID: <mailman.74.1279037956.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Bengt JONSSON <bengt.g.jonsson@stericsson.com>
Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>
---
CHANGELOG

v2 -> v3
 - replaced dev_dbg calls with dev_err.

v1 -> v2
 - Fixed comments from Mark

 drivers/regulator/Kconfig  |    8 +
 drivers/regulator/Makefile |    1 +
 drivers/regulator/ab8500.c |  427 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 436 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/ab8500.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7cd8a29..6c14afd 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -221,5 +221,13 @@ config REGULATOR_AD5398
 	help
 	  This driver supports AD5398 and AD5821 current regulator chips.
 	  If building into module, its name is ad5398.ko.
+
+config REGULATOR_AB8500
+	bool "ST-Ericsson AB8500 Power Regulators"
+	depends on AB8500_CORE
+	help
+	  This driver supports the regulators found on the ST-Ericsson mixed
+	  signal AB8500 PMIC
+
 endif
 
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 74a4638..fc696c5 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_REGULATOR_TPS65023) += tps65023-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6507X) += tps6507x-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
+obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500.o
 
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
new file mode 100644
index 0000000..dc3f1a4
--- /dev/null
+++ b/drivers/regulator/ab8500.c
@@ -0,0 +1,427 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
+ *
+ * AB8500 peripheral regulators
+ *
+ * AB8500 supports the following regulators,
+ * LDOs - VAUDIO, VANAMIC2/2, VDIGMIC, VINTCORE12, VTVOUT,
+ *        VAUX1/2/3, VANA
+ *
+ * for DB8500 cut 1.0 and previous versions of the silicon, all accesses
+ * to registers are through the DB8500 SPI. In cut 1.1 onwards, these
+ * accesses are through the DB8500 PRCMU I2C
+ *
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/ab8500.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/ab8500.h>
+
+/**
+ * struct ab8500_regulator_info - ab8500 regulator information
+ * @desc: regulator description
+ * @ab8500: ab8500 parent
+ * @regulator_dev: regulator device
+ * @max_uV: maximum voltage (for variable voltage supplies)
+ * @min_uV: minimum voltage (for variable voltage supplies)
+ * @fixed_uV: typical voltage (for fixed voltage supplies)
+ * @update_reg: register to control on/off
+ * @mask: mask to enable/disable regulator
+ * @enable: bits to enable the regulator in normal(high power) mode
+ * @voltage_reg: register to control regulator voltage
+ * @voltage_mask: mask to control regulator voltage
+ * @supported_voltages: supported voltage table
+ * @voltages_len: number of supported voltages for the regulator
+ */
+struct ab8500_regulator_info {
+	struct device		*dev;
+	struct regulator_desc	desc;
+	struct ab8500		*ab8500;
+	struct regulator_dev	*regulator;
+	int max_uV;
+	int min_uV;
+	int fixed_uV;
+	int update_reg;
+	int mask;
+	int enable;
+	int voltage_reg;
+	int voltage_mask;
+	int const *supported_voltages;
+	int voltages_len;
+};
+
+/* voltage tables for the vauxn/vintcore supplies */
+static const int ldo_vauxn_voltages[] = {
+	1100000,
+	1200000,
+	1300000,
+	1400000,
+	1500000,
+	1800000,
+	1850000,
+	1900000,
+	2500000,
+	2650000,
+	2700000,
+	2750000,
+	2800000,
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int ldo_vintcore_voltages[] = {
+	1200000,
+	1225000,
+	1250000,
+	1275000,
+	1300000,
+	1325000,
+	1350000,
+};
+
+static int ab8500_regulator_enable(struct regulator_dev *rdev)
+{
+	int regulator_id, ret;
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	regulator_id = rdev_get_id(rdev);
+	if (regulator_id >= AB8500_NUM_REGULATORS)
+		return -EINVAL;
+
+	ret = ab8500_set_bits(info->ab8500, info->update_reg,
+			info->mask, info->enable);
+	if (ret < 0)
+		dev_err(rdev_get_dev(rdev),
+			"couldn't set enable bits for regulator\n");
+	return ret;
+}
+
+static int ab8500_regulator_disable(struct regulator_dev *rdev)
+{
+	int regulator_id, ret;
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	regulator_id = rdev_get_id(rdev);
+	if (regulator_id >= AB8500_NUM_REGULATORS)
+		return -EINVAL;
+
+	ret = ab8500_set_bits(info->ab8500, info->update_reg,
+			info->mask, 0x0);
+	if (ret < 0)
+		dev_err(rdev_get_dev(rdev),
+			"couldn't set disable bits for regulator\n");
+	return ret;
+}
+
+static int ab8500_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	int regulator_id, ret;
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	regulator_id = rdev_get_id(rdev);
+	if (regulator_id >= AB8500_NUM_REGULATORS)
+		return -EINVAL;
+
+	ret = ab8500_read(info->ab8500, info->update_reg);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev),
+			"couldn't read 0x%x register\n", info->update_reg);
+		return ret;
+	}
+
+	if (ret & info->mask)
+		return true;
+	else
+		return false;
+}
+
+static int ab8500_list_voltage(struct regulator_dev *rdev, unsigned selector)
+{
+	int regulator_id;
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	regulator_id = rdev_get_id(rdev);
+	if (regulator_id >= AB8500_NUM_REGULATORS)
+		return -EINVAL;
+
+	/* return the uV for the fixed regulators */
+	if (info->fixed_uV)
+		return info->fixed_uV;
+
+	if (selector > info->voltages_len)
+		return -EINVAL;
+
+	return info->supported_voltages[selector];
+}
+
+static int ab8500_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	int regulator_id, ret, val;
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	regulator_id = rdev_get_id(rdev);
+	if (regulator_id >= AB8500_NUM_REGULATORS)
+		return -EINVAL;
+
+	ret = ab8500_read(info->ab8500, info->voltage_reg);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev),
+			"couldn't read voltage reg for regulator\n");
+		return ret;
+	}
+
+	/* vintcore has a different layout */
+	val = ret & info->voltage_mask;
+	if (regulator_id == AB8500_LDO_INTCORE)
+		ret = info->supported_voltages[val >> 0x3];
+	else
+		ret = info->supported_voltages[val];
+
+	return ret;
+}
+
+static int ab8500_get_best_voltage_index(struct regulator_dev *rdev,
+		int min_uV, int max_uV)
+{
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+	int i;
+
+	/* check the supported voltage */
+	for (i = 0; i < info->voltages_len; i++) {
+		if ((info->supported_voltages[i] >= min_uV) &&
+		    (info->supported_voltages[i] <= max_uV))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ab8500_regulator_set_voltage(struct regulator_dev *rdev,
+		int min_uV, int max_uV)
+{
+	int regulator_id, ret;
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	regulator_id = rdev_get_id(rdev);
+	if (regulator_id >= AB8500_NUM_REGULATORS)
+		return -EINVAL;
+
+	/* get the appropriate voltages within the range */
+	ret = ab8500_get_best_voltage_index(rdev, min_uV, max_uV);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev),
+				"couldn't get best voltage for regulator\n");
+		return ret;
+	}
+
+	/* set the registers for the request */
+	ret = ab8500_set_bits(info->ab8500, info->voltage_reg,
+				info->voltage_mask, ret);
+	if (ret < 0)
+		dev_err(rdev_get_dev(rdev),
+		"couldn't set voltage reg for regulator\n");
+
+	return ret;
+}
+
+static struct regulator_ops ab8500_regulator_ops = {
+	.enable		= ab8500_regulator_enable,
+	.disable	= ab8500_regulator_disable,
+	.is_enabled	= ab8500_regulator_is_enabled,
+	.get_voltage	= ab8500_regulator_get_voltage,
+	.set_voltage	= ab8500_regulator_set_voltage,
+	.list_voltage	= ab8500_list_voltage,
+};
+
+static int ab8500_fixed_get_voltage(struct regulator_dev *rdev)
+{
+	int regulator_id;
+	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	regulator_id = rdev_get_id(rdev);
+	if (regulator_id >= AB8500_NUM_REGULATORS)
+		return -EINVAL;
+
+	return info->fixed_uV;
+}
+
+static struct regulator_ops ab8500_ldo_fixed_ops = {
+	.enable		= ab8500_regulator_enable,
+	.disable	= ab8500_regulator_disable,
+	.is_enabled	= ab8500_regulator_is_enabled,
+	.get_voltage	= ab8500_fixed_get_voltage,
+	.list_voltage	= ab8500_list_voltage,
+};
+
+#define AB8500_LDO(_id, min, max, reg, reg_mask, reg_enable,	\
+		volt_reg, volt_mask, voltages,			\
+			len_volts)				\
+{								\
+	.desc	= {						\
+		.name	= "LDO-" #_id,				\
+		.ops	= &ab8500_regulator_ops,		\
+		.type	= REGULATOR_VOLTAGE,			\
+		.id	= AB8500_LDO_##_id,			\
+		.owner	= THIS_MODULE,				\
+	},							\
+	.min_uV		= (min) * 1000,				\
+	.max_uV		= (max) * 1000,				\
+	.update_reg	= reg,					\
+	.mask		= reg_mask,				\
+	.enable		= reg_enable,				\
+	.voltage_reg	= volt_reg,				\
+	.voltage_mask	= volt_mask,				\
+	.supported_voltages = voltages,				\
+	.voltages_len	= len_volts,				\
+	.fixed_uV	= 0,					\
+}
+
+#define AB8500_FIXED_LDO(_id, fixed, reg, reg_mask,	\
+				reg_enable)		\
+{							\
+	.desc	= {					\
+		.name	= "LDO-" #_id,			\
+		.ops	= &ab8500_ldo_fixed_ops,	\
+		.type	= REGULATOR_VOLTAGE,		\
+		.id	= AB8500_LDO_##_id,		\
+		.owner	= THIS_MODULE,			\
+	},						\
+	.fixed_uV	= fixed * 1000,			\
+	.update_reg	= reg,				\
+	.mask		= reg_mask,			\
+	.enable		= reg_enable,			\
+}
+
+static struct ab8500_regulator_info ab8500_regulator_info[] = {
+	/*
+	 * Variable Voltage LDOs
+	 * name, min uV, max uV, ctrl reg, reg mask, enable mask,
+	 *	volt ctrl reg, volt ctrl mask, volt table, num supported volts
+	 */
+	AB8500_LDO(AUX1, 1100, 3300, 0x0409, 0x3, 0x1, 0x041f, 0xf,
+			ldo_vauxn_voltages, ARRAY_SIZE(ldo_vauxn_voltages)),
+	AB8500_LDO(AUX2, 1100, 3300, 0x0409, 0xc, 0x4, 0x0420, 0xf,
+			ldo_vauxn_voltages, ARRAY_SIZE(ldo_vauxn_voltages)),
+	AB8500_LDO(AUX3, 1100, 3300, 0x040a, 0x3, 0x1, 0x0421, 0xf,
+			ldo_vauxn_voltages, ARRAY_SIZE(ldo_vauxn_voltages)),
+	AB8500_LDO(INTCORE, 1100, 3300, 0x0380, 0x4, 0x4, 0x0380, 0x38,
+		ldo_vintcore_voltages, ARRAY_SIZE(ldo_vintcore_voltages)),
+
+	/*
+	 * Fixed Voltage LDOs
+	 *		 name,	o/p uV, ctrl reg, enable, disable
+	 */
+	AB8500_FIXED_LDO(TVOUT,	  2000,   0x0380,   0x2,    0x2),
+	AB8500_FIXED_LDO(AUDIO,   2000,   0x0383,   0x2,    0x2),
+	AB8500_FIXED_LDO(ANAMIC1, 2050,   0x0383,   0x4,    0x4),
+	AB8500_FIXED_LDO(ANAMIC2, 2050,   0x0383,   0x8,    0x8),
+	AB8500_FIXED_LDO(DMIC,    1800,   0x0383,   0x10,   0x10),
+	AB8500_FIXED_LDO(ANA,     1200,   0x0383,   0xc,    0x4),
+};
+
+static inline struct ab8500_regulator_info *find_regulator_info(int id)
+{
+	struct ab8500_regulator_info *info;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
+		info = &ab8500_regulator_info[i];
+		if (info->desc.id == id)
+			return info;
+	}
+	return NULL;
+}
+
+static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
+{
+	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
+	struct ab8500_platform_data *pdata = dev_get_platdata(ab8500->dev);
+	int i, err;
+
+	if (!ab8500) {
+		dev_err(&pdev->dev, "null mfd parent\n");
+		return -EINVAL;
+	}
+
+	/* register all regulators */
+	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
+		struct ab8500_regulator_info *info = NULL;
+
+		/* assign per-regulator data */
+		info = &ab8500_regulator_info[i];
+		info->dev = &pdev->dev;
+		info->ab8500 = ab8500;
+
+		info->regulator = regulator_register(&info->desc, &pdev->dev,
+				pdata->regulator[i], info);
+		if (IS_ERR(info->regulator)) {
+			err = PTR_ERR(info->regulator);
+			dev_err(&pdev->dev, "failed to register regulator %s\n",
+					info->desc.name);
+			/* when we fail, un-register all earlier regulators */
+			i--;
+			while (i > 0) {
+				info = &ab8500_regulator_info[i];
+				regulator_unregister(info->regulator);
+				i--;
+			}
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static __devexit int ab8500_regulator_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
+		struct ab8500_regulator_info *info = NULL;
+		info = &ab8500_regulator_info[i];
+		regulator_unregister(info->regulator);
+	}
+
+	return 0;
+}
+
+static struct platform_driver ab8500_regulator_driver = {
+	.probe = ab8500_regulator_probe,
+	.remove = __devexit_p(ab8500_regulator_remove),
+	.driver         = {
+		.name   = "ab8500-regulator",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init ab8500_regulator_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&ab8500_regulator_driver);
+	if (ret != 0)
+		pr_err("Failed to register ab8500 regulator: %d\n", ret);
+
+	return ret;
+}
+subsys_initcall(ab8500_regulator_init);
+
+static void __exit ab8500_regulator_exit(void)
+{
+	platform_driver_unregister(&ab8500_regulator_driver);
+}
+module_exit(ab8500_regulator_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Sundar Iyer <sundar.iyer@stericsson.com>");
+MODULE_DESCRIPTION("Regulator Driver for ST-Ericsson AB8500 Mixed-Sig PMIC");
+MODULE_ALIAS("platform:ab8500-regulator");
-- 
1.7.0



>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.79.1279555416.27306.linux-arm-kernel@lists.infradead.org>

of road to cover though, let's see if I can figure it out.

The way I read the code I still have to provide some
kind of dummychip on the bus in order to perform a
loopback test on a bus with no devices connected,
am I right?

Yours,
Linus Walleij


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.85.1280108246.27306.linux-arm-kernel@lists.infradead.org>

boot up time. This because it will improve the start up time of your
final kernel _and_ your boot loader as well if you use kexec.

Cheers,

/ magnus


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.92.1280216615.27306.linux-arm-kernel@lists.infradead.org>

usage scenarios better or worse. This results in higher or lower memory
fragmentation. System use cases are something that kernel or drivers are
definitely not aware, so only user space can tune this parameter to get the
best possible system behavior.

> We can always add more complex scenarios later, but for an initial version
> I'd keep it simple.
> 
> > +
> > +    2. CMA allows a run-time configuration of the memory regions it
> > +       will use to allocate chunks of memory from.  The set of memory
> > +       regions is given on command line so it can be easily changed
> > +       without the need for recompiling the kernel.
> > +
> > +       Each region has it's own size, alignment demand, a start
> > +       address (physical address where it should be placed) and an
> > +       allocator algorithm assigned to the region.
> > +
> > +       This means that there can be different algorithms running at
> > +       the same time, if different devices on the platform have
> > +       distinct memory usage characteristics and different algorithm
> > +       match those the best way.
> 
> Seems overengineering to me. Just ensure that the code can be extended
> later to such hypothetical scenarios. They are hypothetical, right?

Not really. Having the possibility to reconfigure memory configuration
without kernel recompilation is very handy when one is tuning the
configuration for the specific use case.

> > +    3. When requesting memory, devices have to introduce themselves.
> > +       This way CMA knows who the memory is allocated for.  This
> > +       allows for the system architect to specify which memory regions
> > +       each device should use.
> > +
> > +       3a. Devices can also specify a "kind" of memory they want.
> > +           This makes it possible to configure the system in such
> > +           a way, that a single device may get memory from different
> > +           memory regions, depending on the "kind" of memory it
> > +           requested.  For example, a video codec driver might want to
> > +           allocate some shared buffers from the first memory bank and
> > +           the other from the second to get the highest possible
> > +           memory throughput.
> 
> Not sure I understand this. Isn't this just two regions, one for each
> memory bank,
> and the driver requests some buffers from one region and some from the
> other?

Right.

> Not sure how a 'kind of memory' features in this.

This 'kind' is a just cookie or a label used by the driver to distinguish
requests for both memory banks. This functionality is essential for our
hardware (just for hardware video codec we have 3 'kinds' of memory: memory
bank A, memory bank B and special region for the firmware).

> > +    4. For greater flexibility and extensibility, the framework allows
> > +       device drivers to register private regions of reserved memory
> > +       which then may be used only by them.
> > +
> > +       As an effect, if a driver would not use the rest of the CMA
> > +       interface, it can still use CMA allocators and other
> > +       mechanisms.
> 
> Why would you? Is there an actual driver that will need this?

This feature has been added after posting v1 of this rfc/patch. Jonathan 
Corbet suggested in <http://article.gmane.org/gmane.linux.kernel.mm/50689> 
that viafb driver might register its own private memory and use cma just
as an allocator. IMHO this is a good idea, this way we might remove a bunch
of custom allocators from the drivers (yes, there are such all over the
kernel).

> > +       4a. Early in boot process, device drivers can also request the
> > +           CMA framework to a reserve a region of memory for them
> > +           which then will be used as a private region.
> > +
> > +           This way, drivers do not need to directly call bootmem,
> > +           memblock or similar early allocator but merely register an
> > +           early region and the framework will handle the rest
> > +           including choosing the right early allocator.
> 
> The whole concept of private regions seems unnecessary to me.
> 
> <big snip>
> 
> It looks to me as if you tried to think of all possible hypothetical
> situations
> and write a framework for that. Of course, you may know more than I do, and
> some of these situations actually happen.

Not exactly. We tried to design a solution that would cover all requirements
for OUR (quite specific) embedded hardware. However we didn't want to tie it
only to our platform. We just generalized most of our requirements so they can
be reused for other systems.

> The basic design ideas are solid, I think. But you should get rid of all
> the fancy features and go back to basics. We can always add those features
> later should that become necessary. But removing features is much, much
harder.

Well, please keep in mind that we cannot remove features that are essential
for our solution. We know that a simple framework have some advantages
(well, the most important one is the fact that it is easy to understand),
but making it too simple would render it useless from our point of view
(if it would not provide functionality required by our drivers and hardware).

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
