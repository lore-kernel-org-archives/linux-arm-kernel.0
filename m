From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 21 Jul 2010 11:03:00 +0200
Subject: [PATCH v2] arm: use addruart macro to establish debug mappings
Message-ID: <1279702980.221230.84864205444.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we can call addruart with an argument to specify that we want a
physical or virtual address, use addruart in the debug mapping code to
find these addresses.

In the case of CONFIG_DEBUG_ICEDCC, addruart returns 0x0 as the physical
address. In this case, we skip the mapping setup.

Incorporating ASM changes from Nicolas Pitre <npitre@fluxnic.net>.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
v2: add ICEDCC support

---
 arch/arm/kernel/debug.S |    1 +
 arch/arm/kernel/head.S  |   20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 99c209d..19e3004 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -23,6 +23,7 @@
 		@@ debug using ARM EmbeddedICE DCC channel
 
 		.macro	addruart, rp, rv
+		mov	\rp, #0
 		.endm
 
 #if defined(CONFIG_CPU_V6)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..b3b2d64 100644
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
@@ -289,20 +293,28 @@ __create_page_tables:
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
+
+	/* if phys == 0, we don't need to setup debug mappings */
+	tst	r7, #0
+	moveq	pc, lr
+
+	mov	r3, r3, lsr #20
+	mov	r3, r3, lsl #2
+
 	add	r0, r4, r3
 	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
 	cmp	r3, #0x0800			@ limit to 512MB
 	movhi	r3, #0x0800
 	add	r6, r0, r3
-	ldr	r3, [r8, #MACHINFO_PHYSIO]
-	orr	r3, r3, r7
+	mov	r3, r7, lsr #20
+	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
+	orr	r3, r7, r3, lsl #20
 1:	str	r3, [r0], #4
 	add	r3, r3, #1 << 20
 	teq	r0, r6
