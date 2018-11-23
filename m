From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Nov 2018 18:41:04 +0000
Subject: [PATCH v2 5/8] arm64: KVM: Force VHE for systems affected by erratum
 1165522
In-Reply-To: <20181123184107.39334-1-marc.zyngier@arm.com>
References: <20181123184107.39334-1-marc.zyngier@arm.com>
Message-ID: <20181123184107.39334-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to easily mitigate ARM erratum 1165522, we need to force
affected CPUs to run in VHE mode if using KVM.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cpucaps.h  | 3 ++-
 arch/arm64/include/asm/kvm_host.h | 4 ++++
 arch/arm64/kernel/cpu_errata.c    | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 6e2d254c09eb..62d8cd15fdf2 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -54,7 +54,8 @@
 #define ARM64_HAS_CRC32				33
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1188873		35
+#define ARM64_WORKAROUND_1165522		36
 
-#define ARM64_NCAPS				36
+#define ARM64_NCAPS				37
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d6d9aa76a943..9217759afa6b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -432,6 +432,10 @@ static inline bool kvm_arch_requires_vhe(void)
 	if (system_supports_sve())
 		return true;
 
+	/* Some implementations have defects that confine them to VHE */
+	if (cpus_have_cap(ARM64_WORKAROUND_1165522))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a509e35132d2..476e738e6c46 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -739,6 +739,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_1188873,
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
 	},
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_1165522
+	{
+		/* Cortex-A76 r0p0 to r2p0 */
+		.desc = "ARM erratum 1165522",
+		.capability = ARM64_WORKAROUND_1165522,
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+	},
 #endif
 	{
 	}
-- 
2.19.1
