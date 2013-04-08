From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  8 Apr 2013 16:23:11 +0100
Subject: [PATCH 5/5] dmaengine: ste_dma40: Move LCPA allocation and real-time
 config
In-Reply-To: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1365434591-21569-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are various pieces of configuration which do not need to happen
until after a channel is allocated. Here we move some of these so they're
dealt with when it's time to configure the channel, rather than allocate
it.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 3543ea4..8a71bf6 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2472,18 +2472,6 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 
 	pm_runtime_get_sync(d40c->base->dev);
 
-	d40_set_prio_realtime(d40c);
-
-	if (chan_is_logical(d40c)) {
-		if (d40c->dma_cfg.dir == STEDMA40_PERIPH_TO_MEM)
-			d40c->lcpa = d40c->base->lcpa_base +
-				d40c->dma_cfg.src_dev_type * D40_LCPA_CHAN_SIZE;
-		else
-			d40c->lcpa = d40c->base->lcpa_base +
-				d40c->dma_cfg.dst_dev_type *
-				D40_LCPA_CHAN_SIZE + D40_LCPA_CHAN_DST_DELTA;
-	}
-
 	dev_dbg(chan2dev(d40c), "allocated %s channel (phy %d%s)\n",
 		 chan_is_logical(d40c) ? "logical" : "physical",
 		 d40c->phy_chan->num,
@@ -2830,6 +2818,18 @@ static int d40_set_runtime_config(struct dma_chan *chan,
 		d40_phy_cfg(cfg, &d40c->src_def_cfg,
 			    &d40c->dst_def_cfg, false);
 
+	d40_set_prio_realtime(d40c);
+
+	if (chan_is_logical(d40c)) {
+		if (cfg->dir == STEDMA40_PERIPH_TO_MEM)
+			d40c->lcpa = d40c->base->lcpa_base +
+				cfg->src_dev_type * D40_LCPA_CHAN_SIZE;
+		else
+			d40c->lcpa = d40c->base->lcpa_base +
+				cfg->dst_dev_type *
+				D40_LCPA_CHAN_SIZE + D40_LCPA_CHAN_DST_DELTA;
+	}
+
 	/* These settings will take precedence later */
 	d40c->runtime_addr = config_addr;
 	d40c->runtime_direction = config->direction;
-- 
1.7.10.4
