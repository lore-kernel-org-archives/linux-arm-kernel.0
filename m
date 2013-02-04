From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 04 Feb 2013 14:17:55 +0530
Subject: [PATCH] ARM: SAMSUNG: dma: Remove unnecessary code
Message-ID: <1359967675-624-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the usage of DMACH_DT_PROP and dt_dmach_prop
from dma code as the new generic dma dt binding support has been
added.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

The functionality of this patch is dependent on following patches in the link.
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15402.html

This patch is made based on Mark Brown next branch.

 arch/arm/mach-s3c24xx/include/mach/dma.h       |    1 -
 arch/arm/mach-s3c64xx/include/mach/dma.h       |    1 -
 arch/arm/plat-samsung/dma-ops.c                |   10 +---------
 arch/arm/plat-samsung/include/plat/dma-ops.h   |    1 -
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    1 -
 5 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/dma.h b/arch/arm/mach-s3c24xx/include/mach/dma.h
index 6b72d5a..b55da1d 100644
--- a/arch/arm/mach-s3c24xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c24xx/include/mach/dma.h
@@ -24,7 +24,6 @@
 */
 
 enum dma_ch {
-	DMACH_DT_PROP = -1,	/* not yet supported, do not use */
 	DMACH_XD0 = 0,
 	DMACH_XD1,
 	DMACH_SDI,
diff --git a/arch/arm/mach-s3c64xx/include/mach/dma.h b/arch/arm/mach-s3c64xx/include/mach/dma.h
index 57b1ff4..fe1a98c 100644
--- a/arch/arm/mach-s3c64xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c64xx/include/mach/dma.h
@@ -21,7 +21,6 @@
  */
 enum dma_ch {
 	/* DMA0/SDMA0 */
-	DMACH_DT_PROP = -1, /* not yet supported, do not use */
 	DMACH_UART0 = 0,
 	DMACH_UART0_SRC2,
 	DMACH_UART1,
diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index 71d58dd..ec0d731 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -23,23 +23,15 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
 				struct device *dev, char *ch_name)
 {
 	dma_cap_mask_t mask;
-	void *filter_param;
 
 	dma_cap_zero(mask);
 	dma_cap_set(param->cap, mask);
 
-	/*
-	 * If a dma channel property of a device node from device tree is
-	 * specified, use that as the fliter parameter.
-	 */
-	filter_param = (dma_ch == DMACH_DT_PROP) ?
-		(void *)param->dt_dmach_prop : (void *)dma_ch;
-
 	if (dev->of_node)
 		return (unsigned)dma_request_slave_channel(dev, ch_name);
 	else
 		return (unsigned)dma_request_channel(mask, pl330_filter,
-							filter_param);
+							(void *)dma_ch);
 }
 
 static int samsung_dmadev_release(unsigned ch, void *param)
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
index 1141782..ce6d763 100644
--- a/arch/arm/plat-samsung/include/plat/dma-ops.h
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -18,7 +18,6 @@
 
 struct samsung_dma_req {
 	enum dma_transaction_type cap;
-	struct property *dt_dmach_prop;
 	struct s3c2410_dma_client *client;
 };
 
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index d384a80..abe07fa 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -21,7 +21,6 @@
  * use these just as IDs.
  */
 enum dma_ch {
-	DMACH_DT_PROP = -1,
 	DMACH_UART0_RX = 0,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
-- 
1.7.4.4
