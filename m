From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 31 Jan 2018 10:35:06 +0100
Subject: [PULL 27/28] KVM: arm/arm64: Fix userspace_irqchip_in_use counting
In-Reply-To: <20180131093507.22219-1-christoffer.dall@linaro.org>
References: <20180131093507.22219-1-christoffer.dall@linaro.org>
Message-ID: <20180131093507.22219-28-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were not decrementing the static key count in the right location.
kvm_arch_vcpu_destroy() is only called to clean up after a failed
VCPU create attempt, whereas kvm_arch_vcpu_free() is called on teardown
of the VM as well.  Move the static key decrement call to
kvm_arch_vcpu_free().

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 639dca0c0560..04ee7a327870 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -295,6 +295,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
+	if (vcpu->arch.has_run_once && unlikely(!irqchip_in_kernel(vcpu->kvm)))
+		static_branch_dec(&userspace_irqchip_in_use);
+
 	kvm_mmu_free_memory_caches(vcpu);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_pmu_vcpu_destroy(vcpu);
@@ -304,8 +307,6 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.has_run_once && unlikely(!irqchip_in_kernel(vcpu->kvm)))
-		static_branch_dec(&userspace_irqchip_in_use);
 	kvm_arch_vcpu_free(vcpu);
 }
 
-- 
2.14.2
