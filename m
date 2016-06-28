From: james.morse@arm.com (James Morse)
Date: Tue, 28 Jun 2016 15:51:45 +0100
Subject: [PATCH v3 2/7] arm64: vmlinux.ld: Add .mmuoff.{text,data} sections
In-Reply-To: <1467125510-18758-1-git-send-email-james.morse@arm.com>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
Message-ID: <1467125510-18758-3-git-send-email-james.morse@arm.com>
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
Changes since v2:
 * mmuoff.data section added
 * secondary_holding_pen_release initialisation moved to head.S
 * secondary_holding_pen and set_cpu_boot_mode_flag moved into mmuoff.text

 arch/arm64/include/asm/sections.h  |  2 ++
 arch/arm64/kernel/head.S           | 10 +++++++++-
 arch/arm64/kernel/sleep.S          |  2 ++
 arch/arm64/kernel/smp_spin_table.c |  2 +-
 arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
 arch/arm64/mm/proc.S               |  4 ++++
 6 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index cb68eb348566..7eecfa110330 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -24,5 +24,7 @@ extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
+extern char __mmuoff_text_start[], __mmuoff_text_end[];
+extern char __mmuoff_data_start[], __mmuoff_data_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c6e598a94dc..6e56cd136d27 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -52,6 +52,9 @@
 #error TEXT_OFFSET must be less than 2MB
 #endif
 
+/* INVALID_HWID is defined as ULONG_MAX, but we can't include linux/kernel.h */
+#define ULONG_MAX ~0
+
 /*
  * Kernel startup entry point.
  * ---------------------------
@@ -477,6 +480,7 @@ ENTRY(kimage_vaddr)
  * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
  * booted in EL1 or EL2 respectively.
  */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
@@ -627,11 +631,14 @@ ENDPROC(set_cpu_boot_mode_flag)
  * This is not in .bss, because we set it sufficiently early that the boot-time
  * zeroing of .bss would clobber it.
  */
-	.pushsection	.data..cacheline_aligned
+	.pushsection ".mmuoff.data", "aw"
 	.align	L1_CACHE_SHIFT
 ENTRY(__boot_cpu_mode)
 	.long	BOOT_CPU_MODE_EL2
 	.long	BOOT_CPU_MODE_EL1
+
+ENTRY(secondary_holding_pen_release)
+	.quad INVALID_HWID
 	.popsection
 
 	/*
@@ -687,6 +694,7 @@ __secondary_switched:
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
+	.popsection
 
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
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
index 18a71bcd26ee..04b465c72538 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -29,7 +29,7 @@
 #include <asm/smp_plat.h>
 
 extern void secondary_holding_pen(void);
-volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
+extern volatile unsigned long secondary_holding_pen_release;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0de7be4f1a9d..7db9c94213a9 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -118,6 +118,9 @@ SECTIONS
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			SOFTIRQENTRY_TEXT
+			__mmuoff_text_start = .;
+			*(.mmuoff.text)
+			__mmuoff_text_end = .;
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
@@ -193,6 +196,11 @@ SECTIONS
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
index c4317879b938..655ff3ec90f2 100644
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
@@ -255,3 +258,4 @@ ENDPROC(__cpu_setup)
 crval:
 	.word	0xfcffffff			// clear
 	.word	0x34d5d91d			// set
+	.popsection
-- 
2.8.0.rc3
