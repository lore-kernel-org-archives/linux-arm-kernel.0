From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 10:09:37 +0800
Subject: [RFC,PATCH 2/3] arm: use addruart macro to establish debug mappings
In-Reply-To: <1279073377.400469.233833413341.0.gpush@pororo>
Message-ID: <1279073377.401935.180250562939.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we can call addruart with an argument to specify that we want a
physical or virtual address, use addruart in the debug mapping code to
find these addresses.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/kernel/head.S |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..001f286 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -22,6 +22,10 @@
 #include <asm/thread_info.h>
 #include <asm/system.h>
 
+#ifdef CONFIG_DEBUG_LL
+#include <mach/debug-macro.S>
+#endif
+
 #if (PHYS_OFFSET & 0x001fffff)
 #error "PHYS_OFFSET must be at an even 2MiB boundary!"
 #endif
@@ -289,19 +293,24 @@ __create_page_tables:
 	str	r6, [r0]
 
 #ifdef CONFIG_DEBUG_LL
-	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 	/*
 	 * Map in IO space for serial debugging.
 	 * This allows debug messages to be output
 	 * via a serial console before paging_init.
 	 */
-	ldr	r3, [r8, #MACHINFO_PGOFFIO]
+	addruart r7, r3
+	lsr	r3, r3, #20
+	lsl	r3, r3, #2
+
 	add	r0, r4, r3
 	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
 	cmp	r3, #0x0800			@ limit to 512MB
 	movhi	r3, #0x0800
 	add	r6, r0, r3
-	ldr	r3, [r8, #MACHINFO_PHYSIO]
+	mov	r3, #0xff000000
+	orr	r3, r3, #0x00c00000
+	and	r3, r7, r3
+	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 	orr	r3, r3, r7
 1:	str	r3, [r0], #4
 	add	r3, r3, #1 << 20
