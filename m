From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 23:43:56 +0800
Subject: [PATCH] ASoC: fsl: fix multiple definition of init_module
Message-ID: <1357832636-11463-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit f2818d0 (ASoC: fsl: fix miscompilation of snd-soc-imx-pcm),
we will see the following build error when building modules with
CONFIG_SND_IMX_SOC=m in imx_v6_v7_defconfig.

  CC [M]  sound/soc/fsl/phycore-ac97.o
  LD [M]  sound/soc/fsl/snd-soc-fsl-ssi.o
  LD [M]  sound/soc/fsl/snd-soc-fsl-utils.o
  LD [M]  sound/soc/fsl/snd-soc-imx-ssi.o
  LD [M]  sound/soc/fsl/snd-soc-imx-audmux.o
  LD [M]  sound/soc/fsl/snd-soc-imx-pcm.o
sound/soc/fsl/imx-pcm-dma.o: In function `init_module':
imx-pcm-dma.c:(.init.text+0x0): multiple definition of `init_module'
sound/soc/fsl/imx-pcm-fiq.o:imx-pcm-fiq.c:(.init.text+0x0): first defined here
sound/soc/fsl/imx-pcm-dma.o: In function `cleanup_module':
imx-pcm-dma.c:(.exit.text+0x0): multiple definition of `cleanup_module'
sound/soc/fsl/imx-pcm-fiq.o:imx-pcm-fiq.c:(.exit.text+0x0): first defined here
make[4]: *** [sound/soc/fsl/snd-soc-imx-pcm.o] Error 1

Instead of using bool for SND_SOC_IMX_PCM_FIQ and SND_SOC_IMX_PCM_DMA
to fix the original issue, we should completely remove SND_SOC_IMX_PCM
and have imx-pcm.o statically linked with imx-pcm-fiq.o or imx-pcm-dma.o.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Mark,

To be clear, I think it's a v3.8 material.

Shawn

 sound/soc/fsl/Kconfig   |    9 ++-------
 sound/soc/fsl/Makefile  |    5 ++++-
 sound/soc/fsl/imx-pcm.c |    3 ---
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3b98159..a210c8d 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -108,18 +108,13 @@ if SND_IMX_SOC
 config SND_SOC_IMX_SSI
 	tristate
 
-config SND_SOC_IMX_PCM
-	tristate
-
 config SND_SOC_IMX_PCM_FIQ
-	bool
+	tristate
 	select FIQ
-	select SND_SOC_IMX_PCM
 
 config SND_SOC_IMX_PCM_DMA
-	bool
+	tristate
 	select SND_SOC_DMAENGINE_PCM
-	select SND_SOC_IMX_PCM
 
 config SND_SOC_IMX_AUDMUX
 	tristate
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index afd3479..ec14579 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -41,7 +41,10 @@ endif
 obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
 obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
 
-obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
+obj-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += snd-soc-imx-pcm-fiq.o
+snd-soc-imx-pcm-fiq-y := imx-pcm-fiq.o imx-pcm.o
+obj-$(CONFIG_SND_SOC_IMX_PCM_DMA) += snd-soc-imx-pcm-dma.o
+snd-soc-imx-pcm-dma-y := imx-pcm-dma.o imx-pcm.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/sound/soc/fsl/imx-pcm.c b/sound/soc/fsl/imx-pcm.c
index d5cd9ef..0c9f188 100644
--- a/sound/soc/fsl/imx-pcm.c
+++ b/sound/soc/fsl/imx-pcm.c
@@ -31,7 +31,6 @@ int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 			runtime->dma_bytes);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(snd_imx_pcm_mmap);
 
 static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 {
@@ -80,7 +79,6 @@ int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 out:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(imx_pcm_new);
 
 void imx_pcm_free(struct snd_pcm *pcm)
 {
@@ -102,7 +100,6 @@ void imx_pcm_free(struct snd_pcm *pcm)
 		buf->area = NULL;
 	}
 }
-EXPORT_SYMBOL_GPL(imx_pcm_free);
 
 MODULE_DESCRIPTION("Freescale i.MX PCM driver");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.7.9.5
