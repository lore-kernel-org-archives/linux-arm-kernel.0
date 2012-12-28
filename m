From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri, 28 Dec 2012 14:43:38 +0530
Subject: [PATCH v5] usb: phy: samsung: Add support to set pmu isolation
In-Reply-To: <CAFp+6iEUNjZewY1b3T-eCHeiZrouxYGPXtxHuNvJdi+UEKTNjg@mail.gmail.com>
References: <CAFp+6iEUNjZewY1b3T-eCHeiZrouxYGPXtxHuNvJdi+UEKTNjg@mail.gmail.com>
Message-ID: <1356686018-18586-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding support to parse device node data in order to get
required properties to set pmu isolation for usb-phy.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

Changes from v4:
 - Added 'ranges' property to usbphy node, to iomap the child nodes's
   address space.
 - Using offset for device phy control register to make it more generic.
 - Using of_iomap() to map register for child node.
 - Removing buggy check for IS_ERR_OR_NULL for ioremapped address, instead
   checking it against NULL.
 - Adding spin_lock around read-modify-write block in
   samsung_usbphy_set_isolation().
 - removing unnecessary casting for match->data.

 .../devicetree/bindings/usb/samsung-usbphy.txt     |   35 +++++
 drivers/usb/phy/samsung-usbphy.c                   |  145 +++++++++++++++++---
 2 files changed, 159 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
index 7b26e2d..1b97765 100644
--- a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
+++ b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
@@ -9,3 +9,38 @@ Required properties:
 - compatible : should be "samsung,exynos4210-usbphy"
 - reg : base physical address of the phy registers and length of memory mapped
 	region.
+
+Optional properties:
+- #address-cells: should be '1' when usbphy node has a child node with 'reg'
+		  property.
+- #size-cells: should be '1' when usbphy node has a child node with 'reg'
+	       property.
+- ranges: allows valid translation between child's address space and parent's
+	  address space.
+
+- The child node 'usbphy-sys' to the node 'usbphy' is for the system controller
+  interface for usb-phy. It should provide the following information required by
+  usb-phy controller to control phy.
+   - reg : base physical address of PHY control register in PMU which
+           enables/disables the phy controller.
+           The size of this register is the total sum of size of all phy-control
+           registers that the SoC has. For example, the size will be
+           '0x4' in case we have only one phy-control register (like in S3C64XX) or
+           '0x8' in case we have two phy-control registers (like in Exynos4210)
+           and so on.
+
+Example:
+ - Exynos4210
+
+	usbphy at 125B0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "samsung,exynos4210-usbphy";
+		reg = <0x125B0000 0x100>;
+		ranges;
+
+		usbphy-sys {
+			/* USB device and host PHY_CONTROL registers */
+			reg = <0x10020704 0x8>;
+		};
+	};
diff --git a/drivers/usb/phy/samsung-usbphy.c b/drivers/usb/phy/samsung-usbphy.c
index 5c5e1bb5..99e16e9 100644
--- a/drivers/usb/phy/samsung-usbphy.c
+++ b/drivers/usb/phy/samsung-usbphy.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/usb/otg.h>
 #include <linux/platform_data/samsung-usbphy.h>
 
@@ -60,20 +61,45 @@
 #define MHZ (1000*1000)
 #endif
 
