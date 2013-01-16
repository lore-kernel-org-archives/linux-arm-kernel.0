From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:58:52 -0500
Subject: [PATCH v6 10/15] KVM: ARM: Demux CCSIDR in the userspace API
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175852.29147.74726.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cache Size Selection Register (CSSELR) selects the current Cache
Size ID Register (CCSIDR).  You write which cache you are interested
in to CSSELR, and read the information out of CCSIDR.

Which cache numbers are valid is known by reading the Cache Level ID
Register (CLIDR).

To export this state to userspace, we add a KVM_REG_ARM_DEMUX
numberspace (17), which uses 8 bits to represent which register is
being demultiplexed (0 for CCSIDR), and the lower 8 bits to represent
this demultiplexing (in our case, the CSSELR value, which is 4 bits).

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt |    2 
 arch/arm/include/uapi/asm/kvm.h   |    9 ++
 arch/arm/kvm/coproc.c             |  164 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0e22874..94f17a3 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1805,6 +1805,8 @@ ARM 32-bit CP15 registers have the following id bit patterns:
 ARM 64-bit CP15 registers have the following id bit patterns:
   0x4003 0000 000F <zero:1> <zero:4> <crm:4> <opc1:4> <zero:3>
 
+ARM CCSIDR registers are demultiplexed by CSSELR value:
+  0x4002 0000 0011 00 <csselr:8>
 
 4.69 KVM_GET_ONE_REG
 
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 53f45f1..71ae27e 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -104,6 +104,15 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
 #define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
 
+/* Some registers need more space to represent values. */
+#define KVM_REG_ARM_DEMUX		(0x0011 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_DEMUX_ID_MASK	0x000000000000FF00
+#define KVM_REG_ARM_DEMUX_ID_SHIFT	8
+#define KVM_REG_ARM_DEMUX_ID_CCSIDR	(0x00 << KVM_REG_ARM_DEMUX_ID_SHIFT)
+#define KVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
+#define KVM_REG_ARM_DEMUX_VAL_SHIFT	0
+
+
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
 #define KVM_ARM_IRQ_TYPE_MASK		0xff
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 95a0f5e..1827b64 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -35,6 +35,12 @@
  * Co-processor emulation
  *****************************************************************************/
 
+/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
+static u32 cache_levels;
+
+/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
+#define CSSELR_MAX 12
+
 int kvm_handle_cp10_id(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	kvm_inject_undefined(vcpu);
@@ -548,11 +554,113 @@ static int set_invariant_cp15(u64 id, void __user *uaddr)
 	return 0;
 }
 
+static bool is_valid_cache(u32 val)
+{
+	u32 level, ctype;
+
+	if (val >= CSSELR_MAX)
+		return -ENOENT;
+
+	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
+        level = (val >> 1);
+        ctype = (cache_levels >> (level * 3)) & 7;
+
+	switch (ctype) {
+	case 0: /* No cache */
+		return false;
+	case 1: /* Instruction cache only */
+		return (val & 1);
+	case 2: /* Data cache only */
+	case 4: /* Unified cache */
+		return !(val & 1);
+	case 3: /* Separate instruction and data caches */
+		return true;
+	default: /* Reserved: we can't know instruction or data. */
+		return false;
+	}
+}
+
+/* Which cache CCSIDR represents depends on CSSELR value. */
+static u32 get_ccsidr(u32 csselr)
+{
+	u32 ccsidr;
+
+	/* Make sure noone else changes CSSELR during this! */
+	local_irq_disable();
+	/* Put value into CSSELR */
+	asm volatile("mcr p15, 2, %0, c0, c0, 0" : : "r" (csselr));
+	isb();
+	/* Read result out of CCSIDR */
+	asm volatile("mrc p15, 1, %0, c0, c0, 0" : "=r" (ccsidr));
+	local_irq_enable();
+
+	return ccsidr;
+}
+
+static int demux_c15_get(u64 id, void __user *uaddr)
+{
+	u32 val;
+	u32 __user *uval = uaddr;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
+	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
+		if (KVM_REG_SIZE(id) != 4)
+			return -ENOENT;
+		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
+		if (!is_valid_cache(val))
+			return -ENOENT;
+
+		return put_user(get_ccsidr(val), uval);
+	default:
+		return -ENOENT;
+	}
+}
+
+static int demux_c15_set(u64 id, void __user *uaddr)
+{
+	u32 val, newval;
+	u32 __user *uval = uaddr;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
+	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
+		if (KVM_REG_SIZE(id) != 4)
+			return -ENOENT;
+		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
+		if (!is_valid_cache(val))
+			return -ENOENT;
+
+		if (get_user(newval, uval))
+			return -EFAULT;
+
+		/* This is also invariant: you can't change it. */
+		if (newval != get_ccsidr(val))
+			return -EINVAL;
+		return 0;
+	default:
+		return -ENOENT;
+	}
+}
+
 int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	const struct coproc_reg *r;
 	void __user *uaddr = (void __user *)(long)reg->addr;
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_get(reg->id, uaddr);
+
 	r = index_to_coproc_reg(vcpu, reg->id);
 	if (!r)
 		return get_invariant_cp15(reg->id, uaddr);
