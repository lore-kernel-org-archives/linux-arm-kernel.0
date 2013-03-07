From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 09:18:04 +0000
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <20130307023316.GA22554@opensource.wolfsonmicro.com>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
 <20130307023316.GA22554@opensource.wolfsonmicro.com>
Message-ID: <20130307091804.GA17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:33:19AM +0800, Mark Brown wrote:
> On Wed, Mar 06, 2013 at 05:13:33PM +0000, Russell King - ARM Linux wrote:
> 
> > This purpetuates the brain-dead behaviour of the existing ASoC DMA
> > engine layer, which makes it unsuitable for platforms with special DMA
> > memory requirements.
> 
> > The problem is that the DMA mask to be used for allocating DMA-able
> > memory is the DMA engine struct device, not the struct device associated
> > with the ASoC device.
> 
> > I got this right in my ASoC generic DMA engine layer.  Converting this
> > layer is far from trivial though, and as my test platform has now become
> > my entire network firewall, I'm not doing any testing on that anymore.
> 
> Could you go into more detail here please?  Looking at the code I'm not
> seeing any allocations done by the library code at all, the allocations
> are all done by the individual platform DMA drivers so I don't see
> anything stopping them doing what they need.

I don't know what else you require apart from the description above.  Isn't
it rather obvious that you can't preallocate the ALSA buffer against the
DMA engine device if you can only obtain the DMA engine device in the open
function?

Notice in the code below where the DMA engine is obtained in pcm_new and
the buffer is preallocated against the DMA engine struct device.  That's
exactly what I'm talking about.

/*
 * Generic ASoC DMA engine backend
 *
 * Copyright (C) 2012 Russell King
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * We expect the DMA engine to give accurate residue information,
 * returning the number of bytes left to complete to the requested
 * cookie.  We also expect the DMA engine to be able to resume
 * submitted descriptors after a suspend/resume cycle.
 */
#include <linux/dma-mapping.h>
#include <linux/dmaengine.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/spinlock.h>

#include <sound/core.h>
#include <sound/soc-dmaengine.h>
#include <sound/soc.h>
#include <sound/pcm_params.h>

#define BUFFER_SIZE_MAX		65536
#define PERIOD_SIZE_MIN		32
#define PERIOD_SIZE_MAX		16384
#define PERIODS_MIN		2
#define PERIODS_MAX		256

struct buf_info {
	struct scatterlist sg;
	dma_cookie_t cookie;
};

struct soc_dma_chan {
	const struct soc_dma_config *conf;
	spinlock_t lock;
	struct dma_chan *chan;
	struct dma_slave_config cfg;
	enum dma_transfer_direction dir;
	unsigned nr_periods;
	unsigned sg_index;
	unsigned stopped;
	unsigned cyclic;
	dma_cookie_t cyclic_cookie;
	struct buf_info buf[PERIODS_MAX];
};

struct soc_dma_info {
	struct soc_dma_chan *chan[2];
};

static const struct snd_pcm_hardware soc_dmaengine_hardware = {
	.info			= SNDRV_PCM_INFO_MMAP |
				  SNDRV_PCM_INFO_MMAP_VALID |
				  SNDRV_PCM_INFO_INTERLEAVED |
				  SNDRV_PCM_INFO_PAUSE |
				  SNDRV_PCM_INFO_RESUME,
	.period_bytes_min	= PERIOD_SIZE_MIN,
	.period_bytes_max	= PERIOD_SIZE_MAX,
	.periods_min		= PERIODS_MIN,
	.periods_max		= PERIODS_MAX,
	.buffer_bytes_max	= BUFFER_SIZE_MAX,
};

static int soc_dmaengine_submit(struct snd_pcm_substream *substream,
	struct soc_dma_chan *dma);

