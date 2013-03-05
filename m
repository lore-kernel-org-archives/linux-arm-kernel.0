From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:42:55 +0000
Subject: [PATCH 01/29] ARM: KVM: convert GP registers from u32 to unsigned long
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 32bit ARM, unsigned long is guaranteed to be a 32bit quantity.
On 64bit ARM, it is a 64bit quantity.

In order to be able to share code between the two architectures,
convert the registers to be unsigned long, so the core code can
be oblivious of the change.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 12 ++++++------
 arch/arm/include/uapi/asm/kvm.h    | 12 ++++++------
 arch/arm/kvm/coproc.c              |  4 ++--
 arch/arm/kvm/coproc.h              |  4 ++--
 arch/arm/kvm/emulate.c             | 22 +++++++++++-----------
 arch/arm/kvm/mmio.c                |  2 +-
 6 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index fd61199..510488a 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -23,8 +23,8 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
 
-u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
-u32 *vcpu_spsr(struct kvm_vcpu *vcpu);
+unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
+unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu);
 
 int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr);
@@ -37,14 +37,14 @@ static inline bool vcpu_mode_is_32bit(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
+static inline unsigned long *vcpu_pc(struct kvm_vcpu *vcpu)
 {
-	return (u32 *)&vcpu->arch.regs.usr_regs.ARM_pc;
+	return &vcpu->arch.regs.usr_regs.ARM_pc;
 }
 
-static inline u32 *vcpu_cpsr(struct kvm_vcpu *vcpu)
+static inline unsigned long *vcpu_cpsr(struct kvm_vcpu *vcpu)
 {
-	return (u32 *)&vcpu->arch.regs.usr_regs.ARM_cpsr;
+	return &vcpu->arch.regs.usr_regs.ARM_cpsr;
 }
 
 static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 023bfeb..c1ee007 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -53,12 +53,12 @@
 #define KVM_ARM_FIQ_spsr	fiq_regs[7]
 
 struct kvm_regs {
-	struct pt_regs usr_regs;/* R0_usr - R14_usr, PC, CPSR */
-	__u32 svc_regs[3];	/* SP_svc, LR_svc, SPSR_svc */
-	__u32 abt_regs[3];	/* SP_abt, LR_abt, SPSR_abt */
-	__u32 und_regs[3];	/* SP_und, LR_und, SPSR_und */
-	__u32 irq_regs[3];	/* SP_irq, LR_irq, SPSR_irq */
-	__u32 fiq_regs[8];	/* R8_fiq - R14_fiq, SPSR_fiq */
+	struct pt_regs usr_regs;	/* R0_usr - R14_usr, PC, CPSR */
+	unsigned long svc_regs[3];	/* SP_svc, LR_svc, SPSR_svc */
+	unsigned long abt_regs[3];	/* SP_abt, LR_abt, SPSR_abt */
+	unsigned long und_regs[3];	/* SP_und, LR_und, SPSR_und */
+	unsigned long irq_regs[3];	/* SP_irq, LR_irq, SPSR_irq */
+	unsigned long fiq_regs[8];	/* R8_fiq - R14_fiq, SPSR_fiq */
 };
 
 /* Supported Processor Types */
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 4ea9a98..38e76bc 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -76,7 +76,7 @@ static bool access_dcsw(struct kvm_vcpu *vcpu,
 			const struct coproc_params *p,
 			const struct coproc_reg *r)
 {
-	u32 val;
+	unsigned long val;
 	int cpu;
 
 	cpu = get_cpu();
@@ -298,7 +298,7 @@ static int emulate_cp15(struct kvm_vcpu *vcpu,
 		}
 		/* If access function fails, it should complain. */
 	} else {
-		kvm_err("Unsupported guest CP15 access at: %08x\n",
+		kvm_err("Unsupported guest CP15 access at: %08lx\n",
 			*vcpu_pc(vcpu));
 		print_cp_instr(params);
 	}
diff --git a/arch/arm/kvm/coproc.h b/arch/arm/kvm/coproc.h
index 992adfa..b7301d3 100644
--- a/arch/arm/kvm/coproc.h
+++ b/arch/arm/kvm/coproc.h
@@ -84,7 +84,7 @@ static inline bool read_zero(struct kvm_vcpu *vcpu,
 static inline bool write_to_read_only(struct kvm_vcpu *vcpu,
 				      const struct coproc_params *params)
 {
-	kvm_debug("CP15 write to read-only register at: %08x\n",
+	kvm_debug("CP15 write to read-only register at: %08lx\n",
 		  *vcpu_pc(vcpu));
 	print_cp_instr(params);
 	return false;
@@ -93,7 +93,7 @@ static inline bool write_to_read_only(struct kvm_vcpu *vcpu,
 static inline bool read_from_write_only(struct kvm_vcpu *vcpu,
 					const struct coproc_params *params)
 {
-	kvm_debug("CP15 read to write-only register at: %08x\n",
+	kvm_debug("CP15 read to write-only register at: %08lx\n",
 		  *vcpu_pc(vcpu));
 	print_cp_instr(params);
 	return false;
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index d61450a..d3094eb 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -109,10 +109,10 @@ static const unsigned long vcpu_reg_offsets[VCPU_NR_MODES][15] = {
  * Return a pointer to the register number valid in the current mode of
  * the virtual CPU.
  */
-u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num)
+unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num)
 {
-	u32 *reg_array = (u32 *)&vcpu->arch.regs;
-	u32 mode = *vcpu_cpsr(vcpu) & MODE_MASK;
+	unsigned long *reg_array = (unsigned long *)&vcpu->arch.regs;
+	unsigned long mode = *vcpu_cpsr(vcpu) & MODE_MASK;
 
 	switch (mode) {
 	case USR_MODE...SVC_MODE:
@@ -141,9 +141,9 @@ u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num)
 /*
  * Return the SPSR for the current mode of the virtual CPU.
  */
-u32 *vcpu_spsr(struct kvm_vcpu *vcpu)
+unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu)
 {
-	u32 mode = *vcpu_cpsr(vcpu) & MODE_MASK;
+	unsigned long mode = *vcpu_cpsr(vcpu) & MODE_MASK;
 	switch (mode) {
 	case SVC_MODE:
 		return &vcpu->arch.regs.KVM_ARM_SVC_spsr;
@@ -257,9 +257,9 @@ static u32 exc_vector_base(struct kvm_vcpu *vcpu)
  */
 void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 {
-	u32 new_lr_value;
-	u32 new_spsr_value;
-	u32 cpsr = *vcpu_cpsr(vcpu);
+	unsigned long new_lr_value;
+	unsigned long new_spsr_value;
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
 	u32 sctlr = vcpu->arch.cp15[c1_SCTLR];
 	bool is_thumb = (cpsr & PSR_T_BIT);
 	u32 vect_offset = 4;
@@ -291,9 +291,9 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
  */
 static void inject_abt(struct kvm_vcpu *vcpu, bool is_pabt, unsigned long addr)
 {
-	u32 new_lr_value;
-	u32 new_spsr_value;
-	u32 cpsr = *vcpu_cpsr(vcpu);
+	unsigned long new_lr_value;
+	unsigned long new_spsr_value;
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
 	u32 sctlr = vcpu->arch.cp15[c1_SCTLR];
 	bool is_thumb = (cpsr & PSR_T_BIT);
 	u32 vect_offset;
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 98a870f..c186bc9 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -33,7 +33,7 @@
  */
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	__u32 *dest;
+	unsigned long *dest;
 	unsigned int len;
 	int mask;
 
-- 
1.7.12.4
