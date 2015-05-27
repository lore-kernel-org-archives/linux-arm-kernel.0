From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 27 May 2015 18:13:31 +0800
Subject: [PATCH 6/6] mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200
 for imx6qdl
In-Reply-To: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
References: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1432721611-31214-7-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iMX6Q/DL can not support HS200 mode while iMX6SL and iMX6SX can,
so introduce a new flag to distinguish them.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index bcb5673..faf0cb9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -118,6 +118,8 @@
  * when reading data from the card
  */
 #define ESDHC_FLAG_ERR004536		BIT(7)
+/* The IP supports HS200 mode */
+#define ESDHC_FLAG_HS200		BIT(8)
 
 struct esdhc_soc_data {
 	u32 flags;
@@ -145,12 +147,13 @@ static struct esdhc_soc_data usdhc_imx6q_data = {
 
 static struct esdhc_soc_data usdhc_imx6sl_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
-			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
+			| ESDHC_FLAG_HS200,
 };
 
 static struct esdhc_soc_data usdhc_imx6sx_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
-			| ESDHC_FLAG_HAVE_CAP1,
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
 };
 
 struct pltfm_imx_data {
@@ -1004,6 +1007,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
+			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
+
 		/*
 		* errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
 		* TO1.1, it's harmless for MX6SL
-- 
1.9.1