static void soc_dmaengine_callback(void *data)
{
	struct snd_pcm_substream *substream = data;
	struct soc_dma_chan *dma = substream->runtime->private_data;
	int ret;

	snd_pcm_period_elapsed(substream);

	if (!dma->stopped && !dma->cyclic) {
		spin_lock(&dma->lock);
		ret = soc_dmaengine_submit(substream, dma);
		spin_unlock(&dma->lock);

		if (ret == 0)
			dma_async_issue_pending(dma->chan);
		else
			pr_err("%s: failed to submit next DMA buffer\n", __func__);
	}
}

static int soc_dmaengine_submit(struct snd_pcm_substream *substream,
	struct soc_dma_chan *dma)
{
	struct dma_async_tx_descriptor *tx;
	struct dma_chan *ch = dma->chan;
	struct buf_info *buf;
	unsigned sg_index;

	sg_index = dma->sg_index;

	buf = &dma->buf[sg_index];

	tx = dmaengine_prep_slave_sg(ch, &buf->sg, 1, dma->dir,
		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
	if (tx) {
		tx->callback = soc_dmaengine_callback;
		tx->callback_param = substream;

		buf->cookie = dmaengine_submit(tx);

		sg_index++;
		if (sg_index >= dma->nr_periods)
			sg_index = 0;
		dma->sg_index = sg_index;
	}

	return tx ? 0 : -ENOMEM;
}

static int soc_dmaengine_start(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct soc_dma_chan *dma = runtime->private_data;
	unsigned long flags;
	unsigned i;
	int ret = 0;

	if (!dma->cyclic) {
		spin_lock_irqsave(&dma->lock, flags);
		for (i = 0; i < dma->nr_periods; i++) {
			ret = soc_dmaengine_submit(substream, dma);
			if (ret)
				break;
		}
		spin_unlock_irqrestore(&dma->lock, flags);
		if (ret == 0) {
			dma->stopped = 0;
			dma_async_issue_pending(dma->chan);
		} else {
			dma->stopped = 1;
			dmaengine_terminate_all(dma->chan);
		}
	} else {
		struct dma_async_tx_descriptor *tx;

		tx = dmaengine_prep_dma_cyclic(dma->chan, runtime->dma_addr,
			snd_pcm_lib_buffer_bytes(substream),
			snd_pcm_lib_period_bytes(substream), dma->dir,
			DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
		if (tx) {
			tx->callback = soc_dmaengine_callback;
			tx->callback_param = substream;

			dma->cyclic_cookie = dmaengine_submit(tx);
			dma_async_issue_pending(dma->chan);
		}
	}

	return ret;
}

static int soc_dmaengine_stop(struct snd_pcm_substream *substream)
{
	struct soc_dma_chan *dma = substream->runtime->private_data;

	dma->stopped = 1;
	dmaengine_terminate_all(dma->chan);

	return 0;
}

static int soc_dmaengine_open(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct soc_dma_info *info = snd_soc_platform_get_drvdata(rtd->platform);
	struct soc_dma_chan *dma = info->chan[substream->stream];
	int ret = 0;

	if (!dma)
		return -EINVAL;

	runtime->hw = soc_dmaengine_hardware;
	runtime->hw.fifo_size = dma->conf->fifo_size;

	if (dma->conf->align) {
		/*
		 * FIXME: Ideally, there should be some way to query
		 * this from the DMA engine itself.
		 *
		 * It would also be helpful to know the maximum size
		 * a scatterlist entry can be to set the period size.
		 */
		ret = snd_pcm_hw_constraint_step(runtime, 0,
			SNDRV_PCM_HW_PARAM_PERIOD_BYTES, dma->conf->align);
		if (ret)
			goto err;

		ret = snd_pcm_hw_constraint_step(runtime, 0,
			SNDRV_PCM_HW_PARAM_BUFFER_BYTES, dma->conf->align);
		if (ret)
			goto err;
	}

	runtime->private_data = dma;

 err:
	return ret;
}

static int soc_dmaengine_close(struct snd_pcm_substream *substream)
{
	return 0;
}

static int soc_dmaengine_hw_params(struct snd_pcm_substream *substream,
	struct snd_pcm_hw_params *params)
{
	int ret = snd_pcm_lib_malloc_pages(substream,
			params_buffer_bytes(params));

	return ret < 0 ? ret : 0;
}

static int soc_dmaengine_prepare(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct soc_dma_chan *dma = runtime->private_data;
	size_t buf_size = snd_pcm_lib_buffer_bytes(substream);
	size_t period = snd_pcm_lib_period_bytes(substream);
	dma_addr_t addr = runtime->dma_addr;
	unsigned i;

	/* Create an array of sg entries, one for each period */
	for (i = 0; i < PERIODS_MAX && buf_size; i++) {
		BUG_ON(buf_size < period);

		sg_dma_address(&dma->buf[i].sg) = addr;
		sg_dma_len(&dma->buf[i].sg) = period;

		addr += period;
		buf_size -= period;
	}

	if (buf_size) {
		pr_err("DMA buffer size not a multiple of the period size: residue=%zu\n", buf_size);
		return -EINVAL;
	}

	dma->nr_periods = i;
	dma->sg_index = 0;

	return 0;
}

static int soc_dmaengine_trigger(struct snd_pcm_substream *substream, int cmd)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct soc_dma_chan *dma = runtime->private_data;
	int ret;

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		ret = soc_dmaengine_start(substream);
		break;

	case SNDRV_PCM_TRIGGER_STOP:
		ret = soc_dmaengine_stop(substream);
		break;

	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
	case SNDRV_PCM_TRIGGER_SUSPEND:
		ret = dmaengine_pause(dma->chan);
		break;

	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
	case SNDRV_PCM_TRIGGER_RESUME:
		ret = dmaengine_resume(dma->chan);
		break;

	default:
		ret = -EINVAL;
	}

