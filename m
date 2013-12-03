From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Dec 2013 12:12:22 +0000
Subject: [PATCHv8] dmaengine: Add support for BCM2835
In-Reply-To: <1386072258.1871.44.camel@smile>
References: <529CDBA8.6070107@koalo.de> <1386072258.1871.44.camel@smile>
Message-ID: <20131203121222.GS16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 02:04:18PM +0200, Andy Shevchenko wrote:
> On Mon, 2013-12-02 at 20:12 +0100, Florian Meier wrote:
> > +static void bcm2835_dma_free(struct bcm2835_dmadev *od)
> > +{
> > +	while (!list_empty(&od->ddev.channels)) {
> > +		struct bcm2835_chan *c = list_first_entry(&od->ddev.channels,
> > +			struct bcm2835_chan, vc.chan.device_node);
> > +
> 
> list_for_each_entry_safe() suits well here.
> 
> > +		list_del(&c->vc.chan.device_node);
> > +		tasklet_kill(&c->vc.task);
> > +	}

For such a loop, where we're deleting all entries in a list,
list_for_each_entry_safe() is a little heavier than necessary.  This
is how the code would look:

static void bcm2835_dma_free(struct bcm2835_dmadev *od)
{
	struct bcm2835_chan *c, *next;

	list_for_each_entry_safe(c, next, &od->ddev.channels,
				 vc.chan.device_node) {
		list_del(&c->vc.chan.device_node);
		tasklet_kill(&c->vc.task);
	}

I see very little gain in this approach.
