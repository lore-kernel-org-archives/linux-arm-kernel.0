From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:34:03 +0200
Subject: [PATCH 14/20] ASoC: pxa: use snd_dmaengine_dai_dma_data
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-15-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use snd_dmaengine_dai_dma_data for passing the dma parameters from
clients to the pxa pcm lib. This does no functional change, it's just an
intermedia step to migrate the pxa bits over to dmaengine.

The calculation of dcmd is a transition hack which will be removed again
in a later patch. It's just there to make the transition more readable.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 include/sound/pxa2xx-lib.h  |  7 -----
 sound/arm/pxa2xx-ac97.c     | 26 ++++++++++--------
 sound/arm/pxa2xx-pcm-lib.c  | 52 +++++++++++++++++++++++++++++------
 sound/arm/pxa2xx-pcm.c      |  5 +++-
 sound/arm/pxa2xx-pcm.h      |  6 ++--
 sound/soc/pxa/mmp-pcm.c     |  8 ++++--
 sound/soc/pxa/mmp-sspa.c    | 12 +++++---
 sound/soc/pxa/pxa-ssp.c     | 36 ++++++++----------------
 sound/soc/pxa/pxa2xx-ac97.c | 67 +++++++++++++++++++++++----------------------
 sound/soc/pxa/pxa2xx-i2s.c  | 28 +++++++++----------
 sound/soc/pxa/pxa2xx-pcm.c  |  8 ++++--
 11 files changed, 142 insertions(+), 113 deletions(-)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index 2fd3d25..56e818e 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -6,13 +6,6 @@
 
 /* PCM */
 
