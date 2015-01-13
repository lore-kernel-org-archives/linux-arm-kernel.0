From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 22:17:03 +0100
Subject: [PATCH] dma: coh901318: fix function return types build warnings
Message-ID: <2760189.hGZZQd3ELS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent patch that removed coh901318_control() replaced it
with a number of pointers to existing functions, but those
unfortunately have the wrong return  type and need to be
changed to return an 'int' with an error value rather than
a 'void' to avoid these build warnings:

drivers/dma/coh901318.c:2697:32: warning: assignment from incompatible pointer type
  base->dma_slave.device_config = coh901318_dma_set_runtimeconfig;
                                ^
drivers/dma/coh901318.c:2698:31: warning: assignment from incompatible pointer type
  base->dma_slave.device_pause = coh901318_pause;
                               ^
drivers/dma/coh901318.c:2699:32: warning: assignment from incompatible pointer type
  base->dma_slave.device_resume = coh901318_resume

The coh901318_base_init function has the correct return type
already, but needs to be marked 'static' to avoid a sparse
warning about a missing declaration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6782af118b6c ("dmaengine: coh901318: Split device_control")

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 418e4e4fb7ba..fd22dd36985f 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1690,7 +1690,7 @@ static u32 coh901318_get_bytes_left(struct dma_chan *chan)
  * Pauses a transfer without losing data. Enables power save.
  * Use this function in conjunction with coh901318_resume.
  */
-static void coh901318_pause(struct dma_chan *chan)
+static int coh901318_pause(struct dma_chan *chan)
 {
 	u32 val;
 	unsigned long flags;
@@ -1730,12 +1730,13 @@ static void coh901318_pause(struct dma_chan *chan)
 	enable_powersave(cohc);
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
+	return 0;
 }
 
 /* Resumes a transfer that has been stopped via 300_dma_stop(..).
    Power save is handled.
 */
-static void coh901318_resume(struct dma_chan *chan)
+static int coh901318_resume(struct dma_chan *chan)
 {
 	u32 val;
 	unsigned long flags;
@@ -1760,6 +1761,7 @@ static void coh901318_resume(struct dma_chan *chan)
 	}
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
+	return 0;
 }
 
 bool coh901318_filter_id(struct dma_chan *chan, void *chan_id)
@@ -2512,8 +2514,8 @@ static const struct burst_table burst_sizes[] = {
 	},
 };
 
-static void coh901318_dma_set_runtimeconfig(struct dma_chan *chan,
-			struct dma_slave_config *config)
+static int coh901318_dma_set_runtimeconfig(struct dma_chan *chan,
+					   struct dma_slave_config *config)
 {
 	struct coh901318_chan *cohc = to_coh901318_chan(chan);
 	dma_addr_t addr;
@@ -2533,7 +2535,7 @@ static void coh901318_dma_set_runtimeconfig(struct dma_chan *chan,
 		maxburst = config->dst_maxburst;
 	} else {
 		dev_err(COHC_2_DEV(cohc), "illegal channel mode\n");
-		return;
+		return -EINVAL;
 	}
 
 	dev_dbg(COHC_2_DEV(cohc), "configure channel for %d byte transfers\n",
@@ -2579,7 +2581,7 @@ static void coh901318_dma_set_runtimeconfig(struct dma_chan *chan,
 	default:
 		dev_err(COHC_2_DEV(cohc),
 			"bad runtimeconfig: alien address width\n");
-		return;
+		return -EINVAL;
 	}
 
 	ctrl |= burst_sizes[i].reg;
@@ -2589,10 +2591,12 @@ static void coh901318_dma_set_runtimeconfig(struct dma_chan *chan,
 
 	cohc->addr = addr;
 	cohc->ctrl = ctrl;
+
+	return 0;
 }
 
-void coh901318_base_init(struct dma_device *dma, const int *pick_chans,
-			 struct coh901318_base *base)
+static void coh901318_base_init(struct dma_device *dma, const int *pick_chans,
+				struct coh901318_base *base)
 {
 	int chans_i;
 	int i = 0;
