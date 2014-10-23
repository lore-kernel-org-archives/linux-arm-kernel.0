From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 23 Oct 2014 16:38:39 +0300
Subject: [PATCH v3 58/59] dmaengine: Add a warning for drivers not using
 the generic slave caps retrieval
In-Reply-To: <20141023131933.GO7893@lukather>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
 <2006617.Jsn4xl9O1U@avalon> <20141023131933.GO7893@lukather>
Message-ID: <4793064.0sBqs1vkQS@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thursday 23 October 2014 15:19:33 Maxime Ripard wrote:
> On Thu, Oct 23, 2014 at 12:21:31AM +0300, Laurent Pinchart wrote:
> > Hi Maxime,
> > 
> > Thank you for the patch.
> > 
> > On Wednesday 22 October 2014 17:44:12 Maxime Ripard wrote:
> > > For the slave caps retrieval to be really useful, most drivers need to
> > > implement it.
> > > 
> > > Hence, we need to be slightly more aggressive, and trigger a warning at
> > > registration time for drivers that don't fill their caps infos in order
> > > to
> > > encourage them to implement it.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > > 
> > >  drivers/dma/dmaengine.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > index 98e9431f85ec..4e18981b16bd 100644
> > > --- a/drivers/dma/dmaengine.c
> > > +++ b/drivers/dma/dmaengine.c
> > > @@ -827,6 +827,9 @@ int dma_async_device_register(struct dma_device
> > > *device) BUG_ON(!device->device_issue_pending);
> > > 
> > >  	BUG_ON(!device->dev);
> > > 
> > > +	WARN(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
> > > !device->generic_slave_caps,
> > > +	     "this driver doesn't support generic slave capabilities
> > > reporting\n");
> > > +
> > 
> > This might be slightly too aggressive.
> 
> I disagree with that. If we want at some point to have the drivers
> implement it, we should be aggressive (and note that we don't break
> anything, the driver will still work as it used to).

I meant too aggressive given the possibility that a driver might need its own 
implementation if not all channels have the same capability.

> > I agree with your previous comment on all DMA engine drivers
> > returning the same capabilities for all channels, but it might not
> > be true anymore in the future, in which case drivers will need to
> > implement a custom slave caps function. We could delay support for
> > that to when it's needed though.
> 
> Actually, my next patch (59) is removing such possibility... And you
> acked it ;)
> 
> Is it still something we should be concerned about?

Maybe not now, we can always add that possibility back in the future if 
needed.

-- 
Regards,

Laurent Pinchart
