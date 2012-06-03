From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 3 Jun 2012 05:56:49 +0000
Subject: ARM PCI controller registration and representation using device
 tree?
In-Reply-To: <4113992.BTnO0ZYQON@bender>
References: <4113992.BTnO0ZYQON@bender>
Message-ID: <201206030556.49821.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 June 2012, Florian Fainelli wrote:
> I was wondering if anyone had started working on representing the various PCI 
> controllers found on SoCs to a device tree representation?
> 
> It seems like quite some generic code could be borrowed from PowerPC, 
> especially the parsing of the PCI ranges, though I don't see ARM directly 
> exposing a struct pci_controller to easily allow that.
> 
> Any thoughts about this?

I think the PCI host controller code should be a lot more generic than it
currently is. Each architecture has to provide quite a bit of infrastructure
and the differences are to a large part not related to the CPU architecture.

I'd love to get to the point where we can have host controllers defined
in drivers/pci/host/*.c in a way that is completely architecture independent.
Alpha, ia64, microblaze, mips, powerpc, tile and xtensa all have a structure
named "pci_controller" for doing this, but I think they are all different.
ARM has two structures: pci_sys_data (corresponds to pci_controller) and
hw_pci mostly to provide function pointers that are all the same for each
instance. arch/sh has a pci_channel that does the same thing and parisc
has pci_hba_data.

I don't think it's realistic to aim for completely unifying those structures
and implementations, but we can try to define a new architecture independent
abstraction that covers all the common parts and has a pointer the architecture
specific data, which can hold the more obscure things.

	Arnd
