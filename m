From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 12 Jan 2018 13:07:08 +0100
Subject: [PATCH v3 02/41] KVM: arm/arm64: Move vcpu_load call after
 kvm_vcpu_first_run_init
In-Reply-To: <20180112120747.27999-1-christoffer.dall@linaro.org>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
Message-ID: <20180112120747.27999-3-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving the call to vcpu_load() in kvm_arch_vcpu_ioctl_run() to after
we've called kvm_vcpu_first_run_init() simplifies some of the vgic and
there is also no need to do vcpu_load() for things such as handling the
immediate_exit flag.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c     |  7 -------
 virt/kvm/arm/arm.c            | 22 ++++++++--------------
 virt/kvm/arm/vgic/vgic-init.c | 11 -----------
 3 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index cfcd0323deab..c09c701fd68e 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -834,14 +834,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 		return ret;
 
 no_vgic:
-	preempt_disable();
 	timer->enabled = 1;
-	if (!irqchip_in_kernel(vcpu->kvm))
-		kvm_timer_vcpu_load_user(vcpu);
-	else
-		kvm_timer_vcpu_load_vgic(vcpu);
-	preempt_enable();
-
 	return 0;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 5e3c149a6e28..360df72692ee 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -631,27 +631,22 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
-	vcpu_load(vcpu);
-
 	ret = kvm_vcpu_first_run_init(vcpu);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
 		if (ret)
-			goto out;
-		if (kvm_arm_handle_step_debug(vcpu, vcpu->run)) {
-			ret = 0;
-			goto out;
-		}
-
+			return ret;
+		if (kvm_arm_handle_step_debug(vcpu, vcpu->run))
+			return 0;
 	}
 
-	if (run->immediate_exit) {
-		ret = -EINTR;
-		goto out;
-	}
+	if (run->immediate_exit)
+		return -EINTR;
+
+	vcpu_load(vcpu);
 
 	kvm_sigset_activate(vcpu);
 
@@ -803,7 +798,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	kvm_sigset_deactivate(vcpu);
 
-out:
 	vcpu_put(vcpu);
 	return ret;
 }
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 62310122ee78..a0688ef52ad7 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -300,17 +300,6 @@ int vgic_init(struct kvm *kvm)
 
 	dist->initialized = true;
 
-	/*
-	 * If we're initializing GICv2 on-demand when first running the VCPU
-	 * then we need to load the VGIC state onto the CPU.  We can detect
-	 * this easily by checking if we are in between vcpu_load and vcpu_put
-	 * when we just initialized the VGIC.
-	 */
-	preempt_disable();
-	vcpu = kvm_arm_get_running_vcpu();
-	if (vcpu)
-		kvm_vgic_load(vcpu);
-	preempt_enable();
 out:
 	return ret;
 }
-- 
2.14.2
