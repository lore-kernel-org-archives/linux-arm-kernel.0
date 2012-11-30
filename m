From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Nov 2012 10:58:43 +0000
Subject: [PATCH v4 02/14] ARM: Section based HYP idmap
In-Reply-To: <CANM98q+PnhXAxPQwo3Nu3B9okSsCxLitJ82tjF=awOuvSSS=nA@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154224.2836.21775.stgit@chazy-air>
 <20121119141631.GU3205@mudshark.cambridge.arm.com>
 <CANM98q+PnhXAxPQwo3Nu3B9okSsCxLitJ82tjF=awOuvSSS=nA@mail.gmail.com>
Message-ID: <20121130105843.GB26305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 06:59:07PM +0000, Christoffer Dall wrote:
> On Mon, Nov 19, 2012 at 9:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > I also think it might be cleaner to declare the hyp_pgd next to the
> > idmap_pgd then add the hyp_idmap_setup code to init_static_idmap, so
> > that we don't add new entry points to this file. The teardown can all be
> > moved into the kvm/ code as it doesn't need any of the existing idmap
> > functions.
> >
> 
> hmm, we had some attempts at this earlier, but it wasn't all that
> nice. Allocating the hyp_pgd inside idmap.c requires some more logic,
> and the #ifdefs inside init_static_idmap are also not pretty.

[...]

> I see how you would like to clean this up, but it's not really hard to
> read or understand, imho:

I have to disagree. As it stands, idmap.c has *no* entry points for
manipulating the page tables, which is a good thing because it puts all the
mapping code in one place and makes it both easy to use and easy to reason
about. Your patch starts exposing a load of this stuff to the rest of the
kernel, which is actively going against the design that we currently have.

Here is a quick, untested patch to fix that (modulo the ARM_VIRT_EXT implies
ARM_LPAE change I suggested).

Will

--->8

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index 36708ba..3e79d33 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -9,11 +9,10 @@
 
 extern pgd_t *idmap_pgd;
 
-void setup_mm_for_reboot(void);
-
 #ifdef CONFIG_ARM_VIRT_EXT
-void hyp_idmap_teardown(pgd_t *hyp_pgd);
-void hyp_idmap_setup(pgd_t *hyp_pgd);
+extern pgd_t *hyp_pgd;
 #endif
 
+void setup_mm_for_reboot(void);
+
 #endif	/* __ASM_IDMAP_H */
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 59d422f..a6f6134 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -33,8 +33,9 @@
 
 #include "trace.h"
 
+extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
+
 static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
-static pgd_t *hyp_pgd;
 
 static void kvm_tlb_flush_vmid(struct kvm *kvm)
 {
@@ -725,15 +726,32 @@ unsigned long kvm_mmu_get_httbr(void)
 
 int kvm_mmu_init(void)
 {
-	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
-	if (!hyp_pgd)
-		return -ENOMEM;
-
-	hyp_idmap_setup(hyp_pgd);
-	return 0;
+	return hyp_pgd ? 0 : -ENOMEM;
 }
 
 void kvm_mmu_exit(void)
 {
-	hyp_idmap_teardown(hyp_pgd);
+	/*
+	 * This version actually frees the underlying pmds for all pgds
+	 * in range and clear the pgds themselves afterwards.
+	 */
+	unsigned long addr, end;
+	unsigned long next;
+	pgd_t *pgd = hyp_pgd;
+
+	addr = virt_to_phys(__hyp_idmap_text_start);
+	end = virt_to_phys(__hyp_idmap_text_end);
+
+	pgd += pgd_index(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (!pgd_none_or_clear_bad(pgd)) {
+			pud_t *pud = pud_offset(pgd, addr);
+			pmd_t *pmd = pmd_offset(pud, addr);
+
+			pud_clear(pud);
+			clean_pmd_entry(pmd);
+			pmd_free(NULL, (pmd_t *)((unsigned long)pmd & PAGE_MASK));
+		}
+	} while (pgd++, addr = next, addr < end);
 }
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index ea7430e..c97612e 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -86,65 +86,43 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
 	} while (pgd++, addr = next, addr != end);
 }
 
-extern char  __idmap_text_start[], __idmap_text_end[];
+#ifdef CONFIG_ARM_VIRT_EXT
+pgd_t *hyp_pgd;
 
-static int __init init_static_idmap(void)
+extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
+
+static int __init init_static_idmap_hyp(void)
 {
-	idmap_pgd = pgd_alloc(&init_mm);
-	if (!idmap_pgd)
+	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	if (!hyp_pgd)
 		return -ENOMEM;
 
-	identity_mapping_add(idmap_pgd, __idmap_text_start,
-			     __idmap_text_end, 0);
+	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
+			     __hyp_idmap_text_end, PMD_SECT_AP1);
 
 	return 0;
 }
-early_initcall(init_static_idmap);
-
-#if defined(CONFIG_ARM_VIRT_EXT) && defined(CONFIG_ARM_LPAE)
-static void hyp_idmap_del_pmd(pgd_t *pgd, unsigned long addr)
+#else
+static int __init init_static_idmap_hyp(void)
 {
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	pud_clear(pud);
-	clean_pmd_entry(pmd);
-	pmd_free(NULL, (pmd_t *)((unsigned long)pmd & PAGE_MASK));
+	return 0;
 }
+#endif
 
-extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
+extern char  __idmap_text_start[], __idmap_text_end[];
 
-/*
- * This version actually frees the underlying pmds for all pgds in range and
- * clear the pgds themselves afterwards.
- */
-void hyp_idmap_teardown(pgd_t *hyp_pgd)
+static int __init init_static_idmap(void)
 {
-	unsigned long addr, end;
-	unsigned long next;
-	pgd_t *pgd = hyp_pgd;
-
-	addr = virt_to_phys(__hyp_idmap_text_start);
-	end = virt_to_phys(__hyp_idmap_text_end);
+	idmap_pgd = pgd_alloc(&init_mm);
+	if (!idmap_pgd)
+		return -ENOMEM;
 
-	pgd += pgd_index(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (!pgd_none_or_clear_bad(pgd))
-			hyp_idmap_del_pmd(pgd, addr);
-	} while (pgd++, addr = next, addr < end);
-}
-EXPORT_SYMBOL_GPL(hyp_idmap_teardown);
+	identity_mapping_add(idmap_pgd, __idmap_text_start,
+			     __idmap_text_end, 0);
 
-void hyp_idmap_setup(pgd_t *hyp_pgd)
-{
-	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
-			     __hyp_idmap_text_end, PMD_SECT_AP1);
+	return init_static_idmap_hyp();
 }
-EXPORT_SYMBOL_GPL(hyp_idmap_setup);
-#endif
+early_initcall(init_static_idmap);
 
 /*
  * In order to soft-boot, we need to switch to a 1:1 mapping for the
