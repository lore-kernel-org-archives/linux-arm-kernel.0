From: nkaje@codeaurora.org (Naveen Kaje)
Date: Thu,  7 Apr 2016 09:54:16 -0600
Subject: [PATCH] arm64: erratum: Workaround for Kryo reserved system register
 read
Message-ID: <1460044456-5297-1-git-send-email-nkaje@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8.0 architecture reserves several system register
encodings for future use. These encodings should behave
as read-only and always return zero on a read. The Kryo core
errantly causes an instruction abort upon an AArch64
read attempt to the following system register encodings using
the MRS instruction:
	 3, 0, C0, [C4-C7], [2-3, 6-7]
	 3, 0, C0, C3, [3-7]
	 3, 0, C0, [C4,C6,C7], [4-5]
	 3, 0, C0, C2, [6-7]
All system register encodings above use the following form
Op0, Op1, CRn, CRm, Op2.
Note that some of the encodings listed above include the system
register space reserved for the following identification registers
which may appear in future revisions of the ARM architecture beyond
ARMv8.0.

This space includes:
	ID_AA64PFR[2-7]_EL1
	ID_AA64DFR[2-3]_EL1
	ID_AA64AFR[2-3]_EL1
	ID_AA64ISAR[2-7]_EL1
	ID_AA64MMFR[2-7]_EL1

Workaround:
Software must not rely on a zero value returned from any of the system
register encodings listed above when attempting to determine support for
certain architectural options. Software should instead infer architectural
support when unaffected variant is in use by reading the MIDR_EL1.

System Impact
None. The required software workaround does not result in any reduction in
functionality nor does it have any relevant impact on performance or power.

This change uses the ARMv8 implementer introduced in
https://www.mail-archive.com/kvm at vger.kernel.org/msg116473.html

Change-Id: Id53e335b6c4524c730b95e5dd7279cf870bb82f6
Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
---
 Documentation/arm64/silicon-errata.txt | 29 +++++++++++++++--------------
 arch/arm64/Kconfig                     | 29 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h    |  3 ++-
 arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
 arch/arm64/kernel/cpuinfo.c            | 10 +++++++---
 5 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 58b71dd..4e16be5 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -42,17 +42,18 @@ file acts as a registry of software workarounds in the Linux Kernel and
 will be updated when new workarounds are committed and backported to
 stable kernels.
 
-| Implementor    | Component       | Erratum ID      | Kconfig                 |
-+----------------+-----------------+-----------------+-------------------------+
-| ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319    |
-| ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319    |
-| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069    |
-| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472    |
-| ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719    |
-| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419    |
-| ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
-| ARM            | Cortex-A57      | #852523         | N/A                     |
-| ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
-|                |                 |                 |                         |
-| Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
-| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
+| Implementor		 | Component       | Erratum ID      | Kconfig                 |
++------------------------+-----------------+-----------------+-------------------------+
+| ARM			 | Cortex-A53      | #826319         | ARM64_ERRATUM_826319    |
+| ARM			 | Cortex-A53      | #827319         | ARM64_ERRATUM_827319    |
+| ARM			 | Cortex-A53      | #824069         | ARM64_ERRATUM_824069    |
+| ARM			 | Cortex-A53      | #819472         | ARM64_ERRATUM_819472    |
+| ARM			 | Cortex-A53      | #845719         | ARM64_ERRATUM_845719    |
+| ARM			 | Cortex-A53      | #843419         | ARM64_ERRATUM_843419    |
+| ARM			 | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
+| ARM			 | Cortex-A57      | #852523         | N/A                     |
+| ARM			 | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
+|			 |                 |                 |                         |
+| Cavium		 | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
+| Cavium		 | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
+| Qualcomm Technologies	 | Kryo		   | #94	     | KRYO_ERRATUM_94	       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e6e61dc..004e998 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -443,6 +443,35 @@ config CAVIUM_ERRATUM_23154
 
 	  If unsure, say Y.
 
