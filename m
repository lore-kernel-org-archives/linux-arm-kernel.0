From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 25 Apr 2016 17:41:11 +0900
Subject: [PATCH v7 07/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <571765D1.9070207@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-8-git-send-email-james.morse@arm.com>
 <571656E9.5050402@arm.com> <57166CC9.4030804@arm.com>
 <57175BD7.30902@arm.com> <571765D1.9070207@arm.com>
Message-ID: <20160425084111.GA19515@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 12:19:45PM +0100, James Morse wrote:
> Hi Marc,
> 
> On 20/04/16 11:37, Marc Zyngier wrote:
> > On 19/04/16 18:37, James Morse wrote:
> >> It looks like x86 uses the extable to work around this, their vmx_vcpu_run() has:
> >>> 		__ex(ASM_VMX_VMLAUNCH) "\n\t"
> >> Where __ex ends up calling ____kvm_handle_fault_on_reboot(), with a nearby comment:
> >>> * Hardware virtualization extension instructions may fault if a
> >>> * reboot turns off virtualization while processes are running.
> >>> * Trap the fault and ignore the instruction if that happens.
> > 
> > I very much like that approach, to be honest. Tearing down a CPU is
> > something exceptional, so let's make it an actual exception.
> >
> > It is now pretty easy to discriminate between KVM functions and stub
> > functions thanks to your earlier patch, so if we end up calling the
> > hyp-stub because we've torn down KVM's EL2, let's just return an
> > appropriate error code (ARM_EXCEPTION_HYP_GONE), and handle it at EL1.
> 
> Okay. kexec uses kvm_call_hyp() against the hyp-stub to do the kernel-copy and
> hand over to purgatory, but we could change that to a new 'special' builtin
> call, something like HVC_KEXEC_CALL_HYP. It never calls it with kvm loaded, so
> there is no reason the calls have to be same.
> 
> Given hibernate doesn't hit this issue, I will drop this hunk from this version
> of the patch, and repost hibernate incorporating the feedback so far. I will
> provide a patch for kexec to do the above.

Thanks, but you don' have to.
If the fix below is acceptable, we will merge it to our next kexec/kdump
patch series.

-Takahiro AKASHI

> Thanks,
> 
> James


>From d70cf5d3202d819bd7f8c9072c61da783bf07b40 Mon Sep 17 00:00:00 2001
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Mon, 25 Apr 2016 17:29:55 +0900
Subject: [PATCH] arm64: kvm: (experimental) fix kexec exception due to kexec
 reoot

---
 arch/arm/kvm/arm.c               |  8 +-------
 arch/arm64/include/asm/kvm_asm.h |  1 +
 arch/arm64/include/asm/virt.h    |  5 +++++
 arch/arm64/kernel/cpu-reset.S    |  5 +----
 arch/arm64/kernel/hyp-stub.S     | 14 ++++++++++++--
 arch/arm64/kvm/handle_exit.c     |  4 ++++
 6 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 962904a..0e92787 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -587,13 +587,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		/*
 		 * Re-check atomic conditions
 		 */
-		if (unlikely(!__this_cpu_read(kvm_arm_hardware_enabled))) {
-			/* cpu has been torn down */
-			ret = 0;
-			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
-			run->fail_entry.hardware_entry_failure_reason
-					= (u64)-ENOEXEC;
-		} else if (signal_pending(current)) {
+		if (signal_pending(current)) {
 			ret = -EINTR;
 			run->exit_reason = KVM_EXIT_INTR;
 		}
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index ebc8d0e..7f653ad 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -22,6 +22,7 @@
 
 #define ARM_EXCEPTION_IRQ	  0
 #define ARM_EXCEPTION_TRAP	  1
+#define ARM_EXCEPTION_HYP_GONE	  2
 
 #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
 #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index d406d2e..9079661 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -34,6 +34,11 @@
  */
 #define HVC_SET_VECTORS 1
 
+/*
+ * HVC_KEXEC_RESTART
+ */
+#define HVC_KEXEC_RESTART 2
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 11a5bc6..4d35331 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -41,10 +41,7 @@ ENTRY(__cpu_soft_restart)
 	isb
 
 	cbz	x0, 1f				// el2_switch?
-	mov	x0, x1				// entry
-	mov	x1, x2				// arg0
-	mov	x2, x3				// arg1
-	mov	x3, x4				// arg2
+	mov	x0, #HVC_KEXEC_RESTART
 	hvc	#0				// no return
 
 1:	mov	x18, x1				// entry
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 6bba25c..7fad129 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -22,7 +22,8 @@
 #include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/assembler.h>
-#include <asm/kvm_arm.h>
+#include <asm/esr.h>
+#include <asm/kvm_asm.h>
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
@@ -70,7 +71,16 @@ el1_sync:
 	msr	vbar_el2, x1
 	b	9f
 
-2:	do_el2_call
+2:	cmp	x0, #HVC_KEXEC_RESTART
+	b.eq	3f
+	mov	x0, #ARM_EXCEPTION_HYP_GONE
+	b	9f
+
+3:	mov	lr, x1
+	mov	x0, x2
+	mov	x1, x3
+	mov	x2, x4
+	blr	lr
 
 9:	eret
 ENDPROC(el1_sync)
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index eba89e4..31b5224 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -186,6 +186,10 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		exit_handler = kvm_get_exit_handler(vcpu);
 
 		return exit_handler(vcpu, run);
+	case ARM_EXCEPTION_HYP_GONE:
+		/* due to kexec reboot */
+		run->exit_reason = KVM_EXIT_SHUTDOWN;
+		return 0;
 	default:
 		kvm_pr_unimpl("Unsupported exception type: %d",
 			      exception_index);
-- 
2.8.1