	return ret;
}

static snd_pcm_uframes_t soc_dmaengine_pointer(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct soc_dma_chan *dma = runtime->private_data;
	struct dma_chan *ch = dma->chan;
	struct dma_tx_state state;
	unsigned bytes;

	if (dma->cyclic) {
		ch->device->device_tx_status(ch, dma->cyclic_cookie, &state);

		bytes = snd_pcm_lib_buffer_bytes(substream) - state.residue;
	} else {
		unsigned index, pos;
		size_t period = snd_pcm_lib_period_bytes(substream);
		unsigned long flags;
		enum dma_status status;
		dma_cookie_t cookie;

		/*
		 * Get the next-to-be-submitted index, and the last submitted
		 * cookie value.  We use this to obtain the DMA engine state.
		 */
		spin_lock_irqsave(&dma->lock, flags);
		index = dma->sg_index;
		do {
			cookie = dma->buf[index].cookie;
			status = ch->device->device_tx_status(ch, cookie, &state);
			if (status == DMA_SUCCESS) {
				index++;
				if (index > dma->nr_periods)
					index = 0;
			}
		} while (status == DMA_SUCCESS);
		spin_unlock_irqrestore(&dma->lock, flags);

		/* The end of the current DMA buffer */
		pos = (index + 1) * period;
		/* Now take off the residue */
		bytes = pos - state.residue;
		/* And correct for wrap-around */
		if (bytes >= period * dma->nr_periods)
			bytes -= period * dma->nr_periods;
	}

	return bytes_to_frames(runtime, bytes);
}

static int soc_dmaengine_mmap(struct snd_pcm_substream *substream,
	struct vm_area_struct *vma)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_dma_buffer *buf = runtime->dma_buffer_p;

	return dma_mmap_writecombine(buf->dev.dev, vma,
		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
}

