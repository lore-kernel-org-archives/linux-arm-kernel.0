From: inki.dae@samsung.com (InKi Dae)
Date: Tue, 29 Jun 2010 19:49:33 +0900
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-ID: <4C29CFBD.3040205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 CPU interface needs cs, wr setup, wr act and hold delay.
I added some members for them to common framework.

Signed-off-by: InKi Dae <inki.dae at samsung.com <mailto:p.osciak@samsung.com>>
Signed-off-by: Kyungmin Park <kyungmin.park at samsung.com
<mailto:kyungmin.park@samsung.com>>
---

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c

index 0a4dbdc..74122d1 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -759,6 +759,27 @@ void fb_videomode_to_var(struct fb_var_screeninfo *var,
 }
 
 /**
+ * fb_cpumode_to_var - convert fb_cpumode to fb_var_screeninfo
+ * @var: pointer to struct fb_var_screeninfo
+ * @mode: pointer to struct fb_cpumode
+ */
+void fb_cmdmode_to_var(struct fb_var_screeninfo *var,
+			 const struct fb_cmdmode *mode)
+{
+	var->xres = mode->xres;
+	var->yres = mode->yres;
+	var->xres_virtual = mode->xres;
+	var->yres_virtual = mode->yres;
+	var->xoffset = 0;
+	var->yoffset = 0;
+	var->pixclock = mode->pixclock;
+	var->cs_setup = mode->cs_setup;
+	var->wr_setup = mode->wr_setup;
+	var->wr_act = mode->wr_act;
+	var->wr_hold = mode->wr_hold;
+}
+
+/**
  * fb_mode_is_equal - compare 2 videomodes
  * @mode1: first videomode
  * @mode2: second videomode
@@ -1048,6 +1069,7 @@ finished:
 EXPORT_SYMBOL(fb_find_best_display);
 
 EXPORT_SYMBOL(fb_videomode_to_var);
+EXPORT_SYMBOL(fb_cmdmode_to_var);
 EXPORT_SYMBOL(fb_var_to_videomode);
 EXPORT_SYMBOL(fb_mode_is_equal);
 EXPORT_SYMBOL(fb_add_videomode);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 907ace3..73381c3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -269,6 +269,12 @@ struct fb_var_screeninfo {
 	__u32 vmode;			/* see FB_VMODE_*		*/
 	__u32 rotate;			/* angle we rotate counter clockwise */
 	__u32 reserved[5];		/* Reserved for future compatibility */
+
+	/* For cpu interface timing. */
+	__u32 cs_setup;
+	__u32 wr_setup;
+	__u32 wr_act;
+	__u32 wr_hold;
 };
 
 struct fb_cmap {
@@ -1117,11 +1123,24 @@ struct fb_videomode {
 	u32 lower_margin;
 	u32 hsync_len;
 	u32 vsync_len;
+	u32 cmd_allow_len;
 	u32 sync;
 	u32 vmode;
 	u32 flag;
 };
 
+struct fb_cmdmode {
+	const char *name;	/* optional */
+	u32 refresh;		/* optional */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;
+	u32 cs_setup;
+	u32 wr_setup;
+	u32 wr_act;
+	u32 wr_hold;
+};
+
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100629/17de1d8e/attachment-0001.html>
