From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 18:32:21 +0100
Subject: [PATCHv2 2/4] arm64: errata: use arm_smccc_get_conduit()
In-Reply-To: <20180531173223.9668-1-mark.rutland@arm.com>
References: <20180531173223.9668-1-mark.rutland@arm.com>
Message-ID: <20180531173223.9668-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have arm_smccc_get_conduit(), we can hide the PSCI
implementation details from the arm64 cpu errata code, so let's do so.

As arm_smccc_get_conduit() implicitly checks that the SMCCC version is
at least SMCCC_VERSION_1_1, we no longer need to check this explicitly
where switch statements have a default case.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index cf37ca6fa5f2..0d744b47fd63 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -156,9 +156,7 @@ static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
 	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
 }
 
-#include <uapi/linux/psci.h>
 #include <linux/arm-smccc.h>
-#include <linux/psci.h>
 
 static void call_smc_arch_workaround_1(void)
 {
@@ -193,11 +191,8 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
 		return;
 
-	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
-		return;
-
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_HVC:
+	switch (arm_smccc_1_1_get_conduit()) {
+	case SMCCC_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
@@ -208,7 +203,7 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 		smccc_end = NULL;
 		break;
 
-	case PSCI_CONDUIT_SMC:
+	case SMCCC_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
@@ -275,11 +270,11 @@ void __init arm64_update_smccc_conduit(struct alt_instr *alt,
 
 	BUG_ON(nr_inst != 1);
 
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_HVC:
+	switch (arm_smccc_1_1_get_conduit()) {
+	case SMCCC_CONDUIT_HVC:
 		insn = aarch64_insn_get_hvc_value();
 		break;
-	case PSCI_CONDUIT_SMC:
+	case SMCCC_CONDUIT_SMC:
 		insn = aarch64_insn_get_smc_value();
 		break;
 	default:
@@ -305,12 +300,12 @@ void __init arm64_enable_wa2_handling(struct alt_instr *alt,
 
 void arm64_set_ssbd_mitigation(bool state)
 {
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_HVC:
+	switch (arm_smccc_1_1_get_conduit()) {
+	case SMCCC_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
 		break;
 
-	case PSCI_CONDUIT_SMC:
+	case SMCCC_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
 		break;
 
@@ -329,18 +324,13 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 
-	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
-		ssbd_state = ARM64_SSBD_UNKNOWN;
-		return false;
-	}
-
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_HVC:
+	switch (arm_smccc_1_1_get_conduit()) {
+	case SMCCC_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
 		break;
 
-	case PSCI_CONDUIT_SMC:
+	case SMCCC_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
 		break;
-- 
2.11.0
