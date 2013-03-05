From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:42:56 +0000
Subject: [PATCH 02/29] ARM: KVM: abstract fault register accesses
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of directly accessing the fault registers, use proper accessors
so the core code can be shared.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 21 +++++++++++++++++++++
 arch/arm/include/asm/kvm_host.h    | 14 ++++++++------
 arch/arm/kernel/asm-offsets.c      |  8 ++++----
 arch/arm/kvm/arm.c                 | 26 +++++++++++++-------------
 arch/arm/kvm/coproc.c              | 24 ++++++++++++------------
 arch/arm/kvm/mmio.c                | 22 +++++++++++-----------
 arch/arm/kvm/mmu.c                 | 16 ++++++++--------
 7 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 510488a..3c01988 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -22,6 +22,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
+#include <asm/kvm_arm.h>
 
 unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
 unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu);
@@ -69,4 +70,24 @@ static inline bool kvm_vcpu_reg_is_pc(struct kvm_vcpu *vcpu, int reg)
 	return reg == 15;
 }
 
+static inline u32 kvm_vcpu_get_hsr(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.fault.hsr;
+}
+
+static inline unsigned long kvm_vcpu_get_hfar(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.fault.hxfar;
+}
+
+static inline phys_addr_t kvm_vcpu_get_fault_ipa(struct kvm_vcpu *vcpu)
+{
+	return ((phys_addr_t)vcpu->arch.fault.hpfar & HPFAR_MASK) << 8;
+}
+
+static inline unsigned long kvm_vcpu_get_hyp_pc(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.fault.hyp_pc;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index d1736a5..eb836e6 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -80,6 +80,13 @@ struct kvm_mmu_memory_cache {
 	void *objects[KVM_NR_MEM_OBJS];
 };
 
+struct kvm_vcpu_fault_info {
+	u32 hsr;		/* Hyp Syndrome Register */
+	u32 hxfar;		/* Hyp Data/Inst. Fault Address Register */
+	u32 hpfar;		/* Hyp IPA Fault Address Register */
+	u32 hyp_pc;		/* PC when exception was taken from Hyp mode */
+};
+
 struct kvm_vcpu_arch {
 	struct kvm_regs regs;
 
@@ -93,9 +100,7 @@ struct kvm_vcpu_arch {
 	u32 midr;
 
 	/* Exception Information */
-	u32 hsr;		/* Hyp Syndrome Register */
-	u32 hxfar;		/* Hyp Data/Inst Fault Address Register */
-	u32 hpfar;		/* Hyp IPA Fault Address Register */
+	struct kvm_vcpu_fault_info fault;
 
 	/* Floating point registers (VFP and Advanced SIMD/NEON) */
 	struct vfp_hard_struct vfp_guest;
@@ -122,9 +127,6 @@ struct kvm_vcpu_arch {
 	/* Interrupt related fields */
 	u32 irq_lines;		/* IRQ and FIQ levels */
 
-	/* Hyp exception information */
-	u32 hyp_pc;		/* PC when exception was taken from Hyp mode */
-
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 5ce738b..3c09d8c 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -165,10 +165,10 @@ int main(void)
   DEFINE(VCPU_PC,		offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_pc));
   DEFINE(VCPU_CPSR,		offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_cpsr));
   DEFINE(VCPU_IRQ_LINES,	offsetof(struct kvm_vcpu, arch.irq_lines));
-  DEFINE(VCPU_HSR,		offsetof(struct kvm_vcpu, arch.hsr));
-  DEFINE(VCPU_HxFAR,		offsetof(struct kvm_vcpu, arch.hxfar));
-  DEFINE(VCPU_HPFAR,		offsetof(struct kvm_vcpu, arch.hpfar));
-  DEFINE(VCPU_HYP_PC,		offsetof(struct kvm_vcpu, arch.hyp_pc));
+  DEFINE(VCPU_HSR,		offsetof(struct kvm_vcpu, arch.fault.hsr));
+  DEFINE(VCPU_HxFAR,		offsetof(struct kvm_vcpu, arch.fault.hxfar));
+  DEFINE(VCPU_HPFAR,		offsetof(struct kvm_vcpu, arch.fault.hpfar));
+  DEFINE(VCPU_HYP_PC,		offsetof(struct kvm_vcpu, arch.fault.hyp_pc));
 #ifdef CONFIG_KVM_ARM_VGIC
   DEFINE(VCPU_VGIC_CPU,		offsetof(struct kvm_vcpu, arch.vgic_cpu));
   DEFINE(VGIC_CPU_HCR,		offsetof(struct vgic_cpu, vgic_hcr));
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5a93698..6ba934b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -513,16 +513,16 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 static int handle_pabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	/* The hypervisor should never cause aborts */
-	kvm_err("Prefetch Abort taken from Hyp mode at %#08x (HSR: %#08x)\n",
-		vcpu->arch.hxfar, vcpu->arch.hsr);
+	kvm_err("Prefetch Abort taken from Hyp mode at %#08lx (HSR: %#08x)\n",
+		kvm_vcpu_get_hfar(vcpu), kvm_vcpu_get_hsr(vcpu));
 	return -EFAULT;
 }
 
 static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	/* This is either an error in the ws. code or an external abort */
-	kvm_err("Data Abort taken from Hyp mode at %#08x (HSR: %#08x)\n",
-		vcpu->arch.hxfar, vcpu->arch.hsr);
+	kvm_err("Data Abort taken from Hyp mode at %#08lx (HSR: %#08x)\n",
+		kvm_vcpu_get_hfar(vcpu), kvm_vcpu_get_hsr(vcpu));
 	return -EFAULT;
 }
 
