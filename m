From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Mon, 18 Apr 2016 15:13:29 +0800
Subject: [PATCH] mmc: mediatek: fix request blocked by cancel_delayed_work
Message-ID: <1460963609-16179-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there are 2 points will cause could not call mmc_request_done()
and eventually cause the caller thread blocked.

A. if card was busy, cancel_delayed_work() will return false because
the delay work has not been scheduled, in this case, need put
mod_delayed_work() in front of msdc_cmd_is_ready()

B. if a request really need more than 5s(Some Sandisk TF card), it will
use cancel_delayed_work() to cancel itself, and also return false, so use
in_interrupt() to avoid this case

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b17f30d..1511b1b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -724,7 +724,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	bool ret;
 
 	ret = cancel_delayed_work(&host->req_timeout);
-	if (!ret) {
+	if (!ret && in_interrupt()) {
 		/* delay work already running */
 		return;
 	}
@@ -824,7 +824,12 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 	}
 
 	if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
-		tmo = jiffies + msecs_to_jiffies(20);
+		/*
+		 * 2550ms is from EXT_CSD[248], after switch to hs200,
+		 * using CMD13 to polling card status, it will get response
+		 * of 0x800, but EMMC still pull-low DAT0.
+		 */
+		tmo = jiffies + msecs_to_jiffies(2550);
 		/* R1B or with data, should check SDCBUSY */
 		while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
 				time_before(jiffies, tmo))
@@ -847,6 +852,7 @@ static void msdc_start_command(struct msdc_host *host,
 	WARN_ON(host->cmd);
 	host->cmd = cmd;
 
+	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 	if (!msdc_cmd_is_ready(host, mrq, cmd))
 		return;
 
@@ -858,7 +864,6 @@ static void msdc_start_command(struct msdc_host *host,
 
 	cmd->error = 0;
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
-	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 
 	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
 	writel(cmd->arg, host->base + SDC_ARG);
-- 
1.8.1.1.dirty
