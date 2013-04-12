From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 16:18:48 +0100
Subject: [PATCH v3 3/7] ARM: KVM: move to a KVM provided HYP idmap
In-Reply-To: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
References: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365779932-20322-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the HYP page table rework, it is pretty easy to let the KVM
code provide its own idmap, rather than expecting the kernel to
provide it. It takes actually less code to do so.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/idmap.h   |  1 -
 arch/arm/include/asm/kvm_mmu.h |  1 -
 arch/arm/kvm/mmu.c             | 24 +++++++++++++++++++++++-
 arch/arm/mm/idmap.c            | 32 +-------------------------------
 4 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index 1a66f907..bf863ed 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -8,7 +8,6 @@
 #define __idmap __section(.idmap.text) noinline notrace
 
 extern pgd_t *idmap_pgd;
-extern pgd_t *hyp_pgd;
 
 void setup_mm_for_reboot(void);
 
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 970f3b5..3c71a1d 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -21,7 +21,6 @@
 
 #include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
-#include <asm/idmap.h>
 
 /*
  * We directly use the kernel VA for the HYP, as we can directly share
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 96d61da..bfc5927 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -32,6 +32,7 @@
 
 extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 
+static pgd_t *hyp_pgd;
 static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
@@ -715,12 +716,33 @@ phys_addr_t kvm_mmu_get_httbr(void)
 
 int kvm_mmu_init(void)
 {
+	unsigned long hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
+	unsigned long hyp_idmap_end = virt_to_phys(__hyp_idmap_text_end);
+	int err;
+
+	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
 	if (!hyp_pgd) {
 		kvm_err("Hyp mode PGD not allocated\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Create the idmap in the boot page tables */
+	err = 	__create_hyp_mappings(boot_hyp_pgd,
+				      hyp_idmap_start, hyp_idmap_end,
+				      __phys_to_pfn(hyp_idmap_start),
+				      PAGE_HYP);
+
+	if (err) {
+		kvm_err("Failed to idmap %lx-%lx\n",
+			hyp_idmap_start, hyp_idmap_end);
+		goto out;
 	}
 
 	return 0;
+out:
+	kfree(hyp_pgd);
+	return err;
 }
 
 /**
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 5ee505c..83cb3ac 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -8,7 +8,6 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 #include <asm/system_info.h>
-#include <asm/virt.h>
 
 pgd_t *idmap_pgd;
 
@@ -83,37 +82,10 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
 	} while (pgd++, addr = next, addr != end);
 }
 
-#if defined(CONFIG_ARM_VIRT_EXT) && defined(CONFIG_ARM_LPAE)
-pgd_t *hyp_pgd;
-
-extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
-
-static int __init init_static_idmap_hyp(void)
-{
-	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
-	if (!hyp_pgd)
-		return -ENOMEM;
-
-	pr_info("Setting up static HYP identity map for 0x%p - 0x%p\n",
-		__hyp_idmap_text_start, __hyp_idmap_text_end);
-	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
-			     __hyp_idmap_text_end, PMD_SECT_AP1);
-
-	return 0;
-}
-#else
-static int __init init_static_idmap_hyp(void)
-{
-	return 0;
-}
-#endif
-
 extern char  __idmap_text_start[], __idmap_text_end[];
 
 static int __init init_static_idmap(void)
 {
-	int ret;
-
 	idmap_pgd = pgd_alloc(&init_mm);
 	if (!idmap_pgd)
 		return -ENOMEM;
@@ -123,12 +95,10 @@ static int __init init_static_idmap(void)
 	identity_mapping_add(idmap_pgd, __idmap_text_start,
 			     __idmap_text_end, 0);
 
-	ret = init_static_idmap_hyp();
-
 	/* Flush L1 for the hardware to see this page table content */
 	flush_cache_louis();
 
-	return ret;
+	return 0;
 }
 early_initcall(init_static_idmap);
 
-- 
1.8.1.4
