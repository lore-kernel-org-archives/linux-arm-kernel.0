From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 11 Sep 2015 16:55:10 +0800
Subject: [PATCH v2 17/22] KVM: ARM64: Add reset and access handlers for
 PMSWINC register
In-Reply-To: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1441961715-11688-18-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add access handler which emulates writing and reading PMSWINC
register and add support for creating software increment event.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 18 +++++++++++++++++-
 include/kvm/arm_pmu.h     |  2 ++
 virt/kvm/arm/pmu.c        | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b47cd0b..24d00a0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -335,6 +335,11 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
 			vcpu_sys_reg(vcpu, PMOVSSET_EL0) &= ~val;
 			break;
 		}
+		case PMSWINC_EL0: {
+			val = *vcpu_reg(vcpu, p->Rt);
+			kvm_pmu_software_increment(vcpu, val);
+			break;
+		}
 		case PMCR_EL0: {
 			/* Only update writeable bits of PMCR */
 			val = vcpu_sys_reg(vcpu, r->reg);
@@ -364,6 +369,8 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
 			*vcpu_reg(vcpu, p->Rt) = val;
 			break;
 		}
+		case PMSWINC_EL0:
+			return read_zero(vcpu, p);
 		default:
 			*vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, r->reg);
 			break;
@@ -576,7 +583,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  access_pmu_regs, reset_unknown, PMOVSCLR_EL0 },
 	/* PMSWINC_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b100),
-	  trap_raz_wi },
+	  access_pmu_regs, reset_unknown, PMSWINC_EL0 },
 	/* PMSELR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b101),
 	  access_pmu_regs, reset_unknown, PMSELR_EL0 },
@@ -833,6 +840,11 @@ static bool access_pmu_cp15_regs(struct kvm_vcpu *vcpu,
 			vcpu_cp15(vcpu, c9_PMOVSSET) &= ~val;
 			break;
 		}
+		case c9_PMSWINC: {
+			val = *vcpu_reg(vcpu, p->Rt);
+			kvm_pmu_software_increment(vcpu, val);
+			break;
+		}
 		case c9_PMCR: {
 			/* Only update writeable bits of PMCR */
 			val = vcpu_cp15(vcpu, r->reg);
@@ -862,6 +874,8 @@ static bool access_pmu_cp15_regs(struct kvm_vcpu *vcpu,
 			*vcpu_reg(vcpu, p->Rt) = val;
 			break;
 		}
+		case c9_PMSWINC:
+			return read_zero(vcpu, p);
 		default:
 			*vcpu_reg(vcpu, p->Rt) = vcpu_cp15(vcpu, r->reg);
 			break;
@@ -907,6 +921,8 @@ static const struct sys_reg_desc cp15_regs[] = {
 	  reset_unknown_cp15, c9_PMCNTENCLR },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 3), access_pmu_cp15_regs,
 	  reset_unknown_cp15, c9_PMOVSCLR },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 4), access_pmu_cp15_regs,
+	  reset_unknown_cp15, c9_PMSWINC },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 5), access_pmu_cp15_regs,
 	  reset_unknown_cp15, c9_PMSELR },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 6), access_pmu_cp15_regs,
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 59e70af..1a27357 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -41,6 +41,7 @@ unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					unsigned long select_idx);
 void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, unsigned long val);
 void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, unsigned long val);
+void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, unsigned long val);
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, unsigned long data,
 				    unsigned long select_idx);
 #else
@@ -51,6 +52,7 @@ unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 }
 void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, unsigned long val) {}
 void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, unsigned long val) {}
+void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, unsigned long val) {}
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, unsigned long data,
 				    unsigned long select_idx) {}
 #endif
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index c6cdc4e..5f5a483 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -163,6 +163,35 @@ void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, unsigned long val)
 }
 
 /**
+ * kvm_pmu_software_increment - do software increment
+ * @vcpu: The vcpu pointer
+ * @val: the value guest writes to PMSWINC register
+ */
+void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	int i;
+	unsigned int type, enable;
+
+	for (i = 0; i < 32; i++) {
+		if ((val >> i) & 0x1) {
+			if (!vcpu_mode_is_32bit(vcpu)) {
+				type = vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
+				       & ARMV8_EVTYPE_EVENT;
+				enable = vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+				if ((type == 0) && ((enable >> i) & 0x1))
+					vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i)++;
+			} else {
+				type = vcpu_cp15(vcpu, c14_PMEVTYPER0 + i)
+				       & ARMV8_EVTYPE_EVENT;
+				enable = vcpu_cp15(vcpu, c9_PMCNTENSET);
+				if ((type == 0) && ((enable >> i) & 0x1))
+					vcpu_cp15(vcpu, c14_PMEVCNTR0 + i)++;
+			}
+		}
+	}
+}
+
+/**
  * kvm_pmu_find_hw_event - find hardware event
  * @pmu: The pmu pointer
  * @event_select: The number of selected event type
@@ -239,6 +268,10 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, unsigned long data,
 	kvm_pmu_stop_counter(vcpu, select_idx);
 	kvm_pmu_set_evttyper(vcpu, select_idx, data);
 
+	/* For software increment event we don't need to create perf event */
+	if (new_eventsel == 0)
+		return;
+
 	config = kvm_pmu_find_hw_event(pmu, new_eventsel);
 	if (config != PERF_COUNT_HW_MAX) {
 		type = PERF_TYPE_HARDWARE;
-- 
2.0.4