@@ -559,17 +559,17 @@ static bool kvm_condition_valid(struct kvm_vcpu *vcpu)
 	 * catch undefined instructions, and then we won't get past
 	 * the arm_exit_handlers test anyway.
 	 */
-	BUG_ON(((vcpu->arch.hsr & HSR_EC) >> HSR_EC_SHIFT) == 0);
+	BUG_ON(((kvm_vcpu_get_hsr(vcpu) & HSR_EC) >> HSR_EC_SHIFT) == 0);
 
 	/* Top two bits non-zero?  Unconditional. */
-	if (vcpu->arch.hsr >> 30)
+	if (kvm_vcpu_get_hsr(vcpu) >> 30)
 		return true;
 
 	cpsr = *vcpu_cpsr(vcpu);
 
 	/* Is condition field valid? */
-	if ((vcpu->arch.hsr & HSR_CV) >> HSR_CV_SHIFT)
-		cond = (vcpu->arch.hsr & HSR_COND) >> HSR_COND_SHIFT;
+	if ((kvm_vcpu_get_hsr(vcpu) & HSR_CV) >> HSR_CV_SHIFT)
+		cond = (kvm_vcpu_get_hsr(vcpu) & HSR_COND) >> HSR_COND_SHIFT;
 	else {
 		/* This can happen in Thumb mode: examine IT state. */
 		unsigned long it;
@@ -602,20 +602,20 @@ static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case ARM_EXCEPTION_IRQ:
 		return 1;
 	case ARM_EXCEPTION_UNDEFINED:
-		kvm_err("Undefined exception in Hyp mode at: %#08x\n",
-			vcpu->arch.hyp_pc);
+		kvm_err("Undefined exception in Hyp mode at: %#08lx\n",
+			kvm_vcpu_get_hyp_pc(vcpu));
 		BUG();
 		panic("KVM: Hypervisor undefined exception!\n");
 	case ARM_EXCEPTION_DATA_ABORT:
 	case ARM_EXCEPTION_PREF_ABORT:
 	case ARM_EXCEPTION_HVC:
-		hsr_ec = (vcpu->arch.hsr & HSR_EC) >> HSR_EC_SHIFT;
+		hsr_ec = (kvm_vcpu_get_hsr(vcpu) & HSR_EC) >> HSR_EC_SHIFT;
 
 		if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers)
 		    || !arm_exit_handlers[hsr_ec]) {
 			kvm_err("Unkown exception class: %#08lx, "
 				"hsr: %#08x\n", hsr_ec,
-				(unsigned int)vcpu->arch.hsr);
+				(unsigned int)kvm_vcpu_get_hsr(vcpu));
 			BUG();
 		}
 
