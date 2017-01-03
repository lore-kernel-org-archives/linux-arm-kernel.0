From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 3 Jan 2017 16:49:56 +0800
Subject: [PATCH v2 1/2] mmc: core: Fix CMD6 timeout issue
In-Reply-To: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
References: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
Message-ID: <1483433397-11756-2-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

When initializing EMMC, after switch to HS400,
it will issue CMD6 to change ext_csd,
if first CMD6 got CRC error,
the repeat CMD6 may get timeout,
that's because card is not back to transfer state immediately.

For resolving this issue, it need check if card is busy
before sending repeat CMD6.

Not only CMD6 here has this issue, but also other R1B CMD has
the same issue.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/core.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1076b9d..8674dbb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -566,6 +566,25 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		mmc_retune_recheck(host);
 
+		/*
+		 * If a R1B CMD such as CMD6 occur CRC error,
+		 * it will retry 3 times here.
+		 * But before retrying, it must ensure card is in
+		 * transfer state.
+		 * Otherwise, the next retried CMD will got TMO error.
+		 */
+		if (mmc_resp_type(cmd) == MMC_RSP_R1B && host->ops->card_busy) {
+			int tries = 500; /* Wait aprox 500ms at maximum */
+
+			while (host->ops->card_busy(host) && --tries)
+				mmc_delay(1);
+
+			if (tries == 0) {
+				cmd->error = -EBUSY;
+				break;
+			}
+		}
+
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
-- 
1.7.9.5
