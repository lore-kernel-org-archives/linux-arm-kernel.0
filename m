From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:53 +0100
Subject: [PATCH v4 25/32] arm64: KVM: 32bit handling of coprocessor traps
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-26-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the necessary infrastructure to trap coprocessor accesses that
occur when running 32bit guests.

Also wire SMC and HVC trapped in 32bit mode while were at it.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_coproc.h |   5 +
 arch/arm64/kvm/handle_exit.c        |   7 ++
 arch/arm64/kvm/sys_regs.c           | 181 ++++++++++++++++++++++++++++++++++--
 3 files changed, 186 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_coproc.h b/arch/arm64/include/asm/kvm_coproc.h
index 9b4477a..9a59301 100644
--- a/arch/arm64/include/asm/kvm_coproc.h
+++ b/arch/arm64/include/asm/kvm_coproc.h
@@ -32,11 +32,16 @@ struct kvm_sys_reg_table {
 
 struct kvm_sys_reg_target_table {
 	struct kvm_sys_reg_table table64;
+	struct kvm_sys_reg_table table32;
 };
 
 void kvm_register_target_sys_reg_table(unsigned int target,
 				       struct kvm_sys_reg_target_table *table);
 
+int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run);
 int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
 #define kvm_coproc_table_init kvm_sys_reg_table_init
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 4766b7f..9beaca03 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -62,6 +62,13 @@ static int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_EL2_EC_WFI]	= kvm_handle_wfi,
+	[ESR_EL2_EC_CP15_32]	= kvm_handle_cp15_32,
+	[ESR_EL2_EC_CP15_64]	= kvm_handle_cp15_64,
+	[ESR_EL2_EC_CP14_MR]	= kvm_handle_cp14_access,
+	[ESR_EL2_EC_CP14_LS]	= kvm_handle_cp14_load_store,
+	[ESR_EL2_EC_CP14_64]	= kvm_handle_cp14_access,
+	[ESR_EL2_EC_HVC32]	= handle_hvc,
+	[ESR_EL2_EC_SMC32]	= handle_smc,
 	[ESR_EL2_EC_HVC64]	= handle_hvc,
 	[ESR_EL2_EC_SMC64]	= handle_smc,
 	[ESR_EL2_EC_SYS64]	= kvm_handle_sys_reg,
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 52fff0a..9492360 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -38,6 +38,10 @@
  * types are different. My gut feeling is that it should be pretty
  * easy to merge, but that would be an ABI breakage -- again. VFP
  * would also need to be abstracted.
+ *
+ * For AArch32, we only take care of what is being trapped. Anything
+ * that has to do with init and userspace access has to go via the
+ * 64bit interface.
  */
 
 /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
@@ -166,6 +170,16 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b010),
 	  access_dcsw },
 
+	/* TEECR32_EL1 */
+	{ Op0(0b10), Op1(0b010), CRn(0b0000), CRm(0b0000), Op2(0b000),
+	  NULL, reset_val, TEECR32_EL1, 0 },
+	/* TEEHBR32_EL1 */
+	{ Op0(0b10), Op1(0b010), CRn(0b0001), CRm(0b0000), Op2(0b000),
+	  NULL, reset_val, TEEHBR32_EL1, 0 },
+	/* DBGVCR32_EL2 */
+	{ Op0(0b10), Op1(0b100), CRn(0b0000), CRm(0b0111), Op2(0b000),
+	  NULL, reset_val, DBGVCR32_EL2, 0 },
+
 	/* MPIDR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b101),
 	  NULL, reset_mpidr, MPIDR_EL1 },
@@ -276,6 +290,39 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	/* TPIDRRO_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
 	  NULL, reset_unknown, TPIDRRO_EL0 },
+
+	/* DACR32_EL2 */
+	{ Op0(0b11), Op1(0b100), CRn(0b0011), CRm(0b0000), Op2(0b000),
+	  NULL, reset_unknown, DACR32_EL2 },
+	/* IFSR32_EL2 */
+	{ Op0(0b11), Op1(0b100), CRn(0b0101), CRm(0b0000), Op2(0b001),
+	  NULL, reset_unknown, IFSR32_EL2 },
+	/* FPEXC32_EL2 */
+	{ Op0(0b11), Op1(0b100), CRn(0b0101), CRm(0b0011), Op2(0b000),
+	  NULL, reset_val, FPEXC32_EL2, 0x70 },
+};
+
+/* Trapped cp15 registers */
+static const struct sys_reg_desc cp15_regs[] = {
+	/*
+	 * DC{C,I,CI}SW operations:
+	 */
+	{ Op1( 0), CRn( 7), CRm( 6), Op2( 2), access_dcsw },
+	{ Op1( 0), CRn( 7), CRm(10), Op2( 2), access_dcsw },
+	{ Op1( 0), CRn( 7), CRm(14), Op2( 2), access_dcsw },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 0), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 1), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 2), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 3), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 5), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 6), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 7), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(13), Op2( 0), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), pm_fake },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), pm_fake },
 };
 
 /* Target specific emulation tables */
@@ -288,13 +335,20 @@ void kvm_register_target_sys_reg_table(unsigned int target,
 }
 
 /* Get specific register table for this target. */
