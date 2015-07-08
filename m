From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Jul 2015 18:56:34 +0100
Subject: [PATCH v2 02/10] arm/arm64: KVM: Move vgic handling to a
 non-preemptible section
In-Reply-To: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
References: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436378202-20224-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to introduce some serious GIC-poking to the vgic code,
it is important to make sure that we're going to poke the part of
the GIC that belongs to the CPU we're about to run on (otherwise,
we'd end up with some unexpected interrupts firing)...

Introducing a non-preemptible section in kvm_arch_vcpu_ioctl_run
prevents the problem from occuring.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm/kvm/arm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d605180..1583a34 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -528,10 +528,20 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
@@ -544,8 +554,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
-			preempt_enable();
 			kvm_vgic_sync_hwstate(vcpu);
+			preempt_enable();
 			kvm_timer_sync_hwstate(vcpu);
 			continue;
 		}
@@ -586,9 +596,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
