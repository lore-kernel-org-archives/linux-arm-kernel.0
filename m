From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  2 Feb 2015 17:00:54 +0100
Subject: [PATCH] mmc: core: Invoke mmc_pwrseq_post_power_on() prior
 MMC_POWER_ON state
Message-ID: <1422892854-3655-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Host drivers have different ways to sends their "init stream" to the
card. Some need to do it as part of a request, some do it from the
->set_ios() callback in the MMC_POWER_ON state and some don't send an
"init stream" at all.

To be able to use the reset GPIOs from the simple MMC power sequence
provider, the card need to be powered and the "init stream" must not
have been sent.

To cope with these requirements, invoke mmc_pwrseq_post_power_on()
prior we change the state to MMC_POWER_ON in mmc_power_up().

Host drivers shall perform power up operations in the MMC_POWER_UP
state. Unfortunate three hosts (au1xmmc, cb710-mmc and toshsd) don't
conform to this expectation. Instead those ignore the MMC_POWER_UP
state and delays their power up operations to the MMC_POWER_ON state.

Those hosts needs to change their behavior to enable proper support for
the simple MMC power sequence provider.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Some background to this patch:
http://marc.info/?t=142165904000001&r=1&w=2

---
 drivers/mmc/core/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0dc64e6..23f10f7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1637,6 +1637,8 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 */
 	mmc_delay(10);
 
+	mmc_pwrseq_post_power_on(host);
+
 	host->ios.clock = host->f_init;
 
 	host->ios.power_mode = MMC_POWER_ON;
@@ -1648,8 +1650,6 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 */
 	mmc_delay(10);
 
-	mmc_pwrseq_post_power_on(host);
-
 	mmc_host_clk_release(host);
 }
 
-- 
1.9.1
