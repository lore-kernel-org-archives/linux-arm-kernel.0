From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  8 Dec 2012 14:23:22 +0100
Subject: [PATCH] ASoC: atmel-soc: make it buildable on other architectures
Message-ID: <1354973002-13588-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not very useful on non AT91/AVR32 platforms but it provides
more build coverage and prepares for ARM multiplatform.

Also fixes a couple of format type warnings.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

Hi,

Build tested on RM9200 and x86_64.

ARCH_AT91 depend is pushed down to the machine drivers
since they still relies on mach includes.

regards
Joachim Eastwood

 sound/soc/atmel/Kconfig         | 6 +++---
 sound/soc/atmel/atmel-pcm-pdc.c | 4 ++--
 sound/soc/atmel/atmel-pcm.c     | 2 +-
 sound/soc/atmel/atmel_ssc_dai.c | 2 --
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index d1b691b..3fdd87f 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -1,6 +1,6 @@
 config SND_ATMEL_SOC
 	tristate "SoC Audio for the Atmel System-on-Chip"
-	depends on ARCH_AT91
+	depends on HAS_IOMEM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the ATMEL SSC interface. You will also need
@@ -24,7 +24,7 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ATMEL_SSC && SND_ATMEL_SOC && AT91_PROGRAMMABLE_CLOCKS
+	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC && AT91_PROGRAMMABLE_CLOCKS
 	select SND_ATMEL_SOC_PDC
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
@@ -34,7 +34,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
 
 config SND_AT91_SOC_AFEB9260
 	tristate "SoC Audio support for AFEB9260 board"
-	depends on ATMEL_SSC && ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
+	depends on ARCH_AT91 && ATMEL_SSC && ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
 	select SND_ATMEL_SOC_PDC
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_TLV320AIC23
diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 6a293c7..054ea4d 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -159,7 +159,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	pr_debug("atmel-pcm: "
 		"hw_params: DMA for %s initialized "
-		"(dma_bytes=%u, period_size=%u)\n",
+		"(dma_bytes=%zu, period_size=%zu)\n",
 		prtd->params->name,
 		runtime->dma_bytes,
 		prtd->period_size);
@@ -201,7 +201,7 @@ static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	pr_debug("atmel-pcm:buffer_size = %ld,"
-		"dma_area = %p, dma_bytes = %u\n",
+		"dma_area = %p, dma_bytes = %zu\n",
 		rtd->buffer_size, rtd->dma_area, rtd->dma_bytes);
 
 	switch (cmd) {
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index e99f181..3109db7 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -49,7 +49,7 @@ static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 	buf->private_data = NULL;
 	buf->area = dma_alloc_coherent(pcm->card->dev, size,
 			&buf->addr, GFP_KERNEL);
-	pr_debug("atmel-pcm: alloc dma buffer: area=%p, addr=%p, size=%d\n",
+	pr_debug("atmel-pcm: alloc dma buffer: area=%p, addr=%p, size=%zu\n",
 			(void *)buf->area, (void *)buf->addr, size);
 
 	if (!buf->area)
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 1c76634..2755750 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -42,8 +42,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <mach/hardware.h>
-
 #include "atmel-pcm.h"
 #include "atmel_ssc_dai.h"
 
-- 
1.8.0
