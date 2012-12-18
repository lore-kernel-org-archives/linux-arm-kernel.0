From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue, 18 Dec 2012 11:26:07 +0530
Subject: [PATCH] usb: phy: samsung: Add support to set pmu isolation
In-Reply-To: <1355810167-18425-1-git-send-email-gautam.vivek@samsung.com>
References: <1355810167-18425-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1355810167-18425-2-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding support to parse device node data in order to get
required properties to set pmu isolation for usb-phy.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 .../devicetree/bindings/usb/samsung-usbphy.txt     |   10 +++
 drivers/usb/phy/samsung-usbphy.c                   |   80 ++++++++++++++++++--
 2 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
index 7b26e2d..112eaa6 100644
--- a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
+++ b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
@@ -9,3 +9,13 @@ Required properties:
 - compatible : should be "samsung,exynos4210-usbphy"
 - reg : base physical address of the phy registers and length of memory mapped
 	region.
+- samsung,usb-phyctrl : should point to usb-phyctrl sub-node which provides
+			binding data to enable/disable device PHY handled by
+			PMU register.
+
+			Required properties:
+			- compatible : should be "samsung,usbdev-phyctrl" for
+					DEVICE type phy.
+			- samsung,phyctrl-reg: base physical address of
+						PHY_CONTROL register in PMU.
+- samsung,enable-mask : should be '1'
diff --git a/drivers/usb/phy/samsung-usbphy.c b/drivers/usb/phy/samsung-usbphy.c
index 5c5e1bb5..ef394c3 100644
--- a/drivers/usb/phy/samsung-usbphy.c
+++ b/drivers/usb/phy/samsung-usbphy.c
@@ -72,6 +72,8 @@ enum samsung_cpu_type {
  * @dev: The parent device supplied to the probe function
  * @clk: usb phy clock
  * @regs: usb phy register memory base
+ * @devctrl_reg: usb phy-control pmu register memory base
+ * @en_mask: enable mask
  * @ref_clk_freq: reference clock frequency selection
  * @cpu_type: machine identifier
  */
@@ -81,12 +83,62 @@ struct samsung_usbphy {
 	struct device	*dev;
 	struct clk	*clk;
 	void __iomem	*regs;
+	void __iomem	*devctrl_reg;
+	u32		en_mask;
 	int		ref_clk_freq;
 	int		cpu_type;
 };
 
 #define phy_to_sphy(x)		container_of((x), struct samsung_usbphy, phy)
 
+static int samsung_usbphy_parse_dt_param(struct samsung_usbphy *sphy)
+{
+	struct device_node *usb_phyctrl;
+	u32 reg;
+
+	if (!sphy->dev->of_node) {
+		sphy->devctrl_reg = NULL;
+		return -ENODEV;
+	}
+
+	usb_phyctrl = of_parse_phandle(sphy->dev->of_node,
+					"samsung,usb-phyctrl", 0);
+	if (!usb_phyctrl) {
+		dev_dbg(sphy->dev, "Can't get usb-phy control node\n");
+		sphy->devctrl_reg = NULL;
+		return -ENODEV;
+	}
+
+	of_property_read_u32(usb_phyctrl, "samsung,phyctrl-reg", &reg);
+
+	sphy->devctrl_reg = ioremap(reg, SZ_4);
+
+	of_property_read_u32(sphy->dev->of_node, "samsung,enable-mask",
+							&sphy->en_mask);
+
+	return 0;
+}
+
+/*
+ * Set isolation here for phy.
+ * SOCs control this by controlling corresponding PMU registers
+ */
+static void samsung_usbphy_set_isolation(struct samsung_usbphy *sphy, int on)
+{
+	void __iomem *usb_phyctrl_reg;
+	u32 en_mask = sphy->en_mask;
+	u32 reg;
+
+	usb_phyctrl_reg = sphy->devctrl_reg;
+
+	reg = readl(usb_phyctrl_reg);
+
+	if (on)
+		writel(reg & ~en_mask, usb_phyctrl_reg);
+	else
+		writel(reg | en_mask, usb_phyctrl_reg);
+}
+
 /*
  * Returns reference clock frequency selection value
  */
@@ -199,6 +251,8 @@ static int samsung_usbphy_init(struct usb_phy *phy)
 	/* Disable phy isolation */
 	if (sphy->plat && sphy->plat->pmu_isolation)
 		sphy->plat->pmu_isolation(false);
+	else
+		samsung_usbphy_set_isolation(sphy, false);
 
 	/* Initialize usb phy registers */
 	samsung_usbphy_enable(sphy);
@@ -228,6 +282,8 @@ static void samsung_usbphy_shutdown(struct usb_phy *phy)
 	/* Enable phy isolation */
 	if (sphy->plat && sphy->plat->pmu_isolation)
 		sphy->plat->pmu_isolation(true);
+	else
+		samsung_usbphy_set_isolation(sphy, true);
 
 	clk_disable_unprepare(sphy->clk);
 }
@@ -249,17 +305,12 @@ static inline int samsung_usbphy_get_driver_data(struct platform_device *pdev)
 static int __devinit samsung_usbphy_probe(struct platform_device *pdev)
 {
 	struct samsung_usbphy *sphy;
-	struct samsung_usbphy_data *pdata;
+	struct samsung_usbphy_data *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	struct resource *phy_mem;
 	void __iomem	*phy_base;
 	struct clk *clk;
-
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: no platform data defined\n", __func__);
-		return -EINVAL;
-	}
+	int ret;
 
 	phy_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!phy_mem) {
@@ -283,7 +334,20 @@ static int __devinit samsung_usbphy_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
-	sphy->dev		= &pdev->dev;
+	sphy->dev = &pdev->dev;
+
+	ret = samsung_usbphy_parse_dt_param(sphy);
+	if (ret) {
+		/* fallback to pdata */
+		if (!pdata) {
+			dev_err(&pdev->dev,
+				"%s: no device data found\n", __func__);
+			return -ENODEV;
+		} else {
+			sphy->plat = pdata;
+		}
+	}
+
 	sphy->plat		= pdata;
 	sphy->regs		= phy_base;
 	sphy->clk		= clk;
-- 
1.7.6.5