static struct snd_pcm_ops soc_dmaengine_ops = {
	.open = soc_dmaengine_open,
	.close = soc_dmaengine_close,
	.ioctl = snd_pcm_lib_ioctl,
	.hw_params = soc_dmaengine_hw_params,
	.hw_free = snd_pcm_lib_free_pages,
	.prepare = soc_dmaengine_prepare,
	.trigger = soc_dmaengine_trigger,
	.pointer = soc_dmaengine_pointer,
	.mmap = soc_dmaengine_mmap,
};

static struct soc_dma_chan *soc_dmaengine_alloc(void)
{
	struct soc_dma_chan *dma = kzalloc(sizeof(*dma), GFP_KERNEL);
	unsigned i;

	if (dma) {
		spin_lock_init(&dma->lock);
		for (i = 0; i < PERIODS_MAX; i++)
			sg_init_table(&dma->buf[i].sg, 1);
	}
	return dma;
}

static struct dma_chan *soc_dmaengine_get(enum dma_transaction_type type,
	struct soc_dma_config *cfg)
{
	dma_cap_mask_t m;

	dma_cap_zero(m);
	dma_cap_set(type, m);
	return dma_request_channel(m, cfg->filter, cfg->data);
}

static int soc_dmaengine_request(struct soc_dma_chan *dma,
	struct soc_dma_config *cfg, unsigned stream)
{
	int ret;

	dma->conf = cfg;
	dma->chan = soc_dmaengine_get(DMA_CYCLIC, cfg);
	if (!dma->chan)
		dma->chan = soc_dmaengine_get(DMA_SLAVE, cfg);
	else
		dma->cyclic = 1;
	if (!dma->chan) {
		ret = -ENXIO;
		goto err_dma_req;
	}

	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
		dma->dir = DMA_MEM_TO_DEV;
		dma->cfg.direction = DMA_MEM_TO_DEV;
		dma->cfg.dst_addr = cfg->reg;
		dma->cfg.dst_addr_width = cfg->width;
		dma->cfg.dst_maxburst = cfg->maxburst;
	} else {
		dma->dir = DMA_DEV_TO_MEM;
		dma->cfg.direction = DMA_DEV_TO_MEM;
		dma->cfg.src_addr = cfg->reg;
		dma->cfg.src_addr_width = cfg->width;
		dma->cfg.src_maxburst = cfg->maxburst;
	}

	ret = dmaengine_slave_config(dma->chan, &dma->cfg);
	if (ret)
		goto err_dma_cfg;

	return 0;

 err_dma_cfg:
	dma_release_channel(dma->chan);
	dma->chan = NULL;
 err_dma_req:
	return ret;
}

static void soc_dmaengine_release(struct soc_dma_chan *dma)
{
	if (dma && dma->chan)
		dma_release_channel(dma->chan);
	kfree(dma);
}

static int soc_dmaengine_preallocate_buffer(struct snd_pcm *pcm,
	unsigned stream, struct soc_dma_chan *dma)
{
	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
	int ret = 0;

	if (substream) {
		struct snd_dma_buffer *buf = &substream->dma_buffer;

		buf->dev.type = SNDRV_DMA_TYPE_DEV;
		buf->dev.dev = dma->chan->device->dev;
		buf->private_data = NULL;
		buf->area = dma_alloc_writecombine(buf->dev.dev,
				BUFFER_SIZE_MAX, &buf->addr, GFP_KERNEL);
		if (!buf->area)
			return -ENOMEM;

		buf->bytes = BUFFER_SIZE_MAX;
	}
	return ret;
}

