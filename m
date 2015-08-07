From: eric.auger@linaro.org (Eric Auger)
Date: Fri,  7 Aug 2015 18:08:32 +0200
Subject: [PATCH v2 3/4] KVM: arm/arm64: check power_off in critical section
 before VCPU run
In-Reply-To: <1438963713-10460-1-git-send-email-eric.auger@linaro.org>
References: <1438963713-10460-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438963713-10460-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case KVM_SET_MP_STATE ioctl is called just after we executed the
vcpu_sleep check, we can enter the guest although KVM_MP_STATE_STOPPED
is set. Let's check the power_off state in the critical section,
just before entering the guest.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4f50be3..cc404a8 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -555,7 +555,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			run->exit_reason = KVM_EXIT_INTR;
 		}
 
-		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
+		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm) ||
+			vcpu->arch.power_off) {
 			local_irq_enable();
 			kvm_vgic_sync_hwstate(vcpu);
 			preempt_enable();
-- 
1.9.1
