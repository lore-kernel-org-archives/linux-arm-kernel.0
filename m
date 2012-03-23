From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Mar 2012 13:26:03 +0100
Subject: [PATCH 2/2] arm: dma-mapping: use dma_mmap_from_coherent()
In-Reply-To: <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
References: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
 <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1332505563-17646-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dma_mmap_from_coherent() to fix broken mapping of the coherent buffers
to userspace.

Reported-by: Subash Patel <subashrp@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6c24218..0cee054 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -511,6 +511,9 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			    pgprot_writecombine(vma->vm_page_prot) :
 			    pgprot_dmacoherent(vma->vm_page_prot);
 
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
 	c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
 	if (c) {
 		unsigned long off = vma->vm_pgoff;
-- 
1.7.1.569.g6f426
