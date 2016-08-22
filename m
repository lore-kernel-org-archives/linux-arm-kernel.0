From: james.morse@arm.com (James Morse)
Date: Mon, 22 Aug 2016 18:35:18 +0100
Subject: [PATCH v5 2/3] arm64: vmlinux.ld: Add mmuoff text and data sections
In-Reply-To: <1471887319-26702-1-git-send-email-james.morse@arm.com>
References: <1471887319-26702-1-git-send-email-james.morse@arm.com>
Message-ID: <1471887319-26702-3-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resume from hibernate needs to clean any text executed by the kernel with
the MMU off to the PoC. Collect these functions together into a new
.mmuoff.text section.

Data is more complicated, secondary_holding_pen_release is written with
the MMU on, clean and invalidated, then read with the MMU off. In contrast
__boot_cpu_mode is written with the MMU off, the corresponding cache line
is invalidated, so when we read it with the MMU on we don't get stale data.
These cache maintenance operations conflict with each other if the values
are within a Cache Writeback Granule (CWG) of each other.
Collect the data into two sections .mmuoff.data.read and .mmuoff.data.write,
the linker script ensures mmuoff.data.write section is aligned to the
architectural maximum CWG of 2KB.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
Changes since v4:
 * Moved alignment rules out of assembly into the linker script.
 * Split mmuoff.data into two sections one written with the mmu off, the other
   read with the mmu off. CWG alignment only applies to mmuoff.data.write
 * Fixed PE/COFF alignment breakage.

 arch/arm64/include/asm/sections.h  |  2 ++
 arch/arm64/kernel/head.S           | 24 ++++++++++++++++--------
 arch/arm64/kernel/sleep.S          |  2 ++
 arch/arm64/kernel/smp_spin_table.c |  3 ++-
 arch/arm64/kernel/vmlinux.lds.S    | 21 +++++++++++++++++++++
 arch/arm64/mm/proc.S               |  4 ++++
 6 files changed, 47 insertions(+), 9 deletions(-)

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
index b77f58355da1..9bee5394d76b 100644
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
@@ -621,17 +622,29 @@ set_cpu_boot_mode_flag:
 ENDPROC(set_cpu_boot_mode_flag)
 
 /*
+ * These values are written with the MMU off, but read with the MMU on.
+ * Writers will invalidate the corresponding address, discarding up to a
+ * 'Cache Writeback Granule' (CWG) worth of data. The linker script ensures
+ * sufficient alignment that the CWG doesn't overlap another section.
+ */
+	.pushsection ".mmuoff.data.write", "aw"
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
 	.popsection
 
 	/*
@@ -687,6 +700,7 @@ __secondary_switched:
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
+	.popsection
 
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
@@ -706,12 +720,6 @@ ENDPROC(__secondary_switched)
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
index ccf79d849e0a..8c0a6957c7e8 100644
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
 
 	.pushsection	".idmap.text", "ax"
 _resume_switched:
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 18a71bcd26ee..9a00eee9acc8 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -29,7 +29,8 @@
 #include <asm/smp_plat.h>
 
 extern void secondary_holding_pen(void);
-volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
+volatile unsigned long __section(".mmuoff.data.read")
+secondary_holding_pen_release = INVALID_HWID;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 659963d40bb4..97c3f36ce30b 100644
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
@@ -185,6 +188,24 @@ SECTIONS
 	_data = .;
 	_sdata = .;
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+
+	/*
+	 * Data written with the MMU off but read with the MMU on requires
+	 * cache lines to be invalidated, discarding up to a Cache Writeback
+	 * Granule (CWG) of data from the cache. Keep the section that
+	 * requires this type of maintenance to be in its own Cache Writeback
+	 * Granule (CWG) area so the cache maintenance operations don't
+	 * don't interfere with adjacent data.
+	 */
+	.mmuoff.data.write : ALIGN(SZ_2K) {
+		__mmuoff_data_start = .;
+		*(.mmuoff.data.write)
+	}
+	.mmuoff.data.read : ALIGN(SZ_2K) {
+		*(.mmuoff.data.read)
+		__mmuoff_data_end = .;
+	}
+
 	PECOFF_EDATA_PADDING
 	_edata = .;
 
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