-static const struct sys_reg_desc *get_target_table(unsigned target, size_t *num)
+static const struct sys_reg_desc *get_target_table(unsigned target,
+						   bool mode_is_64,
+						   size_t *num)
 {
 	struct kvm_sys_reg_target_table *table;
 
 	table = target_tables[target];
-	*num = table->table64.num;
-	return table->table64.table;
+	if (mode_is_64) {
+		*num = table->table64.num;
+		return table->table64.table;
+	} else {
+		*num = table->table32.num;
+		return table->table32.table;
+	}
 }
 
 static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
@@ -322,13 +376,126 @@ static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
 	return NULL;
 }
 
+int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+static void emulate_cp15(struct kvm_vcpu *vcpu,
+			 const struct sys_reg_params *params)
+{
+	size_t num;
+	const struct sys_reg_desc *table, *r;
+
+	table = get_target_table(vcpu->arch.target, false, &num);
+
+	/* Search target-specific then generic table. */
+	r = find_reg(params, table, num);
+	if (!r)
+		r = find_reg(params, cp15_regs, ARRAY_SIZE(cp15_regs));
+
+	if (likely(r)) {
+		/*
+		 * Not having an accessor means that we have
+		 * configured a trap that we don't know how to
+		 * handle. This certainly qualifies as a gross bug
+		 * that should be fixed right away.
+		 */
+		BUG_ON(!r->access);
+
+		if (likely(r->access(vcpu, params, r))) {
+			/* Skip instruction, since it was emulated */
+			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+			return;
+		}
+		/* If access function fails, it should complain. */
+	}
+
+	kvm_err("Unsupported guest CP15 access at: %08lx\n", *vcpu_pc(vcpu));
+	print_sys_reg_instr(params);
+	kvm_inject_undefined(vcpu);
+}
+
+/**
+ * kvm_handle_cp15_64 -- handles a mrrc/mcrr trap on a guest CP15 access
+ * @vcpu: The VCPU pointer
+ * @run:  The kvm_run struct
+ */
+int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	struct sys_reg_params params;
+	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+	int Rt2 = (hsr >> 10) & 0xf;
+
+	params.CRm = (hsr >> 1) & 0xf;
+	params.Rt = (hsr >> 5) & 0xf;
+	params.is_write = ((hsr & 1) == 0);
+
+	params.Op0 = 0;
+	params.Op1 = (hsr >> 16) & 0xf;
+	params.Op2 = 0;
+	params.CRn = 0;
+
+	/*
+	 * Massive hack here. Store Rt2 in the top 32bits so we only
+	 * have one register to deal with. As we use the same trap
+	 * backends between AArch32 and AArch64, we get away with it.
+	 */
+	if (params.is_write) {
+		u64 val = *vcpu_reg(vcpu, params.Rt);
+		val &= 0xffffffff;
+		val |= *vcpu_reg(vcpu, Rt2) << 32;
+		*vcpu_reg(vcpu, params.Rt) = val;
+	}
+
+	emulate_cp15(vcpu, &params);
+
+	/* Do the opposite hack for the read side */
+	if (!params.is_write) {
+		u64 val = *vcpu_reg(vcpu, params.Rt);
+		val >>= 32;
+		*vcpu_reg(vcpu, Rt2) = val;
+	}
+
+	return 1;
+}
+
+/**
+ * kvm_handle_cp15_32 -- handles a mrc/mcr trap on a guest CP15 access
+ * @vcpu: The VCPU pointer
+ * @run:  The kvm_run struct
+ */
+int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	struct sys_reg_params params;
+	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+
+	params.CRm = (hsr >> 1) & 0xf;
+	params.Rt  = (hsr >> 5) & 0xf;
+	params.is_write = ((hsr & 1) == 0);
+	params.CRn = (hsr >> 10) & 0xf;
+	params.Op0 = 0;
+	params.Op1 = (hsr >> 14) & 0x7;
+	params.Op2 = (hsr >> 17) & 0x7;
+
+	emulate_cp15(vcpu, &params);
+	return 1;
+}
+
 static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 			   const struct sys_reg_params *params)
 {
 	size_t num;
 	const struct sys_reg_desc *table, *r;
 
-	table = get_target_table(vcpu->arch.target, &num);
+	table = get_target_table(vcpu->arch.target, true, &num);
 
 	/* Search target-specific then generic table. */
 	r = find_reg(params, table, num);
@@ -438,7 +605,7 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
 	if (!index_to_params(id, &params))
 		return NULL;
 
-	table = get_target_table(vcpu->arch.target, &num);
+	table = get_target_table(vcpu->arch.target, true, &num);
 	r = find_reg(&params, table, num);
 	if (!r)
 		r = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
@@ -762,7 +929,7 @@ static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
 	size_t num;
 
 	/* We check for duplicates here, to allow arch-specific overrides. */
-	i1 = get_target_table(vcpu->arch.target, &num);
+	i1 = get_target_table(vcpu->arch.target, true, &num);
 	end1 = i1 + num;
 	i2 = sys_reg_descs;
 	end2 = sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
@@ -874,7 +1041,7 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	/* Generic chip reset first (so target could override). */
 	reset_sys_reg_descs(vcpu, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 
-	table = get_target_table(vcpu->arch.target, &num);
+	table = get_target_table(vcpu->arch.target, true, &num);
 	reset_sys_reg_descs(vcpu, table, num);
 
 	for (num = 1; num < NR_SYS_REGS; num++)
-- 
1.8.2.3
