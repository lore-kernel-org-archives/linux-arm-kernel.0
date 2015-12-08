From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:35:51 +0100
Subject: [PATCH] ASoC: fsl: use correct format string for dma_addr_t
Message-ID: <1625124.fpu6AsNAkc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a warning for the imx-pcm-fiq driver when CONFIG_LPAE
is enabled on ARM, because dma_addr_t is 64-bit then:

sound/soc/fsl/imx-pcm-fiq.c: In function 'snd_imx_pcm_mmap':
sound/soc/fsl/imx-pcm-fiq.c:223:107: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]

This changes the printk to use the correct format string for
printing a dma_addr_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/imx-pcm-fiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 7abf6a079574..49d7513f429e 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -220,9 +220,9 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
 		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
 
-	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
+	pr_debug("%s: ret: %d %p %pad 0x%08x\n", __func__, ret,
 			runtime->dma_area,
-			runtime->dma_addr,
+			&runtime->dma_addr,
 			runtime->dma_bytes);
 	return ret;
 }
-- 
2.1.0.rc2
