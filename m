From: ming.lei@canonical.com (Ming Lei)
Date: Fri,  2 Dec 2011 23:02:48 +0800
Subject: [RFC PATCH v1 3/7] media: videobuf2: move out of setting
 pgprot_noncached from vb2_mmap_pfn_range
In-Reply-To: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1322838172-11149-4-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that we can reuse vb2_mmap_pfn_range for the coming videobuf2_page
memops.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/media/video/videobuf2-dma-contig.c |    1 +
 drivers/media/video/videobuf2-memops.c     |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/videobuf2-dma-contig.c b/drivers/media/video/videobuf2-dma-contig.c
index f17ad98..0ea8866 100644
--- a/drivers/media/video/videobuf2-dma-contig.c
+++ b/drivers/media/video/videobuf2-dma-contig.c
@@ -106,6 +106,7 @@ static int vb2_dma_contig_mmap(void *buf_priv, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	return vb2_mmap_pfn_range(vma, buf->dma_addr, buf->size,
 				  &vb2_common_vm_ops, &buf->handler);
 }
diff --git a/drivers/media/video/videobuf2-memops.c b/drivers/media/video/videobuf2-memops.c
index 71a7a78..77e0def 100644
--- a/drivers/media/video/videobuf2-memops.c
+++ b/drivers/media/video/videobuf2-memops.c
@@ -162,7 +162,6 @@ int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
 
 	size = min_t(unsigned long, vma->vm_end - vma->vm_start, size);
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	ret = remap_pfn_range(vma, vma->vm_start, paddr >> PAGE_SHIFT,
 				size, vma->vm_page_prot);
 	if (ret) {
-- 
1.7.5.4