@@ -624,7 +624,7 @@ static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		 * that fail their condition code check"
 		 */
 		if (!kvm_condition_valid(vcpu)) {
-			bool is_wide = vcpu->arch.hsr & HSR_IL;
+			bool is_wide = kvm_vcpu_get_hsr(vcpu) & HSR_IL;
 			kvm_skip_instr(vcpu, is_wide);
 			return 1;
 		}
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 38e76bc..b305916 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -293,7 +293,7 @@ static int emulate_cp15(struct kvm_vcpu *vcpu,
 
 		if (likely(r->access(vcpu, params, r))) {
 			/* Skip instruction, since it was emulated */
-			kvm_skip_instr(vcpu, (vcpu->arch.hsr >> 25) & 1);
+			kvm_skip_instr(vcpu, (kvm_vcpu_get_hsr(vcpu) >> 25) & 1);
 			return 1;
 		}
 		/* If access function fails, it should complain. */
@@ -315,14 +315,14 @@ int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	struct coproc_params params;
 
-	params.CRm = (vcpu->arch.hsr >> 1) & 0xf;
-	params.Rt1 = (vcpu->arch.hsr >> 5) & 0xf;
-	params.is_write = ((vcpu->arch.hsr & 1) == 0);
+	params.CRm = (kvm_vcpu_get_hsr(vcpu) >> 1) & 0xf;
+	params.Rt1 = (kvm_vcpu_get_hsr(vcpu) >> 5) & 0xf;
+	params.is_write = ((kvm_vcpu_get_hsr(vcpu) & 1) == 0);
 	params.is_64bit = true;
 
-	params.Op1 = (vcpu->arch.hsr >> 16) & 0xf;
+	params.Op1 = (kvm_vcpu_get_hsr(vcpu) >> 16) & 0xf;
 	params.Op2 = 0;
-	params.Rt2 = (vcpu->arch.hsr >> 10) & 0xf;
+	params.Rt2 = (kvm_vcpu_get_hsr(vcpu) >> 10) & 0xf;
 	params.CRn = 0;
 
 	return emulate_cp15(vcpu, &params);
@@ -347,14 +347,14 @@ int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	struct coproc_params params;
 
-	params.CRm = (vcpu->arch.hsr >> 1) & 0xf;
-	params.Rt1 = (vcpu->arch.hsr >> 5) & 0xf;
-	params.is_write = ((vcpu->arch.hsr & 1) == 0);
+	params.CRm = (kvm_vcpu_get_hsr(vcpu) >> 1) & 0xf;
+	params.Rt1 = (kvm_vcpu_get_hsr(vcpu) >> 5) & 0xf;
+	params.is_write = ((kvm_vcpu_get_hsr(vcpu) & 1) == 0);
 	params.is_64bit = false;
 
-	params.CRn = (vcpu->arch.hsr >> 10) & 0xf;
-	params.Op1 = (vcpu->arch.hsr >> 14) & 0x7;
-	params.Op2 = (vcpu->arch.hsr >> 17) & 0x7;
+	params.CRn = (kvm_vcpu_get_hsr(vcpu) >> 10) & 0xf;
+	params.Op1 = (kvm_vcpu_get_hsr(vcpu) >> 14) & 0x7;
+	params.Op2 = (kvm_vcpu_get_hsr(vcpu) >> 17) & 0x7;
 	params.Rt2 = 0;
 
 	return emulate_cp15(vcpu, &params);
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index c186bc9..ce63f39 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -65,19 +65,19 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	unsigned long rt, len;
 	bool is_write, sign_extend;
 
-	if ((vcpu->arch.hsr >> 8) & 1) {
+	if ((kvm_vcpu_get_hsr(vcpu) >> 8) & 1) {
 		/* cache operation on I/O addr, tell guest unsupported */
-		kvm_inject_dabt(vcpu, vcpu->arch.hxfar);
+		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 		return 1;
 	}
 
-	if ((vcpu->arch.hsr >> 7) & 1) {
+	if ((kvm_vcpu_get_hsr(vcpu) >> 7) & 1) {
 		/* page table accesses IO mem: tell guest to fix its TTBR */
-		kvm_inject_dabt(vcpu, vcpu->arch.hxfar);
+		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 		return 1;
 	}
 
-	switch ((vcpu->arch.hsr >> 22) & 0x3) {
+	switch ((kvm_vcpu_get_hsr(vcpu) >> 22) & 0x3) {
 	case 0:
 		len = 1;
 		break;
@@ -92,13 +92,13 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	is_write = vcpu->arch.hsr & HSR_WNR;
-	sign_extend = vcpu->arch.hsr & HSR_SSE;
-	rt = (vcpu->arch.hsr & HSR_SRT_MASK) >> HSR_SRT_SHIFT;
+	is_write = kvm_vcpu_get_hsr(vcpu) & HSR_WNR;
+	sign_extend = kvm_vcpu_get_hsr(vcpu) & HSR_SSE;
+	rt = (kvm_vcpu_get_hsr(vcpu) & HSR_SRT_MASK) >> HSR_SRT_SHIFT;
 
 	if (kvm_vcpu_reg_is_pc(vcpu, rt)) {
 		/* IO memory trying to read/write pc */
-		kvm_inject_pabt(vcpu, vcpu->arch.hxfar);
+		kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 		return 1;
 	}
 
@@ -112,7 +112,7 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * The MMIO instruction is emulated and should not be re-executed
 	 * in the guest.
 	 */
-	kvm_skip_instr(vcpu, (vcpu->arch.hsr >> 25) & 1);
+	kvm_skip_instr(vcpu, (kvm_vcpu_get_hsr(vcpu) >> 25) & 1);
 	return 0;
 }
 
@@ -130,7 +130,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	 * space do its magic.
 	 */
 
-	if (vcpu->arch.hsr & HSR_ISV) {
+	if (kvm_vcpu_get_hsr(vcpu) & HSR_ISV) {
 		ret = decode_hsr(vcpu, fault_ipa, &mmio);
 		if (ret)
 			return ret;
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 99e07c7..d0f5f52 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -526,7 +526,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	unsigned long mmu_seq;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 
-	write_fault = kvm_is_write_fault(vcpu->arch.hsr);
+	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
 		kvm_err("Unexpected L2 read permission error\n");
 		return -EFAULT;
@@ -593,15 +593,15 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	gfn_t gfn;
 	int ret, idx;
 
-	hsr_ec = vcpu->arch.hsr >> HSR_EC_SHIFT;
+	hsr_ec = kvm_vcpu_get_hsr(vcpu) >> HSR_EC_SHIFT;
 	is_iabt = (hsr_ec == HSR_EC_IABT);
-	fault_ipa = ((phys_addr_t)vcpu->arch.hpfar & HPFAR_MASK) << 8;
+	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 
-	trace_kvm_guest_fault(*vcpu_pc(vcpu), vcpu->arch.hsr,
-			      vcpu->arch.hxfar, fault_ipa);
+	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
+			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
 
 	/* Check the stage-2 fault is trans. fault or write fault */
-	fault_status = (vcpu->arch.hsr & HSR_FSC_TYPE);
+	fault_status = (kvm_vcpu_get_hsr(vcpu) & HSR_FSC_TYPE);
 	if (fault_status != FSC_FAULT && fault_status != FSC_PERM) {
 		kvm_err("Unsupported fault status: EC=%#lx DFCS=%#lx\n",
 			hsr_ec, fault_status);
@@ -614,7 +614,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (!kvm_is_visible_gfn(vcpu->kvm, gfn)) {
 		if (is_iabt) {
 			/* Prefetch Abort on I/O address */
-			kvm_inject_pabt(vcpu, vcpu->arch.hxfar);
+			kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 			ret = 1;
 			goto out_unlock;
 		}
@@ -627,7 +627,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		}
 
 		/* Adjust page offset */
-		fault_ipa |= vcpu->arch.hxfar & ~PAGE_MASK;
+		fault_ipa |= kvm_vcpu_get_hfar(vcpu) & ~PAGE_MASK;
 		ret = io_mem_abort(vcpu, run, fault_ipa);
 		goto out_unlock;
 	}
-- 
1.7.12.4
