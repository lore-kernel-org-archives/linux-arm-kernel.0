From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 May 2014 09:13:59 -0700
Subject: [PATCH v3 07/14] ARM: KVM: one_reg coproc set and get BE fixes
In-Reply-To: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1399997646-4716-8-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix code that handles KVM_SET_ONE_REG, KVM_GET_ONE_REG ioctls to work in BE
image. Before this fix get/set_one_reg functions worked correctly only in
LE case - reg_from_user was taking 'void *' kernel address that actually could
be target/source memory of either 4 bytes size or 8 bytes size, and code copied
from/to user memory that could hold either 4 bytes register, 8 byte register
or pair of 4 bytes registers.

For example note that there was a case when 4 bytes register was read from
user-land to kernel target address of 8 bytes value. Because it was working
in LE, least significant word was memcpy(ied) and it just worked. In BE code
with 'void *' as target/source 'val' type it is impossible to tell whether
4 bytes register from user-land should be copied to 'val' address itself
(4 bytes target) or it should be copied to 'val' + 4 (least significant word
of 8 bytes value). So first change was to introduce strongly typed
functions, where type of target/source 'val' is strongly defined:

reg_from_user_to_u64 - reads register from user-land to kernel 'u64 *val'
                  address; register size could be 4 or 8 bytes
reg_from_user_to_u32 - reads register(s) from user-land to kernel 'u32 *val'
                  address; note it could be one or two 4 bytes registers
reg_to_user_from_u64 - writes register from kernel 'u64 *val' address to
                  user-land register memory; register size could be
                  4 or 8 bytes
ret_to_user_from_u32 - writes register(s) from kernel 'u32 *val' address to
                  user-land register(s) memory; note it could be
                  one or two 4 bytes registers

All places where reg_from_user, reg_to_user functions were used, were changed
to use either corresponding u64 or u32 variants of functions depending on
type of source/target kernel memory variable.

In case of 'u64 *val' and register size equals 4 bytes, reg_from_user_to_u64
and reg_to_user_from_u64 work only with least siginificant word of
target/source kernel value. It would be nice to deal only with u32 kernel
values in _u32 functions and with u64 kernel values in _u64 functions,
however it is not always possible because functions like set_invariant_cp15
get_invariant_cp15 store values in u64 types but registers are 32bit.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kvm/coproc.c | 118 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 26 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index c58a351..5ca6582 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -682,17 +682,83 @@ static struct coproc_reg invariant_cp15[] = {
 	{ CRn( 0), CRm( 0), Op1( 1), Op2( 7), is32, NULL, get_AIDR },
 };
 
-static int reg_from_user(void *val, const void __user *uaddr, u64 id)
+/*
+ * Reads register value from user-land uaddr address into kernel u64 value
+ * given by val address. Note register size could be 4 bytes, so user-land
+ * 4 bytes value will be copied into least significant word. Or register
+ * size could be 8 bytes, so function works as regular copy.
+ */
+static int reg_from_user_to_u64(u64 *val, const void __user *uaddr, u64 id)
+{
+	unsigned long regsize = KVM_REG_SIZE(id);
+	union {
+		u32	word;
+		u64	dword;
+	} tmp = {0};
+
+	if (copy_from_user(&tmp, uaddr, regsize) != 0)
+		return -EFAULT;
+
+	switch (regsize) {
+	case 4:
+		*val = tmp.word;
+		break;
+	case 8:
+		*val = tmp.dword;
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Reads register value from user-land uaddr address to kernel u32 value
+ * or array of two u32 values. I.e. it may really copy two u32 registers
+ * when used with register which size is 8 bytes (for example V7 64
+ * bit registers like TTBR0/TTBR1).
+ */
+static int reg_from_user_to_u32(u32 *val, const void __user *uaddr, u64 id)
 {
-	/* This Just Works because we are little endian. */
 	if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
 		return -EFAULT;
 	return 0;
 }
 
-static int reg_to_user(void __user *uaddr, const void *val, u64 id)
+/*
+ * Writes register value to user-land uaddr address from kernel u64 value
+ * given by val address. Note register size could be 4 bytes, so only 4
+ * bytes from least significant word will by copied into uaddr address.
+ * In case of 8 bytes sized register it works as regular copy. 
+ */
+static int reg_to_user_from_u64(void __user *uaddr, const u64 *val, u64 id)
+{
+	unsigned long regsize = KVM_REG_SIZE(id);
+	union {
+		u32	word;
+		u64	dword;
+	} tmp;
+
+	switch (regsize) {
+	case 4:
+		tmp.word = *val;
+		break;
+	case 8:
+		tmp.dword = *val;
+		break;
+	}
+
+	if (copy_to_user(uaddr, &tmp, regsize) != 0)
+		return -EFAULT;
+	return 0;
+}
+
+/*
+ * Writes register value to user-land uaddr address from kernel u32 value
+ * or arra of two u32 values. I.e it may really copy two u32 registers
+ * when used with register which size is 8 bytes (for example V7 64
+ * bit registers like TTBR0/TTBR1).
+ */
+static int reg_to_user_from_u32(void __user *uaddr, const u32 *val, u64 id)
 {
-	/* This Just Works because we are little endian. */
 	if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
 		return -EFAULT;
 	return 0;
@@ -710,7 +776,7 @@ static int get_invariant_cp15(u64 id, void __user *uaddr)
 	if (!r)
 		return -ENOENT;
 
-	return reg_to_user(uaddr, &r->val, id);
+	return reg_to_user_from_u64(uaddr, &r->val, id);
 }
 
 static int set_invariant_cp15(u64 id, void __user *uaddr)
@@ -726,7 +792,7 @@ static int set_invariant_cp15(u64 id, void __user *uaddr)
 	if (!r)
 		return -ENOENT;
 
-	err = reg_from_user(&val, uaddr, id);
+	err = reg_from_user_to_u64(&val, uaddr, id);
 	if (err)
 		return err;
 
@@ -894,8 +960,8 @@ static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 	if (vfpid < num_fp_regs()) {
 		if (KVM_REG_SIZE(id) != 8)
 			return -ENOENT;
-		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpregs[vfpid],
-				   id);
+		return reg_to_user_from_u64(uaddr, &vcpu->arch.vfp_guest.fpregs[vfpid],
+					    id);
 	}
 
 	/* FP control registers are all 32 bit. */
@@ -904,22 +970,22 @@ static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 
 	switch (vfpid) {
 	case KVM_REG_ARM_VFP_FPEXC:
-		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpexc, id);
+		return reg_to_user_from_u32(uaddr, &vcpu->arch.vfp_guest.fpexc, id);
 	case KVM_REG_ARM_VFP_FPSCR:
-		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpscr, id);
+		return reg_to_user_from_u32(uaddr, &vcpu->arch.vfp_guest.fpscr, id);
 	case KVM_REG_ARM_VFP_FPINST:
