From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 5 Jun 2014 15:22:52 -0400
Subject: keystone breakage
In-Reply-To: <20140605183223.GF23430@n2100.arm.linux.org.uk>
References: <20140605183223.GF23430@n2100.arm.linux.org.uk>
Message-ID: <5390C38C.9050606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 02:32 PM, Russell King - ARM Linux wrote:
> It's worth pointing out that with Laura's removal of meminfo, keystone
> is now broken - I see that despite Laura's patches being on LAKML for
> a while, this fact has been ignored, and now that Keystone support
> for the LPAE mappings has been merged, Keystone now breaks:
>
> arch/arm/mach-keystone/keystone.c: In function 'keystone_init_meminfo':
> arch/arm/mach-keystone/keystone.c:71:31: error: 'meminfo' undeclared (first use in this function)
>
> I guess this is something that will have to be fixed later.
> 
I have tried Laura's series(v3 or v4 mostly) in past while
reviewing it. But since I wasn't sure about when it is going
to get merged, the meminfo usage remained in my code. I
should have removed the usage of meminfo irrespectively.

Thanks for reporting the issue. So far neither Laura's series nor my
series is showing up in Linus's tip so I couldn't see the
breakage myself but patch at the end of the email should fix
the breakage.

Arnd, Olof,
Will you be able to pick up the below fix from this email ?
If you prefer, I can send the same after rc1 is tagged.


>From 661e238f98171082a7b080720b837283551ff80d Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 5 Jun 2014 14:51:33 -0400
Subject: [PATCH] ARM: keystone: Drop use of meminfo since its not available
 anymore

Laura's series removed the meminfo structure and its no longer available.
Update keystone code to remove the usage of it.

Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/keystone.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 59b8383..4388267 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
+#include <linux/memblock.h>
 
 #include <asm/setup.h>
 #include <asm/mach/map.h>
@@ -83,9 +84,8 @@ static void __init keystone_init_meminfo(void)
 	phys_addr_t offset = PHYS_OFFSET - KEYSTONE_LOW_PHYS_START;
 	phys_addr_t mem_start, mem_end;
 
-	BUG_ON(meminfo.nr_banks < 1);
-	mem_start = meminfo.bank[0].start;
-	mem_end = mem_start + meminfo.bank[0].size - 1;
+	mem_start = memblock_start_of_DRAM();
+	mem_end = memblock_end_of_DRAM();
 
 	/* nothing to do if we are running out of the <32-bit space */
 	if (mem_start >= KEYSTONE_LOW_PHYS_START &&
-- 
1.7.9.5
