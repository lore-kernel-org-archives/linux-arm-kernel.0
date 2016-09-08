From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 14:46:51 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87r38uhalt.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <12394164.0mceYlJJBD@wuerfel> <87r38uhalt.fsf@linux.intel.com>
Message-ID: <7818609.ZAbFcr85D0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 2:52:46 PM CEST Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> >> If we make dwc3.ko a library which glue calls directly then all these
> >> problems are solved but we break all current DTs and fall into the trap
> >> of having another MUSB.
> >
> > I don't see how we'd break the current DTs, I'm fairly sure we could turn dwc3
> 
> well, at a minimum dwc3-{pci,exynos,st,omap,of-simple}.c would have to
> look at possible children for their own quirks and properties.
> 
> > into a library without changing the DT representation. However the parts
> > that I think would change are
> >
> > - The sysfs representation for dwc3-pci, as we would no longer have
> >   a parent-child relationship there.
> 
> that's a no-brainer, I think
> 
> > - The power management handling might need a rework, since you currently
> >   rely on the hierarchy between dwc3-pci, dwc3 and xhci for turning
> >   power on and off
> 
> simple enough to do as well.
> 
> > - turning dwc3 into a library probably implies also turning xhci into
> >   a library, in part for consistency.
> 
> yeah, I considered that too. We could still do it in parts, though.
> 
> > - if we don't do the whole usb_bus->sysdev thing, we need to not just
> >   do this for dwc3 but also chipidea and maybe a couple of others.
> 
> MUSB comes to mind

Right.

> > There should not be any show-stoppers here, but it's a lot of work.
> 
> I think the biggest work will making sure people don't abuse functions
> just because they're now part of a single binary. Having them as
> separate modules helped a lot reducing the maintenance overhead. There
> was only one occasion where someone sent a glue layer which iterated
> over its children to find struct dwc3 * from child's drvdata.

This is where it get a bit philosophical ;-)

I understand that you like the strict separation that the current model
provides, and I agree that can be an advantage.

Changing the abstraction model to a set of library modules the way that
other drivers (e.g. ehci, sdhci, or libata) work to me means changing
this separation model into a different model and once we do that I would
not consider it a mistake for the platform specific driver to take
advantage of that. You still get a bit of separation since the drivers
would be in separate modules that can only access exported symbols,
and the library can still hide its data structures (to some degree).

I still think that turning xhci (and dwc3) into a library would be
an overall win, but if we solve the problems of DMA settings and
usb_device DT properties without it, I'd prefer not to fight over
that with you again ;-)

> >> If we try to pass DMA bits from parent to child, then we have the fact
> >> that DT ends up, in practice, always having a parent device.
> >
> > I don't understand what you mean here, but I agree that the various ways
> 
> well, we can't simply use what I pointed out a few emails back:
> 
> if (dwc->dev->parent)
> 	dwc->sysdev = dwc->dev->parent
> else
> 	dwc->sysdev = dwc->dev

Ok, I see.

> > we discussed for copying the DMA flags from one 'struct device' to another
> > all turned out to be flawed in at least one way.
> >
> > Do you see any problems with the patch I posted other than the ugliness
> > of the dwc3 and xhci drivers finding out which pointer to use for
> > usb_bus->sysdev? If we can solve this, we shouldn't need any new
> > of_dma_configure/acpi_dma_configure calls and we won't have to
> > turn the drivers into a library, so maybe let's try to come up with
> > better ideas for that sub-problem.
> 
> No big problems with that, no. Just the ifdef looking for a PCI bus in
> the parent. How about passing a flag via device_properties? I don't
> wanna change dwc3 core's device name with a platform_device_id because
> there probably already are scripts relying on the names to enable
> pm_runtime for example.

Sounds ok to me. Grygorii's solution might a be a bit more elegant,
but also a bit more error-prone:
If we get a platform that mistakenly sets the dma_mask pointer of
the child device, or a platform that does not set the dma_mask
pointer of the parent, things break.

	Arnd
