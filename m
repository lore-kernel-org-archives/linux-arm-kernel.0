From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 30 Sep 2012 22:19:26 -0400
Subject: [PATCH 03/15] ARM: Section based HYP idmap
In-Reply-To: <20120918130012.GL32204@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153449.21241.26746.stgit@ubuntu>
 <20120918130012.GL32204@mudshark.cambridge.arm.com>
Message-ID: <CANM98q+cTW-cs5y6p-On0unxjQo2y6=Wsj+rLo9vP9r-_DoT-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]

>> +
>> +static int __init hyp_init_static_idmap(void)
>> +{
>> +     hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
>> +     if (!hyp_pgd)
>> +             return -ENOMEM;
>> +
>> +     hyp_idmap_setup();
>> +
>> +     return 0;
>> +}
>> +early_initcall(hyp_init_static_idmap);
>> +#endif
>
> I'd rather the alloc/free functions for the hyp pgd were somewhere else,
> like they are for standard pgds. Then we can just call them here without
> having to encode knowledge of PGD size etc in the mapping code.
>
this used to be the case, but Marc changed it iirc., so just cc'ing
him. The following is an attempt at what you're looking for if I
understand you correctly:

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index a1ab8d6..36708ba 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -12,10 +12,8 @@ extern pgd_t *idmap_pgd;
 void setup_mm_for_reboot(void);

 #ifdef CONFIG_ARM_VIRT_EXT
-extern pgd_t *hyp_pgd;
-
-void hyp_idmap_teardown(void);
-void hyp_idmap_setup(void);
+void hyp_idmap_teardown(pgd_t *hyp_pgd);
+void hyp_idmap_setup(pgd_t *hyp_pgd);
 #endif

 #endif	/* __ASM_IDMAP_H */
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index c3f90b0..ecfaaf0 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -43,4 +43,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu,
struct kvm_run *run);

 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);

+unsigned long kvm_mmu_get_httbr(void);
+int kvm_mmu_init(void);
+void kvm_mmu_exit(void);
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 7e11280..d64ce2a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -35,7 +35,6 @@
 #include <asm/ptrace.h>
 #include <asm/mman.h>
 #include <asm/cputype.h>
-#include <asm/idmap.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/virt.h>
@@ -887,7 +886,7 @@ static void cpu_init_hyp_mode(void *vector)
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors((unsigned long)vector);

-	pgd_ptr = virt_to_phys(hyp_pgd);
+	pgd_ptr = kvm_mmu_get_httbr();
 	stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
 	vector_ptr = (unsigned long)__kvm_hyp_vector;
@@ -918,6 +917,13 @@ static int init_hyp_mode(void)
 	int err = 0;

 	/*
+	 * Allocate Hyp PGD and setup Hyp identity mapping
+	 */
+	err = kvm_mmu_init();
+	if (err)
+		return err;
+
+	/*
 	 * It is probably enough to obtain the default on one
 	 * CPU. It's unlikely to be different on the others.
 	 */
@@ -954,7 +960,7 @@ static int init_hyp_mode(void)
 	/*
 	 * Unmap the identity mapping
 	 */
-	hyp_idmap_teardown();
+	kvm_mmu_exit();

 	/*
 	 * Map the Hyp-code called directly from the host
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 9499d4d..a35a8a9 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -34,6 +34,7 @@
 #include "trace.h"

 static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
+static pgd_t *hyp_pgd;

 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
@@ -994,3 +995,23 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 {
 	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 }
+
+unsigned long kvm_mmu_get_httbr(void)
+{
+	return virt_to_phys(hyp_pgd);
+}
+
+int kvm_mmu_init(void)
+{
+	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	if (!hyp_pgd)
+		return -ENOMEM;
+
+	hyp_idmap_setup(hyp_pgd);
+	return 0;
+}
+
+void kvm_mmu_exit(void)
+{
+	hyp_idmap_teardown(hyp_pgd);
+}
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index f0ab339..ea7430e 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -102,9 +102,6 @@ static int __init init_static_idmap(void)
 early_initcall(init_static_idmap);

 #if defined(CONFIG_ARM_VIRT_EXT) && defined(CONFIG_ARM_LPAE)
-pgd_t *hyp_pgd;
-EXPORT_SYMBOL_GPL(hyp_pgd);
-
 static void hyp_idmap_del_pmd(pgd_t *pgd, unsigned long addr)
 {
 	pud_t *pud;
@@ -123,7 +120,7 @@ extern char  __hyp_idmap_text_start[],
__hyp_idmap_text_end[];
  * This version actually frees the underlying pmds for all pgds in range and
  * clear the pgds themselves afterwards.
  */
-void hyp_idmap_teardown(void)
+void hyp_idmap_teardown(pgd_t *hyp_pgd)
 {
 	unsigned long addr, end;
 	unsigned long next;
@@ -141,27 +138,12 @@ void hyp_idmap_teardown(void)
 }
 EXPORT_SYMBOL_GPL(hyp_idmap_teardown);

-void hyp_idmap_setup(void)
+void hyp_idmap_setup(pgd_t *hyp_pgd)
 {
 	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
 			     __hyp_idmap_text_end, PMD_SECT_AP1);
 }
 EXPORT_SYMBOL_GPL(hyp_idmap_setup);
-
-static int __init hyp_init_static_idmap(void)
-{
-	if (!is_hyp_mode_available())
-		return 0;
-
-	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
-	if (!hyp_pgd)
-		return -ENOMEM;
-
-	hyp_idmap_setup();
-
-	return 0;
-}
-early_initcall(hyp_init_static_idmap);
 #endif

 /*