+#define S3C64XX_USBPHY_ENABLE			(0x1 << 16)
+#define EXYNOS_USBPHY_ENABLE			(0x1 << 0)
+
 enum samsung_cpu_type {
 	TYPE_S3C64XX,
 	TYPE_EXYNOS4210,
 };
 
 /*
+ * struct samsung_usbphy_drvdata - driver data for various SoC variants
+ * @cpu_type: machine identifier
+ * @devphy_en_mask: device phy enable mask for PHY CONTROL register
+ * @pmureg_devphy_offset: offset to DEVICE PHY CONTROL register from
+ *			  mapped address of system controller.
+ *
+ *	Here we have a separate mask for device type phy.
+ *	Having different masks for host and device type phy helps
+ *	in setting independent masks in case of SoCs like S5PV210,
+ *	in which PHY0 and PHY1 enable bits belong to same register
+ *	placed at position 0 and 1 respectively.
+ *	Although for newer SoCs like exynos these bits belong to
+ *	different registers altogether placed@position 0.
+ */
+struct samsung_usbphy_drvdata {
+	int cpu_type;
+	int devphy_en_mask;
+	u32 pmureg_devphy_offset;
+};
+
+/*
  * struct samsung_usbphy - transceiver driver state
  * @phy: transceiver structure
  * @plat: platform data
  * @dev: The parent device supplied to the probe function
  * @clk: usb phy clock
  * @regs: usb phy register memory base
+ * @pmureg: usb device phy-control pmu register memory base
  * @ref_clk_freq: reference clock frequency selection
- * @cpu_type: machine identifier
+ * @drv_data: driver data available for different SoCs
  */
 struct samsung_usbphy {
 	struct usb_phy	phy;
@@ -81,12 +107,63 @@ struct samsung_usbphy {
 	struct device	*dev;
 	struct clk	*clk;
 	void __iomem	*regs;
+	void __iomem	*pmureg;
 	int		ref_clk_freq;
-	int		cpu_type;
+	const struct samsung_usbphy_drvdata *drv_data;
 };
 
 #define phy_to_sphy(x)		container_of((x), struct samsung_usbphy, phy)
 
+static int samsung_usbphy_parse_dt(struct samsung_usbphy *sphy)
+{
+	struct device_node *usbphy_sys;
+
+	/* Getting node for system controller interface for usb-phy */
+	usbphy_sys = of_get_child_by_name(sphy->dev->of_node, "usbphy-sys");
+	if (!usbphy_sys)
+		dev_warn(sphy->dev, "No sys-controller interface for usb-phy\n");
+
+	sphy->pmureg = of_iomap(usbphy_sys, 0);
+
+	of_node_put(usbphy_sys);
+
+	if (sphy->pmureg == NULL) {
+		dev_err(sphy->dev, "Can't get usb-phy pmu control register\n");
+		return -ENODEV;
+	}
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
+	static DEFINE_SPINLOCK(lock);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 reg_val;
+	u32 en_mask;
+
+	if (!sphy->pmureg) {
+		dev_warn(sphy->dev, "Can't set pmu isolation\n");
+		return;
+	}
+
+	reg = sphy->pmureg + sphy->drv_data->pmureg_devphy_offset;
+	en_mask = sphy->drv_data->devphy_en_mask;
+
+	spin_lock_irqsave(&lock, flags);
+
+	reg_val = readl(reg);
+	reg_val = on ? (reg_val & ~en_mask) : (reg_val | en_mask);
+	writel(reg_val, reg);
+
+	spin_unlock_irqrestore(&lock, flags);
+}
+
 /*
  * Returns reference clock frequency selection value
  */
@@ -112,7 +189,7 @@ static int samsung_usbphy_get_refclk_freq(struct samsung_usbphy *sphy)
 		refclk_freq = PHYCLK_CLKSEL_48M;
 		break;
 	default:
-		if (sphy->cpu_type == TYPE_S3C64XX)
+		if (sphy->drv_data->cpu_type == TYPE_S3C64XX)
 			refclk_freq = PHYCLK_CLKSEL_48M;
 		else
 			refclk_freq = PHYCLK_CLKSEL_24M;
@@ -135,7 +212,7 @@ static void samsung_usbphy_enable(struct samsung_usbphy *sphy)
 	phypwr = readl(regs + SAMSUNG_PHYPWR);
 	rstcon = readl(regs + SAMSUNG_RSTCON);
 
-	switch (sphy->cpu_type) {
+	switch (sphy->drv_data->cpu_type) {
 	case TYPE_S3C64XX:
 		phyclk &= ~PHYCLK_COMMON_ON_N;
 		phypwr &= ~PHYPWR_NORMAL_MASK;
@@ -165,7 +242,7 @@ static void samsung_usbphy_disable(struct samsung_usbphy *sphy)
 
 	phypwr = readl(regs + SAMSUNG_PHYPWR);
 
-	switch (sphy->cpu_type) {
+	switch (sphy->drv_data->cpu_type) {
 	case TYPE_S3C64XX:
 		phypwr |= PHYPWR_NORMAL_MASK;
 		break;
@@ -199,6 +276,8 @@ static int samsung_usbphy_init(struct usb_phy *phy)
 	/* Disable phy isolation */
 	if (sphy->plat && sphy->plat->pmu_isolation)
 		sphy->plat->pmu_isolation(false);
+	else
+		samsung_usbphy_set_isolation(sphy, false);
 
 	/* Initialize usb phy registers */
 	samsung_usbphy_enable(sphy);
@@ -228,38 +307,37 @@ static void samsung_usbphy_shutdown(struct usb_phy *phy)
 	/* Enable phy isolation */
 	if (sphy->plat && sphy->plat->pmu_isolation)
 		sphy->plat->pmu_isolation(true);
+	else
+		samsung_usbphy_set_isolation(sphy, true);
 
 	clk_disable_unprepare(sphy->clk);
 }
 
 static const struct of_device_id samsung_usbphy_dt_match[];
 
-static inline int samsung_usbphy_get_driver_data(struct platform_device *pdev)
+static inline const struct samsung_usbphy_drvdata
+*samsung_usbphy_get_driver_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
 		match = of_match_node(samsung_usbphy_dt_match,
 							pdev->dev.of_node);
-		return (int) match->data;
+		return match->data;
 	}
 
-	return platform_get_device_id(pdev)->driver_data;
+	return (struct samsung_usbphy_drvdata *)
+				platform_get_device_id(pdev)->driver_data;
 }
 
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
@@ -283,7 +361,19 @@ static int __devinit samsung_usbphy_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
-	sphy->dev		= &pdev->dev;
+	sphy->dev = dev;
+
+	if (dev->of_node) {
+		ret = samsung_usbphy_parse_dt(sphy);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (!pdata) {
+			dev_err(dev, "no platform data specified\n");
+			return -EINVAL;
+		}
+	}
+
 	sphy->plat		= pdata;
 	sphy->regs		= phy_base;
 	sphy->clk		= clk;
@@ -291,7 +381,7 @@ static int __devinit samsung_usbphy_probe(struct platform_device *pdev)
 	sphy->phy.label		= "samsung-usbphy";
 	sphy->phy.init		= samsung_usbphy_init;
 	sphy->phy.shutdown	= samsung_usbphy_shutdown;
-	sphy->cpu_type		= samsung_usbphy_get_driver_data(pdev);
+	sphy->drv_data		= samsung_usbphy_get_driver_data(pdev);
 	sphy->ref_clk_freq	= samsung_usbphy_get_refclk_freq(sphy);
 
 	platform_set_drvdata(pdev, sphy);
@@ -305,17 +395,30 @@ static int __exit samsung_usbphy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&sphy->phy);
 
+	if (sphy->pmureg)
+		iounmap(sphy->pmureg);
+
 	return 0;
 }
 
