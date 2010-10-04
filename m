From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:25 +0100
Subject: [PATCH 03/10] ARM: hotplug cpu: Keep processor information,
	startup code & __lookup_processor_type
Message-ID: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When hotplug CPU is enabled, we need to keep the list of supported CPUs,
their setup functions, and __lookup_processor_type in place so that we
can find and initialize secondary CPUs.  Move these into the __CPUINIT
section.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head-common.S |   81 +++++++++++++++++++++++------------------
 arch/arm/kernel/vmlinux.lds.S |   24 +++++++++----
 arch/arm/mm/proc-arm1020e.S   |    2 +-
 arch/arm/mm/proc-arm1022.S    |    2 +-
 arch/arm/mm/proc-arm1026.S    |    2 +-
 arch/arm/mm/proc-arm6_7.S     |    2 +-
 arch/arm/mm/proc-arm720.S     |    2 +-
 arch/arm/mm/proc-arm740.S     |    2 +-
 arch/arm/mm/proc-arm7tdmi.S   |    2 +-
 arch/arm/mm/proc-arm920.S     |    2 +-
 arch/arm/mm/proc-arm922.S     |    2 +-
 arch/arm/mm/proc-arm925.S     |    2 +-
 arch/arm/mm/proc-arm926.S     |    2 +-
 arch/arm/mm/proc-arm940.S     |    2 +-
 arch/arm/mm/proc-arm946.S     |    2 +-
 arch/arm/mm/proc-arm9tdmi.S   |    2 +-
 arch/arm/mm/proc-fa526.S      |    2 +-
 arch/arm/mm/proc-feroceon.S   |    2 +-
 arch/arm/mm/proc-mohawk.S     |    2 +-
 arch/arm/mm/proc-sa110.S      |    2 +-
 arch/arm/mm/proc-sa1100.S     |    2 +-
 arch/arm/mm/proc-v6.S         |    6 +++-
 arch/arm/mm/proc-v7.S         |    6 +++-
 arch/arm/mm/proc-xsc3.S       |    2 +-
 arch/arm/mm/proc-xscale.S     |    2 +-
 25 files changed, 93 insertions(+), 66 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index b9505aa..6ad24d2 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -145,45 +145,14 @@ ENDPROC(__error)
 
 
 /*
- * Read processor ID register (CP#15, CR0), and look up in the linker-built
- * supported processor list.  Note that we can't use the absolute addresses
- * for the __proc_info lists since we aren't running with the MMU on
- * (and therefore, we are not in the correct address space).  We have to
- * calculate the offset.
- *
- *	r9 = cpuid
- * Returns:
- *	r3, r4, r6 corrupted
- *	r5 = proc_info pointer in physical address space
- *	r9 = cpuid (preserved)
- */
-__lookup_processor_type:
-	adr	r3, 3f
-	ldmia	r3, {r5 - r7}
-	add	r3, r3, #8
-	sub	r3, r3, r7			@ get offset between virt&phys
-	add	r5, r5, r3			@ convert virt addresses to
-	add	r6, r6, r3			@ physical address space
-1:	ldmia	r5, {r3, r4}			@ value, mask
-	and	r4, r4, r9			@ mask wanted bits
-	teq	r3, r4
-	beq	2f
-	add	r5, r5, #PROC_INFO_SZ		@ sizeof(proc_info_list)
-	cmp	r5, r6
-	blo	1b
-	mov	r5, #0				@ unknown processor
-2:	mov	pc, lr
-ENDPROC(__lookup_processor_type)
-
-/*
- * This provides a C-API version of the above function.
+ * This provides a C-API version of __lookup_processor_type
  */
 ENTRY(lookup_processor_type)
-	stmfd	sp!, {r4 - r7, r9, lr}
+	stmfd	sp!, {r4 - r6, r9, lr}
 	mov	r9, r0
 	bl	__lookup_processor_type
 	mov	r0, r5
-	ldmfd	sp!, {r4 - r7, r9, pc}
+	ldmfd	sp!, {r4 - r6, r9, pc}
 ENDPROC(lookup_processor_type)
 
 /*
@@ -191,8 +160,6 @@ ENDPROC(lookup_processor_type)
  * more information about the __proc_info and __arch_info structures.
  */
 	.align	2
-3:	.long	__proc_info_begin
-	.long	__proc_info_end
 4:	.long	.
 	.long	__arch_info_begin
 	.long	__arch_info_end
@@ -265,3 +232,45 @@ __vet_atags:
 1:	mov	r2, #0
 	mov	pc, lr
 ENDPROC(__vet_atags)
