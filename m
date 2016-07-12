From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 12 Jul 2016 15:46:13 +0800
Subject: [PATCH V2 04/15] mmc: sdhci-esdhc-imx: restore watermark level
 setting after resume
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1468309584-3591-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we config the watermark_level register only in probe.
This will cause the mmc write operation timeout issue after system
resume back in LPSR mode. Because in LPSR mode, after system resume
back, the watermark_level register(0x44) changes to 0x08000880, which
set the write watermark level as 0, and set the read watermark level
as 128. This value is incorrect.

This patch restores the setting of watermark level register after
system resume back.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f94c1efff830..91c6a6864e15 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -39,6 +39,7 @@
 #define  ESDHC_VENDOR_SPEC_VSELECT	(1 << 1)
 #define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON	(1 << 8)
 #define ESDHC_WTMK_LVL			0x44
+#define  ESDHC_WTMK_DEFAULT_VAL		0x10401040
 #define ESDHC_MIX_CTRL			0x48
 #define  ESDHC_MIX_CTRL_DDREN		(1 << 3)
 #define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
@@ -1157,7 +1158,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * to something insane.  Change it back here.
 	 */
 	if (esdhc_is_usdhc(imx_data)) {
-		writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
+		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
 
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
@@ -1261,6 +1262,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
 
 static int sdhci_esdhc_resume(struct device *dev)
 {
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	/* restore watermark setting in case it's lost in low power mode */
+	if (esdhc_is_usdhc(imx_data))
+		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
+
 	return sdhci_pltfm_resume(dev);
 }
 
-- 
1.9.1
