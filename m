From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 11 Sep 2015 16:55:13 +0800
Subject: [PATCH v2 20/22] KVM: ARM64: Reset PMU state when resetting vcpu
In-Reply-To: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1441961715-11688-21-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/reset.c |  3 +++
 include/kvm/arm_pmu.h  |  2 ++
 virt/kvm/arm/pmu.c     | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 0b43265..ee2c2e9 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -107,5 +107,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset timer */
 	kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
 
+	/* Reset PMU */
+	kvm_pmu_vcpu_reset(vcpu);
+
 	return 0;
 }
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 5f1ea2b..d74e183 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -37,6 +37,7 @@ struct kvm_pmu {
 };
 
 #ifdef CONFIG_KVM_ARM_PMU
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
 unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					unsigned long select_idx);
@@ -46,6 +47,7 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, unsigned long val);
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, unsigned long data,
 				    unsigned long select_idx);
 #else
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
 void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
 unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					unsigned long select_idx)
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 9e75372..8476d5e 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -91,6 +91,24 @@ static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu,
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
+		kvm_pmu_stop_counter(vcpu, i);
+		pmu->pmc[i].idx = i;
+		pmu->pmc[i].vcpu = vcpu;
+	}
+	pmu->irq_pending = false;
+}
+
+/**
  * kvm_pmu_sync_hwstate - sync pmu state for cpu
  * @vcpu: The vcpu pointer
  *
-- 
2.0.4
