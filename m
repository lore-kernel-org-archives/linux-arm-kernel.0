From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:40:15 +0000
Subject: [PATCH 30/33] MFD: ucb1x00-core: add wakeup support
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq41H-0000Zl-4V@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add genirq wakeup support for the ucb1x00 device.  This allows an
attached gpio_keys driver to wakeup the system.  Touchscreen is also
possible.

When there are no wakeup sources, ask the platform to assert the reset
signal to avoid any unexpected behaviour; this also puts the reset
signal at the right level when power is removed from the device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c  |   59 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ucb1x00.h |    4 +++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 400604d..70f02da 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -362,12 +362,32 @@ static int ucb1x00_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static int ucb1x00_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct ucb1x00 *ucb = irq_data_get_irq_chip_data(data);
+	struct ucb1x00_plat_data *pdata = ucb->mcp->attached_device.platform_data;
+	unsigned mask = 1 << (data->irq - ucb->irq_base);
+
+	if (!pdata || !pdata->can_wakeup)
+		return -EINVAL;
+
+	raw_spin_lock(&ucb->irq_lock);
+	if (on)
+		ucb->irq_wake |= mask;
+	else
+		ucb->irq_wake &= ~mask;
+	raw_spin_unlock(&ucb->irq_lock);
+
+	return 0;
+}
+
 static struct irq_chip ucb1x00_irqchip = {
 	.name = "ucb1x00",
 	.irq_ack = ucb1x00_irq_noop,
 	.irq_mask = ucb1x00_irq_mask,
 	.irq_unmask = ucb1x00_irq_unmask,
 	.irq_set_type = ucb1x00_irq_set_type,
+	.irq_set_wake = ucb1x00_irq_set_wake,
 };
 
 static int ucb1x00_add_dev(struct ucb1x00 *ucb, struct ucb1x00_driver *drv)
@@ -565,6 +585,9 @@ static int ucb1x00_probe(struct mcp *mcp)
 
 	mcp_set_drvdata(mcp, ucb);
 
+	if (pdata)
+		device_set_wakeup_capable(&ucb->dev, pdata->can_wakeup);
+
 	INIT_LIST_HEAD(&ucb->devs);
 	mutex_lock(&ucb1x00_mutex);
 	list_add_tail(&ucb->node, &ucb1x00_devices);
@@ -648,6 +671,7 @@ void ucb1x00_unregister_driver(struct ucb1x00_driver *drv)
 
 static int ucb1x00_suspend(struct device *dev)
 {
+	struct ucb1x00_plat_data *pdata = dev->platform_data;
 	struct ucb1x00 *ucb = dev_get_drvdata(dev);
 	struct ucb1x00_dev *udev;
 
@@ -657,18 +681,53 @@ static int ucb1x00_suspend(struct device *dev)
 			udev->drv->suspend(udev);
 	}
 	mutex_unlock(&ucb1x00_mutex);
+
+	if (ucb->irq_wake) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&ucb->irq_lock, flags);
+		ucb1x00_enable(ucb);
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl &
+				  ucb->irq_wake);
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl &
+				  ucb->irq_wake);
+		ucb1x00_disable(ucb);
+		raw_spin_unlock_irqrestore(&ucb->irq_lock, flags);
+
+		enable_irq_wake(ucb->irq);
+	} else if (pdata && pdata->reset)
+		pdata->reset(UCB_RST_SUSPEND);
+
 	return 0;
 }
 
 static int ucb1x00_resume(struct device *dev)
 {
+	struct ucb1x00_plat_data *pdata = dev->platform_data;
 	struct ucb1x00 *ucb = dev_get_drvdata(dev);
 	struct ucb1x00_dev *udev;
 
+	if (!ucb->irq_wake && pdata && pdata->reset)
+		pdata->reset(UCB_RST_RESUME);
+
 	ucb1x00_enable(ucb);
 	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
 	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
+
+	if (ucb->irq_wake) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&ucb->irq_lock, flags);
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl &
+				  ucb->irq_mask);
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl &
+				  ucb->irq_mask);
+		raw_spin_unlock_irqrestore(&ucb->irq_lock, flags);
+
+		disable_irq_wake(ucb->irq);
+	}
 	ucb1x00_disable(ucb);
+
 	mutex_lock(&ucb1x00_mutex);
 	list_for_each_entry(udev, &ucb->devs, dev_node) {
 		if (udev->drv->resume)
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index 6fb9074..28af417 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -106,6 +106,8 @@
 
 enum ucb1x00_reset {
 	UCB_RST_PROBE,
+	UCB_RST_RESUME,
+	UCB_RST_SUSPEND,
 	UCB_RST_REMOVE,
 	UCB_RST_PROBE_FAIL,
 };
@@ -114,6 +116,7 @@ struct ucb1x00_plat_data {
 	void			(*reset)(enum ucb1x00_reset);
 	unsigned		irq_base;
 	int			gpio_base;
+	unsigned		can_wakeup;
 };
 
 struct ucb1x00 {
@@ -130,6 +133,7 @@ struct ucb1x00 {
 	u16			irq_fal_enbl;
 	u16			irq_ris_enbl;
 	u16			irq_mask;
+	u16			irq_wake;
 	struct device		dev;
 	struct list_head	node;
 	struct list_head	devs;
-- 
1.7.4.4
