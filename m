From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jul 2015 16:55:00 +0100
Subject: [PATCH v3 02/11] arm/arm64: KVM: Move vgic handling to a
 non-preemptible section
In-Reply-To: <1437753309-17989-1-git-send-email-marc.zyngier@arm.com>
References: <1437753309-17989-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1437753309-17989-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to introduce some serious GIC-poking to the vgic code,
it is important to make sure that we're going to poke the part of
the GIC that belongs to the CPU we're about to run on (otherwise,
we'd end up with some unexpected interrupts firing)...

Introducing a non-preemptible section in kvm_arch_vcpu_ioctl_run
prevents the problem from occuring.

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 1141d21..f1bf418 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -523,10 +523,20 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (vcpu->arch.pause)
 			vcpu_pause(vcpu);
 
+		/*
+		 * Disarming the background timer must be done in a
+		 * preemptible context, as this call may sleep.
+		 */
 		kvm_timer_flush_hwstate(vcpu);
-		kvm_vgic_flush_hwstate(vcpu);
 
+		/*
+		 * Preparing the interrupts to be injected also
+		 * involves poking the GIC, which must be done in a
+		 * non-preemptible context.
+		 */
 		preempt_disable();
+		kvm_vgic_flush_hwstate(vcpu);
+
 		local_irq_disable();
 
 		/*
@@ -539,8 +549,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
-			preempt_enable();
 			kvm_vgic_sync_hwstate(vcpu);
+			preempt_enable();
 			kvm_timer_sync_hwstate(vcpu);
 			continue;
 		}
@@ -585,9 +595,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 */
 		kvm_guest_exit();
 		trace_kvm_exit(kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
-		preempt_enable();
 
 		kvm_vgic_sync_hwstate(vcpu);
+
+		preempt_enable();
+
 		kvm_timer_sync_hwstate(vcpu);
 
 		ret = handle_exit(vcpu, run, ret);
-- 
2.1.4
