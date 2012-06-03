From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jun 2012 08:55:44 +0100
Subject: ARM PCI controller registration and representation using
 device tree?
In-Reply-To: <201206030241.52775.arnd@arndb.de>
References: <4113992.BTnO0ZYQON@bender>
 <20120602143448.GA1624@n2100.arm.linux.org.uk>
 <201206030241.52775.arnd@arndb.de>
Message-ID: <20120603075544.GA15354@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2012 at 02:41:52AM +0000, Arnd Bergmann wrote:
> On Saturday 02 June 2012, Russell King - ARM Linux wrote:
> > I think we have to keep the existing strategy of having struct hw_pci and
> > its pci_sys_data, registering each bus separately with its own individual
> > swizzle and map_irq functions depending on how the bus hardware is setup.
> 
> Actually, I think we won't need to call pci_fixup_irqs for DT at all, so
> there won't be host specific swizzle and map_irq functions. AFAICT the
> interrupt-map property can handle all possible cases, it certainly does
> so for a large number of obscure buses on powerpc.

That means you have to list every PCI device in DT along with its
interrupt number - which means your boot loader will have to scan the
PCI bus and provide interrupt and BAR settings into the kernel.

And that will suck if you have something like a 4 port PCI network card
which has a PCI-to-PCI bridge on - are boot loaders going to have the
correct swizzling support?  I think not.
