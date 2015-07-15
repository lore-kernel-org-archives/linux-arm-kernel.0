From: yao.yuan@freescale.com (Yuan Yao)
Date: Wed, 15 Jul 2015 17:32:58 +0800
Subject: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
References: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1436952778-28000-2-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add power management suspend/resume support for the fsl-edma
driver.

eDMA acted as a basic function used by others. What it needs to do is
the two steps below to support power management.
In fsl_edma_suspend_late:
Check whether the DMA chan is idle and if it is not idle, stop PM
operation.
In fsl_edma_resume_early:
Enable the eDMA and wait for being used.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 drivers/dma/fsl-edma.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 915eec3..f987a4f 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -116,6 +116,12 @@
 				BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
 				BIT(DMA_SLAVE_BUSWIDTH_8_BYTES)
+#ifdef CONFIG_PM
+enum fsl_edma_pm_state {
+	RUNNING = 0,
+	SUSPENDED,
+};
+#endif
 
 struct fsl_edma_hw_tcd {
 	__le32	saddr;
@@ -151,6 +157,11 @@ struct fsl_edma_chan {
 	struct fsl_edma_desc		*edesc;
 	struct fsl_edma_slave_config	fsc;
 	struct dma_pool			*tcd_pool;
+	bool				idle;
+#ifdef CONFIG_PM
+	u32				slave_id;
+	enum fsl_edma_pm_state		pm_state;
+#endif
 };
 
 struct fsl_edma_desc {
@@ -298,6 +309,7 @@ static int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 	fsl_edma_disable_request(fsl_chan);
 	fsl_chan->edesc = NULL;
+	fsl_chan->idle = true;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
@@ -313,6 +325,7 @@ static int fsl_edma_pause(struct dma_chan *chan)
 	if (fsl_chan->edesc) {
 		fsl_edma_disable_request(fsl_chan);
 		fsl_chan->status = DMA_PAUSED;
+		fsl_chan->idle = true;
 	}
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
@@ -327,6 +340,7 @@ static int fsl_edma_resume(struct dma_chan *chan)
 	if (fsl_chan->edesc) {
 		fsl_edma_enable_request(fsl_chan);
 		fsl_chan->status = DMA_IN_PROGRESS;
+		fsl_chan->idle = false;
 	}
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
@@ -648,6 +662,7 @@ static void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
 	fsl_edma_enable_request(fsl_chan);
 	fsl_chan->status = DMA_IN_PROGRESS;
+	fsl_chan->idle = false;
 }
 
 static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
@@ -676,6 +691,7 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 				vchan_cookie_complete(&fsl_chan->edesc->vdesc);
 				fsl_chan->edesc = NULL;
 				fsl_chan->status = DMA_COMPLETE;
+				fsl_chan->idle = true;
 			} else {
 				vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
 			}
@@ -704,6 +720,7 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch),
 				fsl_edma->membase + EDMA_CERR);
 			fsl_edma->chans[ch].status = DMA_ERROR;
+			fsl_edma->chans[ch].idle = true;
 		}
 	}
 	return IRQ_HANDLED;
@@ -724,6 +741,14 @@ static void fsl_edma_issue_pending(struct dma_chan *chan)
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 
+#ifdef CONFIG_PM
+	if (unlikely(fsl_chan->pm_state != RUNNING)) {
+		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
+		/* cannot submit due to suspend */
+		return;
+	}
+#endif
+
 	if (vchan_issue_pending(&fsl_chan->vchan) && !fsl_chan->edesc)
 		fsl_edma_xfer_desc(fsl_chan);
 
@@ -750,6 +775,10 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 				chan->device->privatecnt++;
 				fsl_edma_chan_mux(to_fsl_edma_chan(chan),
 					dma_spec->args[1], true);
+#ifdef CONFIG_PM
+				to_fsl_edma_chan(chan)->slave_id =
+							dma_spec->args[1];
+#endif
 				mutex_unlock(&fsl_edma->fsl_edma_mutex);
 				return chan;
 			}
@@ -888,7 +917,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
 		fsl_chan->edma = fsl_edma;
-
+#ifdef CONFIG_PM
+		fsl_chan->pm_state = RUNNING;
+		fsl_chan->slave_id = 0;
+#endif
+		fsl_chan->idle = true;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
@@ -959,6 +992,60 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int fsl_edma_suspend_late(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	struct fsl_edma_chan *fsl_chan;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		fsl_chan = &fsl_edma->chans[i];
+		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
+		/* Make sure chan is idle or can not into suspend. */
+		if (unlikely(!fsl_chan->idle))
+			goto out;
+		fsl_chan->pm_state = SUSPENDED;
+		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
+	}
+	return 0;
+
+out:
+	for (; i >= 0; i--) {
+		fsl_chan = &fsl_edma->chans[i];
+		fsl_chan->pm_state = RUNNING;
+		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
+	}
+	return -EBUSY;
+}
+
+static int fsl_edma_resume_early(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	struct fsl_edma_chan *fsl_chan;
+	int i;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		fsl_chan = &fsl_edma->chans[i];
+		fsl_chan->pm_state = RUNNING;
+		edma_writew(fsl_edma, 0x0, fsl_edma->membase + EDMA_TCD_CSR(i));
+		if (fsl_chan->slave_id != 0)
+			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
+	}
+
+	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA,
+			fsl_edma->membase + EDMA_CR);
+
+	return 0;
+}
+
+static const struct dev_pm_ops fsl_edma_pm_ops = {
+	.suspend_late   = fsl_edma_suspend_late,
+	.resume_early   = fsl_edma_resume_early,
+};
+#endif
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", },
 	{ /* sentinel */ }
@@ -969,6 +1056,9 @@ static struct platform_driver fsl_edma_driver = {
 	.driver		= {
 		.name	= "fsl-edma",
 		.of_match_table = fsl_edma_dt_ids,
+#ifdef CONFIG_PM
+		.pm     = &fsl_edma_pm_ops,
+#endif
 	},
 	.probe          = fsl_edma_probe,
 	.remove		= fsl_edma_remove,
-- 
2.1.0.27.g96db324
