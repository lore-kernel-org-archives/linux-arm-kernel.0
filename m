From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 21 Oct 2010 23:20:28 +0200
Subject: [PATCH 2/2] sdhci-esdhc-imx: enable QUIRK_NO_MULTIBLOCK only for
	i.MX25 and i.MX35
In-Reply-To: <4CC0A281.1010202@eukrea.com>
References: <4CC0A281.1010202@eukrea.com>
Message-ID: <1287696028-27854-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

only these CPU's errata list this bug.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 11e1ae1..4d67f58 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -136,6 +136,12 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 	}
 
+	/* fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
+	if (cpu_is_mx25() || cpu_is_mx35()) {
+		dev_info(mmc_dev(host->mmc), "using ENGcm07207 workaround\n");
+		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
+	}
+
 	return 0;
 }
 
@@ -162,10 +168,8 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 };
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
-			| SDHCI_QUIRK_BROKEN_ADMA,
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
 	/* ADMA has issues. Might be fixable */
-	/* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
 	.ops = &sdhci_esdhc_ops,
 	.init = esdhc_pltfm_init,
 	.exit = esdhc_pltfm_exit,
-- 
1.7.0.4
