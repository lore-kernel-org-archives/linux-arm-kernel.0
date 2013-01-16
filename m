From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:58:45 -0500
Subject: [PATCH v6 09/15] trom: Christoffer Dall
 <c.dall@virtualopensystems.com>
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175845.29147.24684.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM: ARM: User space API for getting/setting co-proc registers

The following three ioctls are implemented:
 -  KVM_GET_REG_LIST
 -  KVM_GET_ONE_REG
 -  KVM_SET_ONE_REG

Now we have a table for all the cp15 registers, we can drive a generic
API.

The register IDs carry the following encoding:

ARM registers are mapped using the lower 32 bits.  The upper 16 of that
is the register group type, or coprocessor number:

ARM 32-bit CP15 registers have the following id bit patterns:
  0x4002 0000 000F <zero:1> <crn:4> <crm:4> <opc1:4> <opc2:3>

ARM 64-bit CP15 registers have the following id bit patterns:
  0x4003 0000 000F <zero:1> <zero:4> <crm:4> <opc1:4> <zero:3>

For futureproofing, we need to tell QEMU about the CP15 registers the
host lets the guest access.

It will need this information to restore a current guest on a future
CPU or perhaps a future KVM which allow some of these to be changed.

We use a separate table for these, as they're only for the userspace API.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt |    5 +
 arch/arm/include/asm/kvm_coproc.h |    9 +
 arch/arm/include/asm/kvm_host.h   |    4 
 arch/arm/kvm/coproc.c             |  327 +++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/guest.c              |    9 +
 5 files changed, 350 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 5050492..0e22874 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1799,6 +1799,11 @@ is the register group type, or coprocessor number:
 ARM core registers have the following id bit patterns:
   0x4002 0000 0010 <index into the kvm_regs struct:16>
 
+ARM 32-bit CP15 registers have the following id bit patterns:
+  0x4002 0000 000F <zero:1> <crn:4> <crm:4> <opc1:4> <opc2:3>
+
+ARM 64-bit CP15 registers have the following id bit patterns:
+  0x4003 0000 000F <zero:1> <zero:4> <crm:4> <opc1:4> <zero:3>
 
 
 4.69 KVM_GET_ONE_REG
diff --git a/arch/arm/include/asm/kvm_coproc.h b/arch/arm/include/asm/kvm_coproc.h
index bd1ace0..4917c2f 100644
--- a/arch/arm/include/asm/kvm_coproc.h
+++ b/arch/arm/include/asm/kvm_coproc.h
@@ -34,5 +34,14 @@ int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run);
 int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run);
 int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run);
 int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run);
+
+unsigned long kvm_arm_num_guest_msrs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_msrindices(struct kvm_vcpu *vcpu, u64 __user *uindices);
 void kvm_coproc_table_init(void);
+
+struct kvm_one_reg;
+int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
+int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
+int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
+unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu *vcpu);
 #endif /* __ARM_KVM_COPROC_H__ */
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index e1d4168..ed79043 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -27,6 +27,7 @@
 #define KVM_MEMORY_SLOTS 32
 #define KVM_PRIVATE_MEM_SLOTS 4
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+#define KVM_HAVE_ONE_REG
 
 #define KVM_VCPU_MAX_FEATURES 0
 
@@ -137,6 +138,9 @@ int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
+
 /* We do not have shadow page tables, hence the empty hooks */
 static inline int kvm_age_hva(struct kvm *kvm, unsigned long hva)
 {
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 722efe3..95a0f5e 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -18,6 +18,7 @@
  */
 #include <linux/mm.h>
 #include <linux/kvm_host.h>
+#include <linux/uaccess.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_emulate.h>
@@ -347,6 +348,328 @@ int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return emulate_cp15(vcpu, &params);
 }
 
