From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 18 Dec 2009 09:59:49 -0500
Subject: [PATCH] mfd: add subdevs in max8925
Message-ID: <mailman.103.1261399577.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add subdevs in MAX8925. MAX8925 includes regulator, backlight and touch
components.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/Kconfig         |    1 +
 drivers/mfd/max8925-core.c  |  142 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8925.h |   96 +++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 259cabf..ac38a8e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -163,6 +163,7 @@ config PMIC_DA903X
 config MFD_MAX8925
 	tristate "Maxim Semiconductor MAX8925 PMIC Support"
 	depends on I2C
+	select MFD_CORE
 	help
 	  Say yes here to support for Maxim Semiconductor MAX8925. This is
 	  a Power Management IC. This driver provies common support for
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 34c71c8..31b237e 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -20,6 +20,109 @@
 #define IRQ_MODE_STATUS		0
 #define IRQ_MODE_MASK		1

+static struct resource backlight_resources[] = {
+	{
+		.name	= "max8925-backlight",
+		.start	= MAX8925_WLED_MODE_CNTL,
+		.end	= MAX8925_WLED_CNTL,
+		.flags	= IORESOURCE_IO,
+	},
+};
+
+static struct mfd_cell backlight_devs[] = {
+	{
+		.name		= "max8925-backlight",
+		.num_resources	= 1,
+		.resources	= &backlight_resources[0],
+		.id		= -1,
+	},
+};
+
+static struct resource touch_resources[] = {
+	{
+		.name	= "max8925-tsc",
+		.start	= MAX8925_TSC_IRQ,
+		.end	= MAX8925_ADC_RES_END,
+		.flags	= IORESOURCE_IO,
+	},
+};
+
+static struct mfd_cell touch_devs[] = {
+	{
+		.name		= "max8925-touch",
+		.num_resources	= 1,
+		.resources	= &touch_resources[0],
+		.id		= -1,
+	},
+};
+
+#define MAX8925_REG_RESOURCE(_start, _end)	\
+{						\
+	.start	= MAX8925_##_start,		\
+	.end	= MAX8925_##_end,		\
+	.flags	= IORESOURCE_IO,		\
+}
+
+static struct resource regulator_resources[] = {
+	MAX8925_REG_RESOURCE(SDCTL1, SDCTL1),
+	MAX8925_REG_RESOURCE(SDCTL2, SDCTL2),
+	MAX8925_REG_RESOURCE(SDCTL3, SDCTL3),
+	MAX8925_REG_RESOURCE(LDOCTL1, LDOCTL1),
+	MAX8925_REG_RESOURCE(LDOCTL2, LDOCTL2),
+	MAX8925_REG_RESOURCE(LDOCTL3, LDOCTL3),
+	MAX8925_REG_RESOURCE(LDOCTL4, LDOCTL4),
+	MAX8925_REG_RESOURCE(LDOCTL5, LDOCTL5),
+	MAX8925_REG_RESOURCE(LDOCTL6, LDOCTL6),
+	MAX8925_REG_RESOURCE(LDOCTL7, LDOCTL7),
+	MAX8925_REG_RESOURCE(LDOCTL8, LDOCTL8),
+	MAX8925_REG_RESOURCE(LDOCTL9, LDOCTL9),
+	MAX8925_REG_RESOURCE(LDOCTL10, LDOCTL10),
+	MAX8925_REG_RESOURCE(LDOCTL11, LDOCTL11),
+	MAX8925_REG_RESOURCE(LDOCTL12, LDOCTL12),
+	MAX8925_REG_RESOURCE(LDOCTL13, LDOCTL13),
+	MAX8925_REG_RESOURCE(LDOCTL14, LDOCTL14),
+	MAX8925_REG_RESOURCE(LDOCTL15, LDOCTL15),
+	MAX8925_REG_RESOURCE(LDOCTL16, LDOCTL16),
+	MAX8925_REG_RESOURCE(LDOCTL17, LDOCTL17),
+	MAX8925_REG_RESOURCE(LDOCTL18, LDOCTL18),
+	MAX8925_REG_RESOURCE(LDOCTL19, LDOCTL19),
+	MAX8925_REG_RESOURCE(LDOCTL20, LDOCTL20),
+};
+
+#define MAX8925_REG_DEVS(_name, _id)					\
+{									\
+	.name		= "max8925-" #_name,				\
+	.num_resources	= 1,						\
+	.resources	= &regulator_resources[MAX8925_ID_##_id],	\
+	.id		= MAX8925_ID_##_id,				\
+}
+
+static struct mfd_cell regulator_devs[] = {
+	MAX8925_REG_DEVS(sd1, SD1),
+	MAX8925_REG_DEVS(sd2, SD2),
+	MAX8925_REG_DEVS(sd3, SD3),
+	MAX8925_REG_DEVS(ldo1, LDO1),
+	MAX8925_REG_DEVS(ldo2, LDO2),
+	MAX8925_REG_DEVS(ldo3, LDO3),
+	MAX8925_REG_DEVS(ldo4, LDO4),
+	MAX8925_REG_DEVS(ldo5, LDO5),
+	MAX8925_REG_DEVS(ldo6, LDO6),
+	MAX8925_REG_DEVS(ldo7, LDO7),
+	MAX8925_REG_DEVS(ldo8, LDO8),
+	MAX8925_REG_DEVS(ldo9, LDO9),
+	MAX8925_REG_DEVS(ldo10, LDO10),
+	MAX8925_REG_DEVS(ldo11, LDO11),
+	MAX8925_REG_DEVS(ldo12, LDO12),
+	MAX8925_REG_DEVS(ldo13, LDO13),
+	MAX8925_REG_DEVS(ldo14, LDO14),
+	MAX8925_REG_DEVS(ldo15, LDO15),
+	MAX8925_REG_DEVS(ldo16, LDO16),
+	MAX8925_REG_DEVS(ldo17, LDO17),
+	MAX8925_REG_DEVS(ldo18, LDO18),
+	MAX8925_REG_DEVS(ldo19, LDO19),
+	MAX8925_REG_DEVS(ldo20, LDO20),
+};
+
 static int __get_irq_offset(struct max8925_chip *chip, int irq, int mode,
 			    int *offset, int *bit)
 {
@@ -204,6 +307,30 @@ static int __devinit device_gpm_init(struct
max8925_chip *chip,
 		goto out;
 	}
 	chip->chip_irq = i2c->irq;
+
+	ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
+			      ARRAY_SIZE(regulator_devs),
+			      &regulator_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add regulator subdev\n");
+		goto out_irq;
+	}
+
+	if (pdata && pdata->backlight) {
+		ret = mfd_add_devices(chip->dev, 0, &backlight_devs[0],
+				      ARRAY_SIZE(backlight_devs),
+				      &backlight_resources[0], 0);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to add backlight subdev\n");
+			goto out_dev;
+		}
+	}
+	return 0;
+out_dev:
+	mfd_remove_devices(chip->dev);
+out_irq:
+	if (chip->chip_irq)
+		free_irq(chip->chip_irq, chip);
 out:
 	return ret;
 }
