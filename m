From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 30 Sep 2015 17:37:18 +0800
Subject: [PATCH] mmc: core: fix dead loop of mmc_retune
Message-ID: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When get a CRC error, start the mmc_retune, it will issue CMD19/CMD21
to do tune, assume there were 10 clock phase need to try, phase 0 to
phase 6 is ok, phase 7 to phase 9 is NG, we try it from 0 to 9, so
the last CMD19/CMD21 will get CRC error, host->need_retune was set and
cause mmc_retune was called, then dead loop of mmc_retune

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..a3eb20b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -134,9 +134,11 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	int err = cmd->error;
 
 	/* Flag re-tuning needed on CRC errors */
-	if (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
+	if ((cmd->opcode != MMC_SEND_TUNING_BLOCK &&
+	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
+	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
 	    (mrq->data && mrq->data->error == -EILSEQ) ||
-	    (mrq->stop && mrq->stop->error == -EILSEQ))
+	    (mrq->stop && mrq->stop->error == -EILSEQ)))
 		mmc_retune_needed(host);
 
 	if (err && cmd->retries && mmc_host_is_spi(host)) {
-- 
1.8.1.1.dirty
