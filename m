From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 27 Jul 2011 15:14:27 +0900
Subject: [RFC PATCH] DMA: PL330: Update PL330 DMAC to support runtime PM
In-Reply-To: <1311744697-10264-2-git-send-email-boojin.kim@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-2-git-send-email-boojin.kim@samsung.com>
Message-ID: <4E2FACC3.2010109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update runtime PM for PL330 DMAC to reduce power consumption.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
The following patch support runtime PM for PL330 DMAC, but the clock
of PL330 is always on. If the clock of PL330 is always on, additional power
(10mA) is consumed.

"[PATCH 01/15] DMA: PL330: Add support runtime PM for PL330 DMAC"
http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/5931

 arch/arm/plat-samsung/dma-ops.c |   21 +++++++++++
 drivers/dma/pl330.c             |   76 +++++++++++++--------------------------
 include/linux/amba/pl330.h      |   54 +++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 51 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index 9053433..b726e4a 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/amba/pl330.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/dma.h>
 
@@ -33,12 +34,23 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
 	struct dma_slave_config slave_config;
+#ifdef CONFIG_PM_RUNTIME
+	struct dma_pl330_chan *pch;
+	struct dma_pl330_dmac *pdmac;
+#endif
 
 	dma_cap_zero(mask);
 	dma_cap_set(info->cap, mask);
 
 	chan = dma_request_channel(mask, pl330_filter, (void *)dma_ch);
 
+#ifdef CONFIG_PM_RUNTIME
+	pch = container_of(chan, struct dma_pl330_chan, chan);
+	pdmac = pch->dmac;
+
+	pm_runtime_get_sync(pdmac->pif.dev);
+#endif
+
 	if (info->direction == DMA_FROM_DEVICE) {
 		memset(&slave_config, 0, sizeof(struct dma_slave_config));
 		slave_config.direction = info->direction;
@@ -59,8 +71,17 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
 static int samsung_dmadev_release(unsigned ch,
 			struct s3c2410_dma_client *client)
 {
+#ifdef CONFIG_PM_RUNTIME
+	struct dma_pl330_chan *pch =
+		container_of((struct dma_chan *)ch, struct dma_pl330_chan, chan);
+	struct dma_pl330_dmac *pdmac = pdmac = pch->dmac;;
+#endif
+
 	dma_release_channel((struct dma_chan *)ch);
 
+#ifdef CONFIG_PM_RUNTIME
+	pm_runtime_put(pdmac->pif.dev);
+#endif
 	return 0;
 }
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 121c75a..14d0ba6 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -42,57 +42,6 @@ enum desc_status {
 	DONE,
 };
 
-struct dma_pl330_chan {
-	/* Schedule desc completion */
-	struct tasklet_struct task;
-
-	/* DMA-Engine Channel */
-	struct dma_chan chan;
-
-	/* Last completed cookie */
-	dma_cookie_t completed;
-
-	/* List of to be xfered descriptors */
-	struct list_head work_list;
-
-	/* Pointer to the DMAC that manages this channel,
-	 * NULL if the channel is available to be acquired.
-	 * As the parent, this DMAC also provides descriptors
-	 * to the channel.
-	 */
-	struct dma_pl330_dmac *dmac;
-
-	/* To protect channel manipulation */
-	spinlock_t lock;
-
-	/* Token of a hardware channel thread of PL330 DMAC
-	 * NULL if the channel is available to be acquired.
-	 */
-	void *pl330_chid;
-
-	/* taks for cyclic capability */
-	struct tasklet_struct *cyclic_task;
-
-	bool cyclic;
-};
-
-struct dma_pl330_dmac {
-	struct pl330_info pif;
-
-	/* DMA-Engine Device */
-	struct dma_device ddma;
-
-	/* Pool of descriptors available for the DMAC's channels */
-	struct list_head desc_pool;
-	/* To protect desc_pool manipulation */
-	spinlock_t pool_lock;
-
-	/* Peripheral channels connected to this DMAC */
-	struct dma_pl330_chan peripherals[0]; /* keep at end */
-
-	struct clk *clk;
-};
-
 struct dma_pl330_desc {
 	/* To attach to a queue as child */
 	struct list_head node;
@@ -935,6 +884,18 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		pi->pcfg.data_bus_width / 8, pi->pcfg.num_chan,
 		pi->pcfg.num_peri, pi->pcfg.num_events);
 
+#ifdef CONFIG_PM_RUNTIME
+	/* disable the power domain */
+	ret = pm_runtime_put(&adev->dev);
+	if (ret < 0) {
+		dev_err(&adev->dev, "failed to put runtime pm\n");
+		ret = -ENODEV;
+		goto probe_err4;
+	}
+#else
+	/* disable dma clk */
+	clk_disable(pdmac->clk);
+#endif
 	return 0;
 
 probe_err4:
@@ -943,6 +904,13 @@ probe_err3:
 	free_irq(irq, pi);
 probe_err2:
 	iounmap(pi->base);
+
+#ifdef CONFIG_PM_RUNTIME
+	pm_runtime_disable(&adev->dev);
+	pm_runtime_put(&adev->dev);
+#else
+	clk_disable(pdmac->clk);
+#endif
 probe_err1:
 	release_mem_region(res->start, resource_size(res));
 	kfree(pdmac);
@@ -961,6 +929,12 @@ static int __devexit pl330_remove(struct amba_device *adev)
 	if (!pdmac)
 		return 0;
 
+#ifdef CONFIG_PM_RUNTIME
+	pm_runtime_get_sync(&adev->dev);
+#else
+	clk_enable(pdmac->clk);
+#endif
+
 	amba_set_drvdata(adev, NULL);
 
 	/* Idle the DMAC */
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index 17b0ada..d9a63fd 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -12,6 +12,9 @@
 #ifndef	__AMBA_PL330_H_
 #define	__AMBA_PL330_H_
 
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+
 #include <asm/hardware/pl330.h>
 
 struct dma_pl330_peri {
@@ -42,4 +45,55 @@ struct dma_pl330_platdata {
 	unsigned mcbuf_sz;
 };
 
+struct dma_pl330_chan {
+	/* Schedule desc completion */
+	struct tasklet_struct task;
+
+	/* DMA-Engine Channel */
+	struct dma_chan chan;
+
+	/* Last completed cookie */
+	dma_cookie_t completed;
+
+	/* List of to be xfered descriptors */
+	struct list_head work_list;
+
+	/* Pointer to the DMAC that manages this channel,
+	 * NULL if the channel is available to be acquired.
+	 * As the parent, this DMAC also provides descriptors
+	 * to the channel.
+	 */
+	struct dma_pl330_dmac *dmac;
+
+	/* To protect channel manipulation */
+	spinlock_t lock;
+
+	/* Token of a hardware channel thread of PL330 DMAC
+	 * NULL if the channel is available to be acquired.
+	 */
+	void *pl330_chid;
+
+	/* taks for cyclic capability */
+	struct tasklet_struct *cyclic_task;
+
+	bool cyclic;
+};
+
+struct dma_pl330_dmac {
+	struct pl330_info pif;
+
+	/* DMA-Engine Device */
+	struct dma_device ddma;
+
+	/* Pool of descriptors available for the DMAC's channels */
+	struct list_head desc_pool;
+	/* To protect desc_pool manipulation */
+	spinlock_t pool_lock;
+
+	/* Peripheral channels connected to this DMAC */
+	struct dma_pl330_chan peripherals[0]; /* keep at end */
+
+	struct clk *clk;
+};
+
 #endif	/* __AMBA_PL330_H_ */
