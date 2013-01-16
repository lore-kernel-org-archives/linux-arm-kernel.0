From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:58:58 -0500
Subject: [PATCH v6 11/15] KVM: ARM: VFP userspace interface
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175858.29147.76940.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rusty Russell <rusty.russell@linaro.org>

We use space #18 for floating point regs.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt |    6 +
 arch/arm/include/uapi/asm/kvm.h   |   12 ++
 arch/arm/kvm/coproc.c             |  178 +++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 94f17a3..38066a7a 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1808,6 +1808,12 @@ ARM 64-bit CP15 registers have the following id bit patterns:
 ARM CCSIDR registers are demultiplexed by CSSELR value:
   0x4002 0000 0011 00 <csselr:8>
 
+ARM 32-bit VFP control registers have the following id bit patterns:
+  0x4002 0000 0012 1 <regno:12>
+
+ARM 64-bit FP registers have the following id bit patterns:
+  0x4002 0000 0012 0 <regno:12>
+
 4.69 KVM_GET_ONE_REG
 
 Capability: KVM_CAP_ONE_REG
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 71ae27e..bbb6b23 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -112,6 +112,18 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
 #define KVM_REG_ARM_DEMUX_VAL_SHIFT	0
 
+/* VFP registers: we could overload CP10 like ARM does, but that's ugly. */
+#define KVM_REG_ARM_VFP			(0x0012 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_VFP_MASK		0x000000000000FFFF
+#define KVM_REG_ARM_VFP_BASE_REG	0x0
+#define KVM_REG_ARM_VFP_FPSID		0x1000
+#define KVM_REG_ARM_VFP_FPSCR		0x1001
+#define KVM_REG_ARM_VFP_MVFR1		0x1006
+#define KVM_REG_ARM_VFP_MVFR0		0x1007
+#define KVM_REG_ARM_VFP_FPEXC		0x1008
+#define KVM_REG_ARM_VFP_FPINST		0x1009
+#define KVM_REG_ARM_VFP_FPINST2		0x100A
+
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 1827b64..d782638 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -26,6 +26,8 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <trace/events/kvm.h>
+#include <asm/vfp.h>
+#include "../vfp/vfpinstr.h"
 
 #include "trace.h"
 #include "coproc.h"
@@ -653,6 +655,170 @@ static int demux_c15_set(u64 id, void __user *uaddr)
 	}
 }
 
