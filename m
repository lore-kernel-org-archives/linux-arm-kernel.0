From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 12 Apr 2016 11:14:40 +0300
Subject: [RFC 1/1] ARM: mm: add support for specifying shareability level via
 cmdline
In-Reply-To: <1460448880-5677-1-git-send-email-t-kristo@ti.com>
References: <1460448880-5677-1-git-send-email-t-kristo@ti.com>
Message-ID: <1460448880-5677-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pmd_sect_s=x can be used to specify cache coherency level for the CPU.
The value is used to setup cache coherency level for specific MMU
mappings. Currently kernel only supports inner shareable attribute.

This feature is required at least for keystone DMA cache coherency
support, where pages meant to be used by DMA must be marked as outer
shareable also, so the DMA masters can snoop the maintenance messages.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/include/asm/fixmap.h  |    2 +-
 arch/arm/include/asm/pgtable.h |    3 +++
 arch/arm/kernel/setup.c        |   39 +++++++++++++++++++++++++++++++---
 arch/arm/mm/dump.c             |    3 +++
 arch/arm/mm/mmu.c              |   46 +++++++++++++++++++++++++---------------
 5 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 5c17d2d..310981a 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -45,7 +45,7 @@ static const enum fixed_addresses __end_of_fixed_addresses =
 #define FIXMAP_PAGE_RO		(FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
 
 /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
-#define FIXMAP_PAGE_IO		(FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
+#define FIXMAP_PAGE_IO		(FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED | l_pte_shared)
 #define FIXMAP_PAGE_NOCACHE	FIXMAP_PAGE_IO
 
 #define __early_set_fixmap	__set_fixmap
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 348caab..e8a28aa 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -86,6 +86,9 @@ extern pgprot_t		pgprot_hyp_device;
 extern pgprot_t		pgprot_s2;
 extern pgprot_t		pgprot_s2_device;
 
+extern pteval_t		pmd_sect_s;
+extern pteval_t		l_pte_shared;
+
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
 #define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN | L_PTE_RDONLY | L_PTE_NONE)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 139791e..3836c9a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <linux/compiler.h>
 #include <linux/sort.h>
 #include <linux/psci.h>
+#include <linux/moduleparam.h>
 
 #include <asm/unified.h>
 #include <asm/cp15.h>
@@ -668,6 +669,8 @@ static void __init smp_build_mpidr_hash(void)
 }
 #endif
 
+static unsigned long cpu_mm_mmu_flags;
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
@@ -704,6 +707,8 @@ static void __init setup_processor(void)
 		cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
 		proc_arch[cpu_architecture()], get_cr());
 
+	cpu_mm_mmu_flags = list->__cpu_mm_mmu_flags;
+
 	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
 		 list->arch_name, ENDIANNESS);
 	snprintf(elf_platform, ELF_PLATFORM_SIZE, "%s%c",
@@ -716,9 +721,6 @@ static void __init setup_processor(void)
 #ifndef CONFIG_ARM_THUMB
 	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
 #endif
-#ifdef CONFIG_MMU
-	init_default_cache_policy(list->__cpu_mm_mmu_flags);
-#endif
 	erratum_a15_798181_init();
 
 	elf_hwcap_fixup();
@@ -1002,6 +1004,36 @@ void __init hyp_mode_check(void)
 #endif
 }
 
+pteval_t pmd_sect_s = PMD_SECT_S;
+pteval_t l_pte_shared = L_PTE_SHARED;
+
+static int __init parse_mmu_setup(char *str)
+{
+	u32 new_val;
+
+	if (!get_option(&str, &new_val))
+		return -EINVAL;
+
+	if (new_val < 2 || new_val > 3) {
+		pr_err("%s: bad value: %d\n", __func__, new_val);
+		return -EINVAL;
+	}
+
+	new_val = _AT(pteval_t, new_val) << 8;
+
+	pr_info("%s: setting PMD_SECT_S to %08x, old-val%08x\n", __func__,
+		new_val, (u32)pmd_sect_s);
+
+	pmd_sect_s = new_val;
+	l_pte_shared = new_val;
+
+	cpu_mm_mmu_flags = ~(u32)PMD_SECT_S;
+	cpu_mm_mmu_flags |= pmd_sect_s;
+
+	return 0;
+}
+early_param("pmd_sect_s", parse_mmu_setup);
+
 void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc;
