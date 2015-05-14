From: msalter@redhat.com (Mark Salter)
Date: Thu, 14 May 2015 10:22:53 -0400
Subject: [PATCH] arm64: support ACPI tables outside of kernel RAM
Message-ID: <1431613373-10928-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no guarantee that ACPI tables will be located in RAM linearly
mapped by the kernel. This could be because UEFI placed them below the
kernel image or because mem= places them beyond the reach of the linear
kernel mapping. Even though these tables are outside the linear mapped
RAM, they still need to be accessed as normal memory in order to support
unaligned accesses from ACPI code. In this case, the page_is_ram() test
in acpi_os_ioremap() is not sufficient. Additionally, if the table spans
multiple pages, it may fall partially within the linear map and partially
without. If the table overlaps the end of the linear map, the test for
whether or not to use the existing mapping in ioremap_cache() could lead
to a panic when ACPI code tries to access the part beyond the end of the
linear map. This patch attempts to address these problems.

Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Matt Fleming <matt.fleming@intel.com>
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/include/asm/acpi.h |  6 ++-
 arch/arm64/include/asm/efi.h  |  2 +
 arch/arm64/kernel/acpi.c      | 13 ++++++
 arch/arm64/kernel/efi.c       | 95 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c     |  1 +
 arch/arm64/mm/ioremap.c       |  3 +-
 6 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 59c05d8..0849533 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -20,11 +20,15 @@
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
+extern int page_is_acpi_ram(unsigned long pfn);
+
 /* ACPI table mapping after acpi_gbl_permanent_mmap is set */
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
-	if (!page_is_ram(phys >> PAGE_SHIFT))
+	unsigned long pfn = phys >> PAGE_SHIFT;
+
+	if (!page_is_ram(pfn) && !page_is_acpi_ram(pfn))
 		return ioremap(phys, size);
 
 	return ioremap_cache(phys, size);
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index ef57220..3d5c12a 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -6,8 +6,10 @@
 
 #ifdef CONFIG_EFI
 extern void efi_init(void);
+extern void efi_request_acpi_resources(void);
 #else
 #define efi_init()
+#define efi_request_acpi_resources()
 #endif
 
 #define efi_call_virt(f, ...)						\
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 8b83955..2c85ca0 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -343,3 +343,16 @@ void __init acpi_gic_init(void)
 
 	early_acpi_os_unmap_memory((char *)table, tbl_size);
 }
+
+static int __is_acpi_ram(u64 start, u64 end, void *arg)
+{
+	return 1;
+}
+
+int page_is_acpi_ram(unsigned long pfn)
+{
+	u64 addr = (u64) pfn << PAGE_SHIFT;
+
+	return walk_iomem_res("ACPI RAM", IORESOURCE_MEM | IORESOURCE_BUSY,
+			      addr, addr, NULL, __is_acpi_ram) == 1;
+}
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index ab21e0d..2d914d7 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -204,6 +204,101 @@ static __init void reserve_regions(void)
 	set_bit(EFI_MEMMAP, &efi.flags);
 }
 
+#ifdef CONFIG_ACPI
+static void __init __insert_resource(struct resource *res)
+{
+	struct resource *r, *conflict;
+
+	r = alloc_bootmem_low(sizeof(*r));
+	*r = *res;
+
+	/*
+	 * When inserting a resource, there will be a conflict
+	 * only if the resource being inserted partially overlaps
+	 * an existing resource. If the resource being inserted
+	 * is entirely within an existing resource, it becomes
+	 * a child of that resource with no conflict. So if we
+	 * do get a conflict, split the one resource into two
+	 * resources: one inside the conflict and one outside.
+	 */
+	conflict = insert_resource_conflict(&iomem_resource, r);
+	if (conflict) {
+		struct resource *tmp;
+
+		tmp = alloc_bootmem_low(sizeof(*tmp));
+		*tmp = *r;
+
+		if (r->start >= conflict->start) {
+			r->start = conflict->end + 1;
+			tmp->end = conflict->end;
+		} else {
+			r->end = conflict->start - 1;
+			tmp->start = conflict->start;
+		}
+		insert_resource(&iomem_resource, tmp);
+		insert_resource(&iomem_resource, r);
+	}
+}
+
+/*
+ * Create /proc/iomem resources for any ACPI regions in RAM.
+ */
+void __init efi_request_acpi_resources(void)
+{
+	struct resource res;
+	efi_memory_desc_t *md;
+	u64 start, end, npages;
+	unsigned long mapsize = memmap.map_end - memmap.map;
+	void *map;
+
+	map = early_memremap((resource_size_t)memmap.phys_map, mapsize);
+	if (map == NULL)
+		return;
+	memmap.map = map;
+	memmap.map_end = map + mapsize;
+
+	memset(&res, 0, sizeof(res));
+	res.name  = "ACPI RAM";
+	res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	for_each_efi_memory_desc(&memmap, md) {
+		if (!is_normal_ram(md) ||
+		    !(md->type == EFI_ACPI_RECLAIM_MEMORY ||
+		      md->type == EFI_ACPI_MEMORY_NVS))
+			continue;
+
+		start = md->phys_addr;
+		npages = md->num_pages;
+		memrange_efi_to_native(&start, &npages);
+		end = start + (npages << PAGE_SHIFT) - 1;
+
+		if (res.end == 0) {
+			res.start = start;
+			res.end = end;
+			continue;
+		}
+
+		if (start >= res.start && (start - 1) <= res.end) {
+			/* overlaps (or adjacent to) end of old region */
+			if (end > res.end)
+				res.end = end;
+		} else if (end >= (res.start - 1) && end <= res.end) {
+			/* overlaps (or adjacent to) start of old region */
+			if (start  < res.start)
+				res.start = start;
+		} else {
+			__insert_resource(&res);
+			res.start = start;
+			res.end = end;
+		}
+	}
+	if (res.end)
+		__insert_resource(&res);
+
+	early_memunmap(memmap.map, mapsize);
+}
+#endif
+
 void __init efi_init(void)
 {
 	struct efi_fdt_params params;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7475313..a438a0c 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -413,6 +413,7 @@ void __init setup_arch(char **cmdline_p)
 		of_smp_init_cpus();
 #endif
 	} else {
+		efi_request_acpi_resources();
 		psci_acpi_init();
 		acpi_init_cpus();
 	}
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 01e88c8..d62e701 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -96,7 +96,8 @@ EXPORT_SYMBOL(__iounmap);
 void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 {
 	/* For normal memory we already have a cacheable mapping. */
-	if (pfn_valid(__phys_to_pfn(phys_addr)))
+	if (pfn_valid(__phys_to_pfn(phys_addr)) &&
+	    pfn_valid(__phys_to_pfn(phys_addr + size - 1)))
 		return (void __iomem *)__phys_to_virt(phys_addr);
 
 	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
-- 
1.9.3
