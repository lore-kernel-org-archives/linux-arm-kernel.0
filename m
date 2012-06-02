From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jun 2012 15:34:48 +0100
Subject: ARM PCI controller registration and representation using
 device tree?
In-Reply-To: <4113992.BTnO0ZYQON@bender>
References: <4113992.BTnO0ZYQON@bender>
Message-ID: <20120602143448.GA1624@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 02, 2012 at 04:18:11PM +0200, Florian Fainelli wrote:
> I was wondering if anyone had started working on representing the various PCI 
> controllers found on SoCs to a device tree representation?
> 
> It seems like quite some generic code could be borrowed from PowerPC, 
> especially the parsing of the PCI ranges, though I don't see ARM directly 
> exposing a struct pci_controller to easily allow that.
> 
> Any thoughts about this?

I think we have to keep the existing strategy of having struct hw_pci and
its pci_sys_data, registering each bus separately with its own individual
swizzle and map_irq functions depending on how the bus hardware is setup.
Also rememer that the PCI configuration space accessor functions are highly
PCI host bridge specific.

I don't think we can (or should) rely upon platforms having code in their
boot loader to probe the PCI bus, and provide the kernel with the PCI bus
structure.

I don't see this as a problem for DT - we just need a way to represent
each PCI bus as some kind of device.  I'm thinking whether we could get
away with converting the existing model to use platform devices, and
then we can use the existing DT platform device code to create the
relevant platform device.

Irrespective of whether your PCI host bridge appears as PCI device 0:0.0
or not, that's probably the right idea anyway.
