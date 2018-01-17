From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 12:04:44 +0000
Subject: [PATCH 2/3] arm/arm64: kvm: pmu: Make overflow handler NMI safe
In-Reply-To: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
References: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1516190685-20048-3-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using an NMI for the PMU interrupt, taking any lock migh cause a
deadlock. The current PMU overflow handler in KVM takes takes locks when
trying to wake up a vcpu.

When overflow handler is called by an NMI, defer the vcpu waking in an
irq_work queue.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 include/kvm/arm_pmu.h |  1 +
 virt/kvm/arm/pmu.c    | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index f87fe20..6a7c9dd 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -37,6 +37,7 @@ struct kvm_pmu {
 	bool ready;
 	bool created;
 	bool irq_level;
+	struct irq_work overflow_work;
 };

 #define kvm_arm_pmu_v3_ready(v)		((v)->arch.pmu.ready)
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 8a9c423..c5cdeea 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -273,15 +273,37 @@ void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu)
 	kvm_pmu_update_state(vcpu);
 }

+static inline struct kvm_vcpu *kvm_pmu_to_vcpu(struct kvm_pmu *pmu)
+{
+	struct kvm_vcpu_arch *vcpu_arch;
+
+	vcpu_arch = container_of(pmu, struct kvm_vcpu_arch, pmu);
+	return container_of(vcpu_arch, struct kvm_vcpu, arch);
+}
+
 static inline struct kvm_vcpu *kvm_pmc_to_vcpu(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu;
-	struct kvm_vcpu_arch *vcpu_arch;

 	pmc -= pmc->idx;
 	pmu = container_of(pmc, struct kvm_pmu, pmc[0]);
-	vcpu_arch = container_of(pmu, struct kvm_vcpu_arch, pmu);
-	return container_of(vcpu_arch, struct kvm_vcpu, arch);
+	return kvm_pmu_to_vcpu(pmu);
+}
+
+/**
+ * When perf interrupt is an NMI, we cannot safely notify the vcpu corresponding
+ * to the even.
+ * This is why we need a callback to do it once outside of the NMI context.
+ */
+static void kvm_pmu_perf_overflow_notify_vcpu(struct irq_work *work)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_pmu *pmu;
+
+	pmu = container_of(work, struct kvm_pmu, overflow_work);
+	vcpu = kvm_pmu_to_vcpu(pmu);
+
+	kvm_vcpu_kick(vcpu);
 }

 /**
@@ -299,7 +321,11 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,

 	if (kvm_pmu_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
-		kvm_vcpu_kick(vcpu);
+
+		if (!in_nmi())
+			kvm_vcpu_kick(vcpu);
+		else
+			irq_work_queue(&vcpu->arch.pmu.overflow_work);
 	}
 }

@@ -501,6 +527,9 @@ static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
 			return ret;
 	}

+	init_irq_work(&vcpu->arch.pmu.overflow_work,
+		      kvm_pmu_perf_overflow_notify_vcpu);
+
 	vcpu->arch.pmu.created = true;
 	return 0;
 }
--
1.9.1
