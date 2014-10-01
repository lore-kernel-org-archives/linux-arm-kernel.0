From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Oct 2014 10:21:57 +0200
Subject: [PATCH 6/9] dmaengine: Create a generic dma_slave_caps callback
In-Reply-To: <20140927092536.GZ5182@n2100.arm.linux.org.uk>
References: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411808085-27792-7-git-send-email-maxime.ripard@free-electrons.com>
 <20140927092536.GZ5182@n2100.arm.linux.org.uk>
Message-ID: <20141001082157.GE6884@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Sep 27, 2014 at 10:25:36AM +0100, Russell King - ARM Linux wrote:
> On Sat, Sep 27, 2014 at 10:54:42AM +0200, Maxime Ripard wrote:
> > dma_slave_caps is very important to the generic layers that might interact with
> > dmaengine, such as ASoC. Unfortunately, it has been added as yet another
> > dma_device callback, and most of the existing drivers haven't implemented it,
> > reducing its reliability.
> 
> Many haven't implemented it probably because either (a) they don't get used
> with ASoC, or (b) they aren't aware of the new interface, or (c) can't be
> bothered with the churn.

For a), I really see this as a chicken-egg issue. ASoC is the only
user of it because it's the only framework that has a generic layer on
top, and it's the only framework that has a generic layer because most
drivers don't implement it.

Now, there seems to be a trend to actually use a generic DMA layer in
other frameworks. SPI gained one recently, I think I saw something
about some discussions for IIO and I2C too. And in order for this to
work, we have to make it reliable, and as such, implemented on most
drivers.

> However, trying to return something introduces a bug:
> 
> >  static inline int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >  {
> > +	struct dma_device *device;
> > +
> >  	if (!chan || !caps)
> >  		return -EINVAL;
> >  
> > +	device = chan->device;
> > +
> >  	/* check if the channel supports slave transactions */
> > -	if (!test_bit(DMA_SLAVE, chan->device->cap_mask.bits))
> > +	if (!test_bit(DMA_SLAVE, device->cap_mask.bits))
> >  		return -ENXIO;
> >  
> > -	if (chan->device->device_slave_caps)
> > -		return chan->device->device_slave_caps(chan, caps);
> > +	caps->cmd_pause = !!device->device_pause;
> > +	caps->cmd_terminate = !!device->device_terminate_all;
> > +
> > +	if (device->device_slave_caps)
> > +		return device->device_slave_caps(chan, caps);
> >  
> > -	return -ENXIO;
> > +	return 0;
> 
> So this now returns success if the driver doesn't implement device_slave_caps(),
> but with most of the structure zero.
> 
> Now, consider what effect this has with:
> 
> 
>         ret = dma_get_slave_caps(chan, &dma_caps);
>         if (ret == 0) {
>                 if (dma_caps.cmd_pause)
>                         hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
>                 if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
>                         hw.info |= SNDRV_PCM_INFO_BATCH;
> 
>                 if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>                         addr_widths = dma_caps.dstn_addr_widths;
>                 else
>                         addr_widths = dma_caps.src_addr_widths;
>         }
> 
> addr_widths becomes zero, and we also get SNDRV_PCM_INFO_BATCH turned
> on for _all_ DMA engine drivers.  The first renders ASoC useless with
> DMA engine.
> 
> It may be a good way to get people to implement it, but this will cause
> regressions.

Hmmm, nasty indeed. Maybe we could add a test to see if any of the
field we're going to use are filled, and if not, return an error?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/262b71c3/attachment.sig>
