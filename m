From: andre.przywara@linaro.org (Andre Przywara)
Date: Sat,  1 Jun 2013 00:39:12 +0200
Subject: [PATCH] ARM/KVM: save and restore generic timer registers
Message-ID: <1370039952-20888-1-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For migration to work we need to save (and later restore) the state of
each cores virtual generic timer.
Since this is per VCPU, we can use the [gs]et_one_reg ioctl and just
need to add the three registers (control, counter, compare value) to
the list of saved registers. However we provide special accessor
functions to get the value of each register, since the content can
change anytime.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 arch/arm/include/asm/kvm_asm.h  |  7 ++++++-
 arch/arm/include/asm/kvm_host.h |  3 +++
 arch/arm/include/uapi/asm/kvm.h | 16 ++++++++++++++++
 arch/arm/kvm/arch_timer.c       | 32 ++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc.c           | 30 ++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 18d5032..a732b17 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -46,7 +46,12 @@
 #define c13_TID_URO	24	/* Thread ID, User R/O */
 #define c13_TID_PRIV	25	/* Thread ID, Privileged */
 #define c14_CNTKCTL	26	/* Timer Control Register (PL1) */
-#define NR_CP15_REGS	27	/* Number of regs (incl. invalid) */
+#define c14_CNTV_CTL	27	/* Virtual Timer Control Register */
+#define c14_CNTVCT	28	/* Virtual Timer Counter Register */
+#define c14_CNTVCT_high	29	/* Virtual Timer Counter Register */
+#define c14_CNTV_CVAL	30	/* Virtual Timer Counter Register */
+#define c14_CNTV_CVAL_high	31	/* Virtual Timer Counter Register */
+#define NR_CP15_REGS	32	/* Number of regs (incl. invalid) */
 
 #define ARM_EXCEPTION_RESET	  0
 #define ARM_EXCEPTION_UNDEFINED   1
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 57cb786..80714ab 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -224,4 +224,7 @@ static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
 
+u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, const struct kvm_one_reg *);
+void kvm_arm_timer_set_reg(struct kvm_vcpu *, const struct kvm_one_reg *, u64);
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index c1ee007..e3b0115 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -118,6 +118,22 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
 #define KVM_REG_ARM_32_CRN_SHIFT	11
 
+#define KVM_REG_ARM_32_CP15		(KVM_REG_ARM | KVM_REG_SIZE_U32      | \
+					(15ULL << KVM_REG_ARM_COPROC_SHIFT))
+#define KVM_REG_ARM_64_CP15		(KVM_REG_ARM | KVM_REG_SIZE_U64      | \
+					(15ULL << KVM_REG_ARM_COPROC_SHIFT))
+#define KVM_REG_ARM_TIMER_CTL		(KVM_REG_ARM_32_CP15                 | \
+					( 3ULL << KVM_REG_ARM_CRM_SHIFT)     | \
+					(14ULL << KVM_REG_ARM_32_CRN_SHIFT)  | \
+					( 0ULL << KVM_REG_ARM_OPC1_SHIFT)    | \
+					( 1ULL << KVM_REG_ARM_32_OPC2_SHIFT))
+#define KVM_REG_ARM_TIMER_CNT		(KVM_REG_ARM_64_CP15 | \
+					(14ULL << KVM_REG_ARM_CRM_SHIFT)     | \
+					( 1ULL << KVM_REG_ARM_OPC1_SHIFT))
+#define KVM_REG_ARM_TIMER_CVAL		(KVM_REG_ARM_64_CP15 | \
+					(14ULL << KVM_REG_ARM_CRM_SHIFT)     | \
+					( 3ULL << KVM_REG_ARM_OPC1_SHIFT))
+
 /* Normal registers are mapped as coprocessor 16. */
 #define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
 #define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
index c55b608..64a8920b 100644
--- a/arch/arm/kvm/arch_timer.c
+++ b/arch/arm/kvm/arch_timer.c
@@ -171,6 +171,38 @@ static void kvm_timer_init_interrupt(void *info)
 	enable_percpu_irq(timer_irq.irq, 0);
 }
 
