From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 3 Dec 2015 14:11:30 +0800
Subject: [PATCH v5 20/21] KVM: ARM64: Free perf event of PMU when destroying
 vcpu
In-Reply-To: <1449123091-20252-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449123091-20252-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1449123091-20252-21-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

When KVM frees VCPU, it needs to free the perf_event of PMU.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm/kvm/arm.c    |  1 +
 include/kvm/arm_pmu.h |  2 ++
 virt/kvm/arm/pmu.c    | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index cd696ef..cea2176 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -259,6 +259,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_caches(vcpu);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_vgic_vcpu_destroy(vcpu);
+	kvm_pmu_vcpu_destroy(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index fe8035a..53feebb 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -40,6 +40,7 @@ struct kvm_pmu {
 
 #ifdef CONFIG_KVM_ARM_PMU
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
 unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u32 select_idx);
 void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u32 val);
@@ -52,6 +53,7 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u32 data,
 void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u32 val);
 #else
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}
 unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u32 select_idx)
 {
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 4014831..bd2fece 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -98,6 +98,27 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * kvm_pmu_vcpu_destroy - free perf event of PMU for cpu
+ * @vcpu: The vcpu pointer
+ *
+ */
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+
+	for (i = 0; i < ARMV8_MAX_COUNTERS; i++) {
+		struct kvm_pmc *pmc = &pmu->pmc[i];
+
+		if (pmc->perf_event) {
+			perf_event_disable(pmc->perf_event);
+			perf_event_release_kernel(pmc->perf_event);
+			pmc->perf_event = NULL;
+		}
+	}
+}
+
+/**
  * kvm_pmu_flush_hwstate - flush pmu state to cpu
  * @vcpu: The vcpu pointer
  *
-- 
2.0.4
