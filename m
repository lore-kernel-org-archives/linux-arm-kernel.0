From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 13 Jun 2015 14:37:49 +0200
Subject: [PATCH v5 5/7] phy-sun4i-usb: Add support for the usb-phys on the
 sun8i-a33 SoC
In-Reply-To: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
References: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1434199071-22127-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb-phys on the sun8i-a33 SoC are mostly the same as sun8i-a23 but for
some reason (hw bug?) the phyctl register was moved to a different address
and is not initialized to 0 on reset.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  1 +
 drivers/phy/phy-sun4i-usb.c                        | 39 ++++++++++++++++------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index f0c640a..5f48979 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -8,6 +8,7 @@ Required properties:
   * allwinner,sun6i-a31-usb-phy
   * allwinner,sun7i-a20-usb-phy
   * allwinner,sun8i-a23-usb-phy
+  * allwinner,sun8i-a33-usb-phy
 - reg : a list of offset + length pairs
 - reg-names :
   * "phy_ctrl"
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 6850fcd..5060257 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -40,9 +40,10 @@
 #include <linux/workqueue.h>
 
 #define REG_ISCR			0x00
-#define REG_PHYCTL			0x04
+#define REG_PHYCTL_A10			0x04
 #define REG_PHYBIST			0x08
 #define REG_PHYTUNE			0x0c
+#define REG_PHYCTL_A33			0x10
 
 #define PHYCTL_DATA			BIT(7)
 
@@ -90,6 +91,7 @@ struct sun4i_usb_phy_data {
 	struct mutex mutex;
 	int num_phys;
 	u32 disc_thresh;
+	bool has_a33_phyctl;
 	struct sun4i_usb_phy {
 		struct phy *phy;
 		void __iomem *pmu;
@@ -152,37 +154,46 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 {
 	struct sun4i_usb_phy_data *phy_data = to_sun4i_usb_phy_data(phy);
 	u32 temp, usbc_bit = BIT(phy->index * 2);
+	void *phyctl;
 	int i;
 
 	mutex_lock(&phy_data->mutex);
 
+	if (phy_data->has_a33_phyctl) {
+		phyctl = phy_data->base + REG_PHYCTL_A33;
+		/* A33 needs us to set phyctl to 0 explictly */
+		writel(0, phyctl);
+	} else {
+		phyctl = phy_data->base + REG_PHYCTL_A10;
+	}
+
 	for (i = 0; i < len; i++) {
-		temp = readl(phy_data->base + REG_PHYCTL);
+		temp = readl(phyctl);
 
 		/* clear the address portion */
 		temp &= ~(0xff << 8);
 
 		/* set the address */
 		temp |= ((addr + i) << 8);
-		writel(temp, phy_data->base + REG_PHYCTL);
+		writel(temp, phyctl);
 
 		/* set the data bit and clear usbc bit*/
-		temp = readb(phy_data->base + REG_PHYCTL);
+		temp = readb(phyctl);
 		if (data & 0x1)
 			temp |= PHYCTL_DATA;
 		else
 			temp &= ~PHYCTL_DATA;
 		temp &= ~usbc_bit;
-		writeb(temp, phy_data->base + REG_PHYCTL);
+		writeb(temp, phyctl);
 
 		/* pulse usbc_bit */
-		temp = readb(phy_data->base + REG_PHYCTL);
+		temp = readb(phyctl);
 		temp |= usbc_bit;
-		writeb(temp, phy_data->base + REG_PHYCTL);
+		writeb(temp, phyctl);
 
-		temp = readb(phy_data->base + REG_PHYCTL);
+		temp = readb(phyctl);
 		temp &= ~usbc_bit;
-		writeb(temp, phy_data->base + REG_PHYCTL);
+		writeb(temp, phyctl);
 
 		data >>= 1;
 	}
@@ -443,7 +454,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, data);
 
 	if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy") ||
-	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy"))
+	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy") ||
+	    of_device_is_compatible(np, "allwinner,sun8i-a33-usb-phy"))
 		data->num_phys = 2;
 	else
 		data->num_phys = 3;
@@ -455,11 +467,15 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		data->disc_thresh = 3;
 
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy") ||
-	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy"))
+	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy") ||
+	    of_device_is_compatible(np, "allwinner,sun8i-a33-usb-phy"))
 		dedicated_clocks = true;
 	else
 		dedicated_clocks = false;
 
+	if (of_device_is_compatible(np, "allwinner,sun8i-a33-usb-phy"))
+		data->has_a33_phyctl = true;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_ctrl");
 	data->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->base))
@@ -591,6 +607,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-usb-phy" },
 	{ .compatible = "allwinner,sun7i-a20-usb-phy" },
 	{ .compatible = "allwinner,sun8i-a23-usb-phy" },
+	{ .compatible = "allwinner,sun8i-a33-usb-phy" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
-- 
2.4.3
