From: james.morse@arm.com (James Morse)
Date: Mon, 15 Aug 2016 18:12:01 +0100
Subject: [PATCH v4 2/3] arm64: vmlinux.ld: Add .mmuoff.{text,data} sections
In-Reply-To: <1471281122-26295-1-git-send-email-james.morse@arm.com>
References: <1471281122-26295-1-git-send-email-james.morse@arm.com>
Message-ID: <1471281122-26295-3-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resume from hibernate needs to clean any text executed by the kernel with
the MMU off to the PoC. Collect these functions together into a new
.mmuoff.text section. __boot_cpu_mode and secondary_holding_pen_release
are data that is read or written with the MMU off. Add these to a new
.mmuoff.data section.

This covers booting of secondary cores and the cpu_suspend() path used
by cpu-idle and suspend-to-ram.

The bulk of head.S is not included, as the primary boot code is only ever
executed once, the kernel never needs to ensure it is cleaned to a
particular point in the cache.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Pad mmuoff.data section to CWG.
 * Specified the .mmuoff.data section for secondary_holding_pen_release in C

 arch/arm64/include/asm/sections.h  |  2 ++
 arch/arm64/kernel/head.S           | 26 ++++++++++++++++++--------
 arch/arm64/kernel/sleep.S          |  2 ++
 arch/arm64/kernel/smp_spin_table.c |  3 ++-
 arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
 arch/arm64/mm/proc.S               |  4 ++++
 6 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 237fcdd13445..fb824a71fbb2 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -25,5 +25,7 @@ extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
+extern char __mmuoff_data_start[], __mmuoff_data_end[];
+extern char __mmuoff_text_start[], __mmuoff_text_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b77f58355da1..4230eeeeabf5 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -477,6 +477,7 @@ ENTRY(kimage_vaddr)
  * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
  * booted in EL1 or EL2 respectively.
  */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
@@ -621,17 +622,31 @@ set_cpu_boot_mode_flag:
 ENDPROC(set_cpu_boot_mode_flag)
 
 /*
+ * Values in this section are written with the MMU off, but read with the
+ * MMU on. Writers will invalidate the corresponding address, discarding
+ * a 'Cache Writeback Granule' (CWG) worth of data. Align these variables
+ * to the architectural maximum of 2K.
+ */
+	.pushsection ".mmuoff.data", "aw"
+	.align 11
+/*
  * We need to find out the CPU boot mode long after boot, so we need to
  * store it in a writable variable.
  *
  * This is not in .bss, because we set it sufficiently early that the boot-time
  * zeroing of .bss would clobber it.
  */
-	.pushsection	.data..cacheline_aligned
-	.align	L1_CACHE_SHIFT
 ENTRY(__boot_cpu_mode)
 	.long	BOOT_CPU_MODE_EL2
 	.long	BOOT_CPU_MODE_EL1
+/*
+ * The booting CPU updates the failed status @__early_cpu_boot_status,
+ * with MMU turned off.
+ */
+ENTRY(__early_cpu_boot_status)
+	.long 	0
+
+	.align 11
 	.popsection
 
 	/*
@@ -687,6 +702,7 @@ __secondary_switched:
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
+	.popsection
 
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
@@ -706,12 +722,6 @@ ENDPROC(__secondary_switched)
 	dc	ivac, \tmp1			// Invalidate potentially stale cache line
 	.endm
 
-	.pushsection	.data..cacheline_aligned
-	.align	L1_CACHE_SHIFT
-ENTRY(__early_cpu_boot_status)
-	.long 	0
-	.popsection
-
 /*
  * Enable the MMU.
  *
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 9a3aec97ac09..e66ce9b7bbde 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -97,6 +97,7 @@ ENTRY(__cpu_suspend_enter)
 ENDPROC(__cpu_suspend_enter)
 	.ltorg
 
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	/* enable the MMU early - so we can access sleep_save_stash by va */
@@ -106,6 +107,7 @@ ENTRY(cpu_resume)
 	adrp	x26, swapper_pg_dir
 	b	__cpu_setup
 ENDPROC(cpu_resume)
+	.popsection
 
 ENTRY(_cpu_resume)
 	mrs	x1, mpidr_el1
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 18a71bcd26ee..9db2471e1eed 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -29,7 +29,8 @@
 #include <asm/smp_plat.h>
 
 extern void secondary_holding_pen(void);
-volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
+volatile unsigned long __section(".mmuoff.data")
+secondary_holding_pen_release = INVALID_HWID;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 659963d40bb4..bbab3d886516 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -120,6 +120,9 @@ SECTIONS
 			IRQENTRY_TEXT
 			SOFTIRQENTRY_TEXT
 			ENTRY_TEXT
+			__mmuoff_text_start = .;
+			*(.mmuoff.text)
+			__mmuoff_text_end = .;
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
@@ -186,6 +189,11 @@ SECTIONS
 	_sdata = .;
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	PECOFF_EDATA_PADDING
+	.mmuoff.data : {
+		__mmuoff_data_start = .;
+		*(.mmuoff.data)
+		__mmuoff_data_end = .;
+	}
 	_edata = .;
 
 	BSS_SECTION(0, 0, 0)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5bb61de23201..a709e95d68ff 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -83,6 +83,7 @@ ENDPROC(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -111,6 +112,7 @@ ENTRY(cpu_do_resume)
 	isb
 	ret
 ENDPROC(cpu_do_resume)
+	.popsection
 #endif
 
 /*
@@ -172,6 +174,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
  *	Initialise the processor for turning the MMU on.  Return in x0 the
  *	value of the SCTLR_EL1 register.
  */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
@@ -257,3 +260,4 @@ ENDPROC(__cpu_setup)
 crval:
 	.word	0xfcffffff			// clear
 	.word	0x34d5d91d			// set
+	.popsection
-- 
2.8.0.rc3
