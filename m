From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sun,  7 Jan 2018 22:53:36 -0800
Subject: [PATCH 2/2] arm64: Branch predictor hardening for Cavium ThunderX2
In-Reply-To: <1515394416-166994-1-git-send-email-jnair@caviumnetworks.com>
References: <20180108063115.GA163286@jc-sabre>
 <1515394416-166994-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1515394416-166994-2-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PSCI based mitigation for speculative execution attacks targeting
the branch predictor. The approach is similar to the one used for
Cortex-A CPUs, but in case of ThunderX2 we add another SMC call to
test if the firmware supports the capability.

If the secure firmware has been updated with the mitigation code to
invalidate the branch target buffer, we use the PSCI version call to
invoke it.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/kernel/cpu_errata.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index cb0fb37..abceb5d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -124,6 +124,7 @@ static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
 	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
 }
 
+#include <linux/arm-smccc.h>
 #include <linux/psci.h>
 
 static int enable_psci_bp_hardening(void *data)
@@ -138,6 +139,33 @@ static int enable_psci_bp_hardening(void *data)
 
 	return 0;
 }
+
+#define CAVIUM_TX2_SIP_SMC_CALL		0xC200FF00
+#define CAVIUM_TX2_BTB_HARDEN_CAP	0xB0A0
+
+static int enable_tx2_psci_bp_hardening(void *data)
+{
+	const struct arm64_cpu_capabilities *entry = data;
+	struct arm_smccc_res res;
+
+	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
+		return;
+
+	arm_smccc_smc(CAVIUM_TX2_SIP_SMC_CALL, CAVIUM_TX2_BTB_HARDEN_CAP, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0) {
+		pr_warn("Error: CONFIG_HARDEN_BRANCH_PREDICTOR enabled, but firmware does not support it\n");
+		return 0;
+	}
+	if (res.a1 == 1 && psci_ops.get_version) {
+		pr_info("CPU%d: Branch predictor hardening enabled\n", smp_processor_id());
+		install_bp_hardening_cb(entry,
+				       (bp_hardening_cb_t)psci_ops.get_version,
+				       __psci_hyp_bp_inval_start,
+				       __psci_hyp_bp_inval_end);
+	}
+
+	return 0;
+}
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
 #define MIDR_RANGE(model, min, max) \
@@ -302,6 +330,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 		.enable = enable_psci_bp_hardening,
 	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		.enable = enable_tx2_psci_bp_hardening,
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		.enable = enable_tx2_psci_bp_hardening,
+	},
 #endif
 	{
 	}
-- 
2.7.4
