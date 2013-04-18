From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:11:57 +0100
Subject: [PATCH 15/32] dmaengine: ste_dma40: Separate Logical Global Interrupt
 Mask (GIM) unmasking
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the initial setup of a logical channel, it is necessary to unmask
the GIM in order to receive generated terminal count and error interrupts.
We're separating out this required code so it will be possible to move
the remaining code in d40_phy_cfg(), which is mostly runtime configuration
into the runtime_config() routine.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c    |    3 +++
 drivers/dma/ste_dma40_ll.c |   11 ++++++-----
 drivers/dma/ste_dma40_ll.h |    2 ++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index ec0d6ab..178a03c 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2456,6 +2456,9 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 				D40_LCPA_CHAN_SIZE + D40_LCPA_CHAN_DST_DELTA;
 	}
 
+	if (chan_is_logical(d40c))
+		d40_log_gim_unmask(&d40c->src_def_cfg, &d40c->dst_def_cfg);
+
 	dev_dbg(chan2dev(d40c), "allocated %s channel (phy %d%s)\n",
 		 chan_is_logical(d40c) ? "logical" : "physical",
 		 d40c->phy_chan->num,
diff --git a/drivers/dma/ste_dma40_ll.c b/drivers/dma/ste_dma40_ll.c
index 5eb6c10..b72d3e2 100644
--- a/drivers/dma/ste_dma40_ll.c
+++ b/drivers/dma/ste_dma40_ll.c
@@ -50,6 +50,12 @@ void d40_log_cfg(struct stedma40_chan_cfg *cfg,
 
 }
 
+void d40_log_gim_unmask(u32 *src_cfg, u32 *dst_cfg) {
+
+	*src_cfg |= 1 << D40_SREG_CFG_LOG_GIM_POS;
+	*dst_cfg |= 1 << D40_SREG_CFG_LOG_GIM_POS;
+}
+
 /* Sets up SRC and DST CFG register for both logical and physical channels */
 void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
 		 u32 *src_cfg, u32 *dst_cfg, bool is_log)
@@ -107,11 +113,6 @@ void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
 			src |= 1 << D40_SREG_CFG_PRI_POS;
 			dst |= 1 << D40_SREG_CFG_PRI_POS;
 		}
-
-	} else {
-		/* Logical channel */
-		dst |= 1 << D40_SREG_CFG_LOG_GIM_POS;
-		src |= 1 << D40_SREG_CFG_LOG_GIM_POS;
 	}
 
 	if (cfg->src_info.big_endian)
diff --git a/drivers/dma/ste_dma40_ll.h b/drivers/dma/ste_dma40_ll.h
index fdde8ef..8aad679 100644
--- a/drivers/dma/ste_dma40_ll.h
+++ b/drivers/dma/ste_dma40_ll.h
@@ -430,6 +430,8 @@ enum d40_lli_flags {
 	LLI_LAST_LINK	= 1 << 3,
 };
 
+void d40_log_gim_unmask(u32 *src_cfg, u32 *dst_cfg);
+
 void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
 		 u32 *src_cfg,
 		 u32 *dst_cfg,
-- 
1.7.10.4
