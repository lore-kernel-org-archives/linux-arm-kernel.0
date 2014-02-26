From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Feb 2014 18:47:36 +0000
Subject: [PATCH] arm/arm64: KVM: detect CPU reset on CPU_PM_EXIT
Message-ID: <1393440456-2177-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1fcf7ce0c602 (arm: kvm: implement CPU PM notifier) added
support for CPU power-management, using a cpu_notifier to re-init
KVM on a CPU that entered CPU idle.

The code assumed that a CPU entering idle would actually be powered
off, loosing its state entierely, and would then need to be
reinitialized. It turns out that this is not always the case, and
some HW performs CPU PM without actually killing the core. In this
case, we try to reinitialize KVM while it is still live. It ends up
badly, as reported by Andre Przywara (using a Calxeda Midway):

[    3.663897] Kernel panic - not syncing: unexpected prefetch abort in Hyp mode at: 0x685760
[    3.663897] unexpected data abort in Hyp mode at: 0xc067d150
[    3.663897] unexpected HVC/SVC trap in Hyp mode at: 0xc0901dd0

The trick here is to detect if we've been through a full re-init or
not by looking at HVBAR (VBAR_EL2 on arm64). This involves
implementing the backend for __hyp_get_vectors in the main KVM HYP
code (rather small), and checking the return value against the
default one when the CPU notifier is called on CPU_PM_EXIT.

Reported-by: Andre Przywara <osp@andrep.de>
Tested-by: Andre Przywara <osp@andrep.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <rob.herring@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
Paulo, Gleb,

Can you please queue this as a fix for 3.14?

It fixes an issue that has been introduced during the merge window,
and it would be good to have it plugged quickly.

Thanks,

	M.

 arch/arm/kvm/arm.c        |  3 ++-
 arch/arm/kvm/interrupts.S | 11 ++++++++++-
 arch/arm64/kvm/hyp.S      | 27 +++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 1d8248e..bd18bb8 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -878,7 +878,8 @@ static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
+	if (cmd == CPU_PM_EXIT &&
+	    __hyp_get_vectors() == hyp_default_vectors) {
 		cpu_init_hyp_mode(NULL);
 		return NOTIFY_OK;
 	}
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index ddc1553..0d68d40 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -220,6 +220,10 @@ after_vfp_restore:
  * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
  * passed in r0 and r1.
  *
+ * A function pointer with a value of 0xffffffff has a special meaning,
+ * and is used to implement __hyp_get_vectors in the same way as in
+ * arch/arm/kernel/hyp_stub.S.
+ *
  * The calling convention follows the standard AAPCS:
  *   r0 - r3: caller save
  *   r12:     caller save
@@ -363,6 +367,11 @@ hyp_hvc:
 host_switch_to_hyp:
 	pop	{r0, r1, r2}
 
+	/* Check for __hyp_get_vectors */
+	cmp	r0, #-1
+	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
+	beq	1f
+
 	push	{lr}
 	mrs	lr, SPSR
 	push	{lr}
@@ -378,7 +387,7 @@ THUMB(	orr	lr, #1)
 	pop	{lr}
 	msr	SPSR_csxf, lr
 	pop	{lr}
-	eret
+1:	eret
 
 guest_trap:
 	load_vcpu			@ Load VCPU pointer to r0
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 3b47c36..2c56012 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -694,6 +694,24 @@ __hyp_panic_str:
 
 	.align	2
 
+/*
+ * u64 kvm_call_hyp(void *hypfn, ...);
+ *
+ * This is not really a variadic function in the classic C-way and care must
+ * be taken when calling this to ensure parameters are passed in registers
+ * only, since the stack will change between the caller and the callee.
+ *
+ * Call the function with the first argument containing a pointer to the
+ * function you wish to call in Hyp mode, and subsequent arguments will be
+ * passed as x0, x1, and x2 (a maximum of 3 arguments in addition to the
+ * function pointer can be passed).  The function being called must be mapped
+ * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
+ * passed in r0 and r1.
+ *
+ * A function pointer with a value of 0 has a special meaning, and is
+ * used to implement __hyp_get_vectors in the same way as in
+ * arch/arm64/kernel/hyp_stub.S.
+ */
 ENTRY(kvm_call_hyp)
 	hvc	#0
 	ret
@@ -737,7 +755,12 @@ el1_sync:					// Guest trapped into EL2
 	pop	x2, x3
 	pop	x0, x1
 
-	push	lr, xzr
+	/* Check for __hyp_get_vectors */
+	cbnz	x0, 1f
+	mrs	x0, vbar_el2
+	b	2f
+
+1:	push	lr, xzr
 
 	/*
 	 * Compute the function address in EL2, and shuffle the parameters.
@@ -750,7 +773,7 @@ el1_sync:					// Guest trapped into EL2
 	blr	lr
 
 	pop	lr, xzr
-	eret
+2:	eret
 
 el1_trap:
 	/*
-- 
1.8.3.4
