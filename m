From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 29 Oct 2013 11:13:34 +0530
Subject: [PATCH V2] ARM: head: Fix the missing underscore in __ARMEB__ macro
 and .align keyword
Message-ID: <1383025414-5574-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 'f52bb722547f43caeaecbcc62db9f3c3b80ead9b'
Author: Sricharan R <r.sricharan@ti.com>
    ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses

introduced a __ARMEB__ macro usage in a new place, but missed the second
underscore. So correcting it here.

Also a explicit .align keyword is needed for the label with .long
data-type to be aligned on the 4 byte boundary. Otherwise this can
cause problem for thumb2 build. So adding it here.

Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/kernel/head.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 0f6c6d1..179c15f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -555,7 +555,7 @@ ENTRY(fixup_smp)
 	ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(fixup_smp)
 
-#ifdef __ARMEB_
+#ifdef __ARMEB__
 #define LOW_OFFSET	0x4
 #define HIGH_OFFSET	0x0
 #else
@@ -651,6 +651,7 @@ __fixup_a_pv_table:
 #endif
 ENDPROC(__fixup_a_pv_table)
 
+	.align
 3:	.long __pv_offset
 
 ENTRY(fixup_pv_table)
-- 
1.7.9.5
