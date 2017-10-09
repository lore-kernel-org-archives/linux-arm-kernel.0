From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Oct 2017 13:55:32 +0100
Subject: [PATCH 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <1507553734-27854-1-git-send-email-vladimir.murzin@arm.com>
References: <1507553734-27854-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1507553734-27854-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common Not Private (CNP) is a feature of ARMv8.2 extension which
allows translation table entries to be shared between different PEs in
the same inner shareable domain, so the hardware can use this fact to
optimise the caching of such entries in the TLB.

CNP occupies one bit in TTBRx_ELy and VTTBR_EL2, which advertises to
the hardware that the translation table entries pointed to by this
TTBR are the same as every PE in the same inner shareable domain for
which the equivalent TTBR also has CNP bit set. In case CNP bit is set
but TTBR does not point at the same translation table entries, then
the system is mis-configured, so the results of translations are
UNPREDICTABLE.

This patch adds support for Common Not Private translations on
different exceptions levels:

(1) For EL0 there are a few cases we need to care of changes in
    TTBR0_EL1:
    - a switch to idmap
    - software emulated PAN
    in these cases we make sure that CNP is set for non-zero ASIDs
    only.

(2) For EL1 we postpone setting CNP till all cpus are up and rely on
    cpufeature framework to 1) patch the code which is sensitive to
    CNP and 2) update TTBR1_EL1 with CNP bit set. The only case where
    TTBR1_EL1 can be reprogrammed is hibirnation, so the code there is
    changed to save raw TTBR1_EL1 and blindly restore it on resume.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/Kconfig                   | 13 +++++++++++++
 arch/arm64/include/asm/asm-uaccess.h |  2 ++
 arch/arm64/include/asm/cpucaps.h     |  3 ++-
 arch/arm64/include/asm/cpufeature.h  |  6 ++++++
 arch/arm64/include/asm/memory.h      |  1 +
 arch/arm64/include/asm/mmu_context.h | 14 ++++++++++++++
 arch/arm64/include/asm/uaccess.h     | 10 ++++++++--
 arch/arm64/kernel/cpufeature.c       | 21 +++++++++++++++++++++
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/mm/proc.S                 |  5 +++++
 10 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6..351382f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -973,6 +973,19 @@ config ARM64_PMEM
 	  operations if DC CVAP is not supported (following the behaviour of
 	  DC CVAP itself if the system does not define a point of persistence).
 
+config ARM64_CNP
+	bool "Enable support for Common Not Private (CNP) translations"
+	default y
+	help
+	  Common Not Private (CNP) allows translation table entries to
+	  be shared between different PEs in the same inner shareable
+	  domain, so the hardware can use this fact to optimise the
+	  caching of such entries in the TLB.
+
+	  Selecting this option allows the CNP feature to be detected
+	  at runtime, and does not affect PEs that do not implement
+	  this feature.
+
 endmenu
 
 config ARM64_MODULE_CMODEL_LARGE
diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index ecd9788..a3e452e 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -12,6 +12,8 @@
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	.macro	__uaccess_ttbr0_disable, tmp1
 	mrs	\tmp1, ttbr1_el1		// swapper_pg_dir
+	bic	\tmp1, \tmp1, #TTBR_CNP_BIT	// unconditionally clear CNP bit to avoid alternatives
+						// inside alternatives
 	add	\tmp1, \tmp1, #SWAPPER_DIR_SIZE	// reserved_ttbr0 at the end of swapper_pg_dir
 	msr	ttbr0_el1, \tmp1		// set reserved TTBR0_EL1
 	isb
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 8da6216..9b7d94c 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -40,7 +40,8 @@
 #define ARM64_WORKAROUND_858921			19
 #define ARM64_WORKAROUND_CAVIUM_30115		20
 #define ARM64_HAS_DCPOP				21
+#define ARM64_HAS_CNP				22
 
-#define ARM64_NCAPS				22
+#define ARM64_NCAPS				23
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 428ee1f..f7c75ac 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -262,6 +262,12 @@ static inline bool system_uses_ttbr0_pan(void)
 		!cpus_have_const_cap(ARM64_HAS_PAN);
 }
 
+static inline bool system_supports_cnp(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_CNP) &&
+		cpus_have_const_cap(ARM64_HAS_CNP);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f7c4d21..9640abc 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -78,6 +78,7 @@
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
 #define TASK_SIZE_64		(UL(1) << VA_BITS)
