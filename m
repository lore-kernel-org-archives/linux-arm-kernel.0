From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon,  7 Sep 2015 17:01:11 +0530
Subject: [PATCH-v2 3/3] mmc: sdhci: print notice on -EPROBE_DEFER in
 sdhci_add_host() fn
In-Reply-To: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1441625471-16315-4-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds kernel notice/message to sdhci_host_add() fn on
-EPROBE_DEFER.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dbe932..37a5cd5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3130,8 +3130,11 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	/* If there are external regulators, get them */
-	if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER)
+	if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER) {
+		pr_notice("%s: regulator supply unavailable, deferring probe.\n",
+				mmc_hostname(mmc));
 		return -EPROBE_DEFER;
+	}
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-- 
1.9.1
