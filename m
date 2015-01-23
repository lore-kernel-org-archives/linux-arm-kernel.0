From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:44 +0100
Subject: [GIT PULL 15/36] arm/arm64: KVM: rework MPIDR assignment and add
 accessors
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-16-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

The virtual MPIDR registers (containing topology information) for the
guest are currently mapped linearily to the vcpu_id. Improve this
mapping for arm64 by using three levels to not artificially limit the
number of vCPUs.
To help this, change and rename the kvm_vcpu_get_mpidr() function to
mask off the non-affinity bits in the MPIDR register.
Also add an accessor to later allow easier access to a vCPU with a
given MPIDR. Use this new accessor in the PSCI emulation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_emulate.h   |  5 +++--
 arch/arm/include/asm/kvm_host.h      |  2 ++
 arch/arm/kvm/arm.c                   | 13 +++++++++++++
 arch/arm/kvm/psci.c                  | 17 +++++------------
 arch/arm64/include/asm/kvm_emulate.h |  5 +++--
 arch/arm64/include/asm/kvm_host.h    |  2 ++
 arch/arm64/kvm/sys_regs.c            | 13 +++++++++++--
 7 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 66ce176..c528615 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -23,6 +23,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
 #include <asm/kvm_arm.h>
+#include <asm/cputype.h>
 
 unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
 unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu);
@@ -167,9 +168,9 @@ static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
 }
 
-static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
+static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.cp15[c0_MPIDR];
+	return vcpu->arch.cp15[c0_MPIDR] & MPIDR_HWID_BITMASK;
 }
 
 static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 7d07eb8..2fa5174 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -236,6 +236,8 @@ int kvm_perf_teardown(void);
 
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
+struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 74603a0..a7b94ec 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1075,6 +1075,19 @@ static void check_kvm_target_cpu(void *ret)
 	*(int *)ret = kvm_target_cpu();
 }
 
+struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	mpidr &= MPIDR_HWID_BITMASK;
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (mpidr == kvm_vcpu_get_mpidr_aff(vcpu))
+			return vcpu;
+	}
+	return NULL;
+}
+
 /**
  * Initialize Hyp-mode and memory mappings on all CPUs.
  */
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 58cb324..02fa8ef 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -22,6 +22,7 @@
 #include <asm/cputype.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_psci.h>
+#include <asm/kvm_host.h>
 
 /*
  * This is an implementation of the Power State Coordination Interface
@@ -66,25 +67,17 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct kvm *kvm = source_vcpu->kvm;
-	struct kvm_vcpu *vcpu = NULL, *tmp;
+	struct kvm_vcpu *vcpu = NULL;
 	wait_queue_head_t *wq;
 	unsigned long cpu_id;
 	unsigned long context_id;
-	unsigned long mpidr;
 	phys_addr_t target_pc;
-	int i;
 
-	cpu_id = *vcpu_reg(source_vcpu, 1);
+	cpu_id = *vcpu_reg(source_vcpu, 1) & MPIDR_HWID_BITMASK;
 	if (vcpu_mode_is_32bit(source_vcpu))
 		cpu_id &= ~((u32) 0);
 
-	kvm_for_each_vcpu(i, tmp, kvm) {
-		mpidr = kvm_vcpu_get_mpidr(tmp);
-		if ((mpidr & MPIDR_HWID_BITMASK) == (cpu_id & MPIDR_HWID_BITMASK)) {
-			vcpu = tmp;
-			break;
-		}
-	}
+	vcpu = kvm_mpidr_to_vcpu(kvm, cpu_id);
 
 	/*
 	 * Make sure the caller requested a valid CPU and that the CPU is
@@ -155,7 +148,7 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 	 * then ON else OFF
 	 */
 	kvm_for_each_vcpu(i, tmp, kvm) {
-		mpidr = kvm_vcpu_get_mpidr(tmp);
+		mpidr = kvm_vcpu_get_mpidr_aff(tmp);
 		if (((mpidr & target_affinity_mask) == target_affinity) &&
 		    !tmp->arch.pause) {
 			return PSCI_0_2_AFFINITY_LEVEL_ON;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index a6fa2d2..b3f1def 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -27,6 +27,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmio.h>
 #include <asm/ptrace.h>
+#include <asm/cputype.h>
 
 unsigned long *vcpu_reg32(const struct kvm_vcpu *vcpu, u8 reg_num);
 unsigned long *vcpu_spsr32(const struct kvm_vcpu *vcpu);
@@ -192,9 +193,9 @@ static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_FSC_TYPE;
 }
 
-static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
+static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
-	return vcpu_sys_reg(vcpu, MPIDR_EL1);
+	return vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
 }
 
 static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 012af6c..ff8ee3e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -207,6 +207,8 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
 
+struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
+
 static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 				       phys_addr_t pgd_ptr,
 				       unsigned long hyp_stack_ptr,
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3d7c2df..136e679 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -252,10 +252,19 @@ static void reset_amair_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 
 static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
+	u64 mpidr;
+
 	/*
-	 * Simply map the vcpu_id into the Aff0 field of the MPIDR.
+	 * Map the vcpu_id into the first three affinity level fields of
+	 * the MPIDR. We limit the number of VCPUs in level 0 due to a
+	 * limitation to 16 CPUs in that level in the ICC_SGIxR registers
+	 * of the GICv3 to be able to address each CPU directly when
+	 * sending IPIs.
 	 */
-	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1UL << 31) | (vcpu->vcpu_id & 0xff);
+	mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
+	mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
+	mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
+	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1ULL << 31) | mpidr;
 }
 
 /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
-- 
2.1.2.330.g565301e.dirty
