From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Jul 2015 18:56:33 +0100
Subject: [PATCH v2 01/10] arm/arm64: KVM: Fix ordering of timer/GIC on guest
 entry
In-Reply-To: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
References: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436378202-20224-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we now inject the timer interrupt when we're about to enter
the guest, it makes a lot more sense to make sure this happens
before the vgic code queues the pending interrupts.

Otherwise, we get the interrupt on the following exit, which is
not great for latency (and leads to all kind of bizarre issues
when using with active interrupts at the HW level).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index bc738d2..d605180 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -528,8 +528,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (vcpu->arch.pause)
 			vcpu_pause(vcpu);
 
-		kvm_vgic_flush_hwstate(vcpu);
 		kvm_timer_flush_hwstate(vcpu);
+		kvm_vgic_flush_hwstate(vcpu);
 
 		preempt_disable();
 		local_irq_disable();
@@ -545,8 +545,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
 			preempt_enable();
-			kvm_timer_sync_hwstate(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
+			kvm_timer_sync_hwstate(vcpu);
 			continue;
 		}
 
@@ -588,9 +588,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		trace_kvm_exit(kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
 		preempt_enable();
 
-
-		kvm_timer_sync_hwstate(vcpu);
 		kvm_vgic_sync_hwstate(vcpu);
+		kvm_timer_sync_hwstate(vcpu);
 
 		ret = handle_exit(vcpu, run, ret);
 	}
-- 
2.1.4
