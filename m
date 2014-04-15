From: anup.patel@linaro.org (Anup Patel)
Date: Tue, 15 Apr 2014 11:44:12 +0530
Subject: [PATCH v9 09/12] ARM/ARM64: KVM: Emulate PSCI v0.2 MIGRATE_INFO_TYPE
 and related functions
In-Reply-To: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1397542455-354-10-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds emulation of PSCI v0.2 MIGRATE, MIGRATE_INFO_TYPE, and
MIGRATE_INFO_UP_CPU function calls for KVM ARM/ARM64.

KVM ARM/ARM64 being a hypervisor (and not a Trusted OS), we cannot provide
this functions hence we emulate these functions in following way:
1. MIGRATE - Returns "Not Supported"
2. MIGRATE_INFO_TYPE - Return 2 i.e. Trusted OS is not present
3. MIGRATE_INFO_UP_CPU - Returns "Not Supported"

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/psci.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index f6f9290..1af0016 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -182,6 +182,22 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 	case PSCI_0_2_FN64_AFFINITY_INFO:
 		val = kvm_psci_vcpu_affinity_info(vcpu);
 		break;
+	case PSCI_0_2_FN_MIGRATE:
+	case PSCI_0_2_FN64_MIGRATE:
+		val = PSCI_RET_NOT_SUPPORTED;
+		break;
+	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
+		/*
+		 * Trusted OS is MP hence does not require migration
+	         * or
+		 * Trusted OS is not present
+		 */
+		val = PSCI_0_2_TOS_MP;
+		break;
+	case PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
+	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
+		val = PSCI_RET_NOT_SUPPORTED;
+		break;
 	case PSCI_0_2_FN_SYSTEM_OFF:
 		kvm_psci_system_off(vcpu);
 		val = PSCI_RET_SUCCESS;
@@ -193,12 +209,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		ret = 0;
 		break;
 	case PSCI_0_2_FN_CPU_SUSPEND:
-	case PSCI_0_2_FN_MIGRATE:
-	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
-	case PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
 	case PSCI_0_2_FN64_CPU_SUSPEND:
-	case PSCI_0_2_FN64_MIGRATE:
-	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
 		val = PSCI_RET_NOT_SUPPORTED;
 		break;
 	default:
-- 
1.7.9.5
