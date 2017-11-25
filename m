From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 25 Nov 2017 21:57:04 +0100
Subject: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into arch
 specific code
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Message-ID: <20171125205718.7731-2-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for moving calls to vcpu_load() and vcpu_put() into the
architecture specific implementations of the KVM vcpu ioctls, move the
calls in the main kvm_vcpu_ioctl() dispatcher function to each case
of the ioctl select statement.  This allows us to move the vcpu_load()
and vcpu_put() calls into architecture specific implementations of vcpu
ioctls, one by one.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/kvm_main.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a245b83..fafafcc38b5a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2528,16 +2528,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 #endif
 
-
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
 	switch (ioctl) {
 	case KVM_RUN: {
 		struct pid *oldpid;
 		r = -EINVAL;
 		if (arg)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		oldpid = rcu_access_pointer(vcpu->pid);
 		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
 			/* The thread running this VCPU changed. */
@@ -2549,6 +2548,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			put_pid(oldpid);
 		}
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
+		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
@@ -2559,7 +2559,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
 		if (!kvm_regs)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out_free1;
 		r = -EFAULT;
@@ -2579,7 +2583,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
@@ -2588,7 +2596,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!kvm_sregs)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2604,13 +2616,21 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			kvm_sregs = NULL;
 			goto out;
 		}
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2625,7 +2645,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_TRANSLATE: {
@@ -2634,7 +2658,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2649,7 +2677,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&dbg, argp, sizeof(dbg)))
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_SET_SIGNAL_MASK: {
@@ -2680,7 +2712,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!fpu)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2696,14 +2732,21 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		break;
 	}
 	default:
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
+		vcpu_put(vcpu);
 	}
 out:
-	vcpu_put(vcpu);
 	kfree(fpu);
 	kfree(kvm_sregs);
 	return r;
-- 
2.14.2
