From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 11 Sep 2015 16:55:14 +0800
Subject: [PATCH v2 21/22] KVM: ARM64: Free perf event of PMU when destroying
 vcpu
In-Reply-To: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1441961715-11688-22-git-send-email-zhaoshenglong@huawei.com>
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
index ee5d667..a7215c0 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -257,6 +257,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_caches(vcpu);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_vgic_vcpu_destroy(vcpu);
+	kvm_pmu_vcpu_destroy(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index d74e183..2b6fcb1 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -38,6 +38,7 @@ struct kvm_pmu {
 
 #ifdef CONFIG_KVM_ARM_PMU
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
 unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					unsigned long select_idx);
@@ -48,6 +49,7 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, unsigned long data,
 				    unsigned long select_idx);
 #else
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
 void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
 unsigned long kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					unsigned long select_idx)
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 8476d5e..8eccac9 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -109,6 +109,27 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
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
  * kvm_pmu_sync_hwstate - sync pmu state for cpu
  * @vcpu: The vcpu pointer
  *
-- 
2.0.4