+#ifdef CONFIG_VFPv3
+static const int vfp_sysregs[] = { KVM_REG_ARM_VFP_FPEXC,
+				   KVM_REG_ARM_VFP_FPSCR,
+				   KVM_REG_ARM_VFP_FPINST,
+				   KVM_REG_ARM_VFP_FPINST2,
+				   KVM_REG_ARM_VFP_MVFR0,
+				   KVM_REG_ARM_VFP_MVFR1,
+				   KVM_REG_ARM_VFP_FPSID };
+
+static unsigned int num_fp_regs(void)
+{
+	if (((fmrx(MVFR0) & MVFR0_A_SIMD_MASK) >> MVFR0_A_SIMD_BIT) == 2)
+		return 32;
+	else
+		return 16;
+}
+
+static unsigned int num_vfp_regs(void)
+{
+	/* Normal FP regs + control regs. */
+	return num_fp_regs() + ARRAY_SIZE(vfp_sysregs);
+}
+
+static int copy_vfp_regids(u64 __user *uindices)
+{
+	unsigned int i;
+	const u64 u32reg = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_VFP;
+	const u64 u64reg = KVM_REG_ARM | KVM_REG_SIZE_U64 | KVM_REG_ARM_VFP;
+
+	for (i = 0; i < num_fp_regs(); i++) {
+		if (put_user((u64reg | KVM_REG_ARM_VFP_BASE_REG) + i,
+			     uindices))
+			return -EFAULT;
+		uindices++;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(vfp_sysregs); i++) {
+		if (put_user(u32reg | vfp_sysregs[i], uindices))
+			return -EFAULT;
+		uindices++;
+	}
+
+	return num_vfp_regs();
+}
+
+static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
+{
+	u32 vfpid = (id & KVM_REG_ARM_VFP_MASK);
+	u32 val;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	if (vfpid < num_fp_regs()) {
+		if (KVM_REG_SIZE(id) != 8)
+			return -ENOENT;
+		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpregs[vfpid],
+				   id);
+	}
+
+	/* FP control registers are all 32 bit. */
+	if (KVM_REG_SIZE(id) != 4)
+		return -ENOENT;
+
+	switch (vfpid) {
+	case KVM_REG_ARM_VFP_FPEXC:
+		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpexc, id);
+	case KVM_REG_ARM_VFP_FPSCR:
+		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpscr, id);
+	case KVM_REG_ARM_VFP_FPINST:
+		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst, id);
+	case KVM_REG_ARM_VFP_FPINST2:
+		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst2, id);
+	case KVM_REG_ARM_VFP_MVFR0:
+		val = fmrx(MVFR0);
+		return reg_to_user(uaddr, &val, id);
+	case KVM_REG_ARM_VFP_MVFR1:
+		val = fmrx(MVFR1);
+		return reg_to_user(uaddr, &val, id);
+	case KVM_REG_ARM_VFP_FPSID:
+		val = fmrx(FPSID);
+		return reg_to_user(uaddr, &val, id);
+	default:
+		return -ENOENT;
+	}
+}
+
+static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
+{
+	u32 vfpid = (id & KVM_REG_ARM_VFP_MASK);
+	u32 val;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	if (vfpid < num_fp_regs()) {
+		if (KVM_REG_SIZE(id) != 8)
+			return -ENOENT;
+		return reg_from_user(&vcpu->arch.vfp_guest.fpregs[vfpid],
+				     uaddr, id);
+	}
+
+	/* FP control registers are all 32 bit. */
+	if (KVM_REG_SIZE(id) != 4)
+		return -ENOENT;
+
+	switch (vfpid) {
+	case KVM_REG_ARM_VFP_FPEXC:
+		return reg_from_user(&vcpu->arch.vfp_guest.fpexc, uaddr, id);
+	case KVM_REG_ARM_VFP_FPSCR:
+		return reg_from_user(&vcpu->arch.vfp_guest.fpscr, uaddr, id);
+	case KVM_REG_ARM_VFP_FPINST:
+		return reg_from_user(&vcpu->arch.vfp_guest.fpinst, uaddr, id);
+	case KVM_REG_ARM_VFP_FPINST2:
+		return reg_from_user(&vcpu->arch.vfp_guest.fpinst2, uaddr, id);
+	/* These are invariant. */
+	case KVM_REG_ARM_VFP_MVFR0:
+		if (reg_from_user(&val, uaddr, id))
+			return -EFAULT;
+		if (val != fmrx(MVFR0))
+			return -EINVAL;
+		return 0;
+	case KVM_REG_ARM_VFP_MVFR1:
+		if (reg_from_user(&val, uaddr, id))
+			return -EFAULT;
+		if (val != fmrx(MVFR1))
+			return -EINVAL;
+		return 0;
+	case KVM_REG_ARM_VFP_FPSID:
+		if (reg_from_user(&val, uaddr, id))
+			return -EFAULT;
+		if (val != fmrx(FPSID))
+			return -EINVAL;
+		return 0;
+	default:
+		return -ENOENT;
+	}
+}
+#else /* !CONFIG_VFPv3 */
+static unsigned int num_vfp_regs(void)
+{
+	return 0;
+}
+
+static int copy_vfp_regids(u64 __user *uindices)
+{
+	return 0;
+}
+
+static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
+{
+	return -ENOENT;
+}
+
+static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
+{
+	return -ENOENT;
+}
+#endif /* !CONFIG_VFPv3 */
+
 int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	const struct coproc_reg *r;
@@ -661,6 +827,9 @@ int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_get(reg->id, uaddr);
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_VFP)
+		return vfp_get_reg(vcpu, reg->id, uaddr);
+
 	r = index_to_coproc_reg(vcpu, reg->id);
 	if (!r)
 		return get_invariant_cp15(reg->id, uaddr);
@@ -677,6 +846,9 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_set(reg->id, uaddr);
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_VFP)
+		return vfp_set_reg(vcpu, reg->id, uaddr);
+
 	r = index_to_coproc_reg(vcpu, reg->id);
 	if (!r)
 		return set_invariant_cp15(reg->id, uaddr);
@@ -788,6 +960,7 @@ unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu *vcpu)
 {
 	return ARRAY_SIZE(invariant_cp15)
 		+ num_demux_regs()
+		+ num_vfp_regs()
 		+ walk_cp15(vcpu, (u64 __user *)NULL);
 }
 
@@ -808,6 +981,11 @@ int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 		return err;
 	uindices += err;
 
+	err = copy_vfp_regids(uindices);
+	if (err < 0)
+		return err;
+	uindices += err;
+
 	return write_demux_regids(uindices);
 }
 
