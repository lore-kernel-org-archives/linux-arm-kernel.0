From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 16:47:43 +0200
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <20141008101942.GA7179@e102568-lin.cambridge.arm.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <3978481.XNAIA6gzAG@wuerfel>
 <20141008101942.GA7179@e102568-lin.cambridge.arm.com>
Message-ID: <2323270.n17xqW47JB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 October 2014 11:19:43 Lorenzo Pieralisi wrote:
> 
> Ok. So, unless I am missing something, on platform with mem_offset != 0
> /proc and /sys interfaces for remapping PCI resources can't work (IIUC
> the proc interface expects the user to pass in the resource address as
> seen from /proc/bus/pci/devices - which are not BAR values. Even if the
> user passed the BAR value to mmap, pci_mmap_fits() in proc_bus_pci_mmap()
> would fail since it compares the pgoff to resource values, which are not
> BAR values).

I think you are right for the sysfs interface, that one can't possibly
work because of the incorrect address computation.

For the /procfs interface, I think it can work as long as the offsets
used there are coming from the config space dump in /proc/bus/pci/*
rather than from the /sys/bus/pci/devices/*/resource file.
 
> As things stand I think we can safely remove the mem_offset (and
> pci_sys_data dependency) from pci_mmap_page_range(). I do not think
> we can break userspace in any way, basically because it can't work at
> the moment, again, happy to be corrected if I am wrong, please shout.

Please look at the procfs interface again. That one can be defined
in two ways (either like sparc and arm, or like powerpc and microblaze)
but either one should be able to work with user space that expects
that interface and break with user space that expects the other one.

> Or we can add mem_offset to the host bridge (after all architectures like
> PowerPC and Microblaze have a pci_mem_offset variable in their host
> controllers), but still, this removes pci_sys_data dependency but does
> not solve the pci_mmap_page_range() issue.

The host bridge already stores the mem_offset in terms of the resource
list, so we could readily use that, except that it might break the
powerpc hack if that is still in use.

	Arnd
