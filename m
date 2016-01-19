From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 19 Jan 2016 10:58:59 +0000
Subject: [RFC PATCH 1/3] mmc: pwrseq_simple: add to_pwrseq_simple() macro
In-Reply-To: <1453201052-2347-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1453201052-2347-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1453201139-2474-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to_pwrseq_simple() macro to make the code more readable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq_simple.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index d10538b..c091f98 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -26,6 +26,8 @@ struct mmc_pwrseq_simple {
 	struct gpio_descs *reset_gpios;
 };
 
+#define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
+
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 					      int value)
 {
@@ -42,8 +44,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
 		clk_prepare_enable(pwrseq->ext_clk);
@@ -55,16 +56,14 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
 static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 
@@ -76,8 +75,7 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 
 static void mmc_pwrseq_simple_free(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	gpiod_put_array(pwrseq->reset_gpios);
 
-- 
1.9.1