-		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst, id);
+		return reg_to_user_from_u32(uaddr, &vcpu->arch.vfp_guest.fpinst, id);
 	case KVM_REG_ARM_VFP_FPINST2:
-		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst2, id);
+		return reg_to_user_from_u32(uaddr, &vcpu->arch.vfp_guest.fpinst2, id);
 	case KVM_REG_ARM_VFP_MVFR0:
 		val = fmrx(MVFR0);
-		return reg_to_user(uaddr, &val, id);
+		return reg_to_user_from_u32(uaddr, &val, id);
 	case KVM_REG_ARM_VFP_MVFR1:
 		val = fmrx(MVFR1);
-		return reg_to_user(uaddr, &val, id);
+		return reg_to_user_from_u32(uaddr, &val, id);
 	case KVM_REG_ARM_VFP_FPSID:
 		val = fmrx(FPSID);
-		return reg_to_user(uaddr, &val, id);
+		return reg_to_user_from_u32(uaddr, &val, id);
 	default:
 		return -ENOENT;
 	}
@@ -938,8 +1004,8 @@ static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
 	if (vfpid < num_fp_regs()) {
 		if (KVM_REG_SIZE(id) != 8)
 			return -ENOENT;
-		return reg_from_user(&vcpu->arch.vfp_guest.fpregs[vfpid],
-				     uaddr, id);
+		return reg_from_user_to_u64(&vcpu->arch.vfp_guest.fpregs[vfpid],
+					    uaddr, id);
 	}
 
 	/* FP control registers are all 32 bit. */
@@ -948,28 +1014,28 @@ static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
 
 	switch (vfpid) {
 	case KVM_REG_ARM_VFP_FPEXC:
-		return reg_from_user(&vcpu->arch.vfp_guest.fpexc, uaddr, id);
+		return reg_from_user_to_u32(&vcpu->arch.vfp_guest.fpexc, uaddr, id);
 	case KVM_REG_ARM_VFP_FPSCR:
-		return reg_from_user(&vcpu->arch.vfp_guest.fpscr, uaddr, id);
+		return reg_from_user_to_u32(&vcpu->arch.vfp_guest.fpscr, uaddr, id);
 	case KVM_REG_ARM_VFP_FPINST:
-		return reg_from_user(&vcpu->arch.vfp_guest.fpinst, uaddr, id);
+		return reg_from_user_to_u32(&vcpu->arch.vfp_guest.fpinst, uaddr, id);
 	case KVM_REG_ARM_VFP_FPINST2:
-		return reg_from_user(&vcpu->arch.vfp_guest.fpinst2, uaddr, id);
+		return reg_from_user_to_u32(&vcpu->arch.vfp_guest.fpinst2, uaddr, id);
 	/* These are invariant. */
 	case KVM_REG_ARM_VFP_MVFR0:
-		if (reg_from_user(&val, uaddr, id))
+		if (reg_from_user_to_u32(&val, uaddr, id))
 			return -EFAULT;
 		if (val != fmrx(MVFR0))
 			return -EINVAL;
 		return 0;
 	case KVM_REG_ARM_VFP_MVFR1:
-		if (reg_from_user(&val, uaddr, id))
+		if (reg_from_user_to_u32(&val, uaddr, id))
 			return -EFAULT;
 		if (val != fmrx(MVFR1))
 			return -EINVAL;
 		return 0;
 	case KVM_REG_ARM_VFP_FPSID:
-		if (reg_from_user(&val, uaddr, id))
+		if (reg_from_user_to_u32(&val, uaddr, id))
 			return -EFAULT;
 		if (val != fmrx(FPSID))
 			return -EINVAL;
@@ -1016,7 +1082,7 @@ int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return get_invariant_cp15(reg->id, uaddr);
 
 	/* Note: copies two regs if size is 64 bit. */
-	return reg_to_user(uaddr, &vcpu->arch.cp15[r->reg], reg->id);
+	return reg_to_user_from_u32(uaddr, &vcpu->arch.cp15[r->reg], reg->id);
 }
 
 int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -1035,7 +1101,7 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return set_invariant_cp15(reg->id, uaddr);
 
 	/* Note: copies two regs if size is 64 bit */
-	return reg_from_user(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
+	return reg_from_user_to_u32(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
 }
 
 static unsigned int num_demux_regs(void)
-- 
1.8.1.4
