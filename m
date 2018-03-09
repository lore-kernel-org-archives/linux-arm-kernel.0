From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Mar 2018 15:40:50 +0000
Subject: [PATCH] arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery
Message-ID: <20180309154050.30656-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent update to the ARM SMCCC ARCH_WORKAROUND_1 specification
allows firmware to return a non zero, positive value to describe
that although the mitigation is implemented at the higher exception
level, the CPU on which the call is made is not affected.

Let's relax the check on the return value from ARCH_WORKAROUND_1
so that we only error out if the returned value is negative.

Fixes: b092201e0020 ("arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 07823595b7f0..91428426bf26 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -178,7 +178,7 @@ static int enable_smccc_arch_workaround_1(void *data)
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if (res.a0)
+		if ((int)res.a0 < 0)
 			return 0;
 		cb = call_hvc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_hvc_start;
@@ -188,7 +188,7 @@ static int enable_smccc_arch_workaround_1(void *data)
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if (res.a0)
+		if ((int)res.a0 < 0)
 			return 0;
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
-- 
2.14.2
