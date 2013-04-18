From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:11:59 +0100
Subject: [PATCH 17/32] dmaengine: ste_dma40: Remove redundant argument from
 d40_phy_cfg()
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

d40_phy_cfg is now only ever called to configure physical channels, so
there's no requirement to pass though an argument describing the type
of channel and to subsequently test for it.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c    |    3 +-
 drivers/dma/ste_dma40_ll.c |  101 +++++++++++++++++++++-----------------------
 drivers/dma/ste_dma40_ll.h |    3 +-
 3 files changed, 50 insertions(+), 57 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 1c570b6..ff41972 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2799,8 +2799,7 @@ static int d40_set_runtime_config(struct dma_chan *chan,
 	if (chan_is_logical(d40c))
 		d40_log_cfg(cfg, &d40c->log_def.lcsp1, &d40c->log_def.lcsp3);
 	else
-		d40_phy_cfg(cfg, &d40c->src_def_cfg,
-			    &d40c->dst_def_cfg, false);
+		d40_phy_cfg(cfg, &d40c->src_def_cfg, &d40c->dst_def_cfg);
 
 	/* These settings will take precedence later */
 	d40c->runtime_addr = config_addr;
diff --git a/drivers/dma/ste_dma40_ll.c b/drivers/dma/ste_dma40_ll.c
index b72d3e2..9ab9dff 100644
--- a/drivers/dma/ste_dma40_ll.c
+++ b/drivers/dma/ste_dma40_ll.c
@@ -56,63 +56,58 @@ void d40_log_gim_unmask(u32 *src_cfg, u32 *dst_cfg) {
 	*dst_cfg |= 1 << D40_SREG_CFG_LOG_GIM_POS;
 }
 
-/* Sets up SRC and DST CFG register for both logical and physical channels */
-void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
-		 u32 *src_cfg, u32 *dst_cfg, bool is_log)
+void d40_phy_cfg(struct stedma40_chan_cfg *cfg, u32 *src_cfg, u32 *dst_cfg)
 {
 	u32 src = 0;
 	u32 dst = 0;
 
-	if (!is_log) {
-		/* Physical channel */
-		if ((cfg->dir ==  STEDMA40_PERIPH_TO_MEM) ||
-		    (cfg->dir == STEDMA40_PERIPH_TO_PERIPH)) {
-			/* Set master port to 1 */
-			src |= 1 << D40_SREG_CFG_MST_POS;
-			src |= D40_TYPE_TO_EVENT(cfg->dev_type);
-
-			if (cfg->src_info.flow_ctrl == STEDMA40_NO_FLOW_CTRL)
-				src |= 1 << D40_SREG_CFG_PHY_TM_POS;
-			else
-				src |= 3 << D40_SREG_CFG_PHY_TM_POS;
-		}
-		if ((cfg->dir ==  STEDMA40_MEM_TO_PERIPH) ||
-		    (cfg->dir == STEDMA40_PERIPH_TO_PERIPH)) {
-			/* Set master port to 1 */
-			dst |= 1 << D40_SREG_CFG_MST_POS;
-			dst |= D40_TYPE_TO_EVENT(cfg->dev_type);
-
-			if (cfg->dst_info.flow_ctrl == STEDMA40_NO_FLOW_CTRL)
-				dst |= 1 << D40_SREG_CFG_PHY_TM_POS;
-			else
-				dst |= 3 << D40_SREG_CFG_PHY_TM_POS;
-		}
-		/* Interrupt on end of transfer for destination */
-		dst |= 1 << D40_SREG_CFG_TIM_POS;
-
-		/* Generate interrupt on error */
-		src |= 1 << D40_SREG_CFG_EIM_POS;
-		dst |= 1 << D40_SREG_CFG_EIM_POS;
-
-		/* PSIZE */
-		if (cfg->src_info.psize != STEDMA40_PSIZE_PHY_1) {
-			src |= 1 << D40_SREG_CFG_PHY_PEN_POS;
-			src |= cfg->src_info.psize << D40_SREG_CFG_PSIZE_POS;
-		}
-		if (cfg->dst_info.psize != STEDMA40_PSIZE_PHY_1) {
-			dst |= 1 << D40_SREG_CFG_PHY_PEN_POS;
-			dst |= cfg->dst_info.psize << D40_SREG_CFG_PSIZE_POS;
-		}
-
-		/* Element size */
-		src |= cfg->src_info.data_width << D40_SREG_CFG_ESIZE_POS;
-		dst |= cfg->dst_info.data_width << D40_SREG_CFG_ESIZE_POS;
-
-		/* Set the priority bit to high for the physical channel */
-		if (cfg->high_priority) {
-			src |= 1 << D40_SREG_CFG_PRI_POS;
-			dst |= 1 << D40_SREG_CFG_PRI_POS;
-		}
+	if ((cfg->dir ==  STEDMA40_PERIPH_TO_MEM) ||
+	    (cfg->dir == STEDMA40_PERIPH_TO_PERIPH)) {
+		/* Set master port to 1 */
+		src |= 1 << D40_SREG_CFG_MST_POS;
+		src |= D40_TYPE_TO_EVENT(cfg->dev_type);
+
+		if (cfg->src_info.flow_ctrl == STEDMA40_NO_FLOW_CTRL)
+			src |= 1 << D40_SREG_CFG_PHY_TM_POS;
+		else
+			src |= 3 << D40_SREG_CFG_PHY_TM_POS;
+	}
+	if ((cfg->dir ==  STEDMA40_MEM_TO_PERIPH) ||
+	    (cfg->dir == STEDMA40_PERIPH_TO_PERIPH)) {
+		/* Set master port to 1 */
+		dst |= 1 << D40_SREG_CFG_MST_POS;
+		dst |= D40_TYPE_TO_EVENT(cfg->dev_type);
+
+		if (cfg->dst_info.flow_ctrl == STEDMA40_NO_FLOW_CTRL)
+			dst |= 1 << D40_SREG_CFG_PHY_TM_POS;
+		else
+			dst |= 3 << D40_SREG_CFG_PHY_TM_POS;
+	}
+	/* Interrupt on end of transfer for destination */
+	dst |= 1 << D40_SREG_CFG_TIM_POS;
+
+	/* Generate interrupt on error */
+	src |= 1 << D40_SREG_CFG_EIM_POS;
+	dst |= 1 << D40_SREG_CFG_EIM_POS;
+
+	/* PSIZE */
+	if (cfg->src_info.psize != STEDMA40_PSIZE_PHY_1) {
+		src |= 1 << D40_SREG_CFG_PHY_PEN_POS;
+		src |= cfg->src_info.psize << D40_SREG_CFG_PSIZE_POS;
+	}
+	if (cfg->dst_info.psize != STEDMA40_PSIZE_PHY_1) {
+		dst |= 1 << D40_SREG_CFG_PHY_PEN_POS;
+		dst |= cfg->dst_info.psize << D40_SREG_CFG_PSIZE_POS;
+	}
+
+	/* Element size */
+	src |= cfg->src_info.data_width << D40_SREG_CFG_ESIZE_POS;
+	dst |= cfg->dst_info.data_width << D40_SREG_CFG_ESIZE_POS;
+
+	/* Set the priority bit to high for the physical channel */
+	if (cfg->high_priority) {
+		src |= 1 << D40_SREG_CFG_PRI_POS;
+		dst |= 1 << D40_SREG_CFG_PRI_POS;
 	}
 
 	if (cfg->src_info.big_endian)
diff --git a/drivers/dma/ste_dma40_ll.h b/drivers/dma/ste_dma40_ll.h
index 8aad679..e54df09 100644
--- a/drivers/dma/ste_dma40_ll.h
+++ b/drivers/dma/ste_dma40_ll.h
@@ -434,8 +434,7 @@ void d40_log_gim_unmask(u32 *src_cfg, u32 *dst_cfg);
 
 void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
 		 u32 *src_cfg,
-		 u32 *dst_cfg,
-		 bool is_log);
+		 u32 *dst_cfg);
 
 void d40_log_cfg(struct stedma40_chan_cfg *cfg,
 		 u32 *lcsp1,
-- 
1.7.10.4
