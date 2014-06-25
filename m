From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Jun 2014 10:28:49 +0100
Subject: [RFC PATCH 8/9] arm: KVM: timer: move the timer switch into the
 non-preemptible section
In-Reply-To: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
References: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403688530-23273-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to convert the timer code to the new interrupt save/restore API,
make sure the timer switch is done in a non-premtible section, so that
we save/restore the state on the right CPU.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a291e63..92875b2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -554,9 +554,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			vcpu_pause(vcpu);
 
 		kvm_vgic_flush_hwstate(vcpu);
-		kvm_timer_flush_hwstate(vcpu);
 
 		local_irq_disable();
+		kvm_timer_flush_hwstate(vcpu);
 
 		/*
 		 * Re-check atomic conditions
@@ -567,8 +567,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		}
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
-			local_irq_enable();
 			kvm_timer_sync_hwstate(vcpu);
+			local_irq_enable();
 			kvm_vgic_sync_hwstate(vcpu);
 			continue;
 		}
@@ -586,6 +586,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu->arch.last_pcpu = smp_processor_id();
 		kvm_guest_exit();
 		trace_kvm_exit(*vcpu_pc(vcpu));
+		kvm_timer_sync_hwstate(vcpu);
+
 		/*
 		 * We may have taken a host interrupt in HYP mode (ie
 		 * while executing the guest). This interrupt is still
@@ -602,7 +604,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Back from guest
 		 *************************************************************/
 
-		kvm_timer_sync_hwstate(vcpu);
 		kvm_vgic_sync_hwstate(vcpu);
 
 		ret = handle_exit(vcpu, run, ret);
-- 
1.8.3.4
