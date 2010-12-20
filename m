From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 20 Dec 2010 14:50:52 +1100
Subject: [PATCHv3 1/4] mc13xxx-core: Consolidate common code to prepare for
	separate i2c and spi
In-Reply-To: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1292817055-17715-2-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves common mc13xxx definitions to the header file in
preparation for separate i2c and spi driver modules.
spi specific functions are also removed.

Changes to the mc13xxx struct are:
removing the redundant irq member,
adding driver read/write function ptrs,
adding ictype

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/mc13xxx-core.c  |  207 +++++++-----------------------------------
 include/linux/mfd/mc13xxx.h |   77 +++++++++++-----
 2 files changed, 87 insertions(+), 197 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index a2ac2ed..3367a40 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -9,24 +9,14 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/interrupt.h>
-#include <linux/spi/spi.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
 
-struct mc13xxx {
-	struct spi_device *spidev;
-	struct mutex lock;
-	int irq;
-
-	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
-	void *irqdata[MC13XXX_NUM_IRQ];
-};
 
 struct mc13783 {
 	struct mc13xxx mc13xxx;
@@ -150,99 +140,53 @@ EXPORT_SYMBOL(mc13783_to_mc13xxx);
 void mc13xxx_lock(struct mc13xxx *mc13xxx)
 {
 	if (!mutex_trylock(&mc13xxx->lock)) {
-		dev_dbg(&mc13xxx->spidev->dev, "wait for %s from %pf\n",
+		dev_dbg(mc13xxx->dev, "wait for %s from %pf\n",
 				__func__, __builtin_return_address(0));
 
 		mutex_lock(&mc13xxx->lock);
 	}
-	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
+	dev_dbg(mc13xxx->dev, "%s from %pf\n",
 			__func__, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(mc13xxx_lock);
 
 void mc13xxx_unlock(struct mc13xxx *mc13xxx)
 {
-	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
+	dev_dbg(mc13xxx->dev, "%s from %pf\n",
 			__func__, __builtin_return_address(0));
 	mutex_unlock(&mc13xxx->lock);
 }
 EXPORT_SYMBOL(mc13xxx_unlock);
 
-#define MC13XXX_REGOFFSET_SHIFT 25
 int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
 {
-	struct spi_transfer t;
-	struct spi_message m;
 	int ret;
-
 	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
 
 	if (offset > MC13XXX_NUMREGS)
 		return -EINVAL;
 
-	*val = offset << MC13XXX_REGOFFSET_SHIFT;
-
-	memset(&t, 0, sizeof(t));
-
-	t.tx_buf = val;
-	t.rx_buf = val;
-	t.len = sizeof(u32);
-
-	spi_message_init(&m);
-	spi_message_add_tail(&t, &m);
-
-	ret = spi_sync(mc13xxx->spidev, &m);
-
-	/* error in message.status implies error return from spi_sync */
-	BUG_ON(!ret && m.status);
+	ret = mc13xxx->read_dev(mc13xxx, offset, val);
+	dev_vdbg(mc13xxx->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
 
-	if (ret)
-		return ret;
-
-	*val &= 0xffffff;
-
-	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(mc13xxx_reg_read);
 
+
 int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
 {
-	u32 buf;
-	struct spi_transfer t;
-	struct spi_message m;
-	int ret;
-
 	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
-
-	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] <- 0x%06x\n", offset, val);
+	dev_vdbg(mc13xxx->dev, "[0x%02x] <- 0x%06x\n", offset, val);
 
 	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
 		return -EINVAL;
 
-	buf = 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
-
-	memset(&t, 0, sizeof(t));
-
-	t.tx_buf = &buf;
-	t.rx_buf = &buf;
-	t.len = sizeof(u32);
-
-	spi_message_init(&m);
-	spi_message_add_tail(&t, &m);
-
-	ret = spi_sync(mc13xxx->spidev, &m);
-
-	BUG_ON(!ret && m.status);
-
-	if (ret)
-		return ret;
-
-	return 0;
+	return mc13xxx->write_dev(mc13xxx, offset, val);
 }
 EXPORT_SYMBOL(mc13xxx_reg_write);
 
+
 int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
 		u32 mask, u32 val)
 {
@@ -445,7 +389,7 @@ static int mc13xxx_irq_handle(struct mc13xxx *mc13xxx,
 			if (handled == IRQ_HANDLED)
 				num_handled++;
 		} else {
-			dev_err(&mc13xxx->spidev->dev,
+			dev_err(mc13xxx->dev,
 					"BUG: irq %u but no handler\n",
 					baseirq + irq);
 
@@ -481,11 +425,6 @@ static irqreturn_t mc13xxx_irq_thread(int irq, void *data)
 	return IRQ_RETVAL(handled);
 }
 
-enum mc13xxx_id {
-	MC13XXX_ID_MC13783,
-	MC13XXX_ID_MC13892,
-	MC13XXX_ID_INVALID,
-};
 
 const char *mc13xxx_chipname[] = {
 	[MC13XXX_ID_MC13783] = "mc13783",
@@ -493,13 +432,16 @@ const char *mc13xxx_chipname[] = {
 };
 
 #define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
-static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
+static int mc13xxx_identify(struct mc13xxx *mc13xxx)
 {
 	u32 icid;
 	u32 revision;
-	const char *name;
 	int ret;
 
+	/* Get the generation ID from register 46, as apparently some older
+	 * ic revisions only have this info at this location. Newer ICs seem to
+	 * have both.
+	 */
 	ret = mc13xxx_reg_read(mc13xxx, 46, &icid);
 	if (ret)
 		return ret;
@@ -508,26 +450,22 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
 
 	switch (icid) {
 	case 2:
-		*id = MC13XXX_ID_MC13783;
-		name = "mc13783";
+		mc13xxx->ictype = MC13XXX_ID_MC13783;
 		break;
 	case 7:
-		*id = MC13XXX_ID_MC13892;
-		name = "mc13892";
+		mc13xxx->ictype = MC13XXX_ID_MC13892;
 		break;
 	default:
-		*id = MC13XXX_ID_INVALID;
+		mc13xxx->ictype = MC13XXX_ID_INVALID;
 		break;
 	}
 
-	if (*id == MC13XXX_ID_MC13783 || *id == MC13XXX_ID_MC13892) {
+	if (mc13xxx->ictype == MC13XXX_ID_MC13783 ||
+			mc13xxx->ictype == MC13XXX_ID_MC13892) {
 		ret = mc13xxx_reg_read(mc13xxx, MC13XXX_REVISION, &revision);
-		if (ret)
-			return ret;
-
-		dev_info(&mc13xxx->spidev->dev, "%s: rev: %d.%d, "
+		dev_info(mc13xxx->dev, "%s: rev: %d.%d, "
 				"fin: %d, fab: %d, icid: %d/%d\n",
-				mc13xxx_chipname[*id],
+				mc13xxx_chipname[mc13xxx->ictype],
 				maskval(revision, MC13XXX_REVISION_REVFULL),
 				maskval(revision, MC13XXX_REVISION_REVMETAL),
 				maskval(revision, MC13XXX_REVISION_FIN),
@@ -536,26 +474,12 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
 				maskval(revision, MC13XXX_REVISION_ICIDCODE));
 	}
 
-	if (*id != MC13XXX_ID_INVALID) {
-		const struct spi_device_id *devid =
-			spi_get_device_id(mc13xxx->spidev);
-		if (!devid || devid->driver_data != *id)
-			dev_warn(&mc13xxx->spidev->dev, "device id doesn't "
-					"match auto detection!\n");
-	}
-
-	return 0;
+	return (mc13xxx->ictype == MC13XXX_ID_INVALID) ? -ENODEV : 0;
 }
 
 static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
 {
-	const struct spi_device_id *devid =
-		spi_get_device_id(mc13xxx->spidev);
-
-	if (!devid)
-		return NULL;
-
-	return mc13xxx_chipname[devid->driver_data];
+	return mc13xxx_chipname[mc13xxx->ictype];
 }
 
 #include <linux/mfd/mc13783.h>
@@ -563,7 +487,7 @@ static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
 {
 	struct mc13xxx_platform_data *pdata =
-		dev_get_platdata(&mc13xxx->spidev->dev);
+		dev_get_platdata(mc13xxx->dev);
 
 	return pdata->flags;
 }
@@ -601,7 +525,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, unsigned int mode,
 	};
 	init_completion(&adcdone_data.done);
 
-	dev_dbg(&mc13xxx->spidev->dev, "%s\n", __func__);
+	dev_dbg(mc13xxx->dev, "%s\n", __func__);
 
 	mc13xxx_lock(mc13xxx);
 
@@ -643,7 +567,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, unsigned int mode,
 		return -EINVAL;
 	}
 
-	dev_dbg(&mc13783->mc13xxx.spidev->dev, "%s: request irq\n", __func__);
+	dev_dbg(mc13783->mc13xxx.dev, "%s: request irq\n", __func__);
 	mc13xxx_irq_request(mc13xxx, MC13783_IRQ_ADCDONE,
 			mc13783_handler_adcdone, __func__, &adcdone_data);
 	mc13xxx_irq_ack(mc13xxx, MC13783_IRQ_ADCDONE);
@@ -701,7 +625,7 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
 	if (!cell.name)
 		return -ENOMEM;
 
-	return mfd_add_devices(&mc13xxx->spidev->dev, -1, &cell, 1, NULL, 0);
+	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0);
 }
 
 static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
@@ -709,29 +633,16 @@ static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
 	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
 }
 
-static int mc13xxx_probe(struct spi_device *spi)
+int mc13xxx_common_init(struct mc13xxx *mc13xxx,
+			struct mc13xxx_platform_data *pdata, int irq)
 {
-	struct mc13xxx *mc13xxx;
-	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
-	enum mc13xxx_id id;
 	int ret;
 
-	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
-	if (!mc13xxx)
-		return -ENOMEM;
-
-	dev_set_drvdata(&spi->dev, mc13xxx);
-	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
-	spi->bits_per_word = 32;
-	spi_setup(spi);
-
-	mc13xxx->spidev = spi;
-
 	mutex_init(&mc13xxx->lock);
 	mc13xxx_lock(mc13xxx);
 
-	ret = mc13xxx_identify(mc13xxx, &id);
-	if (ret || id == MC13XXX_ID_INVALID)
+	ret = mc13xxx_identify(mc13xxx);
+	if (ret)
 		goto err_revision;
 
 	/* mask all irqs */
@@ -743,14 +654,13 @@ static int mc13xxx_probe(struct spi_device *spi)
 	if (ret)
 		goto err_mask;
 
-	ret = request_threaded_irq(spi->irq, NULL, mc13xxx_irq_thread,
+	ret = request_threaded_irq(irq, NULL, mc13xxx_irq_thread,
 			IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
 
 	if (ret) {
 err_mask:
 err_revision:
 		mutex_unlock(&mc13xxx->lock);
-		dev_set_drvdata(&spi->dev, NULL);
 		kfree(mc13xxx);
 		return ret;
 	}
@@ -786,54 +696,7 @@ err_revision:
 
 	return 0;
 }
-
-static int __devexit mc13xxx_remove(struct spi_device *spi)
-{
-	struct mc13xxx *mc13xxx = dev_get_drvdata(&spi->dev);
-
-	free_irq(mc13xxx->spidev->irq, mc13xxx);
-
-	mfd_remove_devices(&spi->dev);
-
-	kfree(mc13xxx);
-
-	return 0;
-}
-
-static const struct spi_device_id mc13xxx_device_id[] = {
-	{
-		.name = "mc13783",
-		.driver_data = MC13XXX_ID_MC13783,
-	}, {
-		.name = "mc13892",
-		.driver_data = MC13XXX_ID_MC13892,
-	}, {
-		/* sentinel */
-	}
-};
-
-static struct spi_driver mc13xxx_driver = {
-	.id_table = mc13xxx_device_id,
-	.driver = {
-		.name = "mc13xxx",
-		.bus = &spi_bus_type,
-		.owner = THIS_MODULE,
-	},
-	.probe = mc13xxx_probe,
-	.remove = __devexit_p(mc13xxx_remove),
-};
-
-static int __init mc13xxx_init(void)
-{
-	return spi_register_driver(&mc13xxx_driver);
-}
-subsys_initcall(mc13xxx_init);
-
-static void __exit mc13xxx_exit(void)
-{
-	spi_unregister_driver(&mc13xxx_driver);
-}
-module_exit(mc13xxx_exit);
+EXPORT_SYMBOL_GPL(mc13xxx_common_init);
 
 MODULE_DESCRIPTION("Core driver for Freescale MC13XXX PMIC");
 MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index a1d391b..d7c18d7 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -11,7 +11,53 @@
 
 #include <linux/interrupt.h>
 
-struct mc13xxx;
+#define MC13XXX_IRQ_ADCDONE	0
+#define MC13XXX_IRQ_ADCBISDONE	1
+#define MC13XXX_IRQ_TS		2
+#define MC13XXX_IRQ_CHGDET	6
+#define MC13XXX_IRQ_CHGREV	8
+#define MC13XXX_IRQ_CHGSHORT	9
+#define MC13XXX_IRQ_CCCV	10
+#define MC13XXX_IRQ_CHGCURR	11
+#define MC13XXX_IRQ_BPON	12
+#define MC13XXX_IRQ_LOBATL	13
+#define MC13XXX_IRQ_LOBATH	14
+#define MC13XXX_IRQ_1HZ		24
+#define MC13XXX_IRQ_TODA	25
+#define MC13XXX_IRQ_SYSRST	30
+#define MC13XXX_IRQ_RTCRST	31
+#define MC13XXX_IRQ_PC		32
+#define MC13XXX_IRQ_WARM	33
+#define MC13XXX_IRQ_MEMHLD	34
+#define MC13XXX_IRQ_THWARNL	36
+#define MC13XXX_IRQ_THWARNH	37
+#define MC13XXX_IRQ_CLK		38
+
+#define MC13XXX_NUM_IRQ		46
+
+
+enum mc13xxx_id {
+	MC13XXX_ID_MC13783,
+	MC13XXX_ID_MC13892,
+	MC13XXX_ID_INVALID,
+};
+
+struct mc13xxx {
+	union {
+		struct spi_device *spidev;
+		struct i2c_client *i2cclient;
+	};
+	struct device *dev;
+	enum mc13xxx_id ictype;
+
+	struct mutex lock;
+
+	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
+	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
+
+	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
+	void *irqdata[MC13XXX_NUM_IRQ];
+};
 
 void mc13xxx_lock(struct mc13xxx *mc13xxx);
 void mc13xxx_unlock(struct mc13xxx *mc13xxx);
@@ -21,6 +67,11 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val);
 int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
 		u32 mask, u32 val);
 
+struct mc13xxx_platform_data;
+
+int mc13xxx_common_init(struct mc13xxx *mc13xxx,
+			struct mc13xxx_platform_data *pdata, int irq);
+
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
 
 int mc13xxx_irq_request(struct mc13xxx *mc13xxx, int irq,
@@ -37,30 +88,6 @@ int mc13xxx_irq_ack(struct mc13xxx *mc13xxx, int irq);
 
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
 
-#define MC13XXX_IRQ_ADCDONE	0
-#define MC13XXX_IRQ_ADCBISDONE	1
-#define MC13XXX_IRQ_TS		2
-#define MC13XXX_IRQ_CHGDET	6
-#define MC13XXX_IRQ_CHGREV	8
-#define MC13XXX_IRQ_CHGSHORT	9
-#define MC13XXX_IRQ_CCCV	10
-#define MC13XXX_IRQ_CHGCURR	11
-#define MC13XXX_IRQ_BPON	12
-#define MC13XXX_IRQ_LOBATL	13
-#define MC13XXX_IRQ_LOBATH	14
-#define MC13XXX_IRQ_1HZ		24
-#define MC13XXX_IRQ_TODA	25
-#define MC13XXX_IRQ_SYSRST	30
-#define MC13XXX_IRQ_RTCRST	31
-#define MC13XXX_IRQ_PC		32
-#define MC13XXX_IRQ_WARM	33
-#define MC13XXX_IRQ_MEMHLD	34
-#define MC13XXX_IRQ_THWARNL	36
-#define MC13XXX_IRQ_THWARNH	37
-#define MC13XXX_IRQ_CLK		38
-
-#define MC13XXX_NUM_IRQ		46
-
 struct regulator_init_data;
 
 struct mc13xxx_regulator_init_data {
-- 
1.7.1
