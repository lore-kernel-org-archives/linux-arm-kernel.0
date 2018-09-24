From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2018 12:13:41 +0100
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <20180924122614.70738b5c@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
Message-ID: <20180924111341.GP30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 12:26:14PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 24 Sep 2018 11:12:13 +0100, Russell King - ARM Linux wrote:
> 
> > > Thanks for the testing. I'll wait for Russell to say if he is happy
> > > (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> > > the case, I'll send a proper patch to fix the issue.  
> > 
> > I'd prefer not to provide an unmapping API, because it gives the
> > impression that it's okay to unmap the IO space mapping, and we'll
> > end up with drivers that decide to call it in their cleanup path.
> > IO space isn't expected to ever go away - eg, on a PC, it's always
> > present.
> 
> But being able to unmap it would also be needed to be able to remove
> PCI host controller drivers, and therefore compile them as module, and
> make them more like any other drivers.
> 
> I'm not sure why we need to guarantee that the I/O space is always
> mapped:
> 
>  - It isn't mapped before the PCI controller driver does the mapping.
> 
>  - There is no reason for it to be accessed when the PCI controller
>    driver is not initialized: PCI devices can only be probed and
>    initialized when the PCI controller driver is probed/initialized.

There are historic reasons.  PCI provides ISA IO space, and when you
have a machine with ISA peripherals present, the PCI IO space must
never be unmapped - if it is, ISA drivers will oops the kernel.  There
is no way for a vanishing PCI controller to cause ISA drivers to be
unbound.

If you have a host controller that does unmap PCI IO space and you have
ISA peripherals with drivers present, unbinding the PCI host controller
will remove the IO space mapping, and next time an ISA peripheral
touches IO space, the kernel will oops.

> All other drivers, including on ARM, use pci_remap_iospace(), which
> does provide the pci_unmap_iospace() counter part.

... which has been created in PCI land just to deal with PCI without
regard for the above issue.

However, there's another issue I missed - if you _do_ have ISA
peripherals, you likely want the IO space setup from very early on,
and you won't be using the new fangled PCI host driver support anyway.
That uses pci_map_io_early() rather than pci_ioremap_io() or
pci_remap_io().

> But to me, the general direction is that the ARM-specific
> pci_remap_io() API is fading away, and its replacement already provides
> an unmapping capability. So why not add the same unmapping capability
> to pci_remap_io() ?

Yes, that would be a good longer term plan - we don't need three
different ways to map PCI IO space, but it is development.

> But we have a regression and we need to fix it. Do you suggest to not
> use the new pci_host_probe() API ?

Well, arguably, the patch that caused the regression is the buggy patch,
_not_ the lack of unmapping API for pci_ioremap_io().  Trying to address
a regression with further development means that _that_ development
needs thought and review, which is a slower process.

I do understand the desire to keep moving forward and never take a step
backwards, but sometimes backwards steps are the best way to resolve a
regression.  But I also do appreciate that a simple revert in this case
is not possible.

I'll accept your patch on the condition that the ARM private
pci_ioremap_io() will go away in the very near future (please _try_
to get agreement on that before this patch is merged.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
