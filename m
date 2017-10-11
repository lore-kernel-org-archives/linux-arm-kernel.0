From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 11 Oct 2017 10:41:36 +0800
Subject: [PATCH v5 12/12] mmc: mediatek: perfer to use rise edge latching for
 cmd line
In-Reply-To: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
References: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1507689696-25928-13-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

data lines have applied to perfer to use rise edge, also need
apply it to cmd line.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 95759bb..27a6225 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1550,7 +1550,8 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
-	if (final_rise_delay.maxlen >= 12 && final_rise_delay.start < 4)
+	if (final_rise_delay.maxlen >= 12 ||
+	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
 		goto skip_fall;
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-- 
1.8.1.1.dirty
