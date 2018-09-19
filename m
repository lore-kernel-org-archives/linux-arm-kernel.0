From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Wed, 19 Sep 2018 09:04:08 +0530
Subject: [PATCH 1/3] arm64/cpufeatures: Introduce ESR_ELx_SYS64_ISS_RT()
In-Reply-To: <1537328050-29176-1-git-send-email-anshuman.khandual@arm.com>
References: <1537328050-29176-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537328050-29176-2-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extracting target register from ESR.ISS encoding has already been required
at multiple instances. Just make it a macro definition and replace all the
existing use cases.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/esr.h         | 2 ++
 arch/arm64/include/asm/kvm_emulate.h | 2 +-
 arch/arm64/kernel/traps.c            | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ce70c3f..cc2d9e7 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -187,6 +187,8 @@
 
 #define ESR_ELx_SYS64_ISS_SYS_OP_MASK	(ESR_ELx_SYS64_ISS_SYS_MASK | \
 					 ESR_ELx_SYS64_ISS_DIR_MASK)
+#define ESR_ELx_SYS64_ISS_RT(esr) \
+	(((esr) & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT)
 /*
  * User space cache operations have the following sysreg encoding
  * in System instructions.
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 6106a85..2124787 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -335,7 +335,7 @@ static inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
 static inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 {
 	u32 esr = kvm_vcpu_get_hsr(vcpu);
-	return (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 039e9ff..15276b2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -437,7 +437,7 @@ void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 {
 	unsigned long address;
-	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+	int rt = ESR_ELx_SYS64_ISS_RT(esr);
 	int crm = (esr & ESR_ELx_SYS64_ISS_CRM_MASK) >> ESR_ELx_SYS64_ISS_CRM_SHIFT;
 	int ret = 0;
 
@@ -472,7 +472,7 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 
 static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
 {
-	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+	int rt = ESR_ELx_SYS64_ISS_RT(esr);
 	unsigned long val = arm64_ftr_reg_user_value(&arm64_ftr_reg_ctrel0);
 
 	pt_regs_write_reg(regs, rt, val);
@@ -482,7 +482,7 @@ static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
 
 static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
 {
-	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+	int rt = ESR_ELx_SYS64_ISS_RT(esr);
 
 	pt_regs_write_reg(regs, rt, arch_counter_get_cntvct());
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
@@ -490,7 +490,7 @@ static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
 
 static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 {
-	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+	int rt = ESR_ELx_SYS64_ISS_RT(esr);
 
 	pt_regs_write_reg(regs, rt, arch_timer_get_rate());
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
-- 
2.7.4
