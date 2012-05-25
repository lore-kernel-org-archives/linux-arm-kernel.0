From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 25 May 2012 13:23:36 +0530
Subject: [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1337932416.1580.2.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-25 at 15:11 +0800, Zhangfei Gao wrote:
> mmp-pcm handle audio dma based on dmaengine
> Support mmp and pxa910
Looks like this is *not* using soc-dmaengine library, why?
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Leo Yan <leoy@marvell.com>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>  include/linux/platform_data/mmp_audio.h |   22 ++
>  sound/soc/pxa/Kconfig                   |    8 +
>  sound/soc/pxa/Makefile                  |    2 +
>  sound/soc/pxa/mmp-pcm.c                 |  448 +++++++++++++++++++++++++++++++
>  4 files changed, 480 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/platform_data/mmp_audio.h
>  create mode 100644 sound/soc/pxa/mmp-pcm.c
> 
> diff --git a/include/linux/platform_data/mmp_audio.h b/include/linux/platform_data/mmp_audio.h
> new file mode 100644
> index 0000000..0f25d16
> --- /dev/null
> +++ b/include/linux/platform_data/mmp_audio.h
> @@ -0,0 +1,22 @@
> +/*
> + *  MMP Platform AUDIO Management
> + *
> + *  Copyright (c) 2011 Marvell Semiconductors Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef MMP_AUDIO_H
> +#define MMP_AUDIO_H
> +
> +struct mmp_audio_platdata {
> +	u32 period_max_capture;
> +	u32 buffer_max_capture;
> +	u32 period_max_playback;
> +	u32 buffer_max_playback;
> +};
> +
> +#endif /* MMP_AUDIO_H */
> diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
> index a0f7d3c..a516068 100644
> --- a/sound/soc/pxa/Kconfig
> +++ b/sound/soc/pxa/Kconfig
> @@ -8,6 +8,14 @@ config SND_PXA2XX_SOC
>  	  the PXA2xx AC97, I2S or SSP interface. You will also need
>  	  to select the audio interfaces to support below.
>  
> +config SND_MMP_SOC
> +	bool "Soc Audio for Marvell MMP chips"
> +	depends on ARCH_MMP
> +	select SND_ARM
> +	help
> +	  Say Y if you want to add support for codecs attached to
> +	  the MMP SSPA interface.
> +
>  config SND_PXA2XX_AC97
>  	tristate
>  	select SND_AC97_CODEC
> diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
> index af35762..f913e9b 100644
> --- a/sound/soc/pxa/Makefile
> +++ b/sound/soc/pxa/Makefile
> @@ -3,11 +3,13 @@ snd-soc-pxa2xx-objs := pxa2xx-pcm.o
>  snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
>  snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
>  snd-soc-pxa-ssp-objs := pxa-ssp.o
> +snd-soc-mmp-objs := mmp-pcm.o
>  
>  obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
>  obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
>  obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
>  obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
> +obj-$(CONFIG_SND_MMP_SOC) += snd-soc-mmp.o
>  
>  # PXA Machine Support
>  snd-soc-corgi-objs := corgi.o
> diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
> new file mode 100644
> index 0000000..abafbb9
> --- /dev/null
> +++ b/sound/soc/pxa/mmp-pcm.c
> @@ -0,0 +1,448 @@
> +/*
> + * linux/sound/soc/pxa/mmp-pcm.c
> + *
> + * Copyright (C) 2011 Marvell International Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/platform_data/mmp_dma.h>
> +#include <linux/platform_data/mmp_audio.h>
> +#include <sound/pxa2xx-lib.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <mach/sram.h>
> +
> +struct mmp_runtime_data {
> +	int ssp_id;
> +	u32 period_size;
> +	u32 pointer;
> +	struct resource *dma_res;
> +	struct mmp_tdma_data tdma_data;
> +	struct gen_pool *gpool;
> +	struct snd_pcm_substream *substream;
> +	struct dma_chan *dma_chan;
> +	struct dma_async_tx_descriptor *desc;
> +};
> +
> +#define MMP_PCM_INFO (SNDRV_PCM_INFO_MMAP |	\
> +		SNDRV_PCM_INFO_MMAP_VALID |	\
> +		SNDRV_PCM_INFO_INTERLEAVED |	\
> +		SNDRV_PCM_INFO_PAUSE |		\
> +		SNDRV_PCM_INFO_RESUME)
> +
> +#define MMP_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
> +			 SNDRV_PCM_FMTBIT_S24_LE | \
> +			 SNDRV_PCM_FMTBIT_S32_LE)
> +
> +static struct snd_pcm_hardware mmp_pcm_hardware[] = {
> +	{
> +		.info			= MMP_PCM_INFO,
> +		.formats		= MMP_PCM_FORMATS,
> +		.period_bytes_min	= 1024,
> +		.period_bytes_max	= 2048,
> +		.periods_min		= 2,
> +		.periods_max		= 32,
> +		.buffer_bytes_max	= 4096,
> +		.fifo_size		= 32,
> +	},
> +	{
> +		.info			= MMP_PCM_INFO,
> +		.formats		= MMP_PCM_FORMATS,
> +		.period_bytes_min	= 1024,
> +		.period_bytes_max	= 2048,
> +		.periods_min		= 2,
> +		.periods_max		= 32,
> +		.buffer_bytes_max	= 4096,
> +		.fifo_size		= 32,
> +	},
> +};
> +
> +static void mmp_pcm_adma_irq(void *data)
> +{
> +	struct snd_pcm_substream *substream = data;
> +	struct mmp_runtime_data *prtd = substream->runtime->private_data;
> +	size_t dma_bytes = substream->runtime->dma_bytes;
> +
> +	prtd->pointer = (prtd->pointer + prtd->period_size) % dma_bytes;
> +	snd_pcm_period_elapsed(substream);
> +	return;
> +}
> +
> +static bool filter(struct dma_chan *chan, void *param)
> +{
> +	struct mmp_runtime_data *prtd = param;
> +	bool found = false;
> +	char *devname;
> +
> +	devname = kasprintf(GFP_KERNEL, "%s.%d", prtd->dma_res->name,
> +		prtd->ssp_id);
> +	if ((strcmp(dev_name(chan->device->dev), devname) == 0) &&
> +		(chan->chan_id == prtd->dma_res->start)) {
> +		chan->private = &prtd->tdma_data;
> +		found = true;
> +	}
> +
> +	kfree(devname);
> +	return found;
> +}
> +
> +static int mmp_pcm_hw_params(struct snd_pcm_substream *substream,
> +			      struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct mmp_runtime_data *prtd = runtime->private_data;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct pxa2xx_pcm_dma_params *dma_params;
> +	size_t totsize = params_buffer_bytes(params);
> +	size_t period = params_period_bytes(params);
> +	int ret;
> +	struct dma_slave_config slave_config;
> +	dma_cap_mask_t mask;
> +
> +	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +	if (!dma_params)
> +		return 0;
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S8:
> +		prtd->tdma_data.bus_size = 8;
> +		break;
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		prtd->tdma_data.bus_size = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		prtd->tdma_data.bus_size = 24;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		prtd->tdma_data.bus_size = 32;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	prtd->tdma_data.pack_mod = true;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_CYCLIC, mask);
> +	prtd->dma_chan = dma_request_channel(mask, filter, prtd);
> +	if (!prtd->dma_chan)
> +		return -EINVAL;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		slave_config.direction    = DMA_TO_DEVICE;
> +		slave_config.dst_addr     = dma_params->dev_addr;
> +		slave_config.dst_maxburst = 4;
> +	} else {
> +		slave_config.direction	  = DMA_FROM_DEVICE;
> +		slave_config.src_addr	  = dma_params->dev_addr;
> +		slave_config.src_maxburst = 4;
> +	}
> +
> +	ret = dmaengine_slave_config(prtd->dma_chan, &slave_config);
> +	if (ret)
> +		return ret;
> +
> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +
> +	prtd->period_size = period;
> +	runtime->dma_bytes = totsize;
> +
> +	prtd->desc = prtd->dma_chan->device->device_prep_dma_cyclic(
> +			prtd->dma_chan, runtime->dma_addr, totsize, period,
> +			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
> +			DMA_TO_DEVICE : DMA_FROM_DEVICE, NULL);
> +	if (!prtd->desc) {
> +		dev_err(&prtd->dma_chan->dev->device, "cannot prepare slave dma\n");
> +		return -EINVAL;
> +	}
> +
> +	prtd->desc->callback = mmp_pcm_adma_irq;
> +	prtd->desc->callback_param = substream;
> +	dmaengine_submit(prtd->desc);
> +	return 0;
> +}
> +
> +static int mmp_pcm_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct mmp_runtime_data *prtd = substream->runtime->private_data;
> +
> +	if (prtd->dma_chan) {
> +		dma_release_channel(prtd->dma_chan);
> +		prtd->dma_chan = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mmp_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct mmp_runtime_data *prtd = substream->runtime->private_data;
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		prtd->pointer = 0;
> +		dma_async_issue_pending(prtd->dma_chan);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		dmaengine_terminate_all(prtd->dma_chan);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		dma_async_issue_pending(prtd->dma_chan);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		dma_async_issue_pending(prtd->dma_chan);
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static snd_pcm_uframes_t mmp_pcm_pointer(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct mmp_runtime_data *prtd = runtime->private_data;
> +	snd_pcm_uframes_t x;
> +
> +	x = bytes_to_frames(runtime, prtd->pointer);
> +	if (x == runtime->buffer_size)
> +		x = 0;
> +
> +	return x;
> +}
> +
> +static int mmp_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct mmp_runtime_data *prtd;
> +	struct resource *r;
> +	int ret;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_DMA, substream->stream);
> +	if (!r)
> +		return -EBUSY;
> +
> +	snd_soc_set_runtime_hwparams(substream,
> +				&mmp_pcm_hardware[substream->stream]);
> +
> +	/*
> +	 * For mysterious reasons (and despite what the manual says)
> +	 * playback samples are lost if the DMA count is not a multiple
> +	 * of the DMA burst size.  Let's add a rule to enforce that.
> +	 */
> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
> +		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
> +	if (ret)
> +		goto out;
> +
> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
> +		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
> +	if (ret)
> +		goto out;
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		goto out;
> +
> +	prtd = devm_kzalloc(&pdev->dev,
> +			sizeof(struct mmp_runtime_data), GFP_KERNEL);
> +	if (prtd == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	prtd->substream = substream;
> +	runtime->private_data = prtd;
> +	prtd->dma_res = r;
> +	prtd->ssp_id = cpu_dai->id;
> +	return 0;
> +
> +out:
> +	return ret;
> +}
> +
> +static int mmp_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct mmp_runtime_data *prtd = runtime->private_data;
> +
> +	devm_kfree(&pdev->dev, prtd);
> +	runtime->private_data = NULL;
> +	return 0;
> +}
> +
> +static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
> +			 struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	unsigned long off = vma->vm_pgoff;
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	return remap_pfn_range(vma, vma->vm_start,
> +		__phys_to_pfn(runtime->dma_addr) + off,
> +		vma->vm_end - vma->vm_start, vma->vm_page_prot);
> +}
> +
> +struct snd_pcm_ops mmp_pcm_ops = {
> +	.open		= mmp_pcm_open,
> +	.close		= mmp_pcm_close,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +	.hw_params	= mmp_pcm_hw_params,
> +	.hw_free	= mmp_pcm_hw_free,
> +	.trigger	= mmp_pcm_trigger,
> +	.pointer	= mmp_pcm_pointer,
> +	.mmap		= mmp_pcm_mmap,
> +};
> +
> +static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
> +{
> +	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> +	size_t size = mmp_pcm_hardware[stream].buffer_bytes_max;
> +	struct gen_pool *gpool;
> +
> +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +	buf->dev.dev = pcm->card->dev;
> +	buf->private_data = NULL;
> +
> +	gpool = sram_get_gpool("asram");
> +	if (!gpool)
> +		return -ENOMEM;
> +
> +	buf->area = (unsigned char *)gen_pool_alloc(gpool, size);
> +	if (!buf->area)
> +		return -ENOMEM;
> +	buf->addr = gen_pool_virt_to_phys(gpool, (unsigned long)buf->area);
> +	buf->bytes = size;
> +	return 0;
> +}
> +
> +static void mmp_pcm_free_dma_buffers(struct snd_pcm *pcm)
> +{
> +	struct snd_pcm_substream *substream;
> +	struct snd_dma_buffer *buf;
> +	int stream;
> +	struct gen_pool *gpool;
> +
> +	gpool = sram_get_gpool("asram");
> +	if (!gpool)
> +		return;
> +
> +	for (stream = 0; stream < 2; stream++) {
> +		size_t size = mmp_pcm_hardware[stream].buffer_bytes_max;
> +
> +		substream = pcm->streams[stream].substream;
> +		if (!substream)
> +			continue;
> +
> +		buf = &substream->dma_buffer;
> +		if (!buf->area)
> +			continue;
> +		gen_pool_free(gpool, (unsigned long)buf->area, size);
> +		buf->area = NULL;
> +	}
> +
> +	return;
> +}
> +
> +static u64 mmp_pcm_dmamask = DMA_BIT_MASK(64);
> +
> +int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_card *card = rtd->card->snd_card;
> +	struct snd_pcm *pcm = rtd->pcm;
> +	int ret = 0;
> +
> +	if (!card->dev->dma_mask)
> +		card->dev->dma_mask = &mmp_pcm_dmamask;
> +
> +	if (!card->dev->coherent_dma_mask)
> +		card->dev->coherent_dma_mask = DMA_BIT_MASK(64);
> +
> +	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
> +		ret = mmp_pcm_preallocate_dma_buffer(pcm,
> +			SNDRV_PCM_STREAM_PLAYBACK);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
> +		ret = mmp_pcm_preallocate_dma_buffer(pcm,
> +			SNDRV_PCM_STREAM_CAPTURE);
> +		if (ret)
> +			goto out;
> +	}
> + out:
> +	return ret;
> +}
> +
> +struct snd_soc_platform_driver mmp_soc_platform = {
> +	.ops		= &mmp_pcm_ops,
> +	.pcm_new	= mmp_pcm_new,
> +	.pcm_free	= mmp_pcm_free_dma_buffers,
> +};
> +
> +static __devinit int mmp_pcm_probe(struct platform_device *pdev)
> +{
> +	struct mmp_audio_platdata *pdata = pdev->dev.platform_data;
> +
> +	if (pdata) {
> +		mmp_pcm_hardware[SNDRV_PCM_STREAM_PLAYBACK].buffer_bytes_max =
> +						pdata->buffer_max_playback;
> +		mmp_pcm_hardware[SNDRV_PCM_STREAM_PLAYBACK].period_bytes_max =
> +						pdata->period_max_playback;
> +		mmp_pcm_hardware[SNDRV_PCM_STREAM_CAPTURE].buffer_bytes_max =
> +						pdata->buffer_max_capture;
> +		mmp_pcm_hardware[SNDRV_PCM_STREAM_CAPTURE].period_bytes_max =
> +						pdata->period_max_capture;
> +	}
> +	return snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
> +}
> +
> +static int __devexit mmp_pcm_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_platform(&pdev->dev);
> +	return 0;
> +}
> +
> +static struct platform_driver mmp_pcm_driver = {
> +	.driver = {
> +		.name = "mmp-pcm-audio",
> +		.owner = THIS_MODULE,
> +	},
> +
> +	.probe = mmp_pcm_probe,
> +	.remove = __devexit_p(mmp_pcm_remove),
> +};
> +
> +module_platform_driver(mmp_pcm_driver);
> +
> +MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
> +MODULE_DESCRIPTION("MMP Soc Audio DMA module");
> +MODULE_LICENSE("GPL");


-- 
~Vinod
