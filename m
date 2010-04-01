From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 01 Apr 2010 10:59:44 +0800
Subject: [RFC,PATCH] arm: use param address to establish params mapping
Message-ID: <1270090784.325445.260542527481.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, __create_page_tables assumes that the boot params are within
the first MB of physical memory, and creates a translation from the kernel
direct mapping region based on this assumption.

Rather than guessing, use the atags/params address instead. This also
means we don't have to rely on PHYS_ADDR to create the mapping.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/kernel/head.S |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..cec9a31 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -208,6 +208,7 @@ ENDPROC(__turn_mmu_on)
  * amount which are required to get the kernel running, which
  * generally means mapping in the kernel code.
  *
+ * r2  = atags
  * r8  = machinfo
  * r9  = cpuid
  * r10 = procinfo
@@ -279,14 +280,16 @@ __create_page_tables:
 #endif
 
 	/*
-	 * Then map first 1MB of ram in case it contains our boot params.
+	 * Create mapping for boot params to kernel direct mapped region (we
+	 * expect to access the params though phys_to_virt()). This is only
+	 * required if the params aren't covered by the previously established
+	 * direct mapping (ie, TEXT_OFFSET > 1MB, or XIP).
 	 */
-	add	r0, r4, #PAGE_OFFSET >> 18
-	orr	r6, r7, #(PHYS_OFFSET & 0xff000000)
-	.if	(PHYS_OFFSET & 0x00f00000)
-	orr	r6, r6, #(PHYS_OFFSET & 0x00f00000)
-	.endif
-	str	r6, [r0]
+	lsr	r0, r2, #20			@ section index
+	orr	r3, r7, r0, lsl #20		@ section entry
+	add	r0, r0, #(PAGE_OFFSET >> 20)	@ offset to kernel virt addr
+	str	r3, [r4, r0, lsl #2]
+
 
 #ifdef CONFIG_DEBUG_LL
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
