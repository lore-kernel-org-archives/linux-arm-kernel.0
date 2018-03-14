From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 16:50:49 +0000
Subject: [PATCH v6 26/26] arm64: Enable ARM64_HARDEN_EL2_VECTORS on Cortex-A57
 and A72
In-Reply-To: <20180314165049.30105-1-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
Message-ID: <20180314165049.30105-27-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A57 and A72 are vulnerable to the so-called "variant 3a" of
Meltdown, where an attacker can speculatively obtain the value
of a privileged system register.

By enabling ARM64_HARDEN_EL2_VECTORS on these CPUs, obtaining
VBAR_EL2 is not disclosing the hypervisor mappings anymore.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8cf6b60a085a..aacdc118c4c9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -424,6 +424,18 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
 		.enable = enable_smccc_arch_workaround_1,
 	},
+#endif
+#ifdef CONFIG_HARDEN_EL2_VECTORS
+	{
+		.desc = "Cortex-A57 EL2 vector hardening",
+		.capability = ARM64_HARDEN_EL2_VECTORS,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+	},
+	{
+		.desc = "Cortex-A72 EL2 vector hardening",
+		.capability = ARM64_HARDEN_EL2_VECTORS,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+	},
 #endif
 	{
 	}
-- 
2.14.2
