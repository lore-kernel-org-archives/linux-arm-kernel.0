From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:13 +0000
Subject: [PATCH 19/29] ARM: KVM: move hyp init to kvm_host.h
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-20-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the split of the pgd_ptr an implementation specific thing
by moving the init call to an inline function.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h | 19 +++++++++++++++++++
 arch/arm/kvm/arm.c              | 12 +-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 24f457a..f00a557 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -186,4 +186,23 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		int exception_index);
 
+static inline void __cpu_init_hyp_mode(unsigned long long pgd_ptr,
+				       unsigned long hyp_stack_ptr,
+				       unsigned long vector_ptr)
+{
+	unsigned long pgd_low, pgd_high;
+
+	pgd_low = (pgd_ptr & ((1ULL << 32) - 1));
+	pgd_high = (pgd_ptr >> 32ULL);
+
+	/*
+	 * Call initialization code, and switch to the full blown
+	 * HYP code. The init code doesn't need to preserve these registers as
+	 * r1-r3 and r12 are already callee save according to the AAPCS.
+	 * Note that we slightly misuse the prototype by casing the pgd_low to
+	 * a void *.
+	 */
+	kvm_call_hyp((void *)pgd_low, pgd_high, hyp_stack_ptr, vector_ptr);
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index de783ee..3c7c50a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -813,7 +813,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 static void cpu_init_hyp_mode(void *vector)
 {
 	unsigned long long pgd_ptr;
-	unsigned long pgd_low, pgd_high;
 	unsigned long hyp_stack_ptr;
 	unsigned long stack_page;
 	unsigned long vector_ptr;
@@ -822,20 +821,11 @@ static void cpu_init_hyp_mode(void *vector)
 	__hyp_set_vectors((unsigned long)vector);
 
 	pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
-	pgd_low = (pgd_ptr & ((1ULL << 32) - 1));
-	pgd_high = (pgd_ptr >> 32ULL);
 	stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
 	vector_ptr = (unsigned long)__kvm_hyp_vector;
 
-	/*
-	 * Call initialization code, and switch to the full blown
-	 * HYP code. The init code doesn't need to preserve these registers as
-	 * r1-r3 and r12 are already callee save according to the AAPCS.
-	 * Note that we slightly misuse the prototype by casing the pgd_low to
-	 * a void *.
-	 */
-	kvm_call_hyp((void *)pgd_low, pgd_high, hyp_stack_ptr, vector_ptr);
+	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
 
 /**
-- 
1.7.12.4
