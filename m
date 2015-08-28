From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 28 Aug 2015 10:36:59 +0200
Subject: [PATCH 2/2] ARM: dma-mapping: add support for offset parameter in
 dma_mmap()
In-Reply-To: <1440751036-6585-1-git-send-email-m.szyprowski@samsung.com>
References: <1440751036-6585-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1440751036-6585-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU-based dma_mmap() implementation lacked proper support for offset
parameter used in mmap call (it always assumed that mapping starts from
offset zero). This patch adds support for offset parameter to IOMMU-based
implementation.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: stable at vger.kernel.org  # v3.6+
---
 arch/arm/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 67ae0f2ed983..25ecc6afec4c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1424,6 +1424,8 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
 		return -ENXIO;
 
+	pages += off;
+
 	do {
 		int ret = vm_insert_page(vma, uaddr, *pages++);
 		if (ret) {
-- 
1.9.2