+void kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu,
+			   const struct kvm_one_reg *reg, u64 val)
+{
+	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+
+	switch (reg->id) {
+	case KVM_REG_ARM_TIMER_CTL:
+		timer->cntv_ctl = val;
+		break;
+	case KVM_REG_ARM_TIMER_CNT:
+		vcpu->kvm->arch.timer.cntvoff = kvm_phys_timer_read() - val;
+		break;
+	case KVM_REG_ARM_TIMER_CVAL:
+		timer->cntv_cval = val;
+		break;
+	}
+}
+
+u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+
+	switch (reg->id) {
+	case KVM_REG_ARM_TIMER_CTL:
+		return timer->cntv_ctl;
+	case KVM_REG_ARM_TIMER_CNT:
+		return kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
+	case KVM_REG_ARM_TIMER_CVAL:
+		return timer->cntv_cval;
+	}
+	return 0;
+}
 
 static int kvm_timer_cpu_notify(struct notifier_block *self,
 				unsigned long action, void *cpu)
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 8eea97b..63b2e89 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -156,6 +156,8 @@ static const struct coproc_reg cp15_regs[] = {
 	/* TTBR0/TTBR1: swapped by interrupt.S. */
 	{ CRm( 2), Op1( 0), is64, NULL, reset_unknown64, c2_TTBR0 },
 	{ CRm( 2), Op1( 1), is64, NULL, reset_unknown64, c2_TTBR1 },
+	{ CRm(14), Op1( 1), is64, NULL, reset_unknown64, c14_CNTVCT},
+	{ CRm(14), Op1( 3), is64, NULL, reset_unknown64, c14_CNTV_CVAL},
 
 	/* TTBCR: swapped by interrupt.S. */
 	{ CRn( 2), CRm( 0), Op1( 0), Op2( 2), is32,
@@ -226,6 +228,8 @@ static const struct coproc_reg cp15_regs[] = {
 	/* CNTKCTL: swapped by interrupt.S. */
 	{ CRn(14), CRm( 1), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c14_CNTKCTL, 0x00000000 },
+	{ CRn(14), CRm( 3), Op1( 0), Op2( 1), is32,
+			NULL, reset_val, c14_CNTV_CTL, 0x00000000 },
 };
 
 /* Target specific emulation tables */
@@ -823,10 +827,22 @@ static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
 }
 #endif /* !CONFIG_VFPv3 */
 
+static bool is_timer_reg(u64 index)
+{
+	switch (index) {
+	case KVM_REG_ARM_TIMER_CTL:
+	case KVM_REG_ARM_TIMER_CNT:
+	case KVM_REG_ARM_TIMER_CVAL:
+		return true;
+	}
+	return false;
+}
+
 int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	const struct coproc_reg *r;
 	void __user *uaddr = (void __user *)(long)reg->addr;
+	u64 val;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_get(reg->id, uaddr);
@@ -834,6 +850,11 @@ int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_VFP)
 		return vfp_get_reg(vcpu, reg->id, uaddr);
 
+	if (is_timer_reg(reg->id)) {
+		val = kvm_arm_timer_get_reg(vcpu, reg);
+		return reg_to_user(uaddr, &val, reg->id);
+	}
+
 	r = index_to_coproc_reg(vcpu, reg->id);
 	if (!r)
 		return get_invariant_cp15(reg->id, uaddr);
@@ -846,6 +867,8 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	const struct coproc_reg *r;
 	void __user *uaddr = (void __user *)(long)reg->addr;
+	u64 val;
+	int ret;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_set(reg->id, uaddr);
@@ -853,6 +876,13 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_VFP)
 		return vfp_set_reg(vcpu, reg->id, uaddr);
 
+	if (is_timer_reg(reg->id)) {
+		ret = reg_from_user(&val, uaddr, reg->id);
+		if (ret == 0)
+			kvm_arm_timer_set_reg(vcpu, reg, val);
+		return ret;
+	}
+
 	r = index_to_coproc_reg(vcpu, reg->id);
 	if (!r)
 		return set_invariant_cp15(reg->id, uaddr);
-- 
1.7.12.1
