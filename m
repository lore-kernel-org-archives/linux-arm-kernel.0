From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  8 Jan 2014 14:47:28 -0800
Subject: [PATCH 3/5] arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive
In-Reply-To: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
References: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1389221250-30034-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current KVM implementation of PSCI returns INVALID_PARAMETERS if the
waitqueue for the corresponding CPU is not active.  This does not seem
correct, since KVM should not care what the specific thread is doing,
for example, user space may not have called KVM_RUN on this VCPU yet or
the thread may be busy looping to user space because it received a
signal; this is really up to the user space implementation.  Instead we
should check specifically that the CPU is marked as being turned off,
regardless of the VCPU thread state, and if it is, we shall
simply clear the pause flag on the CPU and wake up the thread if it
happens to be blocked for us.

Further, the implementation seems to be racy when executing multiple
VCPU threads.  There really isn't a reasonable user space programming
scheme to ensure all secondary CPUs have reached kvm_vcpu_first_run_init
before turning on the boot CPU.

Therefore, set the pause flag on the vcpu at VCPU init time (which can
reasonably be expected to be completed for all CPUs by user space before
running any VCPUs) and clear both this flag and the feature (in case the
feature can somehow get set again in the future) and ping the waitqueue
on turning on a VCPU using PSCI.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c  | 30 +++++++++++++++++++-----------
 arch/arm/kvm/psci.c | 11 ++++++-----
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2a700e0..151eb91 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -478,15 +478,6 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	/*
-	 * Handle the "start in power-off" case by calling into the
-	 * PSCI code.
-	 */
-	if (test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features)) {
-		*vcpu_reg(vcpu, 0) = KVM_PSCI_FN_CPU_OFF;
-		kvm_psci_call(vcpu);
-	}
-
 	return 0;
 }
 
@@ -700,6 +691,24 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return -EINVAL;
 }
 
+static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
+					 struct kvm_vcpu_init *init)
+{
+	int ret;
+
+	ret = kvm_vcpu_set_target(vcpu, init);
+	if (ret)
+		return ret;
+
+	/*
+	 * Handle the "start in power-off" case by marking the VCPU as paused.
+	 */
+	if (__test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
+		vcpu->arch.pause = true;
+
+	return 0;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -713,8 +722,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&init, argp, sizeof(init)))
 			return -EFAULT;
 
-		return kvm_vcpu_set_target(vcpu, &init);
-
+		return kvm_arch_vcpu_ioctl_vcpu_init(vcpu, &init);
 	}
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 0881bf1..448f60e 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -54,15 +54,15 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 		}
 	}
 
-	if (!vcpu)
+	/*
+	 * Make sure the caller requested a valid CPU and that the CPU is
+	 * turned off.
+	 */
+	if (!vcpu || !vcpu->arch.pause)
 		return KVM_PSCI_RET_INVAL;
 
 	target_pc = *vcpu_reg(source_vcpu, 2);
 
-	wq = kvm_arch_vcpu_wq(vcpu);
-	if (!waitqueue_active(wq))
-		return KVM_PSCI_RET_INVAL;
-
 	kvm_reset_vcpu(vcpu);
 
 	/* Gracefully handle Thumb2 entry point */
@@ -79,6 +79,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	vcpu->arch.pause = false;
 	smp_mb();		/* Make sure the above is visible */
 
+	wq = kvm_arch_vcpu_wq(vcpu);
 	wake_up_interruptible(wq);
 
 	return KVM_PSCI_RET_SUCCESS;
-- 
1.8.5.2
