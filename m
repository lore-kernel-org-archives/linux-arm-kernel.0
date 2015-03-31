From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 31 Mar 2015 10:22:25 +0200
Subject: [PATCH] ASoC: atmel-pcm-pdc: merge atmel-pcm back in
In-Reply-To: <1427738094-6348-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427738094-6348-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <551A5941.2010200@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/03/2015 19:54, Alexandre Belloni a ?crit :
> atmel-pcm.c was split into two files to create a generic framework for both PDC
> and DMA.
> 
> atmel-pcm-dma.c is using the generic dmaengine framework since 95e0e07e710e
> (ASoC: atmel-pcm: use generic dmaengine framework).
> 
> Merge atmel-pcm.c in atmel-pcm-pdc.c as this is now the only user.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

It seems okay:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  sound/soc/atmel/Makefile        |   2 -
>  sound/soc/atmel/atmel-pcm-pdc.c |  79 ++++++++++++++++++++++++++
>  sound/soc/atmel/atmel-pcm.c     | 121 ----------------------------------------
>  sound/soc/atmel/atmel-pcm.h     |   5 --
>  4 files changed, 79 insertions(+), 128 deletions(-)
>  delete mode 100644 sound/soc/atmel/atmel-pcm.c
> 
> diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
> index 466a821da98c..b327e5cc8de3 100644
> --- a/sound/soc/atmel/Makefile
> +++ b/sound/soc/atmel/Makefile
> @@ -1,10 +1,8 @@
>  # AT91 Platform Support
> -snd-soc-atmel-pcm-objs := atmel-pcm.o
>  snd-soc-atmel-pcm-pdc-objs := atmel-pcm-pdc.o
>  snd-soc-atmel-pcm-dma-objs := atmel-pcm-dma.o
>  snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
>  
> -obj-$(CONFIG_SND_ATMEL_SOC) += snd-soc-atmel-pcm.o
>  obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
>  obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
>  obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
> diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
> index a366b3503c28..da861b44413f 100644
> --- a/sound/soc/atmel/atmel-pcm-pdc.c
> +++ b/sound/soc/atmel/atmel-pcm-pdc.c
> @@ -47,6 +47,85 @@
>  #include "atmel-pcm.h"
>  
>  
> +static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
> +	int stream)
> +{
> +	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> +	size_t size = ATMEL_SSC_DMABUF_SIZE;
> +
> +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +	buf->dev.dev = pcm->card->dev;
> +	buf->private_data = NULL;
> +	buf->area = dma_alloc_coherent(pcm->card->dev, size,
> +			&buf->addr, GFP_KERNEL);
> +	pr_debug("atmel-pcm: alloc dma buffer: area=%p, addr=%p, size=%zu\n",
> +			(void *)buf->area, (void *)(long)buf->addr, size);
> +
> +	if (!buf->area)
> +		return -ENOMEM;
> +
> +	buf->bytes = size;
> +	return 0;
> +}
> +
> +static int atmel_pcm_mmap(struct snd_pcm_substream *substream,
> +	struct vm_area_struct *vma)
> +{
> +	return remap_pfn_range(vma, vma->vm_start,
> +		       substream->dma_buffer.addr >> PAGE_SHIFT,
> +		       vma->vm_end - vma->vm_start, vma->vm_page_prot);
> +}
> +
> +static int atmel_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_card *card = rtd->card->snd_card;
> +	struct snd_pcm *pcm = rtd->pcm;
> +	int ret;
> +
> +	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
> +	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
> +		pr_debug("atmel-pcm: allocating PCM playback DMA buffer\n");
> +		ret = atmel_pcm_preallocate_dma_buffer(pcm,
> +			SNDRV_PCM_STREAM_PLAYBACK);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
> +		pr_debug("atmel-pcm: allocating PCM capture DMA buffer\n");
> +		ret = atmel_pcm_preallocate_dma_buffer(pcm,
> +			SNDRV_PCM_STREAM_CAPTURE);
> +		if (ret)
> +			goto out;
> +	}
> + out:
> +	return ret;
> +}
> +
> +static void atmel_pcm_free(struct snd_pcm *pcm)
> +{
> +	struct snd_pcm_substream *substream;
> +	struct snd_dma_buffer *buf;
> +	int stream;
> +
> +	for (stream = 0; stream < 2; stream++) {
> +		substream = pcm->streams[stream].substream;
> +		if (!substream)
> +			continue;
> +
> +		buf = &substream->dma_buffer;
> +		if (!buf->area)
> +			continue;
> +		dma_free_coherent(pcm->card->dev, buf->bytes,
> +				  buf->area, buf->addr);
> +		buf->area = NULL;
> +	}
> +}
> +
>  /*--------------------------------------------------------------------------*\
>   * Hardware definition
>  \*--------------------------------------------------------------------------*/
> diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
> deleted file mode 100644
> index 8ae3fa5ac60a..000000000000
> --- a/sound/soc/atmel/atmel-pcm.c
> +++ /dev/null
> @@ -1,121 +0,0 @@
> -/*
> - * atmel-pcm.c  --  ALSA PCM interface for the Atmel atmel SoC.
> - *
> - *  Copyright (C) 2005 SAN People
> - *  Copyright (C) 2008 Atmel
> - *
> - * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
> - *
> - * Based on at91-pcm. by:
> - * Frank Mandarino <fmandarino@endrelia.com>
> - * Copyright 2006 Endrelia Technologies Inc.
> - *
> - * Based on pxa2xx-pcm.c by:
> - *
> - * Author:	Nicolas Pitre
> - * Created:	Nov 30, 2004
> - * Copyright:	(C) 2004 MontaVista Software, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#include <linux/module.h>
> -#include <linux/dma-mapping.h>
> -#include <sound/pcm.h>
> -#include <sound/soc.h>
> -#include "atmel-pcm.h"
> -
> -static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
> -	int stream)
> -{
> -	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> -	struct snd_dma_buffer *buf = &substream->dma_buffer;
> -	size_t size = ATMEL_SSC_DMABUF_SIZE;
> -
> -	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> -	buf->dev.dev = pcm->card->dev;
> -	buf->private_data = NULL;
> -	buf->area = dma_alloc_coherent(pcm->card->dev, size,
> -			&buf->addr, GFP_KERNEL);
> -	pr_debug("atmel-pcm: alloc dma buffer: area=%p, addr=%p, size=%zu\n",
> -			(void *)buf->area, (void *)(long)buf->addr, size);
> -
> -	if (!buf->area)
> -		return -ENOMEM;
> -
> -	buf->bytes = size;
> -	return 0;
> -}
> -
> -int atmel_pcm_mmap(struct snd_pcm_substream *substream,
> -	struct vm_area_struct *vma)
> -{
> -	return remap_pfn_range(vma, vma->vm_start,
> -		       substream->dma_buffer.addr >> PAGE_SHIFT,
> -		       vma->vm_end - vma->vm_start, vma->vm_page_prot);
> -}
> -EXPORT_SYMBOL_GPL(atmel_pcm_mmap);
> -
> -int atmel_pcm_new(struct snd_soc_pcm_runtime *rtd)
> -{
> -	struct snd_card *card = rtd->card->snd_card;
> -	struct snd_pcm *pcm = rtd->pcm;
> -	int ret;
> -
> -	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		return ret;
> -
> -	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
> -		pr_debug("atmel-pcm: allocating PCM playback DMA buffer\n");
> -		ret = atmel_pcm_preallocate_dma_buffer(pcm,
> -			SNDRV_PCM_STREAM_PLAYBACK);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
> -		pr_debug("atmel-pcm: allocating PCM capture DMA buffer\n");
> -		ret = atmel_pcm_preallocate_dma_buffer(pcm,
> -			SNDRV_PCM_STREAM_CAPTURE);
> -		if (ret)
> -			goto out;
> -	}
> - out:
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(atmel_pcm_new);
> -
> -void atmel_pcm_free(struct snd_pcm *pcm)
> -{
> -	struct snd_pcm_substream *substream;
> -	struct snd_dma_buffer *buf;
> -	int stream;
> -
> -	for (stream = 0; stream < 2; stream++) {
> -		substream = pcm->streams[stream].substream;
> -		if (!substream)
> -			continue;
> -
> -		buf = &substream->dma_buffer;
> -		if (!buf->area)
> -			continue;
> -		dma_free_coherent(pcm->card->dev, buf->bytes,
> -				  buf->area, buf->addr);
> -		buf->area = NULL;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(atmel_pcm_free);
> -
> diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
> index 12ae814eff21..6eaf081cad50 100644
> --- a/sound/soc/atmel/atmel-pcm.h
> +++ b/sound/soc/atmel/atmel-pcm.h
> @@ -83,11 +83,6 @@ struct atmel_pcm_dma_params {
>  #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
>  #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
>  
> -int atmel_pcm_new(struct snd_soc_pcm_runtime *rtd);
> -void atmel_pcm_free(struct snd_pcm *pcm);
> -int atmel_pcm_mmap(struct snd_pcm_substream *substream,
> -		struct vm_area_struct *vma);
> -
>  #if defined(CONFIG_SND_ATMEL_SOC_PDC) || \
>  	defined(CONFIG_SND_ATMEL_SOC_PDC_MODULE)
>  int atmel_pcm_pdc_platform_register(struct device *dev);
> 


-- 
Nicolas Ferre
