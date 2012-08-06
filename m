From: hdk@igel.co.jp (Hideki EIRAKU)
Date: Mon,  6 Aug 2012 18:55:24 +0900
Subject: [PATCH v3 4/4] fbdev: sh_mobile_lcdc: use dma_mmap_coherent if
 available
In-Reply-To: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
References: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
Message-ID: <1344246924-32620-5-git-send-email-hdk@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fb_mmap() implemented in fbmem.c uses smem_start as the physical
address of the frame buffer.  In the sh_mobile_lcdc driver, the
smem_start is a dma_addr_t that is not a physical address when IOMMU is
enabled.  dma_mmap_coherent() maps the address correctly.  It is
available on ARM platforms.

Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 8cb653b..c8cba7a 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1614,6 +1614,17 @@ static int sh_mobile_lcdc_overlay_blank(int blank, struct fb_info *info)
 	return 1;
 }
 
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+static int
+sh_mobile_lcdc_overlay_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	struct sh_mobile_lcdc_overlay *ovl = info->par;
+
+	return dma_mmap_coherent(ovl->channel->lcdc->dev, vma, ovl->fb_mem,
+				 ovl->dma_handle, ovl->fb_size);
+}
+#endif
+
 static struct fb_ops sh_mobile_lcdc_overlay_ops = {
 	.owner          = THIS_MODULE,
 	.fb_read        = fb_sys_read,
@@ -1626,6 +1637,9 @@ static struct fb_ops sh_mobile_lcdc_overlay_ops = {
 	.fb_ioctl       = sh_mobile_lcdc_overlay_ioctl,
 	.fb_check_var	= sh_mobile_lcdc_overlay_check_var,
 	.fb_set_par	= sh_mobile_lcdc_overlay_set_par,
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+	.fb_mmap	= sh_mobile_lcdc_overlay_mmap,
+#endif
 };
 
 static void
@@ -2093,6 +2107,17 @@ static int sh_mobile_lcdc_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+static int
+sh_mobile_lcdc_mmap(struct fb_info *info, struct vm_area_struct *vma)
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
@@ -2108,6 +2133,9 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_release	= sh_mobile_lcdc_release,
 	.fb_check_var	= sh_mobile_lcdc_check_var,
 	.fb_set_par	= sh_mobile_lcdc_set_par,
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+	.fb_mmap	= sh_mobile_lcdc_mmap,
+#endif
 };
 
 static void
-- 
1.7.0.4