+/******************************************************************************
+ * Userspace API
+ *****************************************************************************/
+
+static bool index_to_params(u64 id, struct coproc_params *params)
+{
+	switch (id & KVM_REG_SIZE_MASK) {
+	case KVM_REG_SIZE_U32:
+		/* Any unused index bits means it's not valid. */
+		if (id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK
+			   | KVM_REG_ARM_COPROC_MASK
+			   | KVM_REG_ARM_32_CRN_MASK
+			   | KVM_REG_ARM_CRM_MASK
+			   | KVM_REG_ARM_OPC1_MASK
+			   | KVM_REG_ARM_32_OPC2_MASK))
+			return false;
+
+		params->is_64bit = false;
+		params->CRn = ((id & KVM_REG_ARM_32_CRN_MASK)
+			       >> KVM_REG_ARM_32_CRN_SHIFT);
+		params->CRm = ((id & KVM_REG_ARM_CRM_MASK)
+			       >> KVM_REG_ARM_CRM_SHIFT);
+		params->Op1 = ((id & KVM_REG_ARM_OPC1_MASK)
+			       >> KVM_REG_ARM_OPC1_SHIFT);
+		params->Op2 = ((id & KVM_REG_ARM_32_OPC2_MASK)
+			       >> KVM_REG_ARM_32_OPC2_SHIFT);
+		return true;
+	case KVM_REG_SIZE_U64:
+		/* Any unused index bits means it's not valid. */
+		if (id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK
+			      | KVM_REG_ARM_COPROC_MASK
+			      | KVM_REG_ARM_CRM_MASK
+			      | KVM_REG_ARM_OPC1_MASK))
+			return false;
+		params->is_64bit = true;
+		params->CRm = ((id & KVM_REG_ARM_CRM_MASK)
+			       >> KVM_REG_ARM_CRM_SHIFT);
+		params->Op1 = ((id & KVM_REG_ARM_OPC1_MASK)
+			       >> KVM_REG_ARM_OPC1_SHIFT);
+		params->Op2 = 0;
+		params->CRn = 0;
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Decode an index value, and find the cp15 coproc_reg entry. */
+static const struct coproc_reg *index_to_coproc_reg(struct kvm_vcpu *vcpu,
+						    u64 id)
+{
+	size_t num;
+	const struct coproc_reg *table, *r;
+	struct coproc_params params;
+
+	/* We only do cp15 for now. */
+	if ((id & KVM_REG_ARM_COPROC_MASK) >> KVM_REG_ARM_COPROC_SHIFT != 15)
+		return NULL;
+
+	if (!index_to_params(id, &params))
+		return NULL;
+
+	table = get_target_table(vcpu->arch.target, &num);
+	r = find_reg(&params, table, num);
+	if (!r)
+		r = find_reg(&params, cp15_regs, ARRAY_SIZE(cp15_regs));
+
+	/* Not saved in the cp15 array? */
+	if (r && !r->reg)
+		r = NULL;
+
+	return r;
+}
+
+/*
+ * These are the invariant cp15 registers: we let the guest see the host
+ * versions of these, so they're part of the guest state.
+ *
+ * A future CPU may provide a mechanism to present different values to
+ * the guest, or a future kvm may trap them.
+ */
+/* Unfortunately, there's no register-argument for mrc, so generate. */
+#define FUNCTION_FOR32(crn, crm, op1, op2, name)			\
+	static void get_##name(struct kvm_vcpu *v,			\
+			       const struct coproc_reg *r)		\
+	{								\
+		u32 val;						\
+									\
+		asm volatile("mrc p15, " __stringify(op1)		\
+			     ", %0, c" __stringify(crn)			\
+			     ", c" __stringify(crm)			\
+			     ", " __stringify(op2) "\n" : "=r" (val));	\
+		((struct coproc_reg *)r)->val = val;			\
+	}
+
+FUNCTION_FOR32(0, 0, 0, 0, MIDR)
+FUNCTION_FOR32(0, 0, 0, 1, CTR)
+FUNCTION_FOR32(0, 0, 0, 2, TCMTR)
+FUNCTION_FOR32(0, 0, 0, 3, TLBTR)
+FUNCTION_FOR32(0, 0, 0, 6, REVIDR)
+FUNCTION_FOR32(0, 1, 0, 0, ID_PFR0)
+FUNCTION_FOR32(0, 1, 0, 1, ID_PFR1)
+FUNCTION_FOR32(0, 1, 0, 2, ID_DFR0)
+FUNCTION_FOR32(0, 1, 0, 3, ID_AFR0)
+FUNCTION_FOR32(0, 1, 0, 4, ID_MMFR0)
+FUNCTION_FOR32(0, 1, 0, 5, ID_MMFR1)
+FUNCTION_FOR32(0, 1, 0, 6, ID_MMFR2)
+FUNCTION_FOR32(0, 1, 0, 7, ID_MMFR3)
+FUNCTION_FOR32(0, 2, 0, 0, ID_ISAR0)
+FUNCTION_FOR32(0, 2, 0, 1, ID_ISAR1)
+FUNCTION_FOR32(0, 2, 0, 2, ID_ISAR2)
+FUNCTION_FOR32(0, 2, 0, 3, ID_ISAR3)
+FUNCTION_FOR32(0, 2, 0, 4, ID_ISAR4)
+FUNCTION_FOR32(0, 2, 0, 5, ID_ISAR5)
+FUNCTION_FOR32(0, 0, 1, 1, CLIDR)
+FUNCTION_FOR32(0, 0, 1, 7, AIDR)
+
+/* ->val is filled in by kvm_invariant_coproc_table_init() */
+static struct coproc_reg invariant_cp15[] = {
+	{ CRn( 0), CRm( 0), Op1( 0), Op2( 0), is32, NULL, get_MIDR },
+	{ CRn( 0), CRm( 0), Op1( 0), Op2( 1), is32, NULL, get_CTR },
+	{ CRn( 0), CRm( 0), Op1( 0), Op2( 2), is32, NULL, get_TCMTR },
+	{ CRn( 0), CRm( 0), Op1( 0), Op2( 3), is32, NULL, get_TLBTR },
+	{ CRn( 0), CRm( 0), Op1( 0), Op2( 6), is32, NULL, get_REVIDR },
+
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 0), is32, NULL, get_ID_PFR0 },
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 1), is32, NULL, get_ID_PFR1 },
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 2), is32, NULL, get_ID_DFR0 },
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 3), is32, NULL, get_ID_AFR0 },
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 4), is32, NULL, get_ID_MMFR0 },
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 5), is32, NULL, get_ID_MMFR1 },
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 6), is32, NULL, get_ID_MMFR2 },
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 7), is32, NULL, get_ID_MMFR3 },
+
+	{ CRn( 0), CRm( 2), Op1( 0), Op2( 0), is32, NULL, get_ID_ISAR0 },
+	{ CRn( 0), CRm( 2), Op1( 0), Op2( 1), is32, NULL, get_ID_ISAR1 },
+	{ CRn( 0), CRm( 2), Op1( 0), Op2( 2), is32, NULL, get_ID_ISAR2 },
+	{ CRn( 0), CRm( 2), Op1( 0), Op2( 3), is32, NULL, get_ID_ISAR3 },
+	{ CRn( 0), CRm( 2), Op1( 0), Op2( 4), is32, NULL, get_ID_ISAR4 },
+	{ CRn( 0), CRm( 2), Op1( 0), Op2( 5), is32, NULL, get_ID_ISAR5 },
+
+	{ CRn( 0), CRm( 0), Op1( 1), Op2( 1), is32, NULL, get_CLIDR },
+	{ CRn( 0), CRm( 0), Op1( 1), Op2( 7), is32, NULL, get_AIDR },
+};
+
+static int reg_from_user(void *val, const void __user *uaddr, u64 id)
+{
+	/* This Just Works because we are little endian. */
+	if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
+		return -EFAULT;
+	return 0;
+}
+
+static int reg_to_user(void __user *uaddr, const void *val, u64 id)
+{
+	/* This Just Works because we are little endian. */
+	if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
+		return -EFAULT;
+	return 0;
+}
+
+static int get_invariant_cp15(u64 id, void __user *uaddr)
+{
+	struct coproc_params params;
+	const struct coproc_reg *r;
+
+	if (!index_to_params(id, &params))
+		return -ENOENT;
+
+	r = find_reg(&params, invariant_cp15, ARRAY_SIZE(invariant_cp15));
+	if (!r)
+		return -ENOENT;
+
+	return reg_to_user(uaddr, &r->val, id);
+}
+
+static int set_invariant_cp15(u64 id, void __user *uaddr)
+{
+	struct coproc_params params;
+	const struct coproc_reg *r;
+	int err;
+	u64 val = 0; /* Make sure high bits are 0 for 32-bit regs */
+
+	if (!index_to_params(id, &params))
+		return -ENOENT;
+	r = find_reg(&params, invariant_cp15, ARRAY_SIZE(invariant_cp15));
+	if (!r)
+		return -ENOENT;
+
+	err = reg_from_user(&val, uaddr, id);
+	if (err)
+		return err;
+
+	/* This is what we mean by invariant: you can't change it. */
+	if (r->val != val)
+		return -EINVAL;
+
+	return 0;
+}
+
+int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	const struct coproc_reg *r;
+	void __user *uaddr = (void __user *)(long)reg->addr;
+
+	r = index_to_coproc_reg(vcpu, reg->id);
+	if (!r)
+		return get_invariant_cp15(reg->id, uaddr);
+
+	/* Note: copies two regs if size is 64 bit. */
+	return reg_to_user(uaddr, &vcpu->arch.cp15[r->reg], reg->id);
+}
+
+int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	const struct coproc_reg *r;
+	void __user *uaddr = (void __user *)(long)reg->addr;
+
+	r = index_to_coproc_reg(vcpu, reg->id);
+	if (!r)
+		return set_invariant_cp15(reg->id, uaddr);
+
+	/* Note: copies two regs if size is 64 bit */
+	return reg_from_user(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
+}
+
+static u64 cp15_to_index(const struct coproc_reg *reg)
+{
+	u64 val = KVM_REG_ARM | (15 << KVM_REG_ARM_COPROC_SHIFT);
+	if (reg->is_64) {
+		val |= KVM_REG_SIZE_U64;
+		val |= (reg->Op1 << KVM_REG_ARM_OPC1_SHIFT);
+		val |= (reg->CRm << KVM_REG_ARM_CRM_SHIFT);
+	} else {
+		val |= KVM_REG_SIZE_U32;
+		val |= (reg->Op1 << KVM_REG_ARM_OPC1_SHIFT);
+		val |= (reg->Op2 << KVM_REG_ARM_32_OPC2_SHIFT);
+		val |= (reg->CRm << KVM_REG_ARM_CRM_SHIFT);
+		val |= (reg->CRn << KVM_REG_ARM_32_CRN_SHIFT);
+	}
+	return val;
+}
+
+static bool copy_reg_to_user(const struct coproc_reg *reg, u64 __user **uind)
+{
+	if (!*uind)
+		return true;
+
+	if (put_user(cp15_to_index(reg), *uind))
+		return false;
+
+	(*uind)++;
+	return true;
+}
+
+/* Assumed ordered tables, see kvm_coproc_table_init. */
+static int walk_cp15(struct kvm_vcpu *vcpu, u64 __user *uind)
+{
+	const struct coproc_reg *i1, *i2, *end1, *end2;
+	unsigned int total = 0;
+	size_t num;
+
+	/* We check for duplicates here, to allow arch-specific overrides. */
+	i1 = get_target_table(vcpu->arch.target, &num);
+	end1 = i1 + num;
+	i2 = cp15_regs;
+	end2 = cp15_regs + ARRAY_SIZE(cp15_regs);
+
+	BUG_ON(i1 == end1 || i2 == end2);
+
+	/* Walk carefully, as both tables may refer to the same register. */
+	while (i1 || i2) {
+		int cmp = cmp_reg(i1, i2);
+		/* target-specific overrides generic entry. */
+		if (cmp <= 0) {
+			/* Ignore registers we trap but don't save. */
+			if (i1->reg) {
+				if (!copy_reg_to_user(i1, &uind))
+					return -EFAULT;
+				total++;
+			}
+		} else {
+			/* Ignore registers we trap but don't save. */
+			if (i2->reg) {
+				if (!copy_reg_to_user(i2, &uind))
+					return -EFAULT;
+				total++;
+			}
+		}
+
+		if (cmp <= 0 && ++i1 == end1)
+			i1 = NULL;
+		if (cmp >= 0 && ++i2 == end2)
+			i2 = NULL;
+	}
+	return total;
+}
+
+unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu *vcpu)
+{
+	return ARRAY_SIZE(invariant_cp15)
+		+ walk_cp15(vcpu, (u64 __user *)NULL);
+}
+
+int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	unsigned int i;
+	int err;
+
+	/* Then give them all the invariant registers' indices. */
+	for (i = 0; i < ARRAY_SIZE(invariant_cp15); i++) {
+		if (put_user(cp15_to_index(&invariant_cp15[i]), uindices))
+			return -EFAULT;
+		uindices++;
+	}
+
+	err = walk_cp15(vcpu, uindices);
+	if (err > 0)
+		err = 0;
+	return err;
+}
+
 void kvm_coproc_table_init(void)
 {
 	unsigned int i;
@@ -354,6 +677,10 @@ void kvm_coproc_table_init(void)
 	/* Make sure tables are unique and in order. */
 	for (i = 1; i < ARRAY_SIZE(cp15_regs); i++)
 		BUG_ON(cmp_reg(&cp15_regs[i-1], &cp15_regs[i]) >= 0);
+
+	/* We abuse the reset function to overwrite the table itself. */
+	for (i = 0; i < ARRAY_SIZE(invariant_cp15); i++)
+		invariant_cp15[i].reset(NULL, &invariant_cp15[i]);
 }
 
 /**
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index a12eb22..2339d96 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -26,6 +26,7 @@
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_coproc.h>
 
 #define VM_STAT(x) { #x, offsetof(struct kvm, stat.x), KVM_STAT_VM }
 #define VCPU_STAT(x) { #x, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU }
@@ -119,7 +120,7 @@ static unsigned long num_core_regs(void)
  */
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
-	return num_core_regs();
+	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu);
 }
 
 /**
@@ -138,7 +139,7 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 		uindices++;
 	}
 
-	return 0;
+	return kvm_arm_copy_coproc_indices(vcpu, uindices);
 }
 
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -151,7 +152,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
 		return get_core_reg(vcpu, reg);
 
-	return -EINVAL;
+	return kvm_arm_coproc_get_reg(vcpu, reg);
 }
 
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -164,7 +165,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
 		return set_core_reg(vcpu, reg);
 
-	return -EINVAL;
+	return kvm_arm_coproc_set_reg(vcpu, reg);
 }
 
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
