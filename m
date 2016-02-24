From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 24 Feb 2016 13:08:32 +0800
Subject: [PATCH v13 12/20] KVM: ARM64: Add access handler for PMSWINC register
In-Reply-To: <1456290520-10012-1-git-send-email-zhaoshenglong@huawei.com>
References: <1456290520-10012-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1456290520-10012-13-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add access handler which emulates writing and reading PMSWINC
register and add support for creating software increment event.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h   |  1 +
 arch/arm64/include/asm/perf_event.h |  2 ++
 arch/arm64/kvm/sys_regs.c           | 20 +++++++++++++++++++-
 include/kvm/arm_pmu.h               |  2 ++
 virt/kvm/arm/pmu.c                  | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 05f4808..de1f82d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -127,6 +127,7 @@ enum vcpu_sysreg {
 	PMCNTENSET_EL0,	/* Count Enable Set Register */
 	PMINTENSET_EL1,	/* Interrupt Enable Set Register */
 	PMOVSSET_EL0,	/* Overflow Flag Status Set Register */
+	PMSWINC_EL0,	/* Software Increment Register */
 
 	/* 32bit specific registers. Keep them at the end of the range */
 	DACR32_EL2,	/* Domain Access Control Register */
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 5c77ef8..ceb14a1 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -45,6 +45,8 @@
 #define	ARMV8_PMU_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
 #define	ARMV8_PMU_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
 
+#define ARMV8_PMU_EVTYPE_EVENT_SW_INCR	0	/* Software increment event */
+
 /*
  * Event filters for PMUv3
  */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 6a774f9..10e5379 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -672,6 +672,23 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static bool access_pmswinc(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			   const struct sys_reg_desc *r)
+{
+	u64 mask;
+
+	if (!kvm_arm_pmu_v3_ready(vcpu))
+		return trap_raz_wi(vcpu, p, r);
+
+	if (p->is_write) {
+		mask = kvm_pmu_valid_counter_mask(vcpu);
+		kvm_pmu_software_increment(vcpu, p->regval & mask);
+		return true;
+	}
+
+	return false;
+}
+
 /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
 #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
 	/* DBGBVRn_EL1 */						\
@@ -882,7 +899,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  access_pmovs, NULL, PMOVSSET_EL0 },
 	/* PMSWINC_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b100),
-	  trap_raz_wi },
+	  access_pmswinc, reset_unknown, PMSWINC_EL0 },
 	/* PMSELR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b101),
 	  access_pmselr, reset_unknown, PMSELR_EL0 },
@@ -1221,6 +1238,7 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 1), access_pmcnten },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 2), access_pmcnten },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 3), access_pmovs },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 4), access_pmswinc },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 5), access_pmselr },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 6), access_pmceid },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 7), access_pmceid },
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 60061da..348c4c9 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -44,6 +44,7 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
 void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_overflow_set(struct kvm_vcpu *vcpu, u64 val);
+void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 				    u64 select_idx);
 #else
@@ -65,6 +66,7 @@ static inline u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 static inline void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_overflow_set(struct kvm_vcpu *vcpu, u64 val) {}
+static inline void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu,
 						  u64 data, u64 select_idx) {}
 #endif
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 0232861..9fc775e 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -180,6 +180,36 @@ void kvm_pmu_overflow_set(struct kvm_vcpu *vcpu, u64 val)
 		kvm_vcpu_kick(vcpu);
 }
 
+/**
+ * kvm_pmu_software_increment - do software increment
+ * @vcpu: The vcpu pointer
+ * @val: the value guest writes to PMSWINC register
+ */
+void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
+{
+	int i;
+	u64 type, enable, reg;
+
+	if (val == 0)
+		return;
+
+	enable = vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
+		if (!(val & BIT(i)))
+			continue;
+		type = vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
+		       & ARMV8_PMU_EVTYPE_EVENT;
+		if ((type == ARMV8_PMU_EVTYPE_EVENT_SW_INCR)
+		    && (enable & BIT(i))) {
+			reg = vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
+			reg = lower_32_bits(reg);
+			vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
+			if (!reg)
+				kvm_pmu_overflow_set(vcpu, BIT(i));
+		}
+	}
+}
+
 static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
 {
 	return (vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) &&
@@ -208,6 +238,10 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 	kvm_pmu_stop_counter(vcpu, pmc);
 	eventsel = data & ARMV8_PMU_EVTYPE_EVENT;
 
+	/* Software increment event does't need to be backed by a perf event */
+	if (eventsel == ARMV8_PMU_EVTYPE_EVENT_SW_INCR)
+		return;
+
 	memset(&attr, 0, sizeof(struct perf_event_attr));
 	attr.type = PERF_TYPE_RAW;
 	attr.size = sizeof(attr);
-- 
2.0.4