static int soc_dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
{
	struct snd_pcm *pcm = rtd->pcm;
	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
	struct soc_dma_info *info;
	unsigned stream;
	int ret = 0;

	if (!cpu_dai)
		return -EINVAL;

	if (!cpu_dai->playback_dma_data &&
	    !cpu_dai->capture_dma_data) {
		pr_err("soc_dmaengine: %s has no cpu_dai DMA data - incorrect probe ordering?\n",
			rtd->card->name);
		return -EINVAL;
	}

	info = kzalloc(sizeof(*info), GFP_KERNEL);
	if (!info)
		return -ENOMEM;

	for (stream = 0; stream < ARRAY_SIZE(pcm->streams); stream++) {
		struct soc_dma_config *cfg = NULL;
		struct soc_dma_chan *dma;

		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
			cfg = cpu_dai->playback_dma_data;
		else if (stream == SNDRV_PCM_STREAM_CAPTURE)
			cfg = cpu_dai->capture_dma_data;

		if (!cfg)
			continue;

		info->chan[stream] = dma = soc_dmaengine_alloc();
		if (!dma) {
			ret = -ENOMEM;
			break;
		}

		ret = soc_dmaengine_request(dma, cfg, stream);
		if (ret)
			return ret;

		ret = soc_dmaengine_preallocate_buffer(pcm, stream, dma);
		if (ret)
			break;
	}

	if (ret) {
		for (stream = 0; stream < ARRAY_SIZE(info->chan); stream++)
			soc_dmaengine_release(info->chan[stream]);
		kfree(info);
	} else {
		snd_soc_platform_set_drvdata(rtd->platform, info);
	}

	return ret;
}

/*
 * Use write-combining memory here: the standard ALSA
 * snd_free_dev_pages() doesn't support this.
 */
static void soc_dmaengine_pcm_free(struct snd_pcm *pcm)
{
	unsigned stream;

	for (stream = 0; stream < ARRAY_SIZE(pcm->streams); stream++) {
		struct snd_pcm_substream *substream = pcm->streams[stream].substream;
		struct snd_dma_buffer *buf;

		if (!substream)
			continue;
		buf = &substream->dma_buffer;
		if (!buf->area)
			continue;

		if (buf->dev.type == SNDRV_DMA_TYPE_DEV)
			dma_free_writecombine(buf->dev.dev, buf->bytes,
					      buf->area, buf->addr);
		else
			snd_dma_free_pages(buf);
		buf->area = NULL;
	}
}

/*
 * This is annoying - we can't have symetry with .pcm_new because .pcm_free
 * is called after the runtime information has been removed.  It would be
 * better if we could find somewhere else to store our soc_dma_info pointer.
 */
static int soc_dmaengine_plat_remove(struct snd_soc_platform *platform)
{
	struct soc_dma_info *info = snd_soc_platform_get_drvdata(platform);
	unsigned stream;

	for (stream = 0; stream < ARRAY_SIZE(info->chan); stream++)
		soc_dmaengine_release(info->chan[stream]);
	kfree(info);

	return 0;
}

static struct snd_soc_platform_driver soc_dmaengine_platform = {
	.remove = soc_dmaengine_plat_remove,
	.pcm_new = soc_dmaengine_pcm_new,
	.pcm_free = soc_dmaengine_pcm_free,
	.ops = &soc_dmaengine_ops,
	/* Wait until the cpu_dai has been probed */
	.probe_order = SND_SOC_COMP_ORDER_LATE,
};

static int soc_dmaengine_probe(struct platform_device *pdev)
{
	return snd_soc_register_platform(&pdev->dev, &soc_dmaengine_platform);
}

static int soc_dmaengine_remove(struct platform_device *pdev)
{
	snd_soc_unregister_platform(&pdev->dev);
	return 0;
}

static struct platform_driver soc_dmaengine_driver = {
	.driver = {
		.name = "soc-dmaengine",
		.owner = THIS_MODULE,
	},
	.probe = soc_dmaengine_probe,
	.remove = soc_dmaengine_remove,
};

module_platform_driver(soc_dmaengine_driver);

MODULE_AUTHOR("Russell King");
MODULE_DESCRIPTION("ALSA SoC DMA engine driver");
MODULE_LICENSE("GPL v2");
MODULE_ALIAS("platform:soc-dmaengine");
