From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Oct 2014 10:08:51 +0200
Subject: [PATCH v2 06/53] dmaengine: Create a generic dma_slave_caps
 callback
In-Reply-To: <2111765.kYORi97jNj@avalon>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
 <1496298.0f0GAuhKve@avalon> <20141016162453.GN19438@lukather>
 <2111765.kYORi97jNj@avalon>
Message-ID: <20141023080851.GI7893@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Oct 22, 2014 at 11:16:03PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
> 
> On Thursday 16 October 2014 18:24:53 Maxime Ripard wrote:
> > On Thu, Oct 16, 2014 at 07:15:40PM +0300, Laurent Pinchart wrote:
> > > On Thursday 16 October 2014 12:17:05 Maxime Ripard wrote:
> > > > dma_slave_caps is very important to the generic layers that might
> > > > interact with dmaengine, such as ASoC. Unfortunately, it has been added
> > > > as yet another dma_device callback, and most of the existing drivers
> > > > haven't implemented it, reducing its reliability.
> > > > 
> > > > Introduce a generic behaviour and a flag to trigger it. In case this
> > > > flag hasn't been set, fall back to the old mechanism.
> > > > 
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > ---
> > > > 
> > > >  include/linux/dmaengine.h | 25 +++++++++++++++++++++----
> > > >  1 file changed, 21 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > > index 4d0294ec3567..85afd71df2e7 100644
> > > > --- a/include/linux/dmaengine.h
> > > > +++ b/include/linux/dmaengine.h
> > > > @@ -643,6 +643,8 @@ struct dma_device {
> > > > 
> > > >  	int dev_id;
> > > >  	struct device *dev;
> > > > 
> > > > +	bool generic_slave_caps;
> > > > +
> > > > 
> > > >  	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> > > >  	void (*device_free_chan_resources)(struct dma_chan *chan);
> > > > 
> > > > @@ -772,17 +774,32 @@ static inline struct dma_async_tx_descriptor
> > > > *dmaengine_prep_interleaved_dma(
> > > > 
> > > >  static inline int dma_get_slave_caps(struct dma_chan *chan, struct
> > > > 
> > > > dma_slave_caps *caps) {
> > > 
> > > This is getting too big for an inline function, it should be moved to
> > > drivers/dma/dmaengine.c.
> > 
> > I agree, but I wanted to do that in another patch set. This one is
> > just getting bigger and bigger, and this is not really the point of
> > this serie.
> 
> If both get merged in the same kernel version I would be fine with this.

I'll do my best.

> > > > +	struct dma_device *device;
> > > > +
> > > > 
> > > >  	if (!chan || !caps)
> > > >  		return -EINVAL;
> > > > 
> > > > +	device = chan->device;
> > > > +
> > > > 
> > > >  	/* check if the channel supports slave transactions */
> > > > 
> > > > -	if (!test_bit(DMA_SLAVE, chan->device->cap_mask.bits))
> > > > +	if (!test_bit(DMA_SLAVE, device->cap_mask.bits))
> > > > +		return -ENXIO;
> > > > +
> > > > +	if (device->device_slave_caps)
> > > > +		return device->device_slave_caps(chan, caps);
> > > > +
> > > > +	/*
> > > > +	 * Check whether it reports it uses the generic slave
> > > > +	 * capabilities, if not, that means it doesn't support any
> > > > +	 * kind of slave capabilities reporting.
> > > > +	 */
> > > > +	if (device->generic_slave_caps)
> > > >  		return -ENXIO;
> > > 
> > > Couldn't we replace that check with if (device->device_control) and get
> > > rid of the generic_slave_caps field ? Drivers converted to the new API
> > > would then get slave caps support for free.
> > 
> > Not really. Drivers might have converted to the splitted device_control (and
> > actually all of them are), while they don't define the values needed to
> > implement properly the generic slave caps retrieval (and the vast majority
> > of them doesn't).
> 
> Indeed, my bad.
> 
> How about testing those fields then ? You could consider that the driver wants 
> the generic slave caps implementation if device->directions is set to a non-
> zero value for instance.


Hmmm, why not. I guess I'm in for a v4 then :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141023/b851f5d2/attachment.sig>
