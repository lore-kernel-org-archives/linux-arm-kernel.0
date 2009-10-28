From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:49 +0000
Subject: [PATCH 08/12] ARM: S3C: Add info for supporting circular DMA buffers
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C64XX DMA implementation will work a lot better with the ability
to enqueue circular buffers as the hardware can do it's own linked-list
management.

Add a function s3c_dma_has_circular() to show that the system can do this
and a flag for the channel.

Update the s3c24xx/s3c64xx I2S DMA code to deal with this.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
CC: Mark Brown <broonie@@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c2410/include/mach/dma.h |    7 +++++++
 arch/arm/mach-s3c6400/include/mach/dma.h |    5 +++++
 sound/soc/s3c24xx/s3c24xx-pcm.c          |   17 +++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
index c3a2629..92e2687 100644
--- a/arch/arm/mach-s3c2410/include/mach/dma.h
+++ b/arch/arm/mach-s3c2410/include/mach/dma.h
@@ -110,6 +110,8 @@ enum s3c2410_dma_loadst {
 					    * waiting for reloads */
 #define S3C2410_DMAF_AUTOSTART    (1<<1)   /* auto-start if buffer queued */
 
+#define S3C2410_DMAF_CIRCULAR	(1 << 2)	/* no circular dma support */
+
 /* dma buffer */
 
 struct s3c2410_dma_buf;
@@ -194,4 +196,9 @@ struct s3c2410_dma_chan {
 
 typedef unsigned long dma_device_t;
 
+static inline bool s3c_dma_has_circular(void)
+{
+	return false;
+}
+
 #endif /* __ASM_ARCH_DMA_H */
diff --git a/arch/arm/mach-s3c6400/include/mach/dma.h b/arch/arm/mach-s3c6400/include/mach/dma.h
index 1067619..004edab 100644
--- a/arch/arm/mach-s3c6400/include/mach/dma.h
+++ b/arch/arm/mach-s3c6400/include/mach/dma.h
@@ -68,6 +68,11 @@ static __inline__ int s3c_dma_has_circular(void)
 
 #define S3C2410_DMAF_CIRCULAR		(1 << 0)
 
+static inline bool s3c_dma_has_circular(void)
+{
+	return false;
+}
+
 #include <plat/dma.h>
 
 #endif /* __ASM_ARCH_IRQ_H */
diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 5cbbdc8..1f35c6f 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -75,11 +75,19 @@ static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
+	unsigned int limit;
 	int ret;
 
 	pr_debug("Entered %s\n", __func__);
 
-	while (prtd->dma_loaded < prtd->dma_limit) {
+	if (s3c_dma_has_circular()) {
+		limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
+	} else
+		limit = prtd->dma_limit;
+
+	pr_debug("%s: loaded %d, limit %d\n", __func__, prtd->dma_loaded, limit);
+
+	while (prtd->dma_loaded < limit) {
 		unsigned long len = prtd->dma_period;
 
 		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
@@ -123,7 +131,7 @@ static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
 		snd_pcm_period_elapsed(substream);
 
 	spin_lock(&prtd->lock);
-	if (prtd->state & ST_RUNNING) {
+	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
 		prtd->dma_loaded--;
 		s3c24xx_pcm_enqueue(substream);
 	}
@@ -164,6 +172,11 @@ static int s3c24xx_pcm_hw_params(struct snd_pcm_substream *substream,
 			printk(KERN_ERR "failed to get dma channel\n");
 			return ret;
 		}
+
+		/* use the circular buffering if we have it available. */
+		if (s3c_dma_has_circular())
+			s3c2410_dma_setflags(prtd->params->channel,
+					     S3C2410_DMAF_CIRCULAR);
 	}
 
 	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
-- 
1.6.3.3