+#define TTBR_CNP_BIT		(UL(1) << 0)
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 3257895a..c8adce2 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -135,6 +135,17 @@ static inline void cpu_replace_ttbr1(pgd_t *pgd)
 
 	phys_addr_t pgd_phys = virt_to_phys(pgd);
 
+	if (system_supports_cnp()) {
+		/*
+		 * cpu_replace_ttbr1() is used when there's a boot CPU up
+		 * (i.e. cpufeture framework is not up yet) and latter only
+		 * when we enable CNP via cpufeature's enable() callback.
+		 */
+		BUG_ON(pgd != swapper_pg_dir);
+
+		pgd_phys |= TTBR_CNP_BIT;
+	}
+
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
@@ -178,6 +189,9 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 		BUG_ON(mm->pgd == swapper_pg_dir);
 		task_thread_info(tsk)->ttbr0 =
 			virt_to_phys(mm->pgd) | ASID(mm) << 48;
+
+		if (system_supports_cnp() && ASID(mm))
+			task_thread_info(tsk)->ttbr0 |= TTBR_CNP_BIT;
 	}
 }
 #else
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index fc0f9eb..14b1799 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -107,8 +107,14 @@ static inline void __uaccess_ttbr0_disable(void)
 {
 	unsigned long ttbr;
 
-	/* reserved_ttbr0 placed at the end of swapper_pg_dir */
-	ttbr = read_sysreg(ttbr1_el1) + SWAPPER_DIR_SIZE;
+	/*
+	 * reserved_ttbr0 is placed at the end of swapper_pg_dir.
+	 * When CNP is in use, TTBR1 may have the CNP bit set, but the
+	 * reserved_ttbr should only be used without CNP.
+	 */
+	ttbr = read_sysreg(ttbr1_el1);
+	ttbr &= ~TTBR_CNP_BIT;
+	ttbr += SWAPPER_DIR_SIZE;
 	write_sysreg(ttbr, ttbr0_el1);
 	isb();
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 21e2c95..8d098a1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -101,6 +101,7 @@ EXPORT_SYMBOL(cpu_hwcap_keys);
 static bool __maybe_unused
 cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
 
+static int cpu_enable_cnp(void *__unused);;
 
 /*
  * NOTE: Any changes to the visibility of features should be kept in
@@ -898,6 +899,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
 		.min_field_value = 1,
+#endif
+#ifdef CONFIG_ARM64_CNP
+	{
+		.desc = "Common not Private translations",
+		.capability = ARM64_HAS_CNP,
+		.def_scope = SCOPE_SYSTEM,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR2_CNP_SHIFT,
+		.min_field_value = 1,
+		.enable = cpu_enable_cnp,
 	},
 #endif
 	{},
@@ -1211,6 +1224,14 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 	return (cpus_have_const_cap(ARM64_HAS_PAN) && !cpus_have_const_cap(ARM64_HAS_UAO));
 }
 
+#ifdef CONFIG_ARM64_CNP
+static int cpu_enable_cnp(void *__unused)
+{
+	cpu_replace_ttbr1(swapper_pg_dir);
+	return 0;
+}
+#endif /* CONFIG_ARM64_CNP */
+
 /*
  * We emulate only the following system register space.
  * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 095d3c1..1d056f3 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -124,7 +124,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 		return -EOVERFLOW;
 
 	arch_hdr_invariants(&hdr->invariants);
-	hdr->ttbr1_el1		= __pa_symbol(swapper_pg_dir);
+	hdr->ttbr1_el1		= read_sysreg(ttbr1_el1);
 	hdr->reenter_kernel	= _cpu_resume;
 
 	/* We can't use __hyp_get_vectors() because kvm may still be loaded */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 877d42f..1c94030 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -141,6 +141,11 @@ ENTRY(cpu_do_switch_mm)
 	pre_ttbr0_update_workaround x0, x2, x3
 	mmid	x1, x1				// get mm->context.id
 	bfi	x0, x1, #48, #16		// set the ASID
+alternative_if ARM64_HAS_CNP
+	cbz	x1, 1f
+	orr	x0, x0, #TTBR_CNP_BIT
+1:
+alternative_else_nop_endif
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
 	post_ttbr0_update_workaround
-- 
2.0.0
