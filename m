From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 13 Dec 2017 11:45:54 +0100
Subject: [PATCH v8 1/9] KVM: arm/arm64: Remove redundant preemptible checks
In-Reply-To: <20171213104602.16383-1-christoffer.dall@linaro.org>
References: <20171213104602.16383-1-christoffer.dall@linaro.org>
Message-ID: <20171213104602.16383-2-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __this_cpu_read() and __this_cpu_write() functions already implement
checks for the required preemption levels when using
CONFIG_DEBUG_PREEMPT which gives you nice error messages and such.
Therefore there is no need to explicitly check this using a BUG_ON() in
the code (which we don't do for other uses of per cpu variables either).

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a6524ff27de4..859ff7e3a1eb 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -71,7 +71,6 @@ static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
 
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
-	BUG_ON(preemptible());
 	__this_cpu_write(kvm_arm_running_vcpu, vcpu);
 }
 
@@ -81,7 +80,6 @@ static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
  */
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void)
 {
-	BUG_ON(preemptible());
 	return __this_cpu_read(kvm_arm_running_vcpu);
 }
 
-- 
2.14.2
