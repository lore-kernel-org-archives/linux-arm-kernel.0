From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 24 Sep 2018 12:26:14 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <20180924101213.GO30658@n2100.armlinux.org.uk>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
Message-ID: <20180924122614.70738b5c@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 24 Sep 2018 11:12:13 +0100, Russell King - ARM Linux wrote:

> > Thanks for the testing. I'll wait for Russell to say if he is happy
> > (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> > the case, I'll send a proper patch to fix the issue.  
> 
> I'd prefer not to provide an unmapping API, because it gives the
> impression that it's okay to unmap the IO space mapping, and we'll
> end up with drivers that decide to call it in their cleanup path.
> IO space isn't expected to ever go away - eg, on a PC, it's always
> present.

But being able to unmap it would also be needed to be able to remove
PCI host controller drivers, and therefore compile them as module, and
make them more like any other drivers.

I'm not sure why we need to guarantee that the I/O space is always
mapped:

 - It isn't mapped before the PCI controller driver does the mapping.

 - There is no reason for it to be accessed when the PCI controller
   driver is not initialized: PCI devices can only be probed and
   initialized when the PCI controller driver is probed/initialized.

Also, in general, pci_ioremap_io() is ARM specific, and is now only
used by very few drivers:

 - Dove (Marvell platform)
 - IOP13xx
 - MV78xx0 (Marvell platform, should be moved to use pci-mvebu)
 - Orion5x (Marvell platform, should be moved to use pci-mvebu)
 - pci-mvebu
 - at91_cf

All other drivers, including on ARM, use pci_remap_iospace(), which
does provide the pci_unmap_iospace() counter part.

The only reason I have not changed pci-mvebu to use
pci_{remap,unmap}_iospace() is because it doesn't allow to change the
memory attributes.

But to me, the general direction is that the ARM-specific
pci_remap_io() API is fading away, and its replacement already provides
an unmapping capability. So why not add the same unmapping capability
to pci_remap_io() ?

> I've been toying with the idea of making pci_map_io() ignore
> subsequent attempts to overwrite the mapping with an identical
> mapping, and WARN() if there is an attempt to overwrite an existing
> mapping with other physical address, but I'm not entirely happy
> with that either (which is why I haven't responded sooner.)
> 
> At the moment, I don't have a way forward that I'm happy with for
> this.

But we have a regression and we need to fix it. Do you suggest to not
use the new pci_host_probe() API ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
