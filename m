From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:33:00 +0800
Subject: [PATCH V2 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336563190-19974-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

device_prep_dma_cyclic may be call in audio trigger function which is
atomic context, so we make it atomic too.

 - change channel0 lock to spinlock.
 - Use polling to wait for channel0 finish running.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/dma/imx-sdma.c |   57 ++++++++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fddccae..4fd48eb 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -24,7 +24,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
-#include <linux/wait.h>
+#include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
@@ -324,7 +324,7 @@ struct sdma_engine {
 	struct dma_device		dma_device;
 	struct clk			*clk_ipg;
 	struct clk			*clk_ahb;
-	struct mutex			channel_0_lock;
+	spinlock_t		channel_0_lock;
 	struct sdma_script_start_addrs	*script_addrs;
 };
 
@@ -402,19 +402,27 @@ static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 }
 
 /*
- * sdma_run_channel - run a channel and wait till it's done
+ * sdma_run_channel0 - run a channel and wait till it's done
  */
-static int sdma_run_channel(struct sdma_channel *sdmac)
+static int sdma_run_channel0(struct sdma_engine *sdma)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
 	int ret;
+	unsigned long timeout = 500;
 
-	init_completion(&sdmac->done);
+	sdma_enable_channel(sdma, 0);
 
-	sdma_enable_channel(sdma, channel);
+	while (!(ret = readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
+		if (timeout-- <= 0)
+			break;
+		udelay(1);
+	}
 
-	ret = wait_for_completion_timeout(&sdmac->done, HZ);
+	if (ret) {
+		/* Clear the interrupt status */
+		writel_relaxed(ret, sdma->regs + SDMA_H_INTR);
+	} else {
+		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
+	}
 
 	return ret ? 0 : -ETIMEDOUT;
 }
@@ -426,17 +434,17 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
-
-	mutex_lock(&sdma->channel_0_lock);
+	unsigned long flags;
 
 	buf_virt = dma_alloc_coherent(NULL,
 			size,
 			&buf_phys, GFP_KERNEL);
 	if (!buf_virt) {
-		ret = -ENOMEM;
-		goto err_out;
+		return -ENOMEM;
 	}
 
+	spin_lock_irqsave(&sdma->channel_0_lock, flags);
+
 	bd0->mode.command = C0_SETPM;
 	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
 	bd0->mode.count = size / 2;
@@ -445,12 +453,11 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 
 	memcpy(buf_virt, buf, size);
 
-	ret = sdma_run_channel(&sdma->channel[0]);
+	ret = sdma_run_channel0(sdma);
 
-	dma_free_coherent(NULL, size, buf_virt, buf_phys);
+	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-err_out:
-	mutex_unlock(&sdma->channel_0_lock);
+	dma_free_coherent(NULL, size, buf_virt, buf_phys);
 
 	return ret;
 }
@@ -539,10 +546,6 @@ static void mxc_sdma_handle_channel(struct sdma_channel *sdmac)
 {
 	complete(&sdmac->done);
 
-	/* not interested in channel 0 interrupts */
-	if (sdmac->channel == 0)
-		return;
-
 	if (sdmac->flags & IMX_DMA_SG_LOOP)
 		sdma_handle_channel_loop(sdmac);
 	else
@@ -555,6 +558,8 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 	unsigned long stat;
 
 	stat = readl_relaxed(sdma->regs + SDMA_H_INTR);
+	/* not interested in channel 0 interrupts */
+	stat &= ~1;
 	writel_relaxed(stat, sdma->regs + SDMA_H_INTR);
 
 	while (stat) {
@@ -660,6 +665,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	struct sdma_context_data *context = sdma->context;
 	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
 	int ret;
+	unsigned long flags;
 
 	if (sdmac->direction == DMA_DEV_TO_MEM) {
 		load_address = sdmac->pc_from_device;
@@ -677,7 +683,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	dev_dbg(sdma->dev, "event_mask0 = 0x%08x\n", (u32)sdmac->event_mask[0]);
 	dev_dbg(sdma->dev, "event_mask1 = 0x%08x\n", (u32)sdmac->event_mask[1]);
 
-	mutex_lock(&sdma->channel_0_lock);
+	spin_lock_irqsave(&sdma->channel_0_lock, flags);
 
 	memset(context, 0, sizeof(*context));
 	context->channel_state.pc = load_address;
@@ -696,10 +702,9 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	bd0->mode.count = sizeof(*context) / 4;
 	bd0->buffer_addr = sdma->context_phys;
 	bd0->ext_buffer_addr = 2048 + (sizeof(*context) / 4) * channel;
+	ret = sdma_run_channel0(sdma);
 
-	ret = sdma_run_channel(&sdma->channel[0]);
-
-	mutex_unlock(&sdma->channel_0_lock);
+	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
 	return ret;
 }
@@ -1305,7 +1310,7 @@ static int __init sdma_probe(struct platform_device *pdev)
 	if (!sdma)
 		return -ENOMEM;
 
-	mutex_init(&sdma->channel_0_lock);
+	spin_lock_init(&sdma->channel_0_lock);
 
 	sdma->dev = &pdev->dev;
 
-- 
1.7.5.4