+
+/*
+ * Read processor ID register (CP#15, CR0), and look up in the linker-built
+ * supported processor list.  Note that we can't use the absolute addresses
+ * for the __proc_info lists since we aren't running with the MMU on
+ * (and therefore, we are not in the correct address space).  We have to
+ * calculate the offset.
+ *
+ *	r9 = cpuid
+ * Returns:
+ *	r3, r4, r6 corrupted
+ *	r5 = proc_info pointer in physical address space
+ *	r9 = cpuid (preserved)
+ */
+	__CPUINIT
+__lookup_processor_type:
+	adr	r3, __lookup_processor_type_data
+	ldmia	r3, {r4 - r6}
+	sub	r3, r3, r4			@ get offset between virt&phys
+	add	r5, r5, r3			@ convert virt addresses to
+	add	r6, r6, r3			@ physical address space
+1:	ldmia	r5, {r3, r4}			@ value, mask
+	and	r4, r4, r9			@ mask wanted bits
+	teq	r3, r4
+	beq	2f
+	add	r5, r5, #PROC_INFO_SZ		@ sizeof(proc_info_list)
+	cmp	r5, r6
+	blo	1b
+	mov	r5, #0				@ unknown processor
+2:	mov	pc, lr
+ENDPROC(__lookup_processor_type)
+
+/*
+ * Look in <asm/procinfo.h> for information about the __proc_info structure.
+ */
+	.align	2
+	.type	__lookup_processor_type_data, %object
+__lookup_processor_type_data:
+	.long	.
+	.long	__proc_info_begin
+	.long	__proc_info_end
+	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b16c079..1630524 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -8,6 +8,19 @@
 #include <asm/memory.h>
 #include <asm/page.h>
 	
+#define PROC_INFO							\
+	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
+	*(.proc.info.init)						\
+	VMLINUX_SYMBOL(__proc_info_end) = .;
+
+#ifdef CONFIG_HOTPLUG_CPU
+#define ARM_CPU_DISCARD(x)
+#define ARM_CPU_KEEP(x)		x
+#else
+#define ARM_CPU_DISCARD(x)	x
+#define ARM_CPU_KEEP(x)
+#endif
+
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
@@ -31,9 +44,7 @@ SECTIONS
 			HEAD_TEXT
 			INIT_TEXT
 		_einittext = .;
-		__proc_info_begin = .;
-			*(.proc.info.init)
-		__proc_info_end = .;
+		ARM_CPU_DISCARD(PROC_INFO)
 		__arch_info_begin = .;
 			*(.arch.info.init)
 		__arch_info_end = .;
@@ -68,10 +79,8 @@ SECTIONS
 	/DISCARD/ : {
 		*(.ARM.exidx.exit.text)
 		*(.ARM.extab.exit.text)
-#ifndef CONFIG_HOTPLUG_CPU
-		*(.ARM.exidx.cpuexit.text)
-		*(.ARM.extab.cpuexit.text)
-#endif
+		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
+		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
 #ifndef CONFIG_HOTPLUG
 		*(.ARM.exidx.devexit.text)
 		*(.ARM.extab.devexit.text)
@@ -100,6 +109,7 @@ SECTIONS
 			*(.glue_7)
 			*(.glue_7t)
 		*(.got)			/* Global offset table		*/
+			ARM_CPU_KEEP(PROC_INFO)
 	}
 
 	RO_DATA(PAGE_SIZE)
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index 1a511e7..afc06b9 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -412,7 +412,7 @@ ENTRY(cpu_arm1020e_set_pte_ext)
 #endif /* CONFIG_MMU */
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm1020e_setup, #function
 __arm1020e_setup:
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index 1ffa4eb..8915e0b 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -394,7 +394,7 @@ ENTRY(cpu_arm1022_set_pte_ext)
 #endif /* CONFIG_MMU */
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm1022_setup, #function
 __arm1022_setup:
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 5697c34..ff446c5 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -384,7 +384,7 @@ ENTRY(cpu_arm1026_set_pte_ext)
 	mov	pc, lr
 
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm1026_setup, #function
 __arm1026_setup:
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index 64e0b32..6a7be18 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -238,7 +238,7 @@ ENTRY(cpu_arm7_reset)
 		mcr	p15, 0, r1, c1, c0, 0		@ turn off MMU etc
 		mov	pc, r0
 
-		__INIT
+		__CPUINIT
 
 		.type	__arm6_setup, #function
 __arm6_setup:	mov	r0, #0
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 9d96824..c285395 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -113,7 +113,7 @@ ENTRY(cpu_arm720_reset)
 		mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 		mov	pc, r0
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm710_setup, #function
 __arm710_setup:
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 6c1a9ab..38b27dc 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -55,7 +55,7 @@ ENTRY(cpu_arm740_reset)
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm740_setup, #function
 __arm740_setup:
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 6a850db..0c9786d 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -46,7 +46,7 @@ ENTRY(cpu_arm7tdmi_proc_fin)
 ENTRY(cpu_arm7tdmi_reset)
 		mov	pc, r0
 
