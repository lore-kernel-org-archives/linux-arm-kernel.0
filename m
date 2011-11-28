From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:28:57 +0000
Subject: [PATCH v2 6/6] ARM: SMP: use idmap_pgd for mapping MMU enable during
 secondary booting
In-Reply-To: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
Message-ID: <1322504937-24718-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMP booting code allocates a temporary set of page tables
containing an identity mapping of the kernel image and provides this
to secondary CPUs for initial booting.

In reality, we only need to include the __turn_mmu_on function in the
identity mapping since the rest of the kernel is executing from virtual
addresses after this point.

This patch adds __turn_mmu_on to the .idmap.text section, allowing the
SMP booting code to use the idmap_pgd directly and not have to populate
its own set of page table.

As a result of this patch, we can make the identity_mapping_add function
static (since it is only used within mm/idmap.c) and also remove the
identity_mapping_del function. The identity map population is moved to
an early initcall so that it is setup in time for secondary CPU bringup.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/idmap.h |    3 ---
 arch/arm/kernel/head.S       |    4 +++-
 arch/arm/kernel/smp.c        |   31 +------------------------------
 arch/arm/mm/idmap.c          |   34 ++--------------------------------
 4 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index 62e3d19..bf863ed 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -9,9 +9,6 @@
 
 extern pgd_t *idmap_pgd;
 
-void identity_mapping_add(pgd_t *, unsigned long, unsigned long);
-void identity_mapping_del(pgd_t *, unsigned long, unsigned long);
-
 void setup_mm_for_reboot(void);
 
 #endif	/* __ASM_IDMAP_H */
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 43e3aa3..64e9943 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -398,7 +398,8 @@ ENDPROC(__enable_mmu)
  * other registers depend on the function called upon completion
  */
 	.align	5
-__turn_mmu_on:
+	.pushsection	.idmap.text, "ax"
+ENTRY(__turn_mmu_on)
 	mov	r0, r0
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
 	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
@@ -407,6 +408,7 @@ __turn_mmu_on:
 	mov	pc, r3
 __turn_mmu_on_end:
 ENDPROC(__turn_mmu_on)
+	.popsection
 
 
 #ifdef CONFIG_SMP_ON_UP
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8afadda..76ff28d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -62,7 +62,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct cpuinfo_arm *ci = &per_cpu(cpu_data, cpu);
 	struct task_struct *idle = ci->idle;
-	pgd_t *pgd;
 	int ret;
 
 	/*
@@ -85,29 +84,11 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	}
 
 	/*
-	 * Allocate initial page tables to allow the new CPU to
-	 * enable the MMU safely.  This essentially means a set
-	 * of our "standard" page tables, with the addition of
-	 * a 1:1 mapping for the physical address of the kernel.
-	 */
-	pgd = pgd_alloc(&init_mm);
-	if (!pgd)
-		return -ENOMEM;
-
-	if (PHYS_OFFSET != PAGE_OFFSET) {
-#ifndef CONFIG_HOTPLUG_CPU
-		identity_mapping_add(pgd, __pa(__init_begin), __pa(__init_end));
-#endif
-		identity_mapping_add(pgd, __pa(_stext), __pa(_etext));
-		identity_mapping_add(pgd, __pa(_sdata), __pa(_edata));
-	}
-
-	/*
 	 * We need to tell the secondary core where to find
 	 * its stack and the page tables.
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
-	secondary_data.pgdir = virt_to_phys(pgd);
+	secondary_data.pgdir = virt_to_phys(idmap_pgd);
 	secondary_data.swapper_pg_dir = virt_to_phys(swapper_pg_dir);
 	__cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
 	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
@@ -143,16 +124,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	secondary_data.stack = NULL;
 	secondary_data.pgdir = 0;
 
-	if (PHYS_OFFSET != PAGE_OFFSET) {
-#ifndef CONFIG_HOTPLUG_CPU
-		identity_mapping_del(pgd, __pa(__init_begin), __pa(__init_end));
-#endif
-		identity_mapping_del(pgd, __pa(_stext), __pa(_etext));
-		identity_mapping_del(pgd, __pa(_sdata), __pa(_edata));
-	}
-
-	pgd_free(&init_mm, pgd);
-
 	return ret;
 }
 
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index b01760e..660f1bc 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -32,7 +32,7 @@ static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 	} while (pud++, addr = next, addr != end);
 }
 
-void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
+static void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
 {
 	unsigned long prot, next;
 
@@ -47,36 +47,6 @@ void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
 	} while (pgd++, addr = next, addr != end);
 }
 
-#ifdef CONFIG_SMP
-static void idmap_del_pmd(pud_t *pud, unsigned long addr, unsigned long end)
-{
-	pmd_t *pmd = pmd_offset(pud, addr);
-	pmd_clear(pmd);
-}
-
-static void idmap_del_pud(pgd_t *pgd, unsigned long addr, unsigned long end)
-{
-	pud_t *pud = pud_offset(pgd, addr);
-	unsigned long next;
-
-	do {
-		next = pud_addr_end(addr, end);
-		idmap_del_pmd(pud, addr, next);
-	} while (pud++, addr = next, addr != end);
-}
-
-void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end)
-{
-	unsigned long next;
-
-	pgd += pgd_index(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		idmap_del_pud(pgd, addr, next);
-	} while (pgd++, addr = next, addr != end);
-}
-#endif
-
 extern char  __idmap_text_start[], __idmap_text_end[];
 
 static int __init init_static_idmap(void)
@@ -97,7 +67,7 @@ static int __init init_static_idmap(void)
 
 	return 0;
 }
-arch_initcall(init_static_idmap);
+early_initcall(init_static_idmap);
 
 /*
  * In order to soft-boot, we need to switch to a 1:1 mapping for the
-- 
1.7.4.1