@@ -227,6 +354,20 @@ static int __devinit device_adc_init(struct
max8925_chip *chip,
 		goto out;
 	}
 	chip->chip_irq = i2c->irq;
+
+	if (pdata && pdata->touch) {
+		ret = mfd_add_devices(chip->dev, 0, &touch_devs[0],
+				      ARRAY_SIZE(touch_devs),
+				      &touch_resources[0], 0);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to add touch subdev\n");
+			goto out_irq;
+		}
+	}
+	return 0;
+out_irq:
+	if (chip->chip_irq)
+		free_irq(chip->chip_irq, chip);
 out:
 	return ret;
 }
@@ -249,6 +390,7 @@ void max8925_device_exit(struct max8925_chip *chip)
 {
 	if (chip->chip_irq >= 0)
 		free_irq(chip->chip_irq, chip);
+	mfd_remove_devices(chip->dev);
 }

 MODULE_DESCRIPTION("PMIC Driver for Maxim MAX8925");
diff --git a/include/linux/mfd/max8925.h b/include/linux/mfd/max8925.h
index 8cc0608..7a43ef8 100644
--- a/include/linux/mfd/max8925.h
+++ b/include/linux/mfd/max8925.h
@@ -14,6 +14,33 @@

 #include <linux/interrupt.h>

+/* Unified sub device IDs for MAX8925 */
+enum {
+	MAX8925_ID_SD1,
+	MAX8925_ID_SD2,
+	MAX8925_ID_SD3,
+	MAX8925_ID_LDO1,
+	MAX8925_ID_LDO2,
+	MAX8925_ID_LDO3,
+	MAX8925_ID_LDO4,
+	MAX8925_ID_LDO5,
+	MAX8925_ID_LDO6,
+	MAX8925_ID_LDO7,
+	MAX8925_ID_LDO8,
+	MAX8925_ID_LDO9,
+	MAX8925_ID_LDO10,
+	MAX8925_ID_LDO11,
+	MAX8925_ID_LDO12,
+	MAX8925_ID_LDO13,
+	MAX8925_ID_LDO14,
+	MAX8925_ID_LDO15,
+	MAX8925_ID_LDO16,
+	MAX8925_ID_LDO17,
+	MAX8925_ID_LDO18,
+	MAX8925_ID_LDO19,
+	MAX8925_ID_LDO20,
+};
+
 /* Charger registers */
 #define MAX8925_CHG_IRQ1		(0x7e)
 #define MAX8925_CHG_IRQ2		(0x7f)
