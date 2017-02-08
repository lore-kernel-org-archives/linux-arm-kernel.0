From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2017 11:10:24 +0000
Subject: [PATCH 0/3] ARM initrd updates
Message-ID: <20170208111024.GV27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three patches to cleanup and update the ARM initrd handling, after problems
identified by William Helsby.

The first patch merely moves the early initrd code into a separate
function, rather than being bundled up inside arm_memblock_init().

The second patch restructures the initrd code to be cleaner, but with
no functional changes.  We get rid of the repetitive phys_initrd_size
checks, as we can now just "return" from the function.

The third patch changes how we check for overlaps and the region that
we reserve.  Since the kernel deals with pages and not bytes for
allocation, the minimum granule for marking addresses reserved and
later freeing them is one page.  We already adjust the initrd addresses
in free_initrd_mem(), but we fail to mark the partially used pages
entirely reserved.  Add this.

 arch/arm/mm/init.c | 57 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 18 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
