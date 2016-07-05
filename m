From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  5 Jul 2016 12:17:50 +0200
Subject: [PATCH 1/3] reset: socfpga: no need to store modrst_offset
Message-ID: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we can just add it to membase once, there is no need to store
modrst_offset separately, and to repeat the addition with every access.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-socfpga.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 12add9b..78ebf84 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -28,7 +28,6 @@
 struct socfpga_reset_data {
 	spinlock_t			lock;
 	void __iomem			*membase;
-	u32				modrst_offset;
 	struct reset_controller_dev	rcdev;
 };
 
@@ -45,9 +44,8 @@ static int socfpga_reset_assert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + data->modrst_offset + (bank * NR_BANKS));
-	writel(reg | BIT(offset), data->membase + data->modrst_offset +
-				 (bank * NR_BANKS));
+	reg = readl(data->membase + (bank * NR_BANKS));
+	writel(reg | BIT(offset), data->membase + (bank * NR_BANKS));
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	return 0;
@@ -67,9 +65,8 @@ static int socfpga_reset_deassert(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	reg = readl(data->membase + data->modrst_offset + (bank * NR_BANKS));
-	writel(reg & ~BIT(offset), data->membase + data->modrst_offset +
-				  (bank * NR_BANKS));
+	reg = readl(data->membase + (bank * NR_BANKS));
+	writel(reg & ~BIT(offset), data->membase + (bank * NR_BANKS));
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -85,7 +82,7 @@ static int socfpga_reset_status(struct reset_controller_dev *rcdev,
 	int offset = id % BITS_PER_LONG;
 	u32 reg;
 
-	reg = readl(data->membase + data->modrst_offset + (bank * NR_BANKS));
+	reg = readl(data->membase + (bank * NR_BANKS));
 
 	return !(reg & BIT(offset));
 }
@@ -102,6 +99,7 @@ static int socfpga_reset_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	u32 modrst_offset;
 
 	/*
 	 * The binding was mainlined without the required property.
@@ -122,10 +120,11 @@ static int socfpga_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(data->membase))
 		return PTR_ERR(data->membase);
 
-	if (of_property_read_u32(np, "altr,modrst-offset", &data->modrst_offset)) {
+	if (of_property_read_u32(np, "altr,modrst-offset", &modrst_offset)) {
 		dev_warn(dev, "missing altr,modrst-offset property, assuming 0x10!\n");
-		data->modrst_offset = 0x10;
+		modrst_offset = 0x10;
 	}
+	data->membase += modrst_offset;
 
 	spin_lock_init(&data->lock);
 
-- 
2.8.1
