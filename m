From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 11 Sep 2013 11:38:04 +0530
Subject: [PATCH 2/3] ARM: SAMSUNG: Add residue DMA operation.
In-Reply-To: <1378879685-5352-1-git-send-email-padma.v@samsung.com>
References: <1378879685-5352-1-git-send-email-padma.v@samsung.com>
Message-ID: <1378879685-5352-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dylan Reid <dgreid@chromium.org>

Add a new dma op, residue.  It returns the count of bytes left to be
transfered by the dma.  This is useful for Audio, the Samsung dma ASoC
layer will use this to provide an accurate update to the hw_ptr that is
exported to user space.  ASoC wants large transfers to reduce the amount
of wakeups, but needs to be able to know how much audio has been played
for latency estimates.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/plat-samsung/dma-ops.c              |   14 ++++++++++++++
 arch/arm/plat-samsung/include/plat/dma-ops.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index ec0d731..bfc6c1a 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -122,6 +122,19 @@ static inline int samsung_dmadev_flush(unsigned ch)
 	return dmaengine_terminate_all((struct dma_chan *)ch);
 }
 
+static unsigned samsung_dmadev_residue(unsigned ch)
+{
+	struct dma_chan *chan = (struct dma_chan *)ch;
+	enum dma_status ret;
+	struct dma_tx_state state;
+
+	ret = chan->device->device_tx_status(chan, chan->cookie, &state);
+	if (ret == DMA_SUCCESS) /* Transfer complete. */
+		return 0;
+
+	return state.residue;
+}
+
 static struct samsung_dma_ops dmadev_ops = {
 	.request	= samsung_dmadev_request,
 	.release	= samsung_dmadev_release,
@@ -131,6 +144,7 @@ static struct samsung_dma_ops dmadev_ops = {
 	.started	= NULL,
 	.flush		= samsung_dmadev_flush,
 	.stop		= samsung_dmadev_flush,
+	.residue	= samsung_dmadev_residue,
 };
 
 void *samsung_dmadev_get_ops(void)
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
index ce6d763..82eac53 100644
--- a/arch/arm/plat-samsung/include/plat/dma-ops.h
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -47,6 +47,7 @@ struct samsung_dma_ops {
 	int (*started)(unsigned ch);
 	int (*flush)(unsigned ch);
 	int (*stop)(unsigned ch);
+	unsigned (*residue)(unsigned ch);
 };
 
 extern void *samsung_dmadev_get_ops(void);
-- 
1.7.4.4
