From: vitalya@ti.com (Vitaly Andrianov)
Date: Wed, 14 Jan 2015 12:44:12 -0500
Subject: [Resend PATCH] ARM: mm: use phys_addr_t in ioremap_page functions
Message-ID: <1421257452-18834-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a 32 bit ARM architecture with LPAE extension physical addresses
cannot fit into unsigned long variable.

This patch fixes the ioremap_page function.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Acked-by: Murali Karicheri <m-karicheri2@ti.com>

- Fixing the commit log and resending
---
 arch/arm/include/asm/mach/map.h | 2 +-
 arch/arm/mm/ioremap.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 2fe141f..836f006 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -52,7 +52,7 @@ extern const struct mem_type *get_mem_type(unsigned int type);
 /*
  * external interface to remap single page with appropriate type
  */
-extern int ioremap_page(unsigned long virt, unsigned long phys,
+extern int ioremap_page(unsigned long virt, phys_addr_t phys,
 			const struct mem_type *mtype);
 #else
 #define iotable_init(map,num)	do { } while (0)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f123d6e..e0fe50f 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -103,7 +103,7 @@ void __init add_static_vm_early(struct static_vm *svm)
 	list_add_tail(&svm->list, &curr_svm->list);
 }
 
-int ioremap_page(unsigned long virt, unsigned long phys,
+int ioremap_page(unsigned long virt, phys_addr_t phys,
 		 const struct mem_type *mtype)
 {
 	return ioremap_page_range(virt, virt + PAGE_SIZE, phys,
-- 
1.9.1
