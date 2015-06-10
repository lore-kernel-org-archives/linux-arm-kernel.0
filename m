From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 10 Jun 2015 15:19:24 +0100
Subject: [PATCH v2] ARM: kvm: psci: fix handling of unimplemented functions
Message-ID: <1433945964-18643-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the PSCI specification and the SMC/HVC calling
convention, PSCI function_ids that are not implemented must
return NOT_SUPPORTED as return value.

Current KVM implementation takes an unhandled PSCI function_id
as an error and injects an undefined instruction into the guest
if PSCI implementation is called with a function_id that is not
handled by the resident PSCI version (ie it is not implemented),
which is not the behaviour expected by a guest when calling a
PSCI function_id that is not implemented.

This patch fixes this issue by returning NOT_SUPPORTED whenever
the kvm PSCI call is executed for a function_id that is not
implemented by the PSCI kvm layer.

Cc: <stable@vger.kernel.org> # 3.18+
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
v1->v2:

- Added stable tag
- Combined function_id case values returning NOT_SUPPORTED to default
  case handling

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347353.html

 arch/arm/kvm/psci.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 02fa8ef..531e922 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -230,10 +230,6 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 	case PSCI_0_2_FN64_AFFINITY_INFO:
 		val = kvm_psci_vcpu_affinity_info(vcpu);
 		break;
-	case PSCI_0_2_FN_MIGRATE:
-	case PSCI_0_2_FN64_MIGRATE:
-		val = PSCI_RET_NOT_SUPPORTED;
-		break;
 	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
 		/*
 		 * Trusted OS is MP hence does not require migration
@@ -242,10 +238,6 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		 */
 		val = PSCI_0_2_TOS_MP;
 		break;
-	case PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
-	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
-		val = PSCI_RET_NOT_SUPPORTED;
-		break;
 	case PSCI_0_2_FN_SYSTEM_OFF:
 		kvm_psci_system_off(vcpu);
 		/*
@@ -271,7 +263,8 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		ret = 0;
 		break;
 	default:
-		return -EINVAL;
+		val = PSCI_RET_NOT_SUPPORTED;
+		break;
 	}
 
 	*vcpu_reg(vcpu, 0) = val;
@@ -291,12 +284,9 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 	case KVM_PSCI_FN_CPU_ON:
 		val = kvm_psci_vcpu_on(vcpu);
 		break;
-	case KVM_PSCI_FN_CPU_SUSPEND:
-	case KVM_PSCI_FN_MIGRATE:
+	default:
 		val = PSCI_RET_NOT_SUPPORTED;
 		break;
-	default:
-		return -EINVAL;
 	}
 
 	*vcpu_reg(vcpu, 0) = val;
-- 
2.2.1
