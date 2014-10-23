From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Oct 2014 15:46:51 +0200
Subject: [PATCH v3 58/59] dmaengine: Add a warning for drivers not using
 the generic slave caps retrieval
In-Reply-To: <4793064.0sBqs1vkQS@avalon>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
 <2006617.Jsn4xl9O1U@avalon> <20141023131933.GO7893@lukather>
 <4793064.0sBqs1vkQS@avalon>
Message-ID: <20141023134651.GQ7893@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 04:38:39PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
> 
> On Thursday 23 October 2014 15:19:33 Maxime Ripard wrote:
> > On Thu, Oct 23, 2014 at 12:21:31AM +0300, Laurent Pinchart wrote:
> > > Hi Maxime,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Wednesday 22 October 2014 17:44:12 Maxime Ripard wrote:
> > > > For the slave caps retrieval to be really useful, most drivers need to
> > > > implement it.
> > > > 
> > > > Hence, we need to be slightly more aggressive, and trigger a warning at
> > > > registration time for drivers that don't fill their caps infos in order
> > > > to
> > > > encourage them to implement it.
> > > > 
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > ---
> > > > 
> > > >  drivers/dma/dmaengine.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > > index 98e9431f85ec..4e18981b16bd 100644
> > > > --- a/drivers/dma/dmaengine.c
> > > > +++ b/drivers/dma/dmaengine.c
> > > > @@ -827,6 +827,9 @@ int dma_async_device_register(struct dma_device
> > > > *device) BUG_ON(!device->device_issue_pending);
> > > > 
> > > >  	BUG_ON(!device->dev);
> > > > 
> > > > +	WARN(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
> > > > !device->generic_slave_caps,
> > > > +	     "this driver doesn't support generic slave capabilities
> > > > reporting\n");
> > > > +
> > > 
> > > This might be slightly too aggressive.
> > 
> > I disagree with that. If we want at some point to have the drivers
> > implement it, we should be aggressive (and note that we don't break
> > anything, the driver will still work as it used to).
> 
> I meant too aggressive given the possibility that a driver might need its own 
> implementation if not all channels have the same capability.

Then we'll remove this warning, or rework it, when we will need it,
and hopefully by then, a lot of drivers will have fixed theirs :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141023/76e5e69a/attachment-0001.sig>