@@ -29,12 +56,65 @@
 /* Touch registers */
 #define MAX8925_TSC_IRQ			(0x00)
 #define MAX8925_TSC_IRQ_MASK		(0x01)
+#define MAX8925_ADC_RES_END		(0x6f)

 /* RTC registers */
 #define MAX8925_RTC_STATUS		(0x1a)
 #define MAX8925_RTC_IRQ			(0x1c)
 #define MAX8925_RTC_IRQ_MASK		(0x1d)

+/* WLED registers */
+#define MAX8925_WLED_MODE_CNTL		(0x84)
+#define MAX8925_WLED_CNTL		(0x85)
+
+/* MAX8925 Registers */
+#define MAX8925_SDCTL1			(0x04)
+#define MAX8925_SDCTL2			(0x07)
+#define MAX8925_SDCTL3			(0x0A)
+#define MAX8925_SDV1			(0x06)
+#define MAX8925_SDV2			(0x09)
+#define MAX8925_SDV3			(0x0C)
+#define MAX8925_LDOCTL1			(0x18)
+#define MAX8925_LDOCTL2			(0x1C)
+#define MAX8925_LDOCTL3			(0x20)
+#define MAX8925_LDOCTL4			(0x24)
+#define MAX8925_LDOCTL5			(0x28)
+#define MAX8925_LDOCTL6			(0x2C)
+#define MAX8925_LDOCTL7			(0x30)
+#define MAX8925_LDOCTL8			(0x34)
+#define MAX8925_LDOCTL9			(0x38)
+#define MAX8925_LDOCTL10		(0x3C)
+#define MAX8925_LDOCTL11		(0x40)
+#define MAX8925_LDOCTL12		(0x44)
+#define MAX8925_LDOCTL13		(0x48)
+#define MAX8925_LDOCTL14		(0x4C)
+#define MAX8925_LDOCTL15		(0x50)
+#define MAX8925_LDOCTL16		(0x10)
+#define MAX8925_LDOCTL17		(0x14)
+#define MAX8925_LDOCTL18		(0x72)
+#define MAX8925_LDOCTL19		(0x5C)
+#define MAX8925_LDOCTL20		(0x9C)
+#define MAX8925_LDOVOUT1		(0x1A)
+#define MAX8925_LDOVOUT2		(0x1E)
+#define MAX8925_LDOVOUT3		(0x22)
+#define MAX8925_LDOVOUT4		(0x26)
+#define MAX8925_LDOVOUT5		(0x2A)
+#define MAX8925_LDOVOUT6		(0x2E)
+#define MAX8925_LDOVOUT7		(0x32)
+#define MAX8925_LDOVOUT8		(0x36)
+#define MAX8925_LDOVOUT9		(0x3A)
+#define MAX8925_LDOVOUT10		(0x3E)
+#define MAX8925_LDOVOUT11		(0x42)
+#define MAX8925_LDOVOUT12		(0x46)
+#define MAX8925_LDOVOUT13		(0x4A)
+#define MAX8925_LDOVOUT14		(0x4E)
+#define MAX8925_LDOVOUT15		(0x52)
+#define MAX8925_LDOVOUT16		(0x12)
+#define MAX8925_LDOVOUT17		(0x16)
+#define MAX8925_LDOVOUT18		(0x74)
+#define MAX8925_LDOVOUT19		(0x5E)
+#define MAX8925_LDOVOUT20		(0x9E)
+
 /* bit definitions */
 #define CHG_IRQ1_MASK			(0x07)
 #define CHG_IRQ2_MASK			(0xff)
@@ -80,6 +160,8 @@ enum {
 #define MAX8925_IRQ_TSC_STICK		(0)
 #define MAX8925_IRQ_TSC_NSTICK		(1)

+#define MAX8925_MAX_REGULATOR		(23)
+
 struct max8925_irq {
 	irq_handler_t		handler;
 	void			*data;
@@ -97,7 +179,21 @@ struct max8925_chip {
 	int			chip_irq;
 };

+struct max8925_backlight_pdata {
+	int	lxw_scl;	/* 0/1 -- 0.8Ohm/0.4Ohm */
+	int	lxw_freq;	/* 700KHz ~ 1400KHz */
+	int	dual_string;	/* 0/1 -- single/dual string */
+};
+
+struct max8925_touch_pdata {
+	unsigned int		flags;
+};
+
 struct max8925_platform_data {
+	struct max8925_backlight_pdata	*backlight;
+	struct max8925_touch_pdata	*touch;
+	struct regulator_init_data	*regulator[MAX8925_MAX_REGULATOR];
+
 	int	chip_id;
 	int	chip_irq;
 };
-- 
1.5.6.5
