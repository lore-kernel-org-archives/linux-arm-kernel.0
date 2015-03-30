From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Mar 2015 21:40:37 +0200
Subject: [PATCH] ASoC: atmel-pcm-dma: increase buffer_bytes_max
Message-ID: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel-pcm-dma is not limited to a buffer size of 64kB like atmel-pcm-pdc.
Increase buffer_bytes_max to 512kB to allow for higher bit rates (i.e. 32bps at
192kHz) to work correctly. By default, keep the prealloc at 64kB.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/atmel/atmel-pcm-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index b8e7bad05eb1..b6625c8c411b 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -54,7 +54,7 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
 	.period_bytes_max	= 2 * 0xffff,	/* if 2 bytes format */
 	.periods_min		= 8,
 	.periods_max		= 1024,		/* no limit */
-	.buffer_bytes_max	= ATMEL_SSC_DMABUF_SIZE,
+	.buffer_bytes_max	= 512 * 1024,
 };
 
 /**
@@ -119,7 +119,7 @@ static int atmel_pcm_configure_dma(struct snd_pcm_substream *substream,
 static const struct snd_dmaengine_pcm_config atmel_dmaengine_pcm_config = {
 	.prepare_slave_config = atmel_pcm_configure_dma,
 	.pcm_hardware = &atmel_pcm_dma_hardware,
-	.prealloc_buffer_size = ATMEL_SSC_DMABUF_SIZE,
+	.prealloc_buffer_size = 64 * 1024,
 };
 
 int atmel_pcm_dma_platform_register(struct device *dev)
-- 
2.1.0
