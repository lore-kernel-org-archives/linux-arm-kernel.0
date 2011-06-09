From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  9 Jun 2011 18:21:51 +0100
Subject: [RFC PATCH 1/2] ARM: Add a generic macro for declaring proc_info
	structs
In-Reply-To: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
References: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1307640112-5360-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a macro allows the structure declarations to be more
readable and shorter, as well as enabling build-time checking
of the structure layout.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-macros.S |  141 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 34261f9..fe78f3b 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -254,3 +254,144 @@
 	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
 	mcr	p15, 0, ip, c7, c10, 4		@ data write barrier
 	.endm
+
+/*
+ * proc_info structure declaration macro
+ */
+	.macro proc_info name:req
+		.macro _proc_check_align fieldname:req, align:req
+			.if . - \name != (\align )
+				.error "Unexpected or misaligned proc_info field \fieldname"
+			.endif
+		.endm
+
+		.macro cpu_val value:req
+			_proc_check_align cpu_val, 0
+			.long \value
+		.endm
+
+		.macro cpu_mask value:req
+			_proc_check_align cpu_mask, 4
+			.long \value
+		.endm
+
+		/*
+		 * Normal memory MMU flags for CPUs with no SMP support.
+		 * For CPUs with SMP support, use __cpu_mm_mmu_flags_smp and
+		 * __cpu_mm_mmu_flags_up instead.
+		 */
+		.macro __cpu_mm_mmu_flags value:req
+			_proc_check_align __cpu_mm_mmu_flags, PROCINFO_MM_MMUFLAGS
+			.long \value
+		.endm
+
+		.macro __cpu_mm_mmu_flags_smp value:req
+			_proc_check_align __cpu_mm_mmu_flags_smp, PROCINFO_MM_MMUFLAGS
+ ALT_SMP(		.long \value	)
+		.endm
+
+		/*
+		 * __cpu_mm_mmu_flags_up must follow __cpu_mm_mmu_flags_smp,
+		 * so the assembly-time offset is actually PROCINFO_IO_MMUFLAGS.
+		 * This macro generates fixups, rather than direct output.
+		 */
+		.macro __cpu_mm_mmu_flags_up value:req
+			_proc_check_align __cpu_mm_mmu_flags_up, PROCINFO_IO_MMUFLAGS
+ ALT_UP(		.long \value	)
+		.endm
+
+		.macro __cpu_io_mmu_flags value:req
+			_proc_check_align __cpu_io_mmu_flags, PROCINFO_IO_MMUFLAGS
+			.long \value
+		.endm
+
+		.macro __cpu_flush insn:vararg
+			_proc_check_align __cpu_flush, PROCINFO_INITFUNC
+			\insn
+		.endm
+
+		.macro arch_name string:req
+			_proc_check_align arch_name, 0x14
+			.pushsection .rodata.str, "aMS", 1
+\name\()_arch_name:		.asciz "\string"
+				.size \name\()_arch_name, . - \name\()_arch_name
+				.type \name\()_arch_name, #object
+			.popsection
+			.long \name\()_arch_name
+		.endm
+
+		.macro elf_name string:req
+			_proc_check_align elf_name, 0x18
+			.pushsection .rodata.str, "aMS", 1
+\name\()_elf_name:		.asciz "\string"
+				.size \name\()_elf_name, . - \name\()_elf_name
+				.type \name\()_elf_name, #object
+			.popsection
+			.long \name\()_elf_name
+		.endm
+
+		.macro elf_hwcap value:req
+			_proc_check_align elf_hwcap, 0x1c
+			.long \value
+		.endm
+
+		.macro cpu_name string:req
+			_proc_check_align cpu_name, 0x20
+			.pushsection .rodata.str, "aMS", 1
+\name\()_cpu_name:	.asciz "\string"
+				.size \name\()_cpu_name, . - \name\()_cpu_name
+				.type \name\()_cpu_name, #object
+			.popsection
+			.long \name\()_cpu_name
+		.endm
+
+		.macro proc label:req
+			_proc_check_align proc, 0x24
+			.long \label
+		.endm
+
+		.macro tlb label:req
+			_proc_check_align tlb, 0x28
+			.long \label
+		.endm
+
+		.macro user label:req
+			_proc_check_align user, 0x2c
+			.long \label
+		.endm
+
+		.macro cache label:req
+			_proc_check_align cache, 0x30
+			.long \label
+		.endm
+
+		.macro end_proc_info
+			.if . - \name != PROC_INFO_SZ
+				.error "incorrect number of fields in proc_info"
+			.endif
+			.size \name , . - \name
+			.type \name , #object
+			.popsection
+			.purgem end_proc_info
+			.purgem _proc_check_align
+			.purgem cpu_val
+			.purgem cpu_mask
+			.purgem __cpu_mm_mmu_flags
+			.purgem __cpu_mm_mmu_flags_smp
+			.purgem __cpu_mm_mmu_flags_up
+			.purgem __cpu_io_mmu_flags
+			.purgem __cpu_flush
+			.purgem arch_name
+			.purgem elf_name
+			.purgem elf_hwcap
+			.purgem cpu_name
+			.purgem proc
+			.purgem tlb
+			.purgem user
+			.purgem cache
+		.endm
+
+		.pushsection .proc.info.init, #alloc, #execinstr
+		.align 2
+\name :
+	.endm
-- 
1.7.4.1
