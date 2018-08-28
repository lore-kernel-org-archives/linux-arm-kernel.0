From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:20 +0100
Subject: [PATCH v5 10/27] arm64: cpufeature: Add cpufeature for IRQ priority
 masking
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-11-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a cpufeature indicating whether a cpu supports masking interrupts
by priority.

Add command line option to disable that feature at runtime.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/arm64/include/asm/cpucaps.h                |  3 ++-
 arch/arm64/kernel/cpufeature.c                  | 31 +++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e64..d3e1170 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2764,6 +2764,9 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
+	nogicprios	[ARM64]
+			Disable usage of GIC priorities to toggle interrupt status.
+
 	nosmap		[X86]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index ae1f704..8cc2ae5 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -51,7 +51,8 @@
 #define ARM64_SSBD				30
 #define ARM64_MISMATCHED_CACHE_TYPE		31
 #define ARM64_HAS_STAGE2_FWB			32
+#define ARM64_HAS_IRQ_PRIO_MASKING		33
 
-#define ARM64_NCAPS				33
+#define ARM64_NCAPS				34
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0d1e41e..2f2c557 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1046,6 +1046,22 @@ static void cpu_has_fwb(const struct arm64_cpu_capabilities *__unused)
 	WARN_ON(val & (7 << 27 | 7 << 21));
 }
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+static bool nogicprios = false;
+
+static int __init early_nogicprios(char *p)
+{
+	nogicprios = true;
+	return 0;
+}
+early_param("nogicprios", early_nogicprios);
+
+static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	return !nogicprios && has_useable_gicv3_cpuif(entry, scope);
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1233,6 +1249,21 @@ static void cpu_has_fwb(const struct arm64_cpu_capabilities *__unused)
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
 #endif
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	{
+		/*
+		 * Depends on having GICv3
+		 */
+		.desc = "IRQ priority masking",
+		.capability = ARM64_HAS_IRQ_PRIO_MASKING,
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.matches = can_use_gic_priorities,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_GIC_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
+#endif
 	{},
 };
 
-- 
1.9.1