-		__INIT
+		__CPUINIT
 
 		.type	__arm7tdmi_setup, #function
 __arm7tdmi_setup:
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 86f80aa..fecf570 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -375,7 +375,7 @@ ENTRY(cpu_arm920_set_pte_ext)
 #endif
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm920_setup, #function
 __arm920_setup:
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index f76ce9b..e3cbf87 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -379,7 +379,7 @@ ENTRY(cpu_arm922_set_pte_ext)
 #endif /* CONFIG_MMU */
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm922_setup, #function
 __arm922_setup:
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 657bd3f..572424c 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -428,7 +428,7 @@ ENTRY(cpu_arm925_set_pte_ext)
 #endif /* CONFIG_MMU */
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm925_setup, #function
 __arm925_setup:
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 73f1f3c..63d168b 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -389,7 +389,7 @@ ENTRY(cpu_arm926_set_pte_ext)
 #endif
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm926_setup, #function
 __arm926_setup:
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index fffb061..f6a6282 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -264,7 +264,7 @@ ENTRY(arm940_cache_fns)
 	.long	arm940_dma_unmap_area
 	.long	arm940_dma_flush_range
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm940_setup, #function
 __arm940_setup:
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 249a605..ea2e7f2 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -317,7 +317,7 @@ ENTRY(cpu_arm946_dcache_clean_area)
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__arm946_setup, #function
 __arm946_setup:
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index db47566..db67e31 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -46,7 +46,7 @@ ENTRY(cpu_arm9tdmi_proc_fin)
 ENTRY(cpu_arm9tdmi_reset)
 		mov	pc, r0
 
-		__INIT
+		__CPUINIT
 
 		.type	__arm9tdmi_setup, #function
 __arm9tdmi_setup:
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index 7803fdf..7c9ad62 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -134,7 +134,7 @@ ENTRY(cpu_fa526_set_pte_ext)
 #endif
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__fa526_setup, #function
 __fa526_setup:
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index b304d01..578da69 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -494,7 +494,7 @@ ENTRY(cpu_feroceon_set_pte_ext)
 #endif
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__feroceon_setup, #function
 __feroceon_setup:
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 5f6892f..4458ee6 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -338,7 +338,7 @@ ENTRY(cpu_mohawk_set_pte_ext)
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__mohawk_setup, #function
 __mohawk_setup:
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index a201eb0..5aa8d59 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -156,7 +156,7 @@ ENTRY(cpu_sa110_set_pte_ext)
 #endif
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__sa110_setup, #function
 __sa110_setup:
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 7ddc480..2ac4e6f 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -169,7 +169,7 @@ ENTRY(cpu_sa1100_set_pte_ext)
 #endif
 	mov	pc, lr
 
-	__INIT
+	__CPUINIT
 
 	.type	__sa1100_setup, #function
 __sa1100_setup:
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 22aac85..037d1a4 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -137,7 +137,7 @@ cpu_pj4_name:
 
 	.align
 
-	__INIT
+	__CPUINIT
 
 /*
  *	__v6_setup
@@ -192,6 +192,8 @@ __v6_setup:
 v6_crval:
 	crval	clear=0x01e0fb7f, mmuset=0x00c0387d, ucset=0x00c0187c
 
+	__INITDATA
+
 	.type	v6_processor_functions, #object
 ENTRY(v6_processor_functions)
 	.word	v6_early_abort
@@ -205,6 +207,8 @@ ENTRY(v6_processor_functions)
 	.word	cpu_v6_set_pte_ext
 	.size	v6_processor_functions, . - v6_processor_functions
 
+	.section ".rodata"
+
 	.type	cpu_arch_name, #object
 cpu_arch_name:
 	.asciz	"armv6"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6a8506d..cd15adb 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -169,7 +169,7 @@ cpu_v7_name:
 	.ascii	"ARMv7 Processor"
 	.align
 
-	__INIT
+	__CPUINIT
 
 /*
  *	__v7_setup
@@ -297,6 +297,8 @@ v7_crval:
 __v7_setup_stack:
 	.space	4 * 11				@ 11 registers
 
+	__INITDATA
+
 	.type	v7_processor_functions, #object
 ENTRY(v7_processor_functions)
 	.word	v7_early_abort
@@ -310,6 +312,8 @@ ENTRY(v7_processor_functions)
 	.word	cpu_v7_set_pte_ext
 	.size	v7_processor_functions, . - v7_processor_functions
 
+	.section ".rodata"
+
 	.type	cpu_arch_name, #object
 cpu_arch_name:
 	.asciz	"armv7"
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 361a51e..cad07e4 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -404,7 +404,7 @@ ENTRY(cpu_xsc3_set_pte_ext)
 
 	.align
 
-	__INIT
+	__CPUINIT
 
 	.type	__xsc3_setup, #function
 __xsc3_setup:
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 1407597..cb245ed 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -506,7 +506,7 @@ ENTRY(cpu_xscale_set_pte_ext)
 
 	.align
 
-	__INIT
+	__CPUINIT
 
 	.type	__xscale_setup, #function
 __xscale_setup:
-- 
1.6.2.5