@@ -566,6 +674,9 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	const struct coproc_reg *r;
 	void __user *uaddr = (void __user *)(long)reg->addr;
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_set(reg->id, uaddr);
+
 	r = index_to_coproc_reg(vcpu, reg->id);
 	if (!r)
 		return set_invariant_cp15(reg->id, uaddr);
@@ -574,6 +685,33 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return reg_from_user(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
 }
 
+static unsigned int num_demux_regs(void)
+{
+	unsigned int i, count = 0;
+
+	for (i = 0; i < CSSELR_MAX; i++)
+		if (is_valid_cache(i))
+			count++;
+
+	return count;
+}
+
+static int write_demux_regids(u64 __user *uindices)
+{
+	u64 val = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX;
+	unsigned int i;
+
+	val |= KVM_REG_ARM_DEMUX_ID_CCSIDR;
+	for (i = 0; i < CSSELR_MAX; i++) {
+		if (!is_valid_cache(i))
+			continue;
+		if (put_user(val | i, uindices))
+			return -EFAULT;
+		uindices++;
+	}
+	return 0;
+}
+
 static u64 cp15_to_index(const struct coproc_reg *reg)
 {
 	u64 val = KVM_REG_ARM | (15 << KVM_REG_ARM_COPROC_SHIFT);
@@ -649,6 +787,7 @@ static int walk_cp15(struct kvm_vcpu *vcpu, u64 __user *uind)
 unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu *vcpu)
 {
 	return ARRAY_SIZE(invariant_cp15)
+		+ num_demux_regs()
 		+ walk_cp15(vcpu, (u64 __user *)NULL);
 }
 
@@ -665,9 +804,11 @@ int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	}
 
 	err = walk_cp15(vcpu, uindices);
-	if (err > 0)
-		err = 0;
-	return err;
+	if (err < 0)
+		return err;
+	uindices += err;
+
+	return write_demux_regids(uindices);
 }
 
 void kvm_coproc_table_init(void)
@@ -681,6 +822,23 @@ void kvm_coproc_table_init(void)
 	/* We abuse the reset function to overwrite the table itself. */
 	for (i = 0; i < ARRAY_SIZE(invariant_cp15); i++)
 		invariant_cp15[i].reset(NULL, &invariant_cp15[i]);
+
+	/*
+	 * CLIDR format is awkward, so clean it up.  See ARM B4.1.20:
+	 *
+	 *   If software reads the Cache Type fields from Ctype1
+	 *   upwards, once it has seen a value of 0b000, no caches
+	 *   exist@further-out levels of the hierarchy. So, for
+	 *   example, if Ctype3 is the first Cache Type field with a
+	 *   value of 0b000, the values of Ctype4 to Ctype7 must be
+	 *   ignored.
+	 */
+	asm volatile("mrc p15, 1, %0, c0, c0, 1" : "=r" (cache_levels));
+	for (i = 0; i < 7; i++)
+		if (((cache_levels >> (i*3)) & 7) == 0)
+			break;
+	/* Clear all higher bits. */
+	cache_levels &= (1 << (i*3))-1;
 }
 
 /**
