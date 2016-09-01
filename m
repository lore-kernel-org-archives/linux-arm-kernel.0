From: zijun_hu@zoho.com (zijun_hu)
Date: Thu, 1 Sep 2016 18:58:29 +0800
Subject: [PATCH 2/2] arm64: regard FDT_SW_MAGIC as good fdt magic
Message-ID: <a6a8826c-3006-ae43-ef4c-8049ef93cd9f@zoho.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zijun_hu <zijun_hu@htc.com>

regard FDT_SW_MAGIC as good fdt magic during mapping fdt area
see fdt_check_header() for details

Signed-off-by: zijun_hu <zijun_hu@htc.com>
---
 arch/arm64/mm/mmu.c                  | 3 ++-
 scripts/dtc/libfdt/fdt.h             | 3 ++-
 scripts/dtc/libfdt/libfdt.h          | 2 ++
 scripts/dtc/libfdt/libfdt_internal.h | 2 --
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4989948d1feb..83df20509eae 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -716,7 +716,8 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE),
 			dt_virt_base, SWAPPER_BLOCK_SIZE, prot);
 
-	if (fdt_magic(dt_virt) != FDT_MAGIC)
+	if (fdt_magic(dt_virt) != FDT_MAGIC &&
+			fdt_magic(dt_virt) != FDT_SW_MAGIC)
 		return NULL;
 
 	*size = fdt_totalsize(dt_virt);
diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index 526aedb51556..0e8806327b53 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -92,7 +92,8 @@ struct fdt_property {
 
 #endif /* !__ASSEMBLY */
 
-#define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
+/* 4: version, 4: total size */
+#define FDT_MAGIC	((fdt32_t)0xd00dfeed)
 #define FDT_TAGSIZE	sizeof(fdt32_t)
 
 #define FDT_BEGIN_NODE	0x1		/* Start node: full name */
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index 59ca33976e56..6998f9249183 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -54,6 +54,8 @@
 #include "libfdt_env.h"
 #include "fdt.h"
 
+#define FDT_SW_MAGIC           (~FDT_MAGIC)
+
 #define FDT_FIRST_SUPPORTED_VERSION	0x10
 #define FDT_LAST_SUPPORTED_VERSION	0x11
 
diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/libfdt_internal.h
index 02cfa6fb612d..f4efde0119f2 100644
--- a/scripts/dtc/libfdt/libfdt_internal.h
+++ b/scripts/dtc/libfdt/libfdt_internal.h
@@ -90,6 +90,4 @@ static inline struct fdt_reserve_entry *_fdt_mem_rsv_w(void *fdt, int n)
 	return (void *)(uintptr_t)_fdt_mem_rsv(fdt, n);
 }
 
-#define FDT_SW_MAGIC		(~FDT_MAGIC)
-
 #endif /* _LIBFDT_INTERNAL_H */
-- 
1.9.1
