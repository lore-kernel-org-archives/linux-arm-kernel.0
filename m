From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 3 Aug 2017 18:01:02 +0800
Subject: [PATCH 3/4] phy: phy-mt65xx-usb3: add mediatek directory and rename
 file
In-Reply-To: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
References: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
Message-ID: <dfffa0ab0259630e72fc4125d8e2880a54dedeaf.1501753328.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is actually for T-PHY which supports USB3.0, PCIe and SATA,
and supports more SoCs now, but not just only for series of mt65xx SoCs,
so the name of file, data struct, functions etc with 'mt65xx' may cause
misunderstanding when new SoCs are supported. Here rename them to reflect
the real functions and also enhance readability.

And also update MAINTAINERS file to reflect the correct driver

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 MAINTAINERS                                        |    2 +-
 drivers/phy/Kconfig                                |    9 +-
 drivers/phy/Makefile                               |    2 +-
 drivers/phy/mediatek/Kconfig                       |   14 ++
 drivers/phy/mediatek/Makefile                      |    5 +
 .../{phy-mt65xx-usb3.c => mediatek/phy-mtk-tphy.c} |  264 ++++++++++----------
 6 files changed, 154 insertions(+), 142 deletions(-)
 create mode 100644 drivers/phy/mediatek/Kconfig
 create mode 100644 drivers/phy/mediatek/Makefile
 rename drivers/phy/{phy-mt65xx-usb3.c => mediatek/phy-mtk-tphy.c} (81%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205d397..428e5d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1599,7 +1599,7 @@ M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/phy/phy-mt65xx-usb3.c
+F:	drivers/phy/mediatek/phy-mtk-tphy.c
 
 ARM/MICREL KS8695 ARCHITECTURE
 M:	Greg Ungerer <gerg@uclinux.org>
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index c1807d4..d16704e 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -26,14 +26,6 @@ config PHY_LPC18XX_USB_OTG
 	  This driver is need for USB0 support on LPC18xx/43xx and takes
 	  care of enabling and clock setup.
 
-config PHY_MT65XX_USB3
-	tristate "Mediatek USB3.0 PHY Driver"
-	depends on ARCH_MEDIATEK && OF
-	select GENERIC_PHY
-	help
-	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver,
-	  it supports multiple usb2.0 and usb3.0 ports.
-
 config PHY_PISTACHIO_USB
 	tristate "IMG Pistachio USB2.0 PHY driver"
 	depends on MACH_PISTACHIO
@@ -53,6 +45,7 @@ source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/marvell/Kconfig"
+source "drivers/phy/mediatek/Kconfig"
 source "drivers/phy/motorola/Kconfig"
 source "drivers/phy/qualcomm/Kconfig"
 source "drivers/phy/renesas/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f252201..1c68189 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,12 +4,12 @@
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
-obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
 
 obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
 obj-$(CONFIG_ARCH_MESON)		+= amlogic/
+obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
 obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
new file mode 100644
index 0000000..88ab4e2
--- /dev/null
+++ b/drivers/phy/mediatek/Kconfig
@@ -0,0 +1,14 @@
+#
+# Phy drivers for Mediatek devices
+#
+config PHY_MTK_TPHY
+    tristate "MediaTek T-PHY Driver"
+    depends on ARCH_MEDIATEK && OF
+    select GENERIC_PHY
+    help
+      Say 'Y' here to add support for MediaTek T-PHY driver,
+      it supports multiple usb2.0, usb3.0 ports, PCIe and
+	  SATA, and meanwhile supports two version T-PHY which have
+	  different banks layout, the T-PHY with shared banks between
+	  multi-ports is first version, otherwise is second veriosn,
+	  so you can easily distinguish them by banks layout.
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
new file mode 100644
index 0000000..763a92e
--- /dev/null
+++ b/drivers/phy/mediatek/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the phy drivers.
+#
+
+obj-$(CONFIG_PHY_MTK_TPHY)		+= phy-mtk-tphy.o
diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/mediatek/phy-mtk-tphy.c
similarity index 81%
rename from drivers/phy/phy-mt65xx-usb3.c
rename to drivers/phy/mediatek/phy-mtk-tphy.c
index 45291c1..e3baad7 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -38,7 +38,7 @@
 #define SSUSB_SIFSLV_V2_MISC		0x000
 #define SSUSB_SIFSLV_V2_U2FREQ		0x100
 #define SSUSB_SIFSLV_V2_U2PHY_COM	0x300
-/* u3 phy banks */
+/* u3/pcie/sata phy banks */
 #define SSUSB_SIFSLV_V2_SPLLC		0x000
 #define SSUSB_SIFSLV_V2_CHIP		0x100
 #define SSUSB_SIFSLV_V2_U3PHYD		0x200
@@ -258,15 +258,15 @@
 #define RG_CDR_BIRLTD0_GEN3_MSK		GENMASK(4, 0)
 #define RG_CDR_BIRLTD0_GEN3_VAL(x)	(0x1f & (x))
 
-enum mt_phy_version {
-	MT_PHY_V1 = 1,
-	MT_PHY_V2,
+enum mtk_phy_version {
+	MTK_PHY_V1 = 1,
+	MTK_PHY_V2,
 };
 
-struct mt65xx_phy_pdata {
+struct mtk_phy_pdata {
 	/* avoid RX sensitivity level degradation only for mt8173 */
 	bool avoid_rx_sen_degradation;
-	enum mt_phy_version version;
+	enum mtk_phy_version version;
 };
 
 struct u2phy_banks {
@@ -282,7 +282,7 @@ struct u3phy_banks {
 	void __iomem *phya; /* include u3phya_da */
 };
 
-struct mt65xx_phy_instance {
+struct mtk_phy_instance {
 	struct phy *phy;
 	void __iomem *port_base;
 	union {
@@ -294,18 +294,18 @@ struct mt65xx_phy_instance {
 	u8 type;
 };
 
-struct mt65xx_u3phy {
+struct mtk_tphy {
 	struct device *dev;
 	void __iomem *sif_base;	/* only shared sif */
 	/* deprecated, use @ref_clk instead in phy instance */
 	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
-	const struct mt65xx_phy_pdata *pdata;
-	struct mt65xx_phy_instance **phys;
+	const struct mtk_phy_pdata *pdata;
+	struct mtk_phy_instance **phys;
 	int nphys;
 };
 
-static void hs_slew_rate_calibrate(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *fmreg = u2_banks->fmreg;
@@ -329,7 +329,7 @@ static void hs_slew_rate_calibrate(struct mt65xx_u3phy *u3phy,
 	tmp = readl(fmreg + U3P_U2FREQ_FMCR0);
 	tmp &= ~(P2F_RG_CYCLECNT | P2F_RG_MONCLK_SEL);
 	tmp |= P2F_RG_CYCLECNT_VAL(U3P_FM_DET_CYCLE_CNT);
-	if (u3phy->pdata->version == MT_PHY_V1)
+	if (tphy->pdata->version == MTK_PHY_V1)
 		tmp |= P2F_RG_MONCLK_SEL_VAL(instance->index >> 1);
 
 	writel(tmp, fmreg + U3P_U2FREQ_FMCR0);
@@ -364,7 +364,7 @@ static void hs_slew_rate_calibrate(struct mt65xx_u3phy *u3phy,
 		/* if FM detection fail, set default value */
 		calibration_val = 4;
 	}
-	dev_dbg(u3phy->dev, "phy:%d, fm_out:%d, calib:%d\n",
+	dev_dbg(tphy->dev, "phy:%d, fm_out:%d, calib:%d\n",
 		instance->index, fm_out, calibration_val);
 
 	/* set HS slew rate */
@@ -379,8 +379,8 @@ static void hs_slew_rate_calibrate(struct mt65xx_u3phy *u3phy,
 	writel(tmp, com + U3P_USBPHYACR5);
 }
 
-static void u3_phy_instance_init(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u3_phy_instance_init(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 	u32 tmp;
@@ -426,11 +426,11 @@ static void u3_phy_instance_init(struct mt65xx_u3phy *u3phy,
 	tmp |= P3D_RG_RXDET_STB2_SET_P3_VAL(0x10);
 	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RXDET2);
 
-	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, instance->index);
+	dev_dbg(tphy->dev, "%s(%d)\n", __func__, instance->index);
 }
 
-static void u2_phy_instance_init(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_init(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -462,7 +462,7 @@ static void u2_phy_instance_init(struct mt65xx_u3phy *u3phy,
 		writel(tmp, com + U3P_U2PHYACR4);
 	}
 
-	if (u3phy->pdata->avoid_rx_sen_degradation) {
+	if (tphy->pdata->avoid_rx_sen_degradation) {
 		if (!index) {
 			tmp = readl(com + U3P_USBPHYACR2);
 			tmp |= PA2_RG_SIF_U2PLL_FORCE_EN;
@@ -488,11 +488,11 @@ static void u2_phy_instance_init(struct mt65xx_u3phy *u3phy,
 	tmp |= PA6_RG_U2_SQTH_VAL(2);
 	writel(tmp, com + U3P_USBPHYACR6);
 
-	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
+	dev_dbg(tphy->dev, "%s(%d)\n", __func__, index);
 }
 
-static void u2_phy_instance_power_on(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_power_on(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -515,7 +515,7 @@ static void u2_phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	tmp &= ~P2C_RG_SESSEND;
 	writel(tmp, com + U3P_U2PHYDTM1);
 
-	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
+	if (tphy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(com + U3D_U2PHYDCR0);
 		tmp |= P2C_RG_SIF_U2PLL_FORCE_ON;
 		writel(tmp, com + U3D_U2PHYDCR0);
@@ -524,11 +524,11 @@ static void u2_phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 		tmp |= P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM;
 		writel(tmp, com + U3P_U2PHYDTM0);
 	}
-	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
+	dev_dbg(tphy->dev, "%s(%d)\n", __func__, index);
 }
 
-static void u2_phy_instance_power_off(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_power_off(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
@@ -556,24 +556,24 @@ static void u2_phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 	tmp |= P2C_RG_SESSEND;
 	writel(tmp, com + U3P_U2PHYDTM1);
 
-	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
+	if (tphy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(com + U3D_U2PHYDCR0);
 		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
 		writel(tmp, com + U3D_U2PHYDCR0);
 	}
 
-	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, index);
+	dev_dbg(tphy->dev, "%s(%d)\n", __func__, index);
 }
 
-static void u2_phy_instance_exit(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void u2_phy_instance_exit(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
 	u32 index = instance->index;
 	u32 tmp;
 
-	if (u3phy->pdata->avoid_rx_sen_degradation && index) {
+	if (tphy->pdata->avoid_rx_sen_degradation && index) {
 		tmp = readl(com + U3D_U2PHYDCR0);
 		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
 		writel(tmp, com + U3D_U2PHYDCR0);
@@ -584,13 +584,13 @@ static void u2_phy_instance_exit(struct mt65xx_u3phy *u3phy,
 	}
 }
 
-static void pcie_phy_instance_init(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void pcie_phy_instance_init(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 	u32 tmp;
 
-	if (u3phy->pdata->version != MT_PHY_V1)
+	if (tphy->pdata->version != MTK_PHY_V1)
 		return;
 
 	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG0);
@@ -654,11 +654,11 @@ static void pcie_phy_instance_init(struct mt65xx_u3phy *u3phy,
 
 	/* wait for PCIe subsys register to active */
 	usleep_range(2500, 3000);
-	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, instance->index);
+	dev_dbg(tphy->dev, "%s(%d)\n", __func__, instance->index);
 }
 
-static void pcie_phy_instance_power_on(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void pcie_phy_instance_power_on(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *bank = &instance->u3_banks;
 	u32 tmp;
@@ -673,8 +673,8 @@ static void pcie_phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLE);
 }
 
-static void pcie_phy_instance_power_off(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void pcie_phy_instance_power_off(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 
 {
 	struct u3phy_banks *bank = &instance->u3_banks;
@@ -689,8 +689,8 @@ static void pcie_phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLE);
 }
 
-static void sata_phy_instance_init(struct mt65xx_u3phy *u3phy,
-	struct mt65xx_phy_instance *instance)
+static void sata_phy_instance_init(struct mtk_tphy *tphy,
+	struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 	void __iomem *phyd = u3_banks->phyd;
@@ -744,11 +744,11 @@ static void sata_phy_instance_init(struct mt65xx_u3phy *u3phy,
 	tmp |= RG_EQ_DLEQ_LFI_GEN1_VAL(0x03);
 	writel(tmp, phyd + ANA_EQ_EYE_CTRL_SIGNAL1);
 
-	dev_dbg(u3phy->dev, "%s(%d)\n", __func__, instance->index);
+	dev_dbg(tphy->dev, "%s(%d)\n", __func__, instance->index);
 }
 
-static void phy_v1_banks_init(struct mt65xx_u3phy *u3phy,
-			      struct mt65xx_phy_instance *instance)
+static void phy_v1_banks_init(struct mtk_tphy *tphy,
+			      struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
@@ -756,12 +756,12 @@ static void phy_v1_banks_init(struct mt65xx_u3phy *u3phy,
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
 		u2_banks->misc = NULL;
-		u2_banks->fmreg = u3phy->sif_base + SSUSB_SIFSLV_V1_U2FREQ;
+		u2_banks->fmreg = tphy->sif_base + SSUSB_SIFSLV_V1_U2FREQ;
 		u2_banks->com = instance->port_base + SSUSB_SIFSLV_V1_U2PHY_COM;
 		break;
 	case PHY_TYPE_USB3:
 	case PHY_TYPE_PCIE:
-		u3_banks->spllc = u3phy->sif_base + SSUSB_SIFSLV_V1_SPLLC;
+		u3_banks->spllc = tphy->sif_base + SSUSB_SIFSLV_V1_SPLLC;
 		u3_banks->chip = NULL;
 		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V1_U3PHYD;
 		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V1_U3PHYA;
@@ -770,13 +770,13 @@ static void phy_v1_banks_init(struct mt65xx_u3phy *u3phy,
 		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V1_U3PHYD;
 		break;
 	default:
-		dev_err(u3phy->dev, "incompatible PHY type\n");
+		dev_err(tphy->dev, "incompatible PHY type\n");
 		return;
 	}
 }
 
-static void phy_v2_banks_init(struct mt65xx_u3phy *u3phy,
-			      struct mt65xx_phy_instance *instance)
+static void phy_v2_banks_init(struct mtk_tphy *tphy,
+			      struct mtk_phy_instance *instance)
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
@@ -795,96 +795,96 @@ static void phy_v2_banks_init(struct mt65xx_u3phy *u3phy,
 		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V2_U3PHYA;
 		break;
 	default:
-		dev_err(u3phy->dev, "incompatible PHY type\n");
+		dev_err(tphy->dev, "incompatible PHY type\n");
 		return;
 	}
 }
 
-static int mt65xx_phy_init(struct phy *phy)
+static int mtk_phy_init(struct phy *phy)
 {
-	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
-	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
+	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
+	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
-	ret = clk_prepare_enable(u3phy->u3phya_ref);
+	ret = clk_prepare_enable(tphy->u3phya_ref);
 	if (ret) {
-		dev_err(u3phy->dev, "failed to enable u3phya_ref\n");
+		dev_err(tphy->dev, "failed to enable u3phya_ref\n");
 		return ret;
 	}
 
 	ret = clk_prepare_enable(instance->ref_clk);
 	if (ret) {
-		dev_err(u3phy->dev, "failed to enable ref_clk\n");
+		dev_err(tphy->dev, "failed to enable ref_clk\n");
 		return ret;
 	}
 
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
-		u2_phy_instance_init(u3phy, instance);
+		u2_phy_instance_init(tphy, instance);
 		break;
 	case PHY_TYPE_USB3:
-		u3_phy_instance_init(u3phy, instance);
+		u3_phy_instance_init(tphy, instance);
 		break;
 	case PHY_TYPE_PCIE:
-		pcie_phy_instance_init(u3phy, instance);
+		pcie_phy_instance_init(tphy, instance);
 		break;
 	case PHY_TYPE_SATA:
-		sata_phy_instance_init(u3phy, instance);
+		sata_phy_instance_init(tphy, instance);
 		break;
 	default:
-		dev_err(u3phy->dev, "incompatible PHY type\n");
+		dev_err(tphy->dev, "incompatible PHY type\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int mt65xx_phy_power_on(struct phy *phy)
+static int mtk_phy_power_on(struct phy *phy)
 {
-	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
-	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
+	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
+	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
 
 	if (instance->type == PHY_TYPE_USB2) {
-		u2_phy_instance_power_on(u3phy, instance);
-		hs_slew_rate_calibrate(u3phy, instance);
+		u2_phy_instance_power_on(tphy, instance);
+		hs_slew_rate_calibrate(tphy, instance);
 	} else if (instance->type == PHY_TYPE_PCIE) {
-		pcie_phy_instance_power_on(u3phy, instance);
+		pcie_phy_instance_power_on(tphy, instance);
 	}
 
 	return 0;
 }
 
-static int mt65xx_phy_power_off(struct phy *phy)
+static int mtk_phy_power_off(struct phy *phy)
 {
-	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
-	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
+	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
+	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
 
 	if (instance->type == PHY_TYPE_USB2)
-		u2_phy_instance_power_off(u3phy, instance);
+		u2_phy_instance_power_off(tphy, instance);
 	else if (instance->type == PHY_TYPE_PCIE)
-		pcie_phy_instance_power_off(u3phy, instance);
+		pcie_phy_instance_power_off(tphy, instance);
 
 	return 0;
 }
 
-static int mt65xx_phy_exit(struct phy *phy)
+static int mtk_phy_exit(struct phy *phy)
 {
-	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
-	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
+	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
+	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
 
 	if (instance->type == PHY_TYPE_USB2)
-		u2_phy_instance_exit(u3phy, instance);
+		u2_phy_instance_exit(tphy, instance);
 
 	clk_disable_unprepare(instance->ref_clk);
-	clk_disable_unprepare(u3phy->u3phya_ref);
+	clk_disable_unprepare(tphy->u3phya_ref);
 	return 0;
 }
 
-static struct phy *mt65xx_phy_xlate(struct device *dev,
+static struct phy *mtk_phy_xlate(struct device *dev,
 					struct of_phandle_args *args)
 {
-	struct mt65xx_u3phy *u3phy = dev_get_drvdata(dev);
-	struct mt65xx_phy_instance *instance = NULL;
+	struct mtk_tphy *tphy = dev_get_drvdata(dev);
+	struct mtk_phy_instance *instance = NULL;
 	struct device_node *phy_np = args->np;
 	int index;
 
@@ -893,9 +893,9 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	for (index = 0; index < u3phy->nphys; index++)
-		if (phy_np == u3phy->phys[index]->phy->dev.of_node) {
-			instance = u3phy->phys[index];
+	for (index = 0; index < tphy->nphys; index++)
+		if (phy_np == tphy->phys[index]->phy->dev.of_node) {
+			instance = tphy->phys[index];
 			break;
 		}
 
@@ -913,10 +913,10 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (u3phy->pdata->version == MT_PHY_V1) {
-		phy_v1_banks_init(u3phy, instance);
-	} else if (u3phy->pdata->version == MT_PHY_V2) {
-		phy_v2_banks_init(u3phy, instance);
+	if (tphy->pdata->version == MTK_PHY_V1) {
+		phy_v1_banks_init(tphy, instance);
+	} else if (tphy->pdata->version == MTK_PHY_V2) {
+		phy_v2_banks_init(tphy, instance);
 	} else {
 		dev_err(dev, "phy version is not supported\n");
 		return ERR_PTR(-EINVAL);
@@ -925,30 +925,30 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 	return instance->phy;
 }
 
-static const struct phy_ops mt65xx_u3phy_ops = {
-	.init		= mt65xx_phy_init,
-	.exit		= mt65xx_phy_exit,
-	.power_on	= mt65xx_phy_power_on,
-	.power_off	= mt65xx_phy_power_off,
+static const struct phy_ops mtk_tphy_ops = {
+	.init		= mtk_phy_init,
+	.exit		= mtk_phy_exit,
+	.power_on	= mtk_phy_power_on,
+	.power_off	= mtk_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
-static const struct mt65xx_phy_pdata tphy_v1_pdata = {
+static const struct mtk_phy_pdata tphy_v1_pdata = {
 	.avoid_rx_sen_degradation = false,
-	.version = MT_PHY_V1,
+	.version = MTK_PHY_V1,
 };
 
-static const struct mt65xx_phy_pdata tphy_v2_pdata = {
+static const struct mtk_phy_pdata tphy_v2_pdata = {
 	.avoid_rx_sen_degradation = false,
-	.version = MT_PHY_V2,
+	.version = MTK_PHY_V2,
 };
 
-static const struct mt65xx_phy_pdata mt8173_pdata = {
+static const struct mtk_phy_pdata mt8173_pdata = {
 	.avoid_rx_sen_degradation = true,
-	.version = MT_PHY_V1,
+	.version = MTK_PHY_V1,
 };
 
-static const struct of_device_id mt65xx_u3phy_id_table[] = {
+static const struct of_device_id mtk_tphy_id_table[] = {
 	{ .compatible = "mediatek,mt2701-u3phy", .data = &tphy_v1_pdata },
 	{ .compatible = "mediatek,mt2712-u3phy", .data = &tphy_v2_pdata },
 	{ .compatible = "mediatek,mt8173-u3phy", .data = &mt8173_pdata },
@@ -956,9 +956,9 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
 	{ .compatible = "mediatek,generic-tphy-v2", .data = &tphy_v2_pdata },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, mt65xx_u3phy_id_table);
+MODULE_DEVICE_TABLE(of, mtk_tphy_id_table);
 
-static int mt65xx_u3phy_probe(struct platform_device *pdev)
+static int mtk_tphy_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
@@ -966,50 +966,50 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 	struct device_node *child_np;
 	struct phy_provider *provider;
 	struct resource *sif_res;
-	struct mt65xx_u3phy *u3phy;
+	struct mtk_tphy *tphy;
 	struct resource res;
 	int port, retval;
 
-	match = of_match_node(mt65xx_u3phy_id_table, pdev->dev.of_node);
+	match = of_match_node(mtk_tphy_id_table, pdev->dev.of_node);
 	if (!match)
 		return -EINVAL;
 
-	u3phy = devm_kzalloc(dev, sizeof(*u3phy), GFP_KERNEL);
-	if (!u3phy)
+	tphy = devm_kzalloc(dev, sizeof(*tphy), GFP_KERNEL);
+	if (!tphy)
 		return -ENOMEM;
 
-	u3phy->pdata = match->data;
-	u3phy->nphys = of_get_child_count(np);
-	u3phy->phys = devm_kcalloc(dev, u3phy->nphys,
-				       sizeof(*u3phy->phys), GFP_KERNEL);
-	if (!u3phy->phys)
+	tphy->pdata = match->data;
+	tphy->nphys = of_get_child_count(np);
+	tphy->phys = devm_kcalloc(dev, tphy->nphys,
+				       sizeof(*tphy->phys), GFP_KERNEL);
+	if (!tphy->phys)
 		return -ENOMEM;
 
-	u3phy->dev = dev;
-	platform_set_drvdata(pdev, u3phy);
+	tphy->dev = dev;
+	platform_set_drvdata(pdev, tphy);
 
-	if (u3phy->pdata->version == MT_PHY_V1) {
+	if (tphy->pdata->version == MTK_PHY_V1) {
 		/* get banks shared by multiple phys */
 		sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		u3phy->sif_base = devm_ioremap_resource(dev, sif_res);
-		if (IS_ERR(u3phy->sif_base)) {
+		tphy->sif_base = devm_ioremap_resource(dev, sif_res);
+		if (IS_ERR(tphy->sif_base)) {
 			dev_err(dev, "failed to remap sif regs\n");
-			return PTR_ERR(u3phy->sif_base);
+			return PTR_ERR(tphy->sif_base);
 		}
 	}
 
 	/* it's deprecated, make it optional for backward compatibility */
-	u3phy->u3phya_ref = devm_clk_get(dev, "u3phya_ref");
-	if (IS_ERR(u3phy->u3phya_ref)) {
-		if (PTR_ERR(u3phy->u3phya_ref) == -EPROBE_DEFER)
+	tphy->u3phya_ref = devm_clk_get(dev, "u3phya_ref");
+	if (IS_ERR(tphy->u3phya_ref)) {
+		if (PTR_ERR(tphy->u3phya_ref) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
-		u3phy->u3phya_ref = NULL;
+		tphy->u3phya_ref = NULL;
 	}
 
 	port = 0;
 	for_each_child_of_node(np, child_np) {
-		struct mt65xx_phy_instance *instance;
+		struct mtk_phy_instance *instance;
 		struct phy *phy;
 
 		instance = devm_kzalloc(dev, sizeof(*instance), GFP_KERNEL);
@@ -1018,9 +1018,9 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		u3phy->phys[port] = instance;
+		tphy->phys[port] = instance;
 
-		phy = devm_phy_create(dev, child_np, &mt65xx_u3phy_ops);
+		phy = devm_phy_create(dev, child_np, &mtk_tphy_ops);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create phy\n");
 			retval = PTR_ERR(phy);
@@ -1047,7 +1047,7 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 		port++;
 
 		/* if deprecated clock is provided, ignore instance's one */
-		if (u3phy->u3phya_ref)
+		if (tphy->u3phya_ref)
 			continue;
 
 		instance->ref_clk = devm_clk_get(&phy->dev, "ref");
@@ -1058,7 +1058,7 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 		}
 	}
 
-	provider = devm_of_phy_provider_register(dev, mt65xx_phy_xlate);
+	provider = devm_of_phy_provider_register(dev, mtk_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(provider);
 put_child:
@@ -1066,16 +1066,16 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static struct platform_driver mt65xx_u3phy_driver = {
-	.probe		= mt65xx_u3phy_probe,
+static struct platform_driver mtk_tphy_driver = {
+	.probe		= mtk_tphy_probe,
 	.driver		= {
-		.name	= "mt65xx-u3phy",
-		.of_match_table = mt65xx_u3phy_id_table,
+		.name	= "mtk-tphy",
+		.of_match_table = mtk_tphy_id_table,
 	},
 };
 
-module_platform_driver(mt65xx_u3phy_driver);
+module_platform_driver(mtk_tphy_driver);
 
 MODULE_AUTHOR("Chunfeng Yun <chunfeng.yun@mediatek.com>");
-MODULE_DESCRIPTION("mt65xx USB PHY driver");
+MODULE_DESCRIPTION("MediaTek T-PHY driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
