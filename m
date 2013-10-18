From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 18 Oct 2013 19:48:49 +0800
Subject: [PATCH v3 7/8] mmc: sdhci-esdhc-imx: add preset value quirk for mx6
In-Reply-To: <1382096930-7964-1-git-send-email-b29396@freescale.com>
References: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Message-ID: <1382096930-7964-8-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 does not support preset value feature.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1d1fcb2..461a4c3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1006,8 +1006,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * The imx6q ROM code will change the default watermark level setting
 	 * to something insane.  Change it back here.
 	 */
-	if (esdhc_is_usdhc(imx_data))
+	if (esdhc_is_usdhc(imx_data)) {
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
+		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
-- 
1.7.2.rc3
