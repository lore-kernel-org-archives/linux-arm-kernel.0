From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 9 Oct 2013 19:20:15 +0800
Subject: [PATCH 09/10] mmc: sdhci-esdhc-imx: add preset value quirk for mx6
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Message-ID: <1381317616-1229-10-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 does not support preset value feature.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8879974..5cd70e0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -995,8 +995,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * The imx6q ROM code will change the default watermark level setting
 	 * to something insane.  Change it back here.
 	 */
-	if (is_imx6_usdhc(imx_data))
+	if (is_imx6_usdhc(imx_data)) {
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
+		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+	}
 
 	if (is_imx6q_usdhc(imx_data))
 		sdhci_esdhc_ops.platform_execute_tuning =
-- 
1.7.2.rc3
