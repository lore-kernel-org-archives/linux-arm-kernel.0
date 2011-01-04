From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue,  4 Jan 2011 16:34:56 +1100
Subject: [PATCH v4 1/4] mc13xxx-core: Prepare for separate spi and i2c
	backends.
In-Reply-To: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1294119299-18352-2-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch abstracts the bus specific operations from the driver core.
Read and write handlers are introduced and generic initialization is
consolidated into mc13xxx_comon_init. The irq member is removed because
it is unused.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/mc13xxx-core.c  |  158 +++++++++++++++++++++++++-----------------
 include/linux/mfd/mc13xxx.h |    5 ++
 2 files changed, 99 insertions(+), 64 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index a2ac2ed..d1f1d7b 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -19,10 +19,22 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
 
+enum mc13xxx_id {
+	MC13XXX_ID_MC13783,
+	MC13XXX_ID_MC13892,
+	MC13XXX_ID_INVALID,
+};
+
 struct mc13xxx {
 	struct spi_device *spidev;
+
+	struct device *dev;
+	enum mc13xxx_id ictype;
+
 	struct mutex lock;
-	int irq;
+
+	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
+	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
 
 	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
 	void *irqdata[MC13XXX_NUM_IRQ];
@@ -150,36 +162,32 @@ EXPORT_SYMBOL(mc13783_to_mc13xxx);
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
 
 #define MC13XXX_REGOFFSET_SHIFT 25
-int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
+static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
+				unsigned int offset, u32 *val)
 {
 	struct spi_transfer t;
 	struct spi_message m;
 	int ret;
 
-	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
-
-	if (offset > MC13XXX_NUMREGS)
-		return -EINVAL;
-
 	*val = offset << MC13XXX_REGOFFSET_SHIFT;
 
 	memset(&t, 0, sizeof(t));
@@ -201,26 +209,33 @@ int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
 
 	*val &= 0xffffff;
 
-	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
-
 	return 0;
 }
-EXPORT_SYMBOL(mc13xxx_reg_read);
 
-int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
+int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
 {
-	u32 buf;
-	struct spi_transfer t;
-	struct spi_message m;
 	int ret;
 
 	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
 
-	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] <- 0x%06x\n", offset, val);
-
-	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
+	if (offset > MC13XXX_NUMREGS)
 		return -EINVAL;
 
+	ret = mc13xxx->read_dev(mc13xxx, offset, val);
+	dev_vdbg(mc13xxx->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
+
+	return ret;
+}
+EXPORT_SYMBOL(mc13xxx_reg_read);
+
+static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned int offset,
+		u32 val)
+{
+	u32 buf;
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+
 	buf = 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
 
 	memset(&t, 0, sizeof(t));
@@ -241,6 +256,18 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
 
 	return 0;
 }
+
+int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
+{
+	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
+
+	dev_vdbg(mc13xxx->dev, "[0x%02x] <- 0x%06x\n", offset, val);
+
+	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
+		return -EINVAL;
+
+	return mc13xxx->write_dev(mc13xxx, offset, val);
+}
 EXPORT_SYMBOL(mc13xxx_reg_write);
 
 int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
