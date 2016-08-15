From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 15 Aug 2016 14:45:46 +0800
Subject: [PATCH v4 3/3] arm64: apply __ro_after_init to some objects
In-Reply-To: <1471243546-3090-1-git-send-email-jszhang@marvell.com>
References: <1471243546-3090-1-git-send-email-jszhang@marvell.com>
Message-ID: <1471243546-3090-4-git-send-email-jszhang@marvell.com>
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
 arch/arm64/kernel/cpu_ops.c |  3 ++-
 arch/arm64/kernel/kaslr.c   |  3 ++-
 arch/arm64/kernel/vdso.c    | 30 +++++++++++++++---------------
 arch/arm64/mm/dma-mapping.c |  3 ++-
 arch/arm64/mm/init.c        |  5 +++--
 arch/arm64/mm/mmu.c         |  3 ++-
 6 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index c7cfb8f..e137cea 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cache.h>
 #include <linux/errno.h>
 #include <linux/of.h>
 #include <linux/string.h>
@@ -28,7 +29,7 @@ extern const struct cpu_operations smp_spin_table_ops;
 extern const struct cpu_operations acpi_parking_protocol_ops;
 extern const struct cpu_operations cpu_psci_ops;
 
-const struct cpu_operations *cpu_ops[NR_CPUS];
+const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
 static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
 	&smp_spin_table_ops,
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b054691..769f24e 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cache.h>
 #include <linux/crc32.h>
 #include <linux/init.h>
 #include <linux/libfdt.h>
@@ -20,7 +21,7 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 
-u64 __read_mostly module_alloc_base;
+u64 __ro_after_init module_alloc_base;
 u16 __initdata memstart_offset_seed;
 
 static __init u64 get_kaslr_seed(void *fdt)
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 10ad8ab..6225612 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -18,12 +18,13 @@
  * Author: Will Deacon <will.deacon@arm.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/cache.h>
 #include <linux/clocksource.h>
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
@@ -37,8 +38,7 @@
 #include <asm/vdso_datapage.h>
 
 extern char vdso_start, vdso_end;
-static unsigned long vdso_pages;
-static struct page **vdso_pagelist;
+static unsigned long vdso_pages __ro_after_init;
 
 /*
  * The vDSO data page.
@@ -53,7 +53,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
-static struct page *vectors_page[1];
+static struct page *vectors_page[1] __ro_after_init;
 
 static int __init alloc_vectors_page(void)
 {
@@ -110,11 +110,19 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
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
@@ -138,16 +146,8 @@ static int __init vdso_init(void)
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
+	vdso_spec[0].pages = &vdso_pagelist[0];
+	vdso_spec[1].pages = &vdso_pagelist[1];
 
 	return 0;
 }
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c4284c4..5cd202f 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include <linux/cache.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/genalloc.h>
@@ -30,7 +31,7 @@
 
 #include <asm/cacheflush.h>
 
-static int swiotlb __read_mostly;
+static int swiotlb __ro_after_init;
 
 static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 				 bool coherent)
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bbb7ee7..251e082 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -23,6 +23,7 @@
 #include <linux/swap.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/cache.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
@@ -55,8 +56,8 @@
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
index 4989948..e634a0f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/cache.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -46,7 +47,7 @@
 
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 
-u64 kimage_voffset __read_mostly;
+u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
 /*
-- 
2.8.1
