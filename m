From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 29 Jan 2015 12:36:27 +0100
Subject: [PATCH v4 4/7] mmc: sdhci-pxav3: Modify clock settings for the SDR50
 and DDR50 modes
In-Reply-To: <1422531390-31038-1-git-send-email-gregory.clement@free-electrons.com>
References: <1422531390-31038-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1422531390-31038-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>

According to erratum 'FE-2946959' both SDR50 and DDR50 modes require
specific clock adjustments in SDIO3 Configuration register.

This commit add the support of this register and for SDR50 or DDR50
mode use it as suggested by the erratum:
- Set the SDIO3 Clock Inv field in SDIO3 Configuration register to not
inverted.
- Set the Sample FeedBack Clock field to 0x1

[gregory.clement at free-electrons.com: port from 3.10]

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 58 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index c6394d81e120..0f3f597a1c60 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -62,6 +62,7 @@ struct sdhci_pxa {
 	struct clk *clk_core;
 	struct clk *clk_io;
 	u8	power_mode;
+	void __iomem *sdio3_conf_reg;
 };
 
 /*
@@ -72,6 +73,14 @@ struct sdhci_pxa {
 #define SDHCI_WINDOW_BASE(i)	(0x84 + ((i) << 3))
 #define SDHCI_MAX_WIN_NUM	8
 
+/*
+ * Fields below belong to SDIO3 Configuration Register (third register
+ * region for the Armada 38x flavor)
+ */
+
+#define SDIO3_CONF_CLK_INV	BIT(0)
+#define SDIO3_CONF_SD_FB_CLK	BIT(2)
+
 static int mv_conf_mbus_windows(struct platform_device *pdev,
 				const struct mbus_dram_target_info *dram)
 {
@@ -122,16 +131,29 @@ static int armada_38x_quirks(struct platform_device *pdev,
 			     struct sdhci_host *host)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct resource *res;
 
 	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
-	/*
-	 * According to erratum 'FE-2946959' both SDR50 and DDR50
-	 * modes require specific clock adjustments in SDIO3
-	 * Configuration register, if the adjustment is not done,
-	 * remove them from the capabilities.
-	 */
-	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
-	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "conf-sdio3");
+	if (res) {
+		pxa->sdio3_conf_reg = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(pxa->sdio3_conf_reg))
+			return PTR_ERR(pxa->sdio3_conf_reg);
+	} else {
+		/*
+		 * According to erratum 'FE-2946959' both SDR50 and DDR50
+		 * modes require specific clock adjustments in SDIO3
+		 * Configuration register, if the adjustment is not done,
+		 * remove them from the capabilities.
+		 */
+		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+
+		dev_warn(&pdev->dev, "conf-sdio3 register not found: disabling SDR50 and DDR50 modes.\nConsider updating your dtb\n");
+	}
 
 	/*
 	 * According to erratum 'ERR-7878951' Armada 38x SDHCI
@@ -226,6 +248,8 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 
 static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
 	u16 ctrl_2;
 
 	/*
@@ -255,6 +279,24 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		break;
 	}
 
+	/*
+	 * Update SDIO3 Configuration register according to erratum
+	 * FE-2946959
+	 */
+	if (pxa->sdio3_conf_reg) {
+		u8 reg_val  = readb(pxa->sdio3_conf_reg);
+
+		if (uhs == MMC_TIMING_UHS_SDR50 ||
+		    uhs == MMC_TIMING_UHS_DDR50) {
+			reg_val &= ~SDIO3_CONF_CLK_INV;
+			reg_val |= SDIO3_CONF_SD_FB_CLK;
+		} else {
+			reg_val |= SDIO3_CONF_CLK_INV;
+			reg_val &= ~SDIO3_CONF_SD_FB_CLK;
+		}
+		writeb(reg_val, pxa->sdio3_conf_reg);
+	}
+
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 	dev_dbg(mmc_dev(host->mmc),
 		"%s uhs = %d, ctrl_2 = %04X\n",
-- 
2.1.0
