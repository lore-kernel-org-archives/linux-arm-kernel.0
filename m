From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 28 Jan 2016 10:03:42 +0000
Subject: [PATCH v2 2/3] mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
In-Reply-To: <1453975315-13424-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1453975315-13424-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1453975422-13522-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to_pwrseq_emmc() macro to make the code more readable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq_emmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index 4a82bc7..c2d732a 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -25,6 +25,8 @@ struct mmc_pwrseq_emmc {
 	struct gpio_desc *reset_gpio;
 };
 
+#define to_pwrseq_emmc(p) container_of(p, struct mmc_pwrseq_emmc, pwrseq)
+
 static void __mmc_pwrseq_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)
 {
 	gpiod_set_value(pwrseq->reset_gpio, 1);
@@ -35,16 +37,14 @@ static void __mmc_pwrseq_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)
 
 static void mmc_pwrseq_emmc_reset(struct mmc_host *host)
 {
-	struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_emmc, pwrseq);
+	struct mmc_pwrseq_emmc *pwrseq =  to_pwrseq_emmc(host->pwrseq);
 
 	__mmc_pwrseq_emmc_reset(pwrseq);
 }
 
 static void mmc_pwrseq_emmc_free(struct mmc_host *host)
 {
-	struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_emmc, pwrseq);
+	struct mmc_pwrseq_emmc *pwrseq =  to_pwrseq_emmc(host->pwrseq);
 
 	unregister_restart_handler(&pwrseq->reset_nb);
 	gpiod_put(pwrseq->reset_gpio);
-- 
1.9.1
