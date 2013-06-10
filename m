From: jtzhou@marvell.com (Jett.Zhou)
Date: Mon, 10 Jun 2013 23:53:13 +0800
Subject: [V2 7/7] video: mmp: add video layer set win/addr operations support
Message-ID: <1370879593-11557-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jing Xiang <jxiang@marvell.com>

Since mmp display controller support graphic/video layer together, so
add  win/addr setting operations support when set win parameters.

Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/video/mmp/hw/mmp_ctrl.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 92a5f44..4da6268 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -142,17 +142,27 @@ static void dmafetch_set_fmt(struct mmp_overlay *overlay)
 static void overlay_set_win(struct mmp_overlay *overlay, struct mmp_win *win)
 {
 	struct lcd_regs *regs = path_regs(overlay->path);
-	u32 pitch;
 
 	/* assert win supported */
 	memcpy(&overlay->win, win, sizeof(struct mmp_win));
 
 	mutex_lock(&overlay->access_ok);
-	pitch = win->xsrc * pixfmt_to_stride(win->pix_fmt);
-	writel_relaxed(pitch, &regs->g_pitch);
-	writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
-	writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
-	writel_relaxed(0, &regs->g_start);
+
+	if (overlay_is_vid(overlay)) {
+		writel_relaxed(win->pitch[0], &regs->v_pitch_yc);
+		writel_relaxed(win->pitch[2] << 16 |
+				win->pitch[1], &regs->v_pitch_uv);
+
+		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->v_size);
+		writel_relaxed((win->ydst << 16) | win->xdst, &regs->v_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos, &regs->v_start);
+	} else {
+		writel_relaxed(win->pitch[0], &regs->g_pitch);
+
+		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
+		writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos, &regs->g_start);
+	}
 
 	dmafetch_set_fmt(overlay);
 	mutex_unlock(&overlay->access_ok);
@@ -234,7 +244,13 @@ static int overlay_set_addr(struct mmp_overlay *overlay, struct mmp_addr *addr)
 
 	/* FIXME: assert addr supported */
 	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
-	writel(addr->phys[0], &regs->g_0);
+
+	if (overlay_is_vid(overlay)) {
+		writel_relaxed(addr->phys[0], &regs->v_y0);
+		writel_relaxed(addr->phys[1], &regs->v_u0);
+		writel_relaxed(addr->phys[2], &regs->v_v0);
+	} else
+		writel_relaxed(addr->phys[0], &regs->g_0);
 
 	return overlay->addr.phys[0];
 }
-- 
1.7.0.4
