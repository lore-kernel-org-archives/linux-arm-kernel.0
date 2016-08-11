From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 11 Aug 2016 21:36:49 +0800
Subject: [PATCH v2 4/4] arm64: apply __ro_after_init to some objects
In-Reply-To: <1470922609-754-1-git-send-email-jszhang@marvell.com>
References: <1470922609-754-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470922609-754-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These objects are set during initialization, thereafter are read only.

Previously I only want to mark vdso_pages, vdso_spec, vectors_page and
cpu_ops as __read_mostly from performance point of view. Then inspired
by Kees's patch[1] to apply more __ro_after_init for arm, I think it's
better to mark them as __ro_after_init. What's more, I find some more
objects are also read only after init. So apply __ro_after_init to all
of them.

This patch also removes global vdso_pagelist and tries to clean up
vdso_spec[] assignment code.

[1] http://www.spinics.net/lists/arm-kernel/msg523188.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/cpu_ops.c |  2 +-
 arch/arm64/kernel/kaslr.c   |  2 +-
 arch/arm64/kernel/vdso.c    | 27 +++++++++++++--------------
 arch/arm64/mm/dma-mapping.c |  2 +-
 arch/arm64/mm/init.c        |  4 ++--
 arch/arm64/mm/mmu.c         |  2 +-
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index c7cfb8f..6d32d1a 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -28,7 +28,7 @@ extern const struct cpu_operations smp_spin_table_ops;
 extern const struct cpu_operations acpi_parking_protocol_ops;
 extern const struct cpu_operations cpu_psci_ops;
 
-const struct cpu_operations *cpu_ops[NR_CPUS];
+const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
 static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
 	&smp_spin_table_ops,
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 8ebabc4..93c47e1 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -20,7 +20,7 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 
-u64 module_alloc_base __read_mostly;
+u64 module_alloc_base __ro_after_init;
 u16 memstart_offset_seed __initdata;
 
 static __init u64 get_kaslr_seed(void *fdt)
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 10ad8ab..0af41de 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -37,8 +37,7 @@
 #include <asm/vdso_datapage.h>
 
 extern char vdso_start, vdso_end;
-static unsigned long vdso_pages;
-static struct page **vdso_pagelist;
+static unsigned long vdso_pages __ro_after_init;
 
 /*
  * The vDSO data page.
@@ -53,7 +52,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
-static struct page *vectors_page[1];
+static struct page *vectors_page[1] __ro_after_init;
 
 static int __init alloc_vectors_page(void)
 {
@@ -110,11 +109,19 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 }
 #endif /* CONFIG_COMPAT */
 
-static struct vm_special_mapping vdso_spec[2];
+static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
+	{
+		.name	= "[vvar]",
+	},
+	{
+		.name	= "[vdso]",
+	},
+};
 
 static int __init vdso_init(void)
 {
 	int i;
+	struct page **vdso_pagelist;
 
 	if (memcmp(&vdso_start, "\177ELF", 4)) {
 		pr_err("vDSO is not a valid ELF object!\n");
@@ -138,16 +145,8 @@ static int __init vdso_init(void)
 	for (i = 0; i < vdso_pages; i++)
 		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
 
-	/* Populate the special mapping structures */
-	vdso_spec[0] = (struct vm_special_mapping) {
-		.name	= "[vvar]",
-		.pages	= vdso_pagelist,
-	};
-
-	vdso_spec[1] = (struct vm_special_mapping) {
-		.name	= "[vdso]",
-		.pages	= &vdso_pagelist[1],
-	};
+	vdso_spec[0].pages = vdso_pagelist;
+	vdso_spec[1].pages = &vdso_pagelist[1];
 
 	return 0;
 }
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c4284c4..59d44e7 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -30,7 +30,7 @@
 
 #include <asm/cacheflush.h>
 
-static int swiotlb __read_mostly;
+static int swiotlb __ro_after_init;
 
 static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 				 bool coherent)
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bbb7ee7..e8b81ea 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -55,8 +55,8 @@
  * executes, which assigns it its actual value. So use a default value
  * that cannot be mistaken for a real physical address.
  */
-s64 memstart_addr __read_mostly = -1;
-phys_addr_t arm64_dma_phys_limit __read_mostly;
+s64 memstart_addr __ro_after_init = -1;
+phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4989948..6029bed 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -46,7 +46,7 @@
 
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 
-u64 kimage_voffset __read_mostly;
+u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
 /*
-- 
2.8.1
