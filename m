From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Nov 2017 17:41:16 +0100
Subject: [PATCH v2 16/16] KVM: arm/arm64: Move vcpu_load call after
 kvm_vcpu_first_run_init
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Message-ID: <20171129164116.16167-17-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving the call to vcpu_load() in kvm_arch_vcpu_ioctl_run() to after
we've called kvm_vcpu_first_run_init() simplifies some of the vgic and
there is also no need to do vcpu_load() for things such as handling the
immediate_exit flag.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c     |  4 ----
 virt/kvm/arm/arm.c            | 12 +++++-------
 virt/kvm/arm/vgic/vgic-init.c | 11 -----------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 4151250..801fecf 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -839,11 +839,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 		return ret;
 
 no_vgic:
-	preempt_disable();
 	timer->enabled = 1;
-	kvm_timer_vcpu_load_vgic(vcpu);
-	preempt_enable();
-
 	return 0;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a760ef1..991f1aa 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -622,8 +622,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
-	vcpu_load(vcpu);
-
 	ret = kvm_vcpu_first_run_init(vcpu);
 	if (ret)
 		goto out;
@@ -631,13 +629,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-	if (run->immediate_exit) {
-		ret = -EINTR;
-		goto out;
-	}
+	if (run->immediate_exit)
+		return -EINTR;
+
+	vcpu_load(vcpu);
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 6231012..a0688ef 100644
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
2.7.4
