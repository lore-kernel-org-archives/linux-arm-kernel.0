From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 21 Feb 2017 01:53:00 +1030
Subject: [PATCH v2] ipmi: bt-bmc: Use a regmap for register access
Message-ID: <20170220152300.3422-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The registers for the bt-bmc device live under the Aspeed LPC
controller. Devicetree bindings have recently been introduced for the
LPC controller where the "host" portion of the LPC register space is
described as a syscon device. Future devicetrees describing the bt-bmc
device should nest its node under the appropriate "simple-mfd", "syscon"
compatible node.

This change allows the bt-bmc driver to function with both syscon and
non-syscon- based devicetree descriptions by always using a regmap for
register access, either retrieved from the parent syscon device or
instantiated if none exists.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: C?dric Le Goater <clg@kaod.org>
---

v2: Address Joel's review with some minor cleanups

* Add '|| COMPILE_TEST' to Kconfig depends
* Const-ify the regmap configuration struct
* Remove some redundant output from the WARN formatting

Propagating regmap_{read,write}() failures makes the change more invasive than
I would like, so I have favoured keeping the WARN()s

 drivers/char/ipmi/Kconfig  |  3 +-
 drivers/char/ipmi/bt-bmc.c | 80 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 7f816655cbbf..90f3edffb067 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -78,7 +78,8 @@ config IPMI_POWEROFF
 endif # IPMI_HANDLER
 
 config ASPEED_BT_IPMI_BMC
-	depends on ARCH_ASPEED
+	depends on ARCH_ASPEED || COMPILE_TEST
+       depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
 	tristate "BT IPMI bmc driver"
 	help
 	  Provides a driver for the BT (Block Transfer) IPMI interface
diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index fc9e8891eae3..d6f5d9eb102d 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -12,10 +12,13 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
+#include <linux/regmap.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
 
@@ -60,7 +63,8 @@
 struct bt_bmc {
 	struct device		dev;
 	struct miscdevice	miscdev;
-	void __iomem		*base;
+	struct regmap		*map;
+	int			offset;
 	int			irq;
 	wait_queue_head_t	queue;
 	struct timer_list	poll_timer;
@@ -69,14 +73,29 @@ struct bt_bmc {
 
 static atomic_t open_count = ATOMIC_INIT(0);
 
+static const struct regmap_config bt_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static u8 bt_inb(struct bt_bmc *bt_bmc, int reg)
 {
-	return ioread8(bt_bmc->base + reg);
+	uint32_t val = 0;
+	int rc;
+
+	rc = regmap_read(bt_bmc->map, bt_bmc->offset + reg, &val);
+	WARN(rc != 0, "regmap_read() failed: %d\n", rc);
+
+	return rc == 0 ? (u8) val : 0;
 }
 
 static void bt_outb(struct bt_bmc *bt_bmc, u8 data, int reg)
 {
-	iowrite8(data, bt_bmc->base + reg);
+	int rc;
+
+	rc = regmap_write(bt_bmc->map, bt_bmc->offset + reg, data);
+	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
 }
 
 static void clr_rd_ptr(struct bt_bmc *bt_bmc)
@@ -367,14 +386,18 @@ static irqreturn_t bt_bmc_irq(int irq, void *arg)
 {
 	struct bt_bmc *bt_bmc = arg;
 	u32 reg;
+	int rc;
+
+	rc = regmap_read(bt_bmc->map, bt_bmc->offset + BT_CR2, &reg);
+	if (rc)
+		return IRQ_NONE;
 
-	reg = ioread32(bt_bmc->base + BT_CR2);
 	reg &= BT_CR2_IRQ_H2B | BT_CR2_IRQ_HBUSY;
 	if (!reg)
 		return IRQ_NONE;
 
 	/* ack pending IRQs */
-	iowrite32(reg, bt_bmc->base + BT_CR2);
+	regmap_write(bt_bmc->map, bt_bmc->offset + BT_CR2, reg);
 
 	wake_up(&bt_bmc->queue);
 	return IRQ_HANDLED;
@@ -384,7 +407,6 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 			     struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	u32 reg;
 	int rc;
 
 	bt_bmc->irq = platform_get_irq(pdev, 0);
@@ -405,18 +427,17 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 	 * will be cleared (along with B2H) when we can write the next
 	 * message to the BT buffer
 	 */
-	reg = ioread32(bt_bmc->base + BT_CR1);
-	reg |= BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY;
-	iowrite32(reg, bt_bmc->base + BT_CR1);
+	rc = regmap_update_bits(bt_bmc->map, bt_bmc->offset + BT_CR1,
+				(BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY),
+				(BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY));
 
-	return 0;
+	return rc;
 }
 
 static int bt_bmc_probe(struct platform_device *pdev)
 {
 	struct bt_bmc *bt_bmc;
 	struct device *dev;
-	struct resource *res;
 	int rc;
 
 	if (!pdev || !pdev->dev.of_node)
@@ -431,10 +452,27 @@ static int bt_bmc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, bt_bmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bt_bmc->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(bt_bmc->base))
-		return PTR_ERR(bt_bmc->base);
+	bt_bmc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(bt_bmc->map)) {
+		struct resource *res;
+		void __iomem *base;
+
+		/*
+		 * Assume it's not the MFD-based devicetree description, in
+		 * which case generate a regmap ourselves
+		 */
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		bt_bmc->map = devm_regmap_init_mmio(dev, base, &bt_regmap_cfg);
+		bt_bmc->offset = 0;
+	} else {
+		rc = of_property_read_u32(dev->of_node, "reg", &bt_bmc->offset);
+		if (rc)
+			return rc;
+	}
 
 	mutex_init(&bt_bmc->mutex);
 	init_waitqueue_head(&bt_bmc->queue);
@@ -461,12 +499,12 @@ static int bt_bmc_probe(struct platform_device *pdev)
 		add_timer(&bt_bmc->poll_timer);
 	}
 
-	iowrite32((BT_IO_BASE << BT_CR0_IO_BASE) |
-		  (BT_IRQ << BT_CR0_IRQ) |
-		  BT_CR0_EN_CLR_SLV_RDP |
-		  BT_CR0_EN_CLR_SLV_WRP |
-		  BT_CR0_ENABLE_IBT,
-		  bt_bmc->base + BT_CR0);
+	regmap_write(bt_bmc->map, bt_bmc->offset + BT_CR0,
+		     (BT_IO_BASE << BT_CR0_IO_BASE) |
+		     (BT_IRQ << BT_CR0_IRQ) |
+		     BT_CR0_EN_CLR_SLV_RDP |
+		     BT_CR0_EN_CLR_SLV_WRP |
+		     BT_CR0_ENABLE_IBT);
 
 	clr_b_busy(bt_bmc);
 
-- 
2.9.3
