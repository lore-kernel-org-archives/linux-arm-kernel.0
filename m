From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:03:00 +0100
Subject: [GIT PULL 31/36] arm64: KVM: add SGI generation register emulation
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-32-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

While the generation of a (virtual) inter-processor interrupt (SGI)
on a GICv2 works by writing to a MMIO register, GICv3 uses the system
register ICC_SGI1R_EL1 to trigger them.
Add a trap handler function that calls the new SGI register handler
in the GICv3 code. As ICC_SRE_EL1.SRE at this point is still always 0,
this will not trap yet, but will only be used later when all the data
structures have been initialized properly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/sys_regs.c   |  27 +++++++++++
 include/kvm/arm_vgic.h      |   1 +
 virt/kvm/arm/vgic-v3-emul.c | 111 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 136e679..8c30f26 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -165,6 +165,27 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+/*
+ * Trap handler for the GICv3 SGI generation system register.
+ * Forward the request to the VGIC emulation.
+ * The cp15_64 code makes sure this automatically works
+ * for both AArch64 and AArch32 accesses.
+ */
+static bool access_gic_sgi(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_params *p,
+			   const struct sys_reg_desc *r)
+{
+	u64 val;
+
+	if (!p->is_write)
+		return read_from_write_only(vcpu, p);
+
+	val = *vcpu_reg(vcpu, p->Rt);
+	vgic_v3_dispatch_sgi(vcpu, val);
+
+	return true;
+}
+
 static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 			const struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -434,6 +455,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
 	  NULL, reset_val, VBAR_EL1, 0 },
 
+	/* ICC_SGI1R_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
+	  access_gic_sgi },
 	/* ICC_SRE_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1100), Op2(0b101),
 	  trap_raz_wi },
@@ -666,6 +690,8 @@ static const struct sys_reg_desc cp14_64_regs[] = {
  * register).
  */
 static const struct sys_reg_desc cp15_regs[] = {
+	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
+
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_sctlr, NULL, c1_SCTLR },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
@@ -713,6 +739,7 @@ static const struct sys_reg_desc cp15_regs[] = {
 
 static const struct sys_reg_desc cp15_64_regs[] = {
 	{ Op1( 0), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
+	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
 	{ Op1( 1), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR1 },
 };
 
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 98c3016..b9b2e05 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -307,6 +307,7 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			bool level);
+void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
index 8db1db5..2d2199d 100644
--- a/virt/kvm/arm/vgic-v3-emul.c
+++ b/virt/kvm/arm/vgic-v3-emul.c
@@ -841,6 +841,117 @@ void vgic_v3_init_emulation(struct kvm *kvm)
 	kvm->arch.max_vcpus = KVM_MAX_VCPUS;
 }
 
+/*
+ * Compare a given affinity (level 1-3 and a level 0 mask, from the SGI
+ * generation register ICC_SGI1R_EL1) with a given VCPU.
+ * If the VCPU's MPIDR matches, return the level0 affinity, otherwise
+ * return -1.
+ */
+static int match_mpidr(u64 sgi_aff, u16 sgi_cpu_mask, struct kvm_vcpu *vcpu)
+{
+	unsigned long affinity;
+	int level0;
+
+	/*
+	 * Split the current VCPU's MPIDR into affinity level 0 and the
+	 * rest as this is what we have to compare against.
+	 */
+	affinity = kvm_vcpu_get_mpidr_aff(vcpu);
+	level0 = MPIDR_AFFINITY_LEVEL(affinity, 0);
+	affinity &= ~MPIDR_LEVEL_MASK;
+
+	/* bail out if the upper three levels don't match */
+	if (sgi_aff != affinity)
+		return -1;
+
+	/* Is this VCPU's bit set in the mask ? */
+	if (!(sgi_cpu_mask & BIT(level0)))
+		return -1;
+
+	return level0;
+}
+
+#define SGI_AFFINITY_LEVEL(reg, level) \
+	((((reg) & ICC_SGI1R_AFFINITY_## level ##_MASK) \
+	>> ICC_SGI1R_AFFINITY_## level ##_SHIFT) << MPIDR_LEVEL_SHIFT(level))
+
+/**
+ * vgic_v3_dispatch_sgi - handle SGI requests from VCPUs
+ * @vcpu: The VCPU requesting a SGI
+ * @reg: The value written into the ICC_SGI1R_EL1 register by that VCPU
+ *
+ * With GICv3 (and ARE=1) CPUs trigger SGIs by writing to a system register.
+ * This will trap in sys_regs.c and call this function.
+ * This ICC_SGI1R_EL1 register contains the upper three affinity levels of the
+ * target processors as well as a bitmask of 16 Aff0 CPUs.
+ * If the interrupt routing mode bit is not set, we iterate over all VCPUs to
+ * check for matching ones. If this bit is set, we signal all, but not the
+ * calling VCPU.
+ */
+void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_vcpu *c_vcpu;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	u16 target_cpus;
+	u64 mpidr;
+	int sgi, c;
+	int vcpu_id = vcpu->vcpu_id;
+	bool broadcast;
+	int updated = 0;
+
+	sgi = (reg & ICC_SGI1R_SGI_ID_MASK) >> ICC_SGI1R_SGI_ID_SHIFT;
+	broadcast = reg & BIT(ICC_SGI1R_IRQ_ROUTING_MODE_BIT);
+	target_cpus = (reg & ICC_SGI1R_TARGET_LIST_MASK) >> ICC_SGI1R_TARGET_LIST_SHIFT;
+	mpidr = SGI_AFFINITY_LEVEL(reg, 3);
+	mpidr |= SGI_AFFINITY_LEVEL(reg, 2);
+	mpidr |= SGI_AFFINITY_LEVEL(reg, 1);
+
+	/*
+	 * We take the dist lock here, because we come from the sysregs
+	 * code path and not from the MMIO one (which already takes the lock).
+	 */
+	spin_lock(&dist->lock);
+
+	/*
+	 * We iterate over all VCPUs to find the MPIDRs matching the request.
+	 * If we have handled one CPU, we clear it's bit to detect early
+	 * if we are already finished. This avoids iterating through all
+	 * VCPUs when most of the times we just signal a single VCPU.
+	 */
+	kvm_for_each_vcpu(c, c_vcpu, kvm) {
+
+		/* Exit early if we have dealt with all requested CPUs */
+		if (!broadcast && target_cpus == 0)
+			break;
+
+		 /* Don't signal the calling VCPU */
+		if (broadcast && c == vcpu_id)
+			continue;
+
+		if (!broadcast) {
+			int level0;
+
+			level0 = match_mpidr(mpidr, target_cpus, c_vcpu);
+			if (level0 == -1)
+				continue;
+
+			/* remove this matching VCPU from the mask */
+			target_cpus &= ~BIT(level0);
+		}
+
+		/* Flag the SGI as pending */
+		vgic_dist_irq_set_pending(c_vcpu, sgi);
+		updated = 1;
+		kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
+	}
+	if (updated)
+		vgic_update_state(vcpu->kvm);
+	spin_unlock(&dist->lock);
+	if (updated)
+		vgic_kick_vcpus(vcpu->kvm);
+}
+
 static int vgic_v3_create(struct kvm_device *dev, u32 type)
 {
 	return kvm_vgic_create(dev->kvm, type);
-- 
2.1.2.330.g565301e.dirty
