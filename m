From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 25 Sep 2015 23:41:16 +0200
Subject: [PATCH v3 3/4] KVM: arm/arm64: check power_off in critical section
 before VCPU run
In-Reply-To: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
References: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1443217277-13173-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case a vcpu off PSCI call is called just after we executed the
vcpu_sleep check, we can enter the guest although power_off
is set. Let's check the power_off state in the critical section,
just before entering the guest.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

---

v2 -> v3:
- reword commit message
---
 arch/arm/kvm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9d16f76..4eb59e3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -560,7 +560,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			run->exit_reason = KVM_EXIT_INTR;
 		}
 
-		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
+		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm) ||
+			vcpu->arch.power_off) {
 			local_irq_enable();
 			kvm_timer_sync_hwstate(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
-- 
1.9.1
