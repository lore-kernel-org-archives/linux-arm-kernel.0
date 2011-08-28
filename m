From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 28 Aug 2011 18:39:34 +1000
Subject: How to handle named resources with DT?
In-Reply-To: <5595208.OB5dBohxQP@wuerfel>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108261741.29850.arnd@arndb.de>
	<20110827143736.GA10182@yookeroo.fritz.box>
	<5595208.OB5dBohxQP@wuerfel>
Message-ID: <20110828083934.GA4254@yookeroo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2011 at 08:13:59PM +0200, Arnd Bergmann wrote:
> On Sunday 28 August 2011 00:37:36 David Gibson wrote:
> > On Fri, Aug 26, 2011 at 05:41:29PM +0200, Arnd Bergmann wrote:
> > > On Friday 26 August 2011, Arnd Bergmann wrote:
> > > > On Friday 26 August 2011, David Gibson wrote:
> > > > > If you open code it this way then yes, it's silly.  But what about
> > > > > something like this:
> > > > > 
> > > > > static struct of_device_id foodevice_of_match[] __devinitdata = {
> > > > >         { .compatible = "foocorp,foodevice1234",
> > > > >           .resource_names = {"base_regs", "extra_regs", }, },
> > > > >         { .compatible = "foocorp,foodevice1239",
> > > > >           .resource_names = {"base_regs", "extra_regs", "more_regs", }, }, 
> > > > >         { },
> > > > > };
> > > > 
> > > > Hmm, I hadn't thought of that. This looks quite nice indeed. No objections
> > > > to this from my side.
> > > > 
> > > 
> > > Ah well, one objection on second thought:
> > > 
> > > This assumes that there is just one type of resource, but named resources
> > > may be used for iomem, ioport and irq resources. If you have multiple
> > > IRQs and multiple IOMEM resources, I don't see how the index in the 
> > > resource_names array can be used for both of them.
> > 
> > Details, shmetails, so you have both 'reg_names' and 'interrupt_names'.
> 
> Right, and I guess we can simply ignore DMA and ioport resources because they
> are extremely rare, right?

Well, remember it's where resources can appear in the DT node that
matters, not what the types are in the platform device.  ioports will
typically appear suitably encoded in 'reg', so that's covered.  I've
never been very clear on what exactly DMA resources cover, but yeah,
you might need something for dma-reg or other device tree properties.

> One more detail: IIRC struct of_device_id is exported to module_init_tools
> for purposes of autoloading, so changing the structure breaks user
> space.

Ah.  That is a bit more of a problem.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
