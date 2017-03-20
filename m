From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 17:48:16 +0000
Subject: [PATCH v2 05/18] arm64: cpu_errata: Add capability to advertise
 Cortex-A73 erratum 858921
In-Reply-To: <20170320174829.28182-1-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
Message-ID: <20170320174829.28182-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to work around Cortex-A73 erratum 858921 in a subsequent
patch, add the required capability that advertise the erratum.

As the configuration option it depends on is not present yet,
this has no immediate effect.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 1 +
 arch/arm64/include/asm/cpucaps.h       | 3 ++-
 arch/arm64/kernel/cpu_errata.c         | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 2f66683500b8..10f2dddbf449 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -54,6 +54,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #852523         | N/A                         |
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 | ARM            | Cortex-A72      | #853709         | N/A                         |
+| ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index fb78a5d3b60b..b3aab8a17868 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -37,7 +37,8 @@
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
+#define ARM64_WORKAROUND_858921			19
 
-#define ARM64_NCAPS				19
+#define ARM64_NCAPS				20
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 2be1d1c05303..2ed2a7657711 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -158,6 +158,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 			   MIDR_CPU_VAR_REV(0, 0)),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_858921
+	{
+	/* Cortex-A73 all versions */
+		.desc = "ARM erratum 858921",
+		.capability = ARM64_WORKAROUND_858921,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	},
+#endif
 	{
 	}
 };
-- 
2.11.0
