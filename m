From: hdk@igel.co.jp (Hideki EIRAKU)
Date: Wed, 25 Jul 2012 15:29:24 +0900
Subject: [PATCH 3/3] fbdev: sh_mobile_lcdc: use dma_mmap_coherent if available
In-Reply-To: <1343197764-13659-1-git-send-email-hdk@igel.co.jp>
References: <1343197764-13659-1-git-send-email-hdk@igel.co.jp>
Message-ID: <1343197764-13659-4-git-send-email-hdk@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fb_mmap() implemented in fbmem.c uses smem_start as the physical
address of the frame buffer.  In the sh_mobile_lcdc driver, the
smem_start is a dma_addr_t that is not a physical address when IOMMU is
enabled.  dma_mmap_coherent() maps the address correctly.  It is
available on ARM platforms.

Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index e672698..65732c4 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1393,6 +1393,17 @@ static int sh_mobile_lcdc_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+static int
+sh_mobile_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+
+	return dma_mmap_coherent(ch->lcdc->dev, vma, ch->fb_mem,
+				 ch->dma_handle, ch->fb_size);
+}
+#endif
+
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.owner          = THIS_MODULE,
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
@@ -1408,6 +1419,9 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_release	= sh_mobile_release,
 	.fb_check_var	= sh_mobile_check_var,
 	.fb_set_par	= sh_mobile_set_par,
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+	.fb_mmap	= sh_mobile_fb_mmap,
+#endif
 };
 
 static void
-- 
1.7.0.4
