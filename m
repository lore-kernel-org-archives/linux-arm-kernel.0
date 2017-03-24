From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Fri, 24 Mar 2017 14:19:00 +0800
Subject: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
In-Reply-To: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch is refine for 'commit c6dbab9cb58f ("mmc: core: Hold re-tuning
during switch commands")'
Since it has 3 retries at max for CMD6, if the first CMD6 got CRC error,
then should do re-tune before the next CMD6 was sent.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc_ops.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index fe80f26..6931927 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -534,8 +534,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	bool use_r1b_resp = use_busy_signal;
 	unsigned char old_timing = host->ios.timing;
 
-	mmc_retune_hold(host);
-
 	/*
 	 * If the cmd timeout and the max_busy_timeout of the host are both
 	 * specified, let's validate them. A failure means we need to prevent
@@ -567,6 +565,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.sanitize_busy = true;
 
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	mmc_retune_hold(host);
 	if (err)
 		goto out;
 
-- 
1.7.9.5
