From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 31 Jul 2018 14:08:56 +0100
Subject: [PATCH v6 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
References: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1533042538-26184-2-git-send-email-vladimir.murzin@arm.com>
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
but TTBR does not point at the same translation table entries for a
given ASID and VMID, then the system is mis-configured, so the results
of translations are UNPREDICTABLE.

For kernel we postpone setting CNP till all cpus are up and rely on
cpufeature framework to 1) patch the code which is sensitive to CNP
and 2) update TTBR1_EL1 with CNP bit set. TTBR1_EL1 can be
reprogrammed as result of hibernation or cpuidle (via __enable_mmu).
For these two cases we restore CnP bit via __cpu_suspend_exit().

There are a few cases we need to care of changes in TTBR0_EL1:
  - a switch to idmap
  - software emulated PAN

we rule out latter via Kconfig options and for the former we make
sure that CNP is set for non-zero ASIDs only.

Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/Kconfig                     | 13 +++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cpufeature.h    |  6 ++++++
 arch/arm64/include/asm/mmu_context.h   | 17 +++++++++++++++--
 arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
 arch/arm64/kernel/cpufeature.c         | 34 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/suspend.c            |  4 ++++
 arch/arm64/mm/context.c                |  3 +++
 arch/arm64/mm/proc.S                   | 11 ++++++++---
 9 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..70a4ad3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1124,6 +1124,19 @@ config ARM64_RAS_EXTN
 	  and access the new registers if the system supports the extension.
 	  Platform RAS features may additionally depend on firmware support.
 
+config ARM64_CNP
+	bool "Enable support for Common Not Private (CNP) translations"
+	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
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
 
 config ARM64_SVE
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 8a699c7..7219654 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -49,7 +49,8 @@
 #define ARM64_HAS_CACHE_DIC			28
 #define ARM64_HW_DBM				29
 #define ARM64_SSBD				30
+#define ARM64_HAS_CNP				31
 
-#define ARM64_NCAPS				31
+#define ARM64_NCAPS				32
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1..b5e2440 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -508,6 +508,12 @@ static inline bool system_supports_sve(void)
 		cpus_have_const_cap(ARM64_SVE);
 }
 
+static inline bool system_supports_cnp(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_CNP) &&
+		cpus_have_const_cap(ARM64_HAS_CNP);
+}
+
 #define ARM64_SSBD_UNKNOWN		-1
 #define ARM64_SSBD_FORCE_DISABLE	0
 #define ARM64_SSBD_KERNEL		1
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 39ec0b8..1e58bf5 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -147,12 +147,25 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
 	ttbr_replace_func *replace_phys;
 
-	phys_addr_t pgd_phys = virt_to_phys(pgdp);
+	/* phys_to_ttbr() zeros lower 2 bits of ttbr with 52-bit PA */
+	phys_addr_t ttbr1 = phys_to_ttbr(virt_to_phys(pgdp));
+
+	if (system_supports_cnp() && !WARN_ON(pgdp != lm_alias(swapper_pg_dir))) {
+		/*
+		 * cpu_replace_ttbr1() is used when there's a boot CPU
+		 * up (i.e. cpufeature framework is not up yet) and
+		 * latter only when we enable CNP via cpufeature's
+		 * enable() callback.
+		 * Also we rely on the cpu_hwcap bit being set before
+		 * calling the enable() function.
+		 */
+		ttbr1 |= TTBR_CNP_BIT;
+	}
 
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
-	replace_phys(pgd_phys);
+	replace_phys(ttbr1);
 	cpu_uninstall_idmap();
 }
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index fd208ea..1d7d8da 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -211,6 +211,8 @@
 #define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
 #define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
+#define TTBR_CNP_BIT		(UL(1) << 0)
+
 /*
  * TCR flags.
  */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f24892a..53d495f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -20,6 +20,7 @@
 
 #include <linux/bsearch.h>
 #include <linux/cpumask.h>
+#include <linux/crash_dump.h>
 #include <linux/sort.h>
 #include <linux/stop_machine.h>
 #include <linux/types.h>
@@ -117,6 +118,7 @@ EXPORT_SYMBOL(cpu_hwcap_keys);
 static bool __maybe_unused
 cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
 
+static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
 
 /*
  * NOTE: Any changes to the visibility of features should be kept in
@@ -858,6 +860,20 @@ static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
 	return read_sanitised_ftr_reg(SYS_CTR_EL0) & BIT(CTR_DIC_SHIFT);
 }
 
+static bool __maybe_unused
+has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	/*
+	 * Kdump isn't guaranteed to power-off all secondary CPUs, CNP
+	 * may share TLB entries with a CPU stuck in the crashed
+	 * kernel.
+	 */
+	 if (is_kdump_kernel())
+		return false;
+
+	return has_cpuid_feature(entry, scope);
+}
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
@@ -1202,6 +1218,19 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
 #endif
+#ifdef CONFIG_ARM64_CNP
+	{
+		.desc = "Common not Private translations",
+		.capability = ARM64_HAS_CNP,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_useable_cnp,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR2_CNP_SHIFT,
+		.min_field_value = 1,
+		.cpu_enable = cpu_enable_cnp,
+	},
+#endif
 	{},
 };
 
@@ -1638,6 +1667,11 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 	return (cpus_have_const_cap(ARM64_HAS_PAN) && !cpus_have_const_cap(ARM64_HAS_UAO));
 }
 
+static void __maybe_unused cpu_enable_cnp(struct arm64_cpu_capabilities const *cap)
+{
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+}
+
 /*
  * We emulate only the following system register space.
  * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 70c2833..9405d1b 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -48,6 +48,10 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	cpu_uninstall_idmap();
 
+	/* Restore CnP bit in TTBR1_EL1 */
+	if (system_supports_cnp())
+		cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+
 	/*
 	 * PSTATE was not saved over suspend/resume, re-enable any detected
 	 * features that might not have been set correctly.
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index c127f94..a65af49 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -196,6 +196,9 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	unsigned long flags;
 	u64 asid, old_active_asid;
 
+	if (system_supports_cnp())
+		cpu_set_reserved_ttbr0();
+
 	asid = atomic64_read(&mm->context.id);
 
 	/*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 03646e6..2c75b0b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -160,6 +160,12 @@ ENTRY(cpu_do_switch_mm)
 	mrs	x2, ttbr1_el1
 	mmid	x1, x1				// get mm->context.id
 	phys_to_ttbr x3, x0
+
+alternative_if ARM64_HAS_CNP
+	cbz     x1, 1f                          // skip CNP for reserved ASID
+	orr     x3, x3, #TTBR_CNP_BIT
+1:
+alternative_else_nop_endif
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	bfi	x3, x1, #48, #16		// set the ASID field in TTBR0
 #endif
@@ -184,7 +190,7 @@ ENDPROC(cpu_do_switch_mm)
 .endm
 
 /*
- * void idmap_cpu_replace_ttbr1(phys_addr_t new_pgd)
+ * void idmap_cpu_replace_ttbr1(phys_addr_t ttbr1)
  *
  * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
  * called by anything else. It can only be executed from a TTBR0 mapping.
@@ -194,8 +200,7 @@ ENTRY(idmap_cpu_replace_ttbr1)
 
 	__idmap_cpu_set_reserved_ttbr1 x1, x3
 
-	phys_to_ttbr x3, x0
-	msr	ttbr1_el1, x3
+	msr	ttbr1_el1, x0
 	isb
 
 	restore_daif x2
-- 
2.0.0
