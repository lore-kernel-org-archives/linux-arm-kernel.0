From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 24 May 2017 11:24:27 +0100
Subject: [PATCH v5 2/7] dma: Add simple dma_noop_mmap
In-Reply-To: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1495621472-9323-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a simple implementation of mmap to dma_noop_ops.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Reported-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 lib/dma-noop.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index ff4ef5e..0acc3f6 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -66,6 +66,26 @@ static int dma_noop_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
+static int dma_noop_mmap(struct device *dev, struct vm_area_struct *vma,
+			 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			 unsigned long attrs)
+{
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
+	unsigned long off = vma->vm_pgoff;
+	int ret = -ENXIO;
+
+	if (off < count && user_count <= (count - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      user_count << PAGE_SHIFT,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
 const struct dma_map_ops dma_noop_ops = {
 	.alloc			= dma_noop_alloc,
 	.free			= dma_noop_free,
@@ -73,6 +93,7 @@ const struct dma_map_ops dma_noop_ops = {
 	.map_sg			= dma_noop_map_sg,
 	.mapping_error		= dma_noop_mapping_error,
 	.dma_supported		= dma_noop_supported,
+	.mmap			= dma_noop_mmap,
 };
 
 EXPORT_SYMBOL(dma_noop_ops);
-- 
2.0.0
