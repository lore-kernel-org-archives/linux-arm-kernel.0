From: anup.patel@linaro.org (Anup Patel)
Date: Fri, 21 Mar 2014 18:23:31 +0530
Subject: [PATCH v5 08/11] ARM/ARM64: KVM: Emulate PSCI v0.2 MIGRATE_INFO_TYPE
 and related functions
In-Reply-To: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1395406414-11707-9-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds emulation of PSCI v0.2 MIGRATE, MIGRATE_INFO_TYPE, and
MIGRATE_INFO_UP_CPU function calls for KVM ARM/ARM64.

KVM ARM/ARM64 being a hypervisor (and not a Trusted OS), we cannot provide
this functions hence we emulate these functions in following way:
1. MIGRATE - Returns "Not Supported"
2. MIGRATE_INFO_TYPE - Return 2 i.e. Trusted OS is either not present
   or does not require migration
3. MIGRATE_INFO_UP_CPU - Returns "Not Supported"

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/psci.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 5bd9ae4..ab1d098 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -197,6 +197,21 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 	case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
 		val = kvm_psci_vcpu_affinity_info(vcpu);
 		break;
+	case KVM_PSCI_0_2_FN_MIGRATE:
+	case KVM_PSCI_0_2_FN64_MIGRATE:
+		val = KVM_PSCI_RET_NI;
+		break;
+	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
+		/*
+		 * Trusted OS is either not present or
+		 * does not require migration
+		 */
+		val = 2;
+		break;
+	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
+	case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
+		val = KVM_PSCI_RET_NI;
+		break;
 	case KVM_PSCI_0_2_FN_SYSTEM_OFF:
 		kvm_psci_system_off(vcpu);
 		val = KVM_PSCI_RET_SUCCESS;
@@ -208,12 +223,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		ret = 0;
 		break;
 	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
-	case KVM_PSCI_0_2_FN_MIGRATE:
-	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
-	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
 	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
-	case KVM_PSCI_0_2_FN64_MIGRATE:
-	case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
 		val = KVM_PSCI_RET_NI;
 		break;
 	default:
-- 
1.7.9.5
