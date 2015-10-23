From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 23 Oct 2015 15:58:23 +0100
Subject: arm64: iomem_resource doesn't contain all the region used
Message-ID: <562A4B0F.2020603@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've been working on trying to get balloon memory hotplug working for
ARM64 guest on Xen.

In order to find a suitable region to hotplug the fake memory, we are
trying to find a free region within iomem_resource.

But on ARM64, only an handful number of regions are listed in it. For
instance on X-Gene we have only:

42sh> cat /proc/iomem

10510000-105103ff : /soc/rtc at 10510000
1a400000-1a400fff : /soc/sata at 1a400000
1a800000-1a800fff : /soc/sata at 1a800000
1f220000-1f220fff : /soc/sata at 1a400000
1f227000-1f227fff : /soc/sata at 1a400000
1f22a000-1f22a0ff : /soc/phy at 1f22a000
1f22d000-1f22dfff : /soc/sata at 1a400000
1f22e000-1f22efff : /soc/sata at 1a400000
1f230000-1f230fff : /soc/sata at 1a800000
1f23a000-1f23a0ff : /soc/phy at 1f23a000
1f23d000-1f23dfff : /soc/sata at 1a800000
1f23e000-1f23efff : /soc/sata at 1a800000
1f2b0000-1f2bffff : csr
79000000-798fffff : /soc/msi at 79000000
4100000000-41ffffffff : System RAM
  4100080000-41008b58a3 : Kernel code
  410093c000-41009e9fff : Kernel data
e0d0000000-e0d003ffff : cfg

This is because most of the ARM drivers are using of_iomap which doesn't
register the region.

Looking to the code, I found a function of_io_request_and_map which
register the resource and does the mapping. I'm wondering if there is
any reason to have introduce a new function rather than doing the job in
of_iomap?

Although, that wouldn't fix all the drivers because some of them are
directly using ioremap. I've got in mind the initialization of GICv2 for
ACPI platform.

Is there any way we could register the IO region used on ARM without
having to enforce it in all the drivers?

Regards,

-- 
Julien Grall
