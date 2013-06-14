From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 14:38:49 +0200
Subject: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <20130614105310.GA19060@manwe>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <000001ce68d7$ca762200$5f626600$@samsung.com> <20130614105310.GA19060@manwe>
Message-ID: <3309315.fJN6KWK0oA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 June 2013 12:53:11 Thierry Reding wrote:
> 
> I think the biggest missing piece is pci_common_exit(), the counterpart
> of pci_common_init(), to cleanup a host bridge on ARM. I haven't looked
> in detail at the other architectures, but I suspect there must be some
> code to call when a host bridge is removed.
> 
> Looking at drivers/pci/remove.c, it seems like pci_remove_root_bus()
> might be what we're looking at. It isn't exported so it can't be used by
> modules, but that can be changed. Is that how a host bridge is typically
> removed from the system?

It's fairly new to have host bridges in loadable modules, so I'm pretty
sure it's not supported by the core yet, but it also doesn't seem hard
to do. I think you are right with regard to pci_remove_root_bus,
and Bjorn might be able to provide more information.

Ideally we should be able to load and unload the pci host driver
in a loop indefinitely without crashing or exposing any races
or leaks, but I would not bet on that working without bugs in the
core, since that goes beyond the normal pci (device) hotplug case.

	Arnd
