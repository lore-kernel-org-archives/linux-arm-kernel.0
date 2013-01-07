From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:43 +0100
Subject: [PATCH 01/16] dmaengine: ste_dma40: reset priority bit for logical
 channels
In-Reply-To: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1357557718-15676-2-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Narayanan <narayanan.gopalakrishnan@stericsson.com>

This patch sets the SSCFG/SDCFG bit[7] PRI only for physical channel
requests with high priority.  For logical channels, this bit will be
zero.

Signed-off-by: Narayanan G <narayanan.gopalakrishnan@stericsson.com>
Reviewed-by: Rabin Vincent <rabin.vincent@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40_ll.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ste_dma40_ll.c b/drivers/dma/ste_dma40_ll.c
index 851ad56..d64b72a 100644
--- a/drivers/dma/ste_dma40_ll.c
+++ b/drivers/dma/ste_dma40_ll.c
@@ -102,17 +102,18 @@ void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
 		src |= cfg->src_info.data_width << D40_SREG_CFG_ESIZE_POS;
 		dst |= cfg->dst_info.data_width << D40_SREG_CFG_ESIZE_POS;
 
+		/* Set the priority bit to high for the physical channel */
+		if (cfg->high_priority) {
+			src |= 1 << D40_SREG_CFG_PRI_POS;
+			dst |= 1 << D40_SREG_CFG_PRI_POS;
+		}
+
 	} else {
 		/* Logical channel */
 		dst |= 1 << D40_SREG_CFG_LOG_GIM_POS;
 		src |= 1 << D40_SREG_CFG_LOG_GIM_POS;
 	}
 
-	if (cfg->high_priority) {
-		src |= 1 << D40_SREG_CFG_PRI_POS;
-		dst |= 1 << D40_SREG_CFG_PRI_POS;
-	}
-
 	if (cfg->src_info.big_endian)
 		src |= 1 << D40_SREG_CFG_LBE_POS;
 	if (cfg->dst_info.big_endian)
-- 
1.7.12.1
