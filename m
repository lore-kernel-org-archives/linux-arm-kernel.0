From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:26:55 +0200
Subject: [PATCH 05/29] arm64: cpu_errata: Add capability to advertise
 Cortex-A73 erratum 858921
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to work around Cortex-A73 erratum 858921 in a subsequent
patch, add the required capability that advertise the erratum.

As the configuration option it depends on is not present yet,
this has no immediate effect.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 1 +
 arch/arm64/include/asm/cpucaps.h       | 3 ++-
 arch/arm64/kernel/cpu_errata.c         | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 2f66683..10f2ddd 100644
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
index fb78a5d..b3aab8a 100644
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
index 2be1d1c..2ed2a76 100644
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
2.7.4
