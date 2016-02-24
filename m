From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 24 Feb 2016 13:08:37 +0800
Subject: [PATCH v13 17/20] KVM: ARM64: Free perf event of PMU when destroying
 vcpu
In-Reply-To: <1456290520-10012-1-git-send-email-zhaoshenglong@huawei.com>
References: <1456290520-10012-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1456290520-10012-18-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

When KVM frees VCPU, it needs to free the perf_event of PMU.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm/kvm/arm.c    |  1 +
 include/kvm/arm_pmu.h |  2 ++
 virt/kvm/arm/pmu.c    | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f54264c..d2c2cc3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -266,6 +266,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_caches(vcpu);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_vgic_vcpu_destroy(vcpu);
+	kvm_pmu_vcpu_destroy(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index a227213..fd396d6 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -43,6 +43,7 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_overflow_set(struct kvm_vcpu *vcpu, u64 val);
@@ -68,6 +69,7 @@ static inline u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 	return 0;
 }
 static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_overflow_set(struct kvm_vcpu *vcpu, u64 val) {}
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index ee3772c..cb946fd 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -101,6 +101,27 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 	}
 }
 
+/**
+ * kvm_pmu_vcpu_destroy - free perf event of PMU for cpu
+ * @vcpu: The vcpu pointer
+ *
+ */
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+
+	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
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
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 {
 	u64 val = vcpu_sys_reg(vcpu, PMCR_EL0) >> ARMV8_PMU_PMCR_N_SHIFT;
-- 
2.0.4
