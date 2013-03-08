From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Mar 2013 13:50:15 +0000
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307113917.0b751a75@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306230412.GA5870@obsidianresearch.com> <20130307113917.0b751a75@skate>
Message-ID: <201303081350.15429.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 March 2013, Thomas Petazzoni wrote:
> This doesn't work for PCIe interfaces. The PCIe windows cannot be
> described in the DT, because they are inherently dynamic, and depend on
> which PCIe devices are plugged into the PCIe slots, and how much I/O
> and memory space each of those devices require.
> 
> This means that regardless of what you think, some windows will have
> to be created dynamically during the system initialization, and we will
> not be able to describe all windows in the Device Tree.
> 
> And to me, it seems completely stupid to have some windows defined
> statically in the Device Tree, and some other windows set up
> dynamically when the system initializes.

You could have no "ranges" property in the boot time DT if you are
looking for consistency here.

Ideally, the ranges would contain exactly the setup of the MBUS windows
that was configured with at boot time, and then get updated by the
kernel when the windows are dynamically changed. An skipping the
ranges at boot time would imply that none of the devices underneath
MBUS are currently mapped to physical addresses. Putting some of
the ranges is there is a way to handle two cases though:

* Overriding the boot loader (or hardware) defaults, telling the
  kernel that we really want to set up the windows differently. In
  a perfect world, this would not be necessary, because the boot
  loader should be able to make sure the two always match.
* Windows that we don't want to be set up at boot time yet because
  we know that we want dynamic allocation.

> > At the stanza of MBUS driver's bus. Each line represents a MBUS target
> > (this is a physical HW IP block). The MAPDEF is a SOC specific 'target
> > id' that is currently living in tables in the driver. This value is
> > directly compatible with the mbus window register and is defined by
> > Marvell. The 2nd number is the CPU base address of that window, and
> > the last is the size.
> 
> Please explain how you handle PCIe windows.

Any window that we don't want to hardcode, like the PCIe windows, can
be absent from the "ranges", which in DT syntax means exactly the right
thing: There are bus addresses on the child bus that are wired to one
device but not currently mapped into the parent bus. This is exactly
what we do for instance on a PCI bus ranges property that does not map
its I/O space window into the parent bus as a linear map. This is the
normal case on x86, but also done on a few other platforms.

> > Per OF conventions the base address should be the value the bootloader
> > left it at - but that is not important, the value could be 0. A
> > dynamic MBUS driver would go through each item in the ranges, find
> > an address range and program a window with the MAPDEF from the DT. It
> > would then write the base address back into the DT (at runtime!) so
> > that the entire DT remains conistent with the current state of the
> > hardware.
> 
> Why the heck would the kernel need to rewrite the DT ?
> 
> Just like a driver does an ioremap() to create a virtual -> physical
> mapping, the driver can just as well do mvebu_mbus_add_window() to
> create a physical -> device mapping. It doesn't have to be hardcoded
> into the Device Tree.

The important difference is that the DT describes the physical address
space as seen from the CPU bus interface, but does not care at all about
the virtual addresses that the kernel puts into page tables.

Describing the mapping of addresses from one bus address space to another,
down to the CPU's view is the core of all DT bindings, and we should do
that properly and consistently. If you change the mapping at run-time,
updating the properties is the natural thing to do.

	Arnd
