From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 12 Jul 2010 11:03:12 +0800
Subject: [RFC,PATCH 2/2] arm: use addruart macro to establish debug mappings
In-Reply-To: <1278903792.387175.713057245098.0.gpush@pororo>
Message-ID: <1278903792.388155.428219242752.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we can call addruart with an argument to specify that we want a
physical or virtual address, use addruart in the debug mapping code to
find these addresses.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/Kconfig.debug |    1 -
 arch/arm/kernel/head.S |   15 ++++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index fbb094a..91344af 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -65,7 +65,6 @@ config DEBUG_STACK_USAGE
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
-	depends on !OF
 	depends on DEBUG_KERNEL
 	help
 	  Say Y here to include definitions of printascii, printch, printhex
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 8bfc4bb..9571996 100644
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
@@ -305,19 +309,24 @@ __create_page_tables:
 	str	r6, [r0]
 
 #ifdef CONFIG_DEBUG_LL
-	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 	/*
 	 * Map in IO space for serial debugging.
 	 * This allows debug messages to be output
 	 * via a serial console before paging_init.
 	 */
-	ldr	r3, [r8, #MACHINFO_PGOFFIO]
+	mov	r3, #1
+	addruart r3, r0
+	lsr	r3, r3, #20
+	lsl	r3, r3, #2
+
 	add	r0, r4, r3
 	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
 	cmp	r3, #0x0800			@ limit to 512MB
 	movhi	r3, #0x0800
 	add	r6, r0, r3
-	ldr	r3, [r8, #MACHINFO_PHYSIO]
+	mov	r3, #0
+	addruart r3, r7
+	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 	orr	r3, r3, r7
 1:	str	r3, [r0], #4
 	add	r3, r3, #1 << 20