+static const struct samsung_usbphy_drvdata usbphy_s3c64xx = {
+	.cpu_type		= TYPE_S3C64XX,
+	.devphy_en_mask		= S3C64XX_USBPHY_ENABLE,
+};
+
+static const struct samsung_usbphy_drvdata usbphy_exynos4 = {
+	.cpu_type		= TYPE_EXYNOS4210,
+	.devphy_en_mask		= EXYNOS_USBPHY_ENABLE,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id samsung_usbphy_dt_match[] = {
 	{
 		.compatible = "samsung,s3c64xx-usbphy",
-		.data = (void *)TYPE_S3C64XX,
+		.data = &usbphy_s3c64xx,
 	}, {
 		.compatible = "samsung,exynos4210-usbphy",
-		.data = (void *)TYPE_EXYNOS4210,
+		.data = &usbphy_exynos4,
 	},
 	{},
 };
@@ -325,10 +428,10 @@ MODULE_DEVICE_TABLE(of, samsung_usbphy_dt_match);
 static struct platform_device_id samsung_usbphy_driver_ids[] = {
 	{
 		.name		= "s3c64xx-usbphy",
-		.driver_data	= TYPE_S3C64XX,
+		.driver_data	= (unsigned long)&usbphy_s3c64xx,
 	}, {
 		.name		= "exynos4210-usbphy",
-		.driver_data	= TYPE_EXYNOS4210,
+		.driver_data	= (unsigned long)&usbphy_exynos4,
 	},
 	{},
 };
-- 
1.7.6.5
