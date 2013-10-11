From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:16 +0100
Subject: [PATCH 10/14] arm64: head: create a new function for setting the
 boot_cpu_mode flag
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-11-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the code for setting the __cpu_boot_mode flag is munged in
with el2_setup. This makes things difficult on a BE bringup as a
memory access has to have occurred before el2_setup which is the place
that we'd like to set the endianess on the current EL.

Create a new function for setting __cpu_boot_mode and have el2_setup
return the mode the CPU. Also define a new constant in virt.h,
BOOT_CPU_MODE_EL1, for readability.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm64/include/asm/virt.h |    3 ++-
 arch/arm64/kernel/head.S      |   34 +++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 26e310c..130e2be 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -18,7 +18,8 @@
 #ifndef __ASM__VIRT_H
 #define __ASM__VIRT_H
 
-#define BOOT_CPU_MODE_EL2	(0x0e12b007)
+#define BOOT_CPU_MODE_EL1	(0xe11)
+#define BOOT_CPU_MODE_EL2	(0xe12)
 
 #ifndef __ASSEMBLY__
 #include <asm/cacheflush.h>
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7090c12..b3fcdf4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -123,8 +123,9 @@
 
 ENTRY(stext)
 	mov	x21, x0				// x21=FDT
+	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
 	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
-	bl	el2_setup			// Drop to EL1
+	bl	set_cpu_boot_mode_flag
 	mrs	x22, midr_el1			// x22=cpuid
 	mov	x0, x22
 	bl	lookup_processor_type
@@ -150,21 +151,20 @@ ENDPROC(stext)
 /*
  * If we're fortunate enough to boot at EL2, ensure that the world is
  * sane before dropping to EL1.
+ *
+ * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
+ * booted in EL1 or EL2 respectively.
  */
 ENTRY(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #PSR_MODE_EL2t
 	ccmp	x0, #PSR_MODE_EL2h, #0x4, ne
-	ldr	x0, =__boot_cpu_mode		// Compute __boot_cpu_mode
-	add	x0, x0, x28
 	b.eq	1f
-	str	wzr, [x0]			// Remember we don't have EL2...
+	mov	w20, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
 	ret
 
 	/* Hyp configuration. */
-1:	ldr	w1, =BOOT_CPU_MODE_EL2
-	str	w1, [x0, #4]			// This CPU has EL2
-	mov	x0, #(1 << 31)			// 64-bit EL1
+1:	mov	x0, #(1 << 31)			// 64-bit EL1
 	msr	hcr_el2, x0
 
 	/* Generic timers. */
@@ -204,10 +204,25 @@ ENTRY(el2_setup)
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, x0
 	msr	elr_el2, lr
+	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	eret
 ENDPROC(el2_setup)
 
 /*
+ * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
+ * in x20. See arch/arm64/include/asm/virt.h for more info.
+ */
+ENTRY(set_cpu_boot_mode_flag)
+	ldr	x1, =__boot_cpu_mode		// Compute __boot_cpu_mode
+	add	x1, x1, x28
+	cmp	w20, #BOOT_CPU_MODE_EL2
+	b.ne	1f
+	add	x1, x1, #4
+1:	str	w20, [x1]			// This CPU has booted in EL1
+	ret
+ENDPROC(set_cpu_boot_mode_flag)
+
+/*
  * We need to find out the CPU boot mode long after boot, so we need to
  * store it in a writable variable.
  *
@@ -235,8 +250,9 @@ ENTRY(__boot_cpu_mode)
 	 * cores are held until we're ready for them to initialise.
 	 */
 ENTRY(secondary_holding_pen)
-	bl	__calc_phys_offset		// x24=phys offset
-	bl	el2_setup			// Drop to EL1
+	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
+	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
 	ldr     x1, =MPIDR_HWID_BITMASK
 	and	x0, x0, x1
-- 
1.7.9.5