+config KRYO_ERRATUM_94
+	bool "ERRATUM to KRYO System Register Read"
+	help
+	The ARMv8.0 specification reserves several system registers
+	for future use. These registers should behave read-only and
+	return zero on a read. The Kryo core errantly causes
+	an instruction abort upon AArch64 read attempt of the following
+	system register encodings using the MRS instruction.
+
+	3, 0, C0, [C4-C7], [2-3, 6-7]
+	3, 0, C0, C3, [3-7]
+	3, 0, C0, [C4,C6,C7], [4-5]
+	3, 0, C0, C2, [6-7]
+
+	All system register encodings above use the form
+
+	Op0, Op1, CRn, CRm, Op2.
+
+	Note that some of the encodings listed above include
+	the system register space reserved for the following
+	identification registers which may appear in future revisions
+	of the ARM architecture beyond ARMv8.0.
+	This space includes:
+	ID_AA64PFR[2-7]_EL1
+	ID_AA64DFR[2-3]_EL1
+	ID_AA64AFR[2-3]_EL1
+	ID_AA64ISAR[2-7]_EL1
+	ID_AA64MMFR[2-7]_EL1
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index d28e8b2..448a637 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -30,8 +30,9 @@
 #define ARM64_HAS_LSE_ATOMICS			5
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
+#define ARM64_WORKAROUND_KRYO_94		8
 
-#define ARM64_NCAPS				8
+#define ARM64_NCAPS				9
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index feb6b4e..27f5846 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -24,6 +24,7 @@
 #define MIDR_CORTEX_A53 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_THUNDERX	MIDR_CPU_PART(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
+#define MIDR_QCOM_KRYO  MIDR_CPU_PART(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 
 #define CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
 			MIDR_ARCHITECTURE_MASK)
@@ -100,6 +101,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
 	},
 #endif
+#ifdef CONFIG_KRYO_ERRATUM_94
+	{
+		.desc = "Kryo Erratum 94",
+		.capability = ARM64_WORKAROUND_KRYO_94,
+		MIDR_RANGE(MIDR_QCOM_KRYO, 0x00, 0x01),
+	},
+#endif
 	{
 	}
 };
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 966fbd5..9921fac 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -204,13 +204,18 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_dczid = read_cpuid(SYS_DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
 
+	check_local_cpu_errata();
+
 	info->reg_id_aa64dfr0 = read_cpuid(SYS_ID_AA64DFR0_EL1);
 	info->reg_id_aa64dfr1 = read_cpuid(SYS_ID_AA64DFR1_EL1);
 	info->reg_id_aa64isar0 = read_cpuid(SYS_ID_AA64ISAR0_EL1);
 	info->reg_id_aa64isar1 = read_cpuid(SYS_ID_AA64ISAR1_EL1);
 	info->reg_id_aa64mmfr0 = read_cpuid(SYS_ID_AA64MMFR0_EL1);
 	info->reg_id_aa64mmfr1 = read_cpuid(SYS_ID_AA64MMFR1_EL1);
-	info->reg_id_aa64mmfr2 = read_cpuid(SYS_ID_AA64MMFR2_EL1);
+	if (cpus_have_cap(ARM64_WORKAROUND_KRYO_94))
+		info->reg_id_aa64mmfr2 = 0;
+	else
+		info->reg_id_aa64mmfr2 = read_cpuid(SYS_ID_AA64MMFR2_EL1);
 	info->reg_id_aa64pfr0 = read_cpuid(SYS_ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(SYS_ID_AA64PFR1_EL1);
 
@@ -223,6 +228,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_isar5 = read_cpuid(SYS_ID_ISAR5_EL1);
 	info->reg_id_mmfr0 = read_cpuid(SYS_ID_MMFR0_EL1);
 	info->reg_id_mmfr1 = read_cpuid(SYS_ID_MMFR1_EL1);
+
 	info->reg_id_mmfr2 = read_cpuid(SYS_ID_MMFR2_EL1);
 	info->reg_id_mmfr3 = read_cpuid(SYS_ID_MMFR3_EL1);
 	info->reg_id_pfr0 = read_cpuid(SYS_ID_PFR0_EL1);
@@ -233,8 +239,6 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_mvfr2 = read_cpuid(SYS_MVFR2_EL1);
 
 	cpuinfo_detect_icache_policy(info);
-
-	check_local_cpu_errata();
 }
 
 void cpuinfo_store_cpu(void)
-- 
1.8.2.1
