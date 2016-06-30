From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 30 Jun 2016 10:01:01 +0800
Subject: [PATCH 4/4] mmc: mediatek: perfer to use rise edge latching
In-Reply-To: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
References: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1467252061-3791-5-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in our host design, rise edge latching is more stable than fall edge
latching. so that if rise edge has enough margin, no need scan fall edge.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 91277b9..84e9afc 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1328,7 +1328,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 rise_delay = 0, fall_delay = 0;
-	struct msdc_delay_phase final_rise_delay, final_fall_delay;
+	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	u8 final_delay, final_maxlen;
 	int cmd_err;
 	int i;
@@ -1341,6 +1341,11 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		if (!cmd_err)
 			rise_delay |= (1 << i);
 	}
+	final_rise_delay = get_best_delay(host, rise_delay);
+	/* if rising edge has enough margin, then do not scan falling edge */
+	if (final_rise_delay.maxlen >= 10 ||
+	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
+		goto skip_fall;
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
@@ -1350,10 +1355,9 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		if (!cmd_err)
 			fall_delay |= (1 << i);
 	}
-
-	final_rise_delay = get_best_delay(host, rise_delay);
 	final_fall_delay = get_best_delay(host, fall_delay);
 
+skip_fall:
 	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
@@ -1374,7 +1378,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 rise_delay = 0, fall_delay = 0;
-	struct msdc_delay_phase final_rise_delay, final_fall_delay;
+	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	u8 final_delay, final_maxlen;
 	int i, ret;
 
@@ -1387,6 +1391,11 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 		if (!ret)
 			rise_delay |= (1 << i);
 	}
+	final_rise_delay = get_best_delay(host, rise_delay);
+	/* if rising edge has enough margin, then do not scan falling edge */
+	if (final_rise_delay.maxlen >= 10 ||
+	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
+		goto skip_fall;
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
@@ -1397,14 +1406,10 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 		if (!ret)
 			fall_delay |= (1 << i);
 	}
-
-	final_rise_delay = get_best_delay(host, rise_delay);
 	final_fall_delay = get_best_delay(host, fall_delay);
 
+skip_fall:
 	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
-	/* Rising edge is more stable, prefer to use it */
-	if (final_rise_delay.maxlen >= 10)
-		final_maxlen = final_rise_delay.maxlen;
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
-- 
1.8.1.1.dirty
