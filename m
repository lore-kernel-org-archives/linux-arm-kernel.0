From: Haiying.Wang@nxp.com (Haiying Wang)
Date: Thu, 20 Apr 2017 15:34:16 -0400
Subject: [PATCH 1/3] arm64: extend ioremap for cacheable non-shareable memory
In-Reply-To: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
References: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
Message-ID: <1492716858-24509-2-git-send-email-Haiying.Wang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP arm64 based SoC needs to allocate cacheable and
non-shareable memory for the software portals of
Queue manager, so we extend the arm64 ioremap support
for this memory attribute.

Signed-off-by: Haiying Wang <Haiying.Wang@nxp.com>
---
 arch/arm64/include/asm/io.h           | 1 +
 arch/arm64/include/asm/pgtable-prot.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 0c00c87..b6f03e7 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -170,6 +170,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
+#define ioremap_cache_ns(addr, size)	__ioremap((addr), (size), __pgprot(PROT_NORMAL_NS))
 #define iounmap				__iounmap
 
 /*
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2142c77..7fc7910 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -42,6 +42,7 @@
 #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
 #define PROT_NORMAL_WT		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_WT))
 #define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
+#define PROT_NORMAL_NS		(PTE_TYPE_PAGE | PTE_AF | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
 
 #define PROT_SECT_DEVICE_nGnRE	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
 #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
-- 
2.7.4
