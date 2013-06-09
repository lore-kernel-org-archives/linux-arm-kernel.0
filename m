From: jtzhou@marvell.com (Jett.Zhou)
Date: Sun, 9 Jun 2013 16:43:43 +0800
Subject: [V1 1/7] video: mmp: rb swap setting update for new LCD driver
Message-ID: <1370767423-11240-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guoqing Li <ligq@marvell.com>

We could set rb swap in two modules: DMA controler and interface
output after blending.
This patch move the panel rbswap requirement setting in later module.

Signed-off-by: Guoqing Li <ligq@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/video/mmp/hw/mmp_ctrl.c |   15 ++++++++-------
 drivers/video/mmp/hw/mmp_ctrl.h |    4 ++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 4bd31b2..a472c4d 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -60,8 +60,7 @@ static irqreturn_t ctrl_handle_irq(int irq, void *dev_id)
 
 static u32 fmt_to_reg(struct mmp_overlay *overlay, int pix_fmt)
 {
-	u32 link_config = path_to_path_plat(overlay->path)->link_config;
-	u32 rbswap, uvswap = 0, yuvswap = 0,
+	u32 rbswap = 0, uvswap = 0, yuvswap = 0,
 		csc_en = 0, val = 0,
 		vid = overlay_is_vid(overlay);
 
@@ -71,27 +70,23 @@ static u32 fmt_to_reg(struct mmp_overlay *overlay, int pix_fmt)
 	case PIXFMT_RGB888PACK:
 	case PIXFMT_RGB888UNPACK:
 	case PIXFMT_RGBA888:
-		rbswap = !(link_config & 0x1);
+		rbswap = 1;
 		break;
 	case PIXFMT_VYUY:
 	case PIXFMT_YVU422P:
 	case PIXFMT_YVU420P:
-		rbswap = link_config & 0x1;
 		uvswap = 1;
 		break;
 	case PIXFMT_YUYV:
-		rbswap = link_config & 0x1;
 		yuvswap = 1;
 		break;
 	default:
-		rbswap = link_config & 0x1;
 		break;
 	}
 
 	switch (pix_fmt) {
 	case PIXFMT_RGB565:
 	case PIXFMT_BGR565:
-		val = 0;
 		break;
 	case PIXFMT_RGB1555:
 	case PIXFMT_BGR1555:
@@ -263,6 +258,12 @@ static void path_set_mode(struct mmp_path *path, struct mmp_mode *mode)
 	tmp |= CFG_DUMB_ENA(1);
 	writel_relaxed(tmp, ctrl_regs(path) + intf_ctrl(path->id));
 
+	/* interface rb_swap setting */
+	tmp = readl_relaxed(ctrl_regs(path) + intf_rbswap_ctrl(path->id)) &
+		(~(CFG_INTFRBSWAP_MASK));
+	tmp |= link_config & CFG_INTFRBSWAP_MASK;
+	writel_relaxed(tmp, ctrl_regs(path) + intf_rbswap_ctrl(path->id));
+
 	writel_relaxed((mode->yres << 16) | mode->xres, &regs->screen_active);
 	writel_relaxed((mode->left_margin << 16) | mode->right_margin,
 		&regs->screen_h_porch);
diff --git a/drivers/video/mmp/hw/mmp_ctrl.h b/drivers/video/mmp/hw/mmp_ctrl.h
index edd2002..975d890 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.h
+++ b/drivers/video/mmp/hw/mmp_ctrl.h
@@ -163,6 +163,8 @@ struct lcd_regs {
 
 #define LCD_SCLK(path) ((PATH_PN == path->id) ? LCD_CFG_SCLK_DIV :\
 	((PATH_TV == path->id) ? LCD_TCLK_DIV : LCD_PN2_SCLK_DIV))
+#define intf_rbswap_ctrl(id)	((id) ? (((id) & 1) ? LCD_TVIF_CTRL : \
+				PN2_IOPAD_CONTROL) : LCD_TOP_CTRL)
 
 /* dither configure */
 #ifdef CONFIG_CPU_PXA988
@@ -615,6 +617,8 @@ struct lcd_regs {
 #define LCD_SPU_DUMB_CTRL			0x01B8
 #define	 CFG_DUMBMODE(mode)			((mode)<<28)
 #define	 CFG_DUMBMODE_MASK			0xF0000000
+#define	 CFG_INTFRBSWAP(mode)			((mode)<<24)
+#define	 CFG_INTFRBSWAP_MASK			0x0F000000
 #define	 CFG_LCDGPIO_O(data)			((data)<<20)
 #define	 CFG_LCDGPIO_O_MASK			0x0FF00000
 #define	 CFG_LCDGPIO_ENA(gpio)			((gpio)<<12)
-- 
1.7.0.4
