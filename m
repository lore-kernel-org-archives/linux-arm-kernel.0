From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Sep 2014 10:25:36 +0100
Subject: [PATCH 6/9] dmaengine: Create a generic dma_slave_caps callback
In-Reply-To: <1411808085-27792-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411808085-27792-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140927092536.GZ5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 10:54:42AM +0200, Maxime Ripard wrote:
> dma_slave_caps is very important to the generic layers that might interact with
> dmaengine, such as ASoC. Unfortunately, it has been added as yet another
> dma_device callback, and most of the existing drivers haven't implemented it,
> reducing its reliability.

Many haven't implemented it probably because either (a) they don't get used
with ASoC, or (b) they aren't aware of the new interface, or (c) can't be
bothered with the churn.

However, trying to return something introduces a bug:

>  static inline int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  {
> +	struct dma_device *device;
> +
>  	if (!chan || !caps)
>  		return -EINVAL;
>  
> +	device = chan->device;
> +
>  	/* check if the channel supports slave transactions */
> -	if (!test_bit(DMA_SLAVE, chan->device->cap_mask.bits))
> +	if (!test_bit(DMA_SLAVE, device->cap_mask.bits))
>  		return -ENXIO;
>  
> -	if (chan->device->device_slave_caps)
> -		return chan->device->device_slave_caps(chan, caps);
> +	caps->cmd_pause = !!device->device_pause;
> +	caps->cmd_terminate = !!device->device_terminate_all;
> +
> +	if (device->device_slave_caps)
> +		return device->device_slave_caps(chan, caps);
>  
> -	return -ENXIO;
> +	return 0;

So this now returns success if the driver doesn't implement device_slave_caps(),
but with most of the structure zero.

Now, consider what effect this has with:


        ret = dma_get_slave_caps(chan, &dma_caps);
        if (ret == 0) {
                if (dma_caps.cmd_pause)
                        hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
                if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
                        hw.info |= SNDRV_PCM_INFO_BATCH;

                if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
                        addr_widths = dma_caps.dstn_addr_widths;
                else
                        addr_widths = dma_caps.src_addr_widths;
        }

addr_widths becomes zero, and we also get SNDRV_PCM_INFO_BATCH turned
on for _all_ DMA engine drivers.  The first renders ASoC useless with
DMA engine.

It may be a good way to get people to implement it, but this will cause
regressions.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
