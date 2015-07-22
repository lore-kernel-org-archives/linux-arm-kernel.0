From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 22 Jul 2015 20:53:07 +0800
Subject: [PATCH V2 08/11] mmc: sdhci: make max-frequency property in device
 tree work
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1437569590-5228-9-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree provides option to specify the max freqency with property
"max-frequency" in dts and common parse function mmc_of_parse() will
parse it and use this value to set host->f_max to tell the MMC core
the maxinum frequency the host works.

However, current sdhci driver will finally overwrite this value with
host->max_clk regardless of the max-frequency property.

This patch makes sure not overwrite the max-frequency set from device
tree and do basic sanity check.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 947033d..c83d110 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2874,6 +2874,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	u32 max_current_caps;
 	unsigned int ocr_avail;
 	unsigned int override_timeout_clk;
+	u32 max_clk;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -3058,18 +3059,22 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
-	mmc->f_max = host->max_clk;
+	max_clk = host->max_clk;
+
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else if (host->version >= SDHCI_SPEC_300) {
 		if (host->clk_mul) {
 			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
-			mmc->f_max = host->max_clk * host->clk_mul;
+			max_clk = host->max_clk * host->clk_mul;
 		} else
 			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
+	if (!mmc->f_max || (mmc->f_max && (mmc->f_max > max_clk)))
+		mmc->f_max = max_clk;
+
 	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
 		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
 					SDHCI_TIMEOUT_CLK_SHIFT;
-- 
1.9.1
