From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 7 Jul 2014 21:24:33 +0100
Subject: [RFC PATCH 0/2] xen/arm: fix "xen_add_mach_to_phys_entry: cannot
 add" problem
Message-ID: <alpine.DEB.2.02.1407072007470.27641@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
Xen support in Linux for ARM and ARM64 suffers from lack of support for
multiple mfn to pfn mappings: whenever a frontend grants the same page
multiple times to the backend, the mfn to pfn accounting in
arch/arm/xen/p2m.c fails. The issue has become critical since v3.15,
when xen-netfront/xen-netback switched from grant copies to grant
mappings, therefore causing the issue to happen much more often.

Fixing the mfn to pfn accounting in p2m.c is difficult and expensive,
therefore we are looking for alternative solutions. One idea is avoiding
mfn to pfn conversions altogether. The only code path that needs them is
swiotlb-xen:unmap_page (and single_for_cpu and single_for_device).

To avoid mfn to pfn conversions we rely on a second p2m mapping done by
Xen, see the attached patch. In Linux we use it to perform the cache
maintenance operations without mfns conversions.



Stefano Stabellini (2):
      xen/arm: reimplement xen_dma_unmap_page & friends
      xen/arm: remove mach_to_phys rbtree

 arch/arm/include/asm/xen/page-coherent.h |   25 ++--
 arch/arm/include/asm/xen/page.h          |    9 --
 arch/arm/xen/Makefile                    |    2 +-
 arch/arm/xen/mm32.c                      |  202 ++++++++++++++++++++++++++++++
 arch/arm/xen/p2m.c                       |   64 +---------
 5 files changed, 211 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/xen/mm32.c
-------------- next part --------------

diff --git a/xen/include/asm-arm/grant_table.h b/xen/include/asm-arm/grant_table.h
index eac8a70..95519c5 100644
--- a/xen/include/asm-arm/grant_table.h
+++ b/xen/include/asm-arm/grant_table.h
@@ -34,7 +34,7 @@ static inline int replace_grant_supported(void)
      (i < max_nr_grant_frames)) ? 0 : (d->arch.grant_table_gpfn[i]))
 
 #define gnttab_need_iommu_mapping(d)                    \
-    (is_domain_direct_mapped(d) && need_iommu(d))
+    (is_domain_direct_mapped(d))
 
 #endif /* __ASM_GRANT_TABLE_H__ */
 /*
