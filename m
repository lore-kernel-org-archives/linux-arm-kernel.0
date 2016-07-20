From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 21 Jul 2016 00:51:31 +0200
Subject: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
In-Reply-To: <20160720152340.GA8337@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <3969169.CcnEsvYuly@vostro.rjw.lan> <20160720152340.GA8337@wunner.de>
Message-ID: <1735644.0mfUjJQtul@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 20, 2016 05:23:40 PM Lukas Wunner wrote:
> On Wed, Jul 20, 2016 at 02:52:42PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 20, 2016 08:24:50 AM Lukas Wunner wrote:
> > > On Wed, Jul 20, 2016 at 02:33:18AM +0200, Rafael J. Wysocki wrote:
> > > > On Friday, June 17, 2016 04:07:38 PM Lukas Wunner wrote:
> > > > > On Fri, Jun 17, 2016 at 02:54:56PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > > > > On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
> > > > > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > > > We also have such a functional dependency for Thunderbolt on Macs:
> > > > > > > On resume from system sleep, the PCIe hotplug ports may not resume
> > > > > > > before the thunderbolt driver has reestablished the PCI tunnels.
> > > > > > > Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> > > > > > > in drivers/pci/quirks.c. It would be good if we could represent
> > > > > > > this dependency using something like Rafael's approach instead of
> > > > > > > open coding it, however one detail in Rafael's patches is problematic:
> > > > > > >
> > > > > > > > New links are added by calling device_link_add() which may happen
> > > > > > > > either before the consumer device is probed or when probing it, in
> > > > > > > > which case the caller needs to ensure that the driver of the
> > > > > > > > supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
> > > > > > > > flag should be passed to device_link_add() to reflect that.
> > > > > > >
> > > > > > > The thunderbolt driver cannot call device_link_add() before the
> > > > > > > PCIe hotplug ports are bound to a driver unless we amend portdrv
> > > > > > > to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> > > > > > > if the thunderbolt driver isn't loaded.
> > > > > > >
> > > > > > > It would therefore be beneficial if device_link_add() can be
> > > > > > > called even *after* the consumer is bound.
> > > > > > 
> > > > > > I don't quite follow.
> > > > > > 
> > > > > > Who's the provider and who's the consumer here?
> > > > > 
> > > > > thunderbolt.ko is the supplier.
> > > > 
> > > > But it binds to the children of the ports that are supposed to be its
> > > > consumers?
> > > > 
> > > > Why is that even expected to work?
> > > 
> > > No, the consumers are aunts (or uncles) of the supplier, if you will. :-)
> > > 
> > > The consumers are the hotplug ports (named "Downstream Bridge 1 / 2" in
> > > the drawing below). The supplier is the NHI:
> > > 
> > >       (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
> > >                                          +-- Downstream Bridge 1 --
> > >                                          +-- Downstream Bridge 2 --
> > >                                          ...
> > > 
> > > We're calling pci_power_up() and pci_restore_state() from
> > > pci_pm_resume_noirq(). And that will fail for devices below
> > > the hotplug ports if the PCI tunnels haven't been re-established
> > > yet by the NHI.
> > 
> > So the NHI is a PCIe device, right?
> > 
> > Does the Thunderbolt driver bind to that device?
> 
> The NHI is a PCI device but not a bridge. It has class 0x88000.
> Yes, thunderbolt.ko binds to the NHI.
> 
> And portdrv binds to the upstream bridge and downstream bridges.
> Those have class 0x60400.

OK, so why would there be a problem with creating links from the NHI (producer)
to the ports (consumers) before binding portdrv to them?

Thanks,
Rafael
