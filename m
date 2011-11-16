From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:18 -0500
Subject: [PATCH 0/23] mach/vmalloc.h removal, and ioremap optimization
Message-ID: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series removes all instances of mach/vmalloc.h in order to
have a more unified memory map across all ARM architectures.  To do so,
the static mappings are moved inside the vmalloc area.  And finally this
allows for a generic optimization to ioremap where static mappings are
reused whenever possible, using common code instead of having this
duplicated in a couple places.

This series provides a net reduction of more than 1200 lines of code.

One regression was discovered on shmobile during testing because that
platform asks for 158MB of consistent DMA memory while the documented
maximum is 14MB.  Inspection of the code doesn't tell why this is
required, and listed maintainers did not respond yet, two months
after repeated inquiries.  So a temporary exception to the definition
of VMALLOC_END was added for CONFIG_SHMOBILE and a noisy warning to
get those maintainers' attention.

This patch series was initially submitted for inclusion for v3.1, and
withdrawn due to too many problems found on OMAP.  Those problems are
now fixed in current mainline.  This is therefore rebased on v3.2-rc2.

This series is also available from the following Git repository:

	git://git.linaro.org/people/nico/linux vmalloc

[PATCH 01/23] ARM: mach-dove: remove inclusion of <mach/vmalloc.h>
[PATCH 02/23] ARM: mach-prima2: don't define SIRFSOC_VA in terms of
[PATCH 03/23] ARM: plat-mxc: remove inclusion of <mach/vmalloc.h>
[PATCH 04/23] ARM: mach-at91: remove arch specific special handling
[PATCH 05/23] ARM: mach-davinci: remove arch specific special
[PATCH 06/23] ARM: mach-tegra: remove arch specific special handling
[PATCH 07/23] ARM: plat-omap: remove arch specific special handling
[PATCH 08/23] ARM: mach-bcmring: use proper constant to identify DMA
[PATCH 09/23] ARM: mach-orion5x: remove arch specific special
[PATCH 10/23] ARM: mach-kirkwood: remove arch specific special
[PATCH 11/23] ARM: mach-ixp23xx: remove arch specific special
[PATCH 12/23] ARM: plat-iop: remove arch specific special handling
[PATCH 13/23] ARM: versatile: remove overlapping map_desc entry
[PATCH 14/23] ARM: realview: fix map_desc alignment
[PATCH 15/23] ARM: realview-eb11mp: fix map_desc alignment
[PATCH 16/23] ARM: sort the meminfo array earlier
[PATCH 17/23] ARM: move initialization of the high_memory variable
[PATCH 18/23] mm: add vm_area_add_early()
[PATCH 19/23] ARM: move iotable mappings within the vmalloc region
[PATCH 20/23] ARM: simplify __iounmap() when dealing with section
[PATCH 21/23] ARM: add generic ioremap optimization by reusing
[PATCH 22/23] ARM: big removal of now unused vmalloc.h files
[PATCH 23/23] ARM: move VMALLOC_END down temporarily for shmobile
