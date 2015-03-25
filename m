From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 25 Mar 2015 11:27:47 +0000
Subject: [PATCH RESEND 2/7] ARM: socfpga: enable big endian for secondary
 core(s)
In-Reply-To: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427282872-10563-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the secondary code to allow the secondary boot to work when the
system is running big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/headsmp.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index f65ea0a..a580dcd 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -10,6 +10,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/memory.h>
+#include <asm/assembler.h>
 
 	.arch	armv7-a
 
@@ -18,12 +19,14 @@ ENTRY(secondary_trampoline)
 	 * Thus, we can just subtract the PAGE_OFFSET to get the physical
 	 * address of &cpu1start_addr. This would not work for platforms
 	 * where the physical memory does not start at 0x0.
-	 */
+	*/
+ARM_BE8(setend	be)
 	adr	r0, 1f
 	ldmia	r0, {r1, r2}
 	sub	r2, r2, #PAGE_OFFSET
 	ldr	r3, [r2]
 	ldr	r4, [r3]
+ARM_BE8(rev	r4, r4)
 	bx	r4
 
 	.align
-- 
2.1.4