@@ -445,7 +472,7 @@ static int mc13xxx_irq_handle(struct mc13xxx *mc13xxx,
 			if (handled == IRQ_HANDLED)
 				num_handled++;
 		} else {
-			dev_err(&mc13xxx->spidev->dev,
+			dev_err(mc13xxx->dev,
 					"BUG: irq %u but no handler\n",
 					baseirq + irq);
 
@@ -481,25 +508,23 @@ static irqreturn_t mc13xxx_irq_thread(int irq, void *data)
 	return IRQ_RETVAL(handled);
 }
 
-enum mc13xxx_id {
-	MC13XXX_ID_MC13783,
-	MC13XXX_ID_MC13892,
-	MC13XXX_ID_INVALID,
-};
-
 const char *mc13xxx_chipname[] = {
 	[MC13XXX_ID_MC13783] = "mc13783",
 	[MC13XXX_ID_MC13892] = "mc13892",
 };
 
 #define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
-static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
+static int mc13xxx_identify(struct mc13xxx *mc13xxx)
 {
 	u32 icid;
 	u32 revision;
-	const char *name;
 	int ret;
 
+	/*
+	 * Get the generation ID from register 46, as apparently some older
+	 * IC revisions only have this info at this location. Newer ICs seem to
+	 * have both.
+	 */
 	ret = mc13xxx_reg_read(mc13xxx, 46, &icid);
 	if (ret)
 		return ret;
@@ -508,26 +533,23 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
 
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
 
-		dev_info(&mc13xxx->spidev->dev, "%s: rev: %d.%d, "
+		dev_info(mc13xxx->dev, "%s: rev: %d.%d, "
 				"fin: %d, fab: %d, icid: %d/%d\n",
-				mc13xxx_chipname[*id],
+				mc13xxx_chipname[mc13xxx->ictype],
 				maskval(revision, MC13XXX_REVISION_REVFULL),
 				maskval(revision, MC13XXX_REVISION_REVMETAL),
 				maskval(revision, MC13XXX_REVISION_FIN),
@@ -536,26 +558,12 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
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
@@ -563,7 +571,7 @@ static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
 {
 	struct mc13xxx_platform_data *pdata =
-		dev_get_platdata(&mc13xxx->spidev->dev);
+		dev_get_platdata(mc13xxx->dev);
 
 	return pdata->flags;
 }
@@ -601,7 +609,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, unsigned int mode,
 	};
 	init_completion(&adcdone_data.done);
 
-	dev_dbg(&mc13xxx->spidev->dev, "%s\n", __func__);
+	dev_dbg(mc13xxx->dev, "%s\n", __func__);
 
 	mc13xxx_lock(mc13xxx);
 
@@ -643,7 +651,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, unsigned int mode,
 		return -EINVAL;
 	}
 
-	dev_dbg(&mc13783->mc13xxx.spidev->dev, "%s: request irq\n", __func__);
+	dev_dbg(mc13783->mc13xxx.dev, "%s: request irq\n", __func__);
 	mc13xxx_irq_request(mc13xxx, MC13783_IRQ_ADCDONE,
 			mc13783_handler_adcdone, __func__, &adcdone_data);
 	mc13xxx_irq_ack(mc13xxx, MC13783_IRQ_ADCDONE);
@@ -701,7 +709,7 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
 	if (!cell.name)
 		return -ENOMEM;
 
-	return mfd_add_devices(&mc13xxx->spidev->dev, -1, &cell, 1, NULL, 0);
+	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0);
 }
 
 static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
@@ -713,7 +721,6 @@ static int mc13xxx_probe(struct spi_device *spi)
 {
 	struct mc13xxx *mc13xxx;
 	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
-	enum mc13xxx_id id;
 	int ret;
 
 	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
@@ -725,13 +732,36 @@ static int mc13xxx_probe(struct spi_device *spi)
 	spi->bits_per_word = 32;
 	spi_setup(spi);
 
+	mc13xxx->dev = &spi->dev;
 	mc13xxx->spidev = spi;
+	mc13xxx->read_dev = mc13xxx_spi_reg_read;
+	mc13xxx->write_dev = mc13xxx_spi_reg_write;
+
+	ret = mc13xxx_common_init(mc13xxx, pdata, spi->irq);
+
+	if (ret) {
+		dev_set_drvdata(&spi->dev, NULL);
+	} else {
+		const struct spi_device_id *devid =
+			spi_get_device_id(mc13xxx->spidev);
+		if (!devid || devid->driver_data != mc13xxx->ictype)
+			dev_warn(mc13xxx->dev,
+				"device id doesn't match auto detection!\n");
+	}
+
+	return ret;
+}
+
+int mc13xxx_common_init(struct mc13xxx *mc13xxx,
+		struct mc13xxx_platform_data *pdata, int irq)
+{
+	int ret;
 
 	mutex_init(&mc13xxx->lock);
 	mc13xxx_lock(mc13xxx);
 
-	ret = mc13xxx_identify(mc13xxx, &id);
-	if (ret || id == MC13XXX_ID_INVALID)
+	ret = mc13xxx_identify(mc13xxx);
+	if (ret)
 		goto err_revision;
 
 	/* mask all irqs */
@@ -743,14 +773,13 @@ static int mc13xxx_probe(struct spi_device *spi)
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
@@ -786,6 +815,7 @@ err_revision:
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mc13xxx_common_init);
 
 static int __devexit mc13xxx_remove(struct spi_device *spi)
 {
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index a1d391b..f5d277d 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -21,6 +21,11 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val);
 int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
 		u32 mask, u32 val);
 
+struct mc13xxx_platform_data;
+
+int mc13xxx_common_init(struct mc13xxx *mc13xxx,
+		struct mc13xxx_platform_data *pdata, int irq);
+
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
 
 int mc13xxx_irq_request(struct mc13xxx *mc13xxx, int irq,
-- 
1.7.1