@@ -1032,6 +1064,7 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 #ifdef CONFIG_MMU
+	init_default_cache_policy(cpu_mm_mmu_flags);
 	early_paging_init(mdesc);
 #endif
 	setup_dma_zone(mdesc);
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 9fe8e24..319412e 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -346,6 +346,9 @@ static int ptdump_init(void)
 	struct dentry *pe;
 	unsigned i, j;
 
+	if (l_pte_shared != L_PTE_SHARED)
+		pte_bits[3].val = l_pte_shared;
+
 	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
 		if (pg_level[i].bits)
 			for (j = 0; j < pg_level[i].num; j++)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 62f4d01..4140acb 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -454,9 +454,9 @@ static void __init build_mem_type_table(void)
 			pr_warn("Forcing write-allocate cache policy for SMP\n");
 			cachepolicy = CPOLICY_WRITEALLOC;
 		}
-		if (!(initial_pmd_value & PMD_SECT_S)) {
+		if ((initial_pmd_value & PMD_SECT_S) != pmd_sect_s) {
 			pr_warn("Forcing shared mappings for SMP\n");
-			initial_pmd_value |= PMD_SECT_S;
+			initial_pmd_value |= pmd_sect_s;
 		}
 	}
 
@@ -591,27 +591,39 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 #endif
 
+		mem_types[MT_DEVICE].prot_sect &= ~PMD_SECT_S;
+		mem_types[MT_DEVICE].prot_sect |= pmd_sect_s;
+
+		mem_types[MT_DEVICE].prot_pte &= ~L_PTE_SHARED;
+		mem_types[MT_DEVICE].prot_pte |= l_pte_shared;
+
+		mem_types[MT_DEVICE].prot_pte_s2 &= ~L_PTE_SHARED;
+		mem_types[MT_DEVICE].prot_pte_s2 |= l_pte_shared;
+
+		mem_types[MT_MEMORY_RW_SO].prot_sect &= ~PMD_SECT_S;
+		mem_types[MT_MEMORY_RW_SO].prot_sect |= pmd_sect_s;
+
 		/*
 		 * If the initial page tables were created with the S bit
 		 * set, then we need to do the same here for the same
 		 * reasons given in early_cachepolicy().
 		 */
 		if (initial_pmd_value & PMD_SECT_S) {
-			user_pgprot |= L_PTE_SHARED;
-			kern_pgprot |= L_PTE_SHARED;
-			vecs_pgprot |= L_PTE_SHARED;
-			s2_pgprot |= L_PTE_SHARED;
-			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
-			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
-			mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_MEMORY_RWX].prot_sect |= PMD_SECT_S;
-			mem_types[MT_MEMORY_RWX].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_S;
-			mem_types[MT_MEMORY_RW].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_MEMORY_DMA_READY].prot_pte |= L_PTE_SHARED;
-			mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= PMD_SECT_S;
-			mem_types[MT_MEMORY_RWX_NONCACHED].prot_pte |= L_PTE_SHARED;
+			user_pgprot |= l_pte_shared;
+			kern_pgprot |= l_pte_shared;
+			vecs_pgprot |= l_pte_shared;
+			s2_pgprot |= l_pte_shared;
+			mem_types[MT_DEVICE_WC].prot_sect |= pmd_sect_s;
+			mem_types[MT_DEVICE_WC].prot_pte |= l_pte_shared;
+			mem_types[MT_DEVICE_CACHED].prot_sect |= pmd_sect_s;
+			mem_types[MT_DEVICE_CACHED].prot_pte |= l_pte_shared;
+			mem_types[MT_MEMORY_RWX].prot_sect |= pmd_sect_s;
+			mem_types[MT_MEMORY_RWX].prot_pte |= l_pte_shared;
+			mem_types[MT_MEMORY_RW].prot_sect |= pmd_sect_s;
+			mem_types[MT_MEMORY_RW].prot_pte |= l_pte_shared;
+			mem_types[MT_MEMORY_DMA_READY].prot_pte |= l_pte_shared;
+			mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= pmd_sect_s;
+			mem_types[MT_MEMORY_RWX_NONCACHED].prot_pte |= l_pte_shared;
 		}
 	}
 
-- 
1.7.9.5