-struct pxa2xx_pcm_dma_params {
-	char *name;			/* stream identifier */
-	u32 dcmd;			/* DMA descriptor dcmd field */
-	volatile u32 *drcmr;		/* the DMA request channel to use */
-	u32 dev_addr;			/* device physical address for DMA */
-};
-
 extern int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params);
 extern int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream);
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index ce431e6..5066a37 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -14,12 +14,14 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/dmaengine.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
@@ -41,20 +43,20 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_reset,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_out = {
-	.name			= "AC97 PCM out",
-	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(12),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST32 | DCMD_WIDTH4,
+static unsigned long pxa2xx_ac97_pcm_out_req = 12;
+static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_out = {
+	.addr		= __PREG(PCDR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.maxburst	= 32,
+	.filter_data	= &pxa2xx_ac97_pcm_out_req,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_in = {
-	.name			= "AC97 PCM in",
-	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(11),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST32 | DCMD_WIDTH4,
+static unsigned long pxa2xx_ac97_pcm_in_req = 11;
+static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_in = {
+	.addr		= __PREG(PCDR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.maxburst	= 32,
+	.filter_data	= &pxa2xx_ac97_pcm_in_req,
 };
 
 static struct snd_pcm *pxa2xx_ac97_pcm;
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 823359e..a61d7a9 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -7,11 +7,13 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/dma.h>
 
@@ -43,6 +45,35 @@ int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	size_t period = params_period_bytes(params);
 	pxa_dma_desc *dma_desc;
 	dma_addr_t dma_buff_phys, next_desc_phys;
+	u32 dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
+
+	/* temporary transition hack */
+	switch (rtd->params->addr_width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		dcmd |= DCMD_WIDTH1;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		dcmd |= DCMD_WIDTH2;
+		break;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		dcmd |= DCMD_WIDTH4;
+		break;
+	default:
+		/* can't happen */
+		break;
+	}
+
+	switch (rtd->params->maxburst) {
+	case 8:
+		dcmd |= DCMD_BURST8;
+		break;
+	case 16:
+		dcmd |= DCMD_BURST16;
+		break;
+	case 32:
+		dcmd |= DCMD_BURST32;
+		break;
+	}
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = totsize;
@@ -55,14 +86,14 @@ int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 		dma_desc->ddadr = next_desc_phys;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			dma_desc->dsadr = dma_buff_phys;
-			dma_desc->dtadr = rtd->params->dev_addr;
+			dma_desc->dtadr = rtd->params->addr;
 		} else {
-			dma_desc->dsadr = rtd->params->dev_addr;
+			dma_desc->dsadr = rtd->params->addr;
 			dma_desc->dtadr = dma_buff_phys;
 		}
 		if (period > totsize)
 			period = totsize;
-		dma_desc->dcmd = rtd->params->dcmd | period | DCMD_ENDIRQEN;
+		dma_desc->dcmd = dcmd | period | DCMD_ENDIRQEN;
 		dma_desc++;
 		dma_buff_phys += period;
 	} while (totsize -= period);
@@ -76,8 +107,10 @@ int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
 
-	if (rtd && rtd->params && rtd->params->drcmr)
-		*rtd->params->drcmr = 0;
+	if (rtd && rtd->params && rtd->params->filter_data) {
+		unsigned long req = *(unsigned long *) rtd->params->filter_data;
+		DRCMR(req) = 0;
+	}
 
 	snd_pcm_set_runtime_buffer(substream, NULL);
 	return 0;
@@ -136,6 +169,7 @@ EXPORT_SYMBOL(pxa2xx_pcm_pointer);
 int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
+	unsigned long req;
 
 	if (!prtd || !prtd->params)
 		return 0;
@@ -146,7 +180,8 @@ int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
 	DCSR(prtd->dma_ch) &= ~DCSR_RUN;
 	DCSR(prtd->dma_ch) = 0;
 	DCMD(prtd->dma_ch) = 0;
-	*prtd->params->drcmr = prtd->dma_ch | DRCMR_MAPVLD;
+	req = *(unsigned long *) prtd->params->filter_data;
+	DRCMR(req) = prtd->dma_ch | DRCMR_MAPVLD;
 
 	return 0;
 }
@@ -155,7 +190,6 @@ EXPORT_SYMBOL(__pxa2xx_pcm_prepare);
 void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
 {
 	struct snd_pcm_substream *substream = dev_id;
-	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
 	int dcsr;
 
 	dcsr = DCSR(dma_ch);
@@ -164,8 +198,8 @@ void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
 	if (dcsr & DCSR_ENDINTR) {
 		snd_pcm_period_elapsed(substream);
 	} else {
-		printk(KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
-			rtd->params->name, dma_ch, dcsr);
+		printk(KERN_ERR "DMA error on channel %d (DCSR=%#x)\n",
+			dma_ch, dcsr);
 		snd_pcm_stream_lock(substream);
 		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 		snd_pcm_stream_unlock(substream);
diff --git a/sound/arm/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm.c
index 26422a3..69a2455 100644
--- a/sound/arm/pxa2xx-pcm.c
+++ b/sound/arm/pxa2xx-pcm.c
@@ -11,8 +11,11 @@
  */
 
 #include <linux/module.h>
+#include <linux/dmaengine.h>
+
 #include <sound/core.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "pxa2xx-pcm.h"
 
@@ -40,7 +43,7 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 
 	rtd->params = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		      client->playback_params : client->capture_params;
-	ret = pxa_request_dma(rtd->params->name, DMA_PRIO_LOW,
+	ret = pxa_request_dma("dma", DMA_PRIO_LOW,
 			      pxa2xx_pcm_dma_irq, substream);
 	if (ret < 0)
 		goto err2;
diff --git a/sound/arm/pxa2xx-pcm.h b/sound/arm/pxa2xx-pcm.h
index 65f86b5..2a8fc08 100644
--- a/sound/arm/pxa2xx-pcm.h
+++ b/sound/arm/pxa2xx-pcm.h
@@ -13,14 +13,14 @@
 
 struct pxa2xx_runtime_data {
 	int dma_ch;
-	struct pxa2xx_pcm_dma_params *params;
+	struct snd_dmaengine_dai_dma_data *params;
 	pxa_dma_desc *dma_desc_array;
 	dma_addr_t dma_desc_array_phys;
 };
 
 struct pxa2xx_pcm_client {
-	struct pxa2xx_pcm_dma_params *playback_params;
-	struct pxa2xx_pcm_dma_params *capture_params;
+	struct snd_dmaengine_dai_dma_data *playback_params;
+	struct snd_dmaengine_dai_dma_data *capture_params;
 	int (*startup)(struct snd_pcm_substream *);
 	void (*shutdown)(struct snd_pcm_substream *);
 	int (*prepare)(struct snd_pcm_substream *);
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 5d57e07..9a97843 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -17,6 +17,8 @@
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
 #include <linux/platform_data/mmp_audio.h>
+#include <linux/dmaengine.h>
+
 #include <sound/pxa2xx-lib.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -67,7 +69,7 @@ static int mmp_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct pxa2xx_pcm_dma_params *dma_params;
+	struct snd_dmaengine_dai_dma_data *dma_params;
 	struct dma_slave_config slave_config;
 	int ret;
 
@@ -80,10 +82,10 @@ static int mmp_pcm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		slave_config.dst_addr     = dma_params->dev_addr;
+		slave_config.dst_addr     = dma_params->addr;
 		slave_config.dst_maxburst = 4;
 	} else {
-		slave_config.src_addr	  = dma_params->dev_addr;
+		slave_config.src_addr	  = dma_params->addr;
 		slave_config.src_maxburst = 4;
 	}
 
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 62142ce..84f1e9e 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -27,12 +27,15 @@
 #include <linux/slab.h>
 #include <linux/pxa2xx_ssp.h>
 #include <linux/io.h>
+#include <linux/dmaengine.h>
+
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 #include "mmp-sspa.h"
 
 /*
@@ -40,7 +43,7 @@
  */
 struct sspa_priv {
 	struct ssp_device *sspa;
-	struct pxa2xx_pcm_dma_params *dma_params;
+	struct snd_dmaengine_dai_dma_data *dma_params;
 	struct clk *audio_clk;
 	struct clk *sysclk;
 	int dai_fmt;
@@ -266,7 +269,7 @@ static int mmp_sspa_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(dai);
 	struct ssp_device *sspa = sspa_priv->sspa;
-	struct pxa2xx_pcm_dma_params *dma_params;
+	struct snd_dmaengine_dai_dma_data *dma_params;
 	u32 sspa_ctrl;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -309,7 +312,7 @@ static int mmp_sspa_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	dma_params = &sspa_priv->dma_params[substream->stream];
-	dma_params->dev_addr = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+	dma_params->addr = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
 				(sspa->phys_base + SSPA_TXD) :
 				(sspa->phys_base + SSPA_RXD);
 	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_params);
@@ -425,7 +428,8 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dma_params = devm_kzalloc(&pdev->dev,
-			2 * sizeof(struct pxa2xx_pcm_dma_params), GFP_KERNEL);
+			2 * sizeof(struct snd_dmaengine_dai_dma_data),
+			GFP_KERNEL);
 	if (priv->dma_params == NULL)
 		return -ENOMEM;
 
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 82b9985..3903343 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/pxa2xx_ssp.h>
 #include <linux/of.h>
+#include <linux/dmaengine.h>
 
 #include <asm/irq.h>
 
@@ -31,9 +32,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/hardware.h>
-#include <mach/dma.h>
 
 #include "../../arm/pxa2xx-pcm.h"
 #include "pxa-ssp.h"
@@ -80,27 +81,14 @@ static void pxa_ssp_disable(struct ssp_device *ssp)
 	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
 }
 
-struct pxa2xx_pcm_dma_data {
-	struct pxa2xx_pcm_dma_params params;
-	char name[20];
-};
-
 static void pxa_ssp_set_dma_params(struct ssp_device *ssp, int width4,
-			int out, struct pxa2xx_pcm_dma_params *dma_data)
+			int out, struct snd_dmaengine_dai_dma_data *dma)
 {
-	struct pxa2xx_pcm_dma_data *dma;
-
-	dma = container_of(dma_data, struct pxa2xx_pcm_dma_data, params);
-
-	snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
-			width4 ? "32-bit" : "16-bit", out ? "out" : "in");
-
-	dma->params.name = dma->name;
-	dma->params.drcmr = &DRCMR(out ? ssp->drcmr_tx : ssp->drcmr_rx);
-	dma->params.dcmd = (out ? (DCMD_INCSRCADDR | DCMD_FLOWTRG) :
-				  (DCMD_INCTRGADDR | DCMD_FLOWSRC)) |
-			(width4 ? DCMD_WIDTH4 : DCMD_WIDTH2) | DCMD_BURST16;
-	dma->params.dev_addr = ssp->phys_base + SSDR;
+	dma->filter_data = out ? &ssp->drcmr_tx : &ssp->drcmr_rx;
+	dma->addr_width = width4 ? DMA_SLAVE_BUSWIDTH_4_BYTES :
+				   DMA_SLAVE_BUSWIDTH_2_BYTES;
+	dma->maxburst = 16;
+	dma->addr = ssp->phys_base + SSDR;
 }
 
 static int pxa_ssp_startup(struct snd_pcm_substream *substream,
@@ -108,7 +96,7 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 {
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
-	struct pxa2xx_pcm_dma_data *dma;
+	struct snd_dmaengine_dai_dma_data *dma;
 	int ret = 0;
 
 	if (!cpu_dai->active) {
@@ -116,10 +104,10 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 		pxa_ssp_disable(ssp);
 	}
 
-	dma = kzalloc(sizeof(struct pxa2xx_pcm_dma_data), GFP_KERNEL);
+	dma = kzalloc(sizeof(struct snd_dmaengine_dai_dma_data), GFP_KERNEL);
 	if (!dma)
 		return -ENOMEM;
-	snd_soc_dai_set_dma_data(cpu_dai, substream, &dma->params);
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma);
 
 	return ret;
 }
@@ -560,7 +548,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	u32 sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = pxa_ssp_read_reg(ssp, SSTSA) & 0xf;
-	struct pxa2xx_pcm_dma_params *dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 
 	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
 
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 1475515..f1059d9 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -14,15 +14,16 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/dmaengine.h>
 
 #include <sound/core.h>
 #include <sound/ac97_codec.h>
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-ac97.h>
-#include <mach/dma.h>
 #include <mach/audio.h>
 
 #include "pxa2xx-ac97.h"
@@ -48,44 +49,44 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_cold_reset,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_out = {
-	.name			= "AC97 PCM Stereo out",
-	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(12),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST32 | DCMD_WIDTH4,
+static unsigned long pxa2xx_ac97_pcm_stereo_in_req = 12;
+static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
+	.addr		= __PREG(PCDR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.maxburst	= 32,
+	.filter_data	= &pxa2xx_ac97_pcm_stereo_in_req,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_in = {
-	.name			= "AC97 PCM Stereo in",
-	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(11),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST32 | DCMD_WIDTH4,
+static unsigned long pxa2xx_ac97_pcm_stereo_out_req = 11;
+static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
+	.addr		= __PREG(PCDR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.maxburst	= 32,
+	.filter_data	= &pxa2xx_ac97_pcm_stereo_out_req,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_aux_mono_out = {
-	.name			= "AC97 Aux PCM (Slot 5) Mono out",
-	.dev_addr		= __PREG(MODR),
-	.drcmr			= &DRCMR(10),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
+static unsigned long pxa2xx_ac97_pcm_aux_mono_out_req = 10;
+static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_out = {
+	.addr		= __PREG(MODR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
+	.maxburst	= 16,
+	.filter_data	= &pxa2xx_ac97_pcm_aux_mono_out_req,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_aux_mono_in = {
-	.name			= "AC97 Aux PCM (Slot 5) Mono in",
-	.dev_addr		= __PREG(MODR),
-	.drcmr			= &DRCMR(9),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
+static unsigned long pxa2xx_ac97_pcm_aux_mono_in_req = 9;
+static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_in = {
+	.addr		= __PREG(MODR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
+	.maxburst	= 16,
+	.filter_data	= &pxa2xx_ac97_pcm_aux_mono_in_req,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_mic_mono_in = {
-	.name			= "AC97 Mic PCM (Slot 6) Mono in",
-	.dev_addr		= __PREG(MCDR),
-	.drcmr			= &DRCMR(8),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
+static unsigned long pxa2xx_ac97_pcm_aux_mic_mono_req = 8;
+static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_mic_mono_in = {
+	.addr		= __PREG(MCDR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
+	.maxburst	= 16,
+	.filter_data	= &pxa2xx_ac97_pcm_aux_mic_mono_req,
 };
 
 #ifdef CONFIG_PM
@@ -119,7 +120,7 @@ static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *cpu_dai)
 {
-	struct pxa2xx_pcm_dma_params *dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_data = &pxa2xx_ac97_pcm_stereo_out;
@@ -135,7 +136,7 @@ static int pxa2xx_ac97_hw_aux_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params,
 				     struct snd_soc_dai *cpu_dai)
 {
-	struct pxa2xx_pcm_dma_params *dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_data = &pxa2xx_ac97_pcm_aux_mono_out;
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index f7ca716..d5340a0 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -23,9 +23,9 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/hardware.h>
-#include <mach/dma.h>
 #include <mach/audio.h>
 
 #include "pxa2xx-i2s.h"
@@ -82,20 +82,20 @@ static struct pxa_i2s_port pxa_i2s;
 static struct clk *clk_i2s;
 static int clk_ena = 0;
 
-static struct pxa2xx_pcm_dma_params pxa2xx_i2s_pcm_stereo_out = {
-	.name			= "I2S PCM Stereo out",
-	.dev_addr		= __PREG(SADR),
-	.drcmr			= &DRCMR(3),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST32 | DCMD_WIDTH4,
+static unsigned long pxa2xx_i2s_pcm_stereo_out_req = 3;
+static struct snd_dmaengine_dai_dma_data pxa2xx_i2s_pcm_stereo_out = {
+	.addr		= __PREG(SADR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.maxburst	= 32,
+	.filter_data	= &pxa2xx_i2s_pcm_stereo_out_req,
 };
 
-static struct pxa2xx_pcm_dma_params pxa2xx_i2s_pcm_stereo_in = {
-	.name			= "I2S PCM Stereo in",
-	.dev_addr		= __PREG(SADR),
-	.drcmr			= &DRCMR(2),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST32 | DCMD_WIDTH4,
+static unsigned long pxa2xx_i2s_pcm_stereo_in_req = 2;
+static struct snd_dmaengine_dai_dma_data pxa2xx_i2s_pcm_stereo_in = {
+	.addr		= __PREG(SADR),
+	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.maxburst	= 32,
+	.filter_data	= &pxa2xx_i2s_pcm_stereo_in_req,
 };
 
 static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream,
@@ -163,7 +163,7 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct pxa2xx_pcm_dma_params *dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 
 	BUG_ON(IS_ERR(clk_i2s));
 	clk_prepare_enable(clk_i2s);
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index ecff116..0aa2d69 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -12,10 +12,12 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
+#include <linux/dmaengine.h>
 
 #include <sound/core.h>
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "../../arm/pxa2xx-pcm.h"
 
@@ -25,7 +27,7 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pxa2xx_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct pxa2xx_pcm_dma_params *dma;
+	struct snd_dmaengine_dai_dma_data *dma;
 	int ret;
 
 	dma = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
@@ -39,7 +41,7 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	 * with different params */
 	if (prtd->params == NULL) {
 		prtd->params = dma;
-		ret = pxa_request_dma(prtd->params->name, DMA_PRIO_LOW,
+		ret = pxa_request_dma("name", DMA_PRIO_LOW,
 			      pxa2xx_pcm_dma_irq, substream);
 		if (ret < 0)
 			return ret;
@@ -47,7 +49,7 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	} else if (prtd->params != dma) {
 		pxa_free_dma(prtd->dma_ch);
 		prtd->params = dma;
-		ret = pxa_request_dma(prtd->params->name, DMA_PRIO_LOW,
+		ret = pxa_request_dma("name", DMA_PRIO_LOW,
 			      pxa2xx_pcm_dma_irq, substream);
 		if (ret < 0)
 			return ret;
-- 
1.8.3.1
