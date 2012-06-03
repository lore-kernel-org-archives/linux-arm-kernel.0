From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 3 Jun 2012 02:41:52 +0000
Subject: ARM PCI controller registration and representation using device
 tree?
In-Reply-To: <20120602143448.GA1624@n2100.arm.linux.org.uk>
References: <4113992.BTnO0ZYQON@bender>
 <20120602143448.GA1624@n2100.arm.linux.org.uk>
Message-ID: <201206030241.52775.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 June 2012, Russell King - ARM Linux wrote:
> I think we have to keep the existing strategy of having struct hw_pci and
> its pci_sys_data, registering each bus separately with its own individual
> swizzle and map_irq functions depending on how the bus hardware is setup.

Actually, I think we won't need to call pci_fixup_irqs for DT at all, so
there won't be host specific swizzle and map_irq functions. AFAICT the
interrupt-map property can handle all possible cases, it certainly does
so for a large number of obscure buses on powerpc.

Please have a look at drivers/of/of_pci_irq.c to see if you can spot
anything missing in there. The interrupt-map lets you define a mapping
from a bus-specific interrupt number to a global one, with an address/mask
of the bus/dev/fn ID of the device(s) it applies to. For anything with
default swizzling, we just provide the map for the root dev, while those
devices that require a more complex mapping need to list each IRQ line
that is connected differently. See arch/powerpc/boot/dts/mpc5121ads.dts
for an example with a nonstandard mapping.

> Also rememer that the PCI configuration space accessor functions are highly
> PCI host bridge specific.

Right. We can have a default ones for mmconfig and PIO 0xcfc in drivers/pci,
but I think most will have a separate one on ARM.

	Arnd
