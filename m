From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 8 Dec 2015 20:47:38 +0800
Subject: [PATCH v6 19/21] KVM: ARM64: Reset PMU state when resetting vcpu
In-Reply-To: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1449578860-15808-20-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

When resetting vcpu, it needs to reset the PMU state to initial status.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/reset.c |  3 +++
 include/kvm/arm_pmu.h  |  2 ++
 virt/kvm/arm/pmu.c     | 17 +++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index f34745c..dfbce78 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -120,6 +120,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
 
+	/* Reset PMU */
+	kvm_pmu_vcpu_reset(vcpu);
+
 	/* Reset timer */
 	return kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
 }
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index c4041008..e0f5bfe 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -38,6 +38,7 @@ struct kvm_pmu {
 };
 
 #ifdef CONFIG_KVM_ARM_PMU
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u32 select_idx);
 void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u32 val);
@@ -49,6 +50,7 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u32 data,
 				    u32 select_idx);
 void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u32 val);
 #else
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u32 select_idx)
 {
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index ff182d6..01e8eb2 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -91,6 +91,23 @@ static void kvm_pmu_stop_counter(struct kvm_pmc *pmc)
 }
 
 /**
+ * kvm_pmu_vcpu_reset - reset pmu state for cpu
+ * @vcpu: The vcpu pointer
+ *
+ */
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+
+	for (i = 0; i < ARMV8_MAX_COUNTERS; i++) {
+		kvm_pmu_stop_counter(&pmu->pmc[i]);
+		pmu->pmc[i].idx = i;
+		pmu->pmc[i].bitmask = 0xffffffffUL;
+	}
+}
+
+/**
  * kvm_pmu_flush_hwstate - flush pmu state to cpu
  * @vcpu: The vcpu pointer
  *
-- 
2.0.4
