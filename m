From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 01 Sep 2010 09:07:50 +0800
Subject: [PATCH 3/3] arm: use addruart macro to establish debug mappings
In-Reply-To: <1283303270.565454.673065645961.0.gpush@pororo>
Message-ID: <1283303270.567057.949026731811.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we can get both physical and virtual addresses from the addruart
macro, we can use this to establish the debug mappings.

In the case of CONFIG_DEBUG_ICEDCC, we don't need any mappings, but
may still need to setup r7 correctly.

Incorporating ASM changes from Nicolas Pitre <npitre@fluxnic.net>.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

---
 arch/arm/kernel/head.S |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..1def822 100644
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
@@ -289,24 +293,35 @@ __create_page_tables:
 	str	r6, [r0]
 
 #ifdef CONFIG_DEBUG_LL
-	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
+#ifndef CONFIG_DEBUG_ICEDCC
 	/*
 	 * Map in IO space for serial debugging.
 	 * This allows debug messages to be output
 	 * via a serial console before paging_init.
 	 */
-	ldr	r3, [r8, #MACHINFO_PGOFFIO]
+	addruart r7, r3
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
 	bne	1b
+
+#else /* CONFIG_DEBUG_ICEDCC */
+	/* we don't need any serial debugging mappings for ICEDCC */
+	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
+#endif /* !CONFIG_DEBUG_ICEDCC */
+
 #if defined(CONFIG_ARCH_NETWINDER) || defined(CONFIG_ARCH_CATS)
 	/*
 	 * If we're using the NetWinder or CATS, we also need to map
