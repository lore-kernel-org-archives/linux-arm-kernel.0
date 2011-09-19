From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 19 Sep 2011 11:58:57 +0530
Subject: [PATCH 1/6] DMA: PL330: move filter function into driver
In-Reply-To: <1316413742-23535-1-git-send-email-thomas.abraham@linaro.org>
References: <1316413742-23535-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1316413742-23535-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma channel selection filter function is moved from plat-samsung
into the pl330 driver. In additon to that, a check is added in the
filter function to ensure that the channel on which the filter has
been invoked is pl330 channel instance (and avoid any incorrect
access of chan->private in a system with multiple types of DMA
drivers).

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/plat-samsung/dma-ops.c |    6 ------
 drivers/dma/pl330.c             |   15 +++++++++++++++
 include/linux/amba/pl330.h      |    2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index 6e3d9ab..8d18425 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -17,12 +17,6 @@
 
 #include <mach/dma.h>
 
-static inline bool pl330_filter(struct dma_chan *chan, void *param)
-{
-	struct dma_pl330_peri *peri = chan->private;
-	return peri->peri_id == (unsigned)param;
-}
-
 static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
 				struct samsung_dma_info *info)
 {
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 621134f..5f1d24c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -116,6 +116,9 @@ struct dma_pl330_desc {
 	struct dma_pl330_chan *pchan;
 };
 
+/* forward declaration */
+static struct amba_driver pl330_driver;
+
 static inline struct dma_pl330_chan *
 to_pchan(struct dma_chan *ch)
 {
@@ -267,6 +270,18 @@ static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
 	tasklet_schedule(&pch->task);
 }
 
+bool pl330_filter(struct dma_chan *chan, void *param)
+{
+	struct dma_pl330_peri *peri;
+
+	if (chan->device->dev->driver != &pl330_driver.drv)
+		return false;
+
+	peri = chan->private;
+	return peri->peri_id == (unsigned)param;
+}
+EXPORT_SYMBOL(pl330_filter);
+
 static int pl330_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index d12f077..6db72da 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -12,6 +12,7 @@
 #ifndef	__AMBA_PL330_H_
 #define	__AMBA_PL330_H_
 
+#include <linux/dmaengine.h>
 #include <asm/hardware/pl330.h>
 
 struct dma_pl330_peri {
@@ -38,4 +39,5 @@ struct dma_pl330_platdata {
 	unsigned mcbuf_sz;
 };
 
+extern bool pl330_filter(struct dma_chan *chan, void *param);
 #endif	/* __AMBA_PL330_H_ */
-- 
1.6.6.rc2
