From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:59:51 +0000
Subject: [PATCH 06/10] ARM: add versatile family consolidated CLCD support
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRS3-0003mv-L3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This consolidates the CLCD panel definitions and memory allocation into
one location.

Rename the Sanyo 2.5in and Epson 2.2in displays after their respective
part numbers.  Rather than using a general "Sanyo 2.5in" and "Epson
2.2in" description of the display panel, use the manufacturers part
number to be more specific.  This helps people identify what the timings
actually refer to, which are panel specific.

While here, add CLCD capability information to each panel definition,
which has no effect until we add the board-level capabilities.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/plat-versatile/Kconfig             |    6 +
 arch/arm/plat-versatile/Makefile            |    1 +
 arch/arm/plat-versatile/clcd.c              |  182 +++++++++++++++++++++++++++
 arch/arm/plat-versatile/include/plat/clcd.h |    9 ++
 5 files changed, 199 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-versatile/Kconfig
 create mode 100644 arch/arm/plat-versatile/clcd.c
 create mode 100644 arch/arm/plat-versatile/include/plat/clcd.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 70a0170..3087985 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1007,6 +1007,7 @@ source "arch/arm/mach-ux500/Kconfig"
 source "arch/arm/mach-versatile/Kconfig"
 
 source "arch/arm/mach-vexpress/Kconfig"
+source "arch/arm/plat-versatile/Kconfig"
 
 source "arch/arm/mach-w90x900/Kconfig"
 
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
new file mode 100644
index 0000000..22540f5
--- /dev/null
+++ b/arch/arm/plat-versatile/Kconfig
@@ -0,0 +1,6 @@
+if PLAT_VERSATILE
+
+config PLAT_VERSATILE_CLCD
+	bool
+
+endif
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 16dde08..8b3341c 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -6,3 +6,4 @@ ifeq ($(CONFIG_LEDS_CLASS),y)
 obj-$(CONFIG_ARCH_REALVIEW) += leds.o
 obj-$(CONFIG_ARCH_VERSATILE) += leds.o
 endif
+obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
diff --git a/arch/arm/plat-versatile/clcd.c b/arch/arm/plat-versatile/clcd.c
new file mode 100644
index 0000000..6628cc2
--- /dev/null
+++ b/arch/arm/plat-versatile/clcd.c
@@ -0,0 +1,182 @@
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+#include <plat/clcd.h>
+
+static struct clcd_panel vga = {
+	.mode		= {
+		.name		= "VGA",
+		.refresh	= 60,
+		.xres		= 640,
+		.yres		= 480,
+		.pixclock	= 39721,
+		.left_margin	= 40,
+		.right_margin	= 24,
+		.upper_margin	= 32,
+		.lower_margin	= 11,
+		.hsync_len	= 96,
+		.vsync_len	= 2,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
+	.bpp		= 16,
+};
+
+static struct clcd_panel xvga = {
+	.mode		= {
+		.name		= "XVGA",
+		.refresh	= 60,
+		.xres		= 1024,
+		.yres		= 768,
+		.pixclock	= 15748,
+		.left_margin	= 152,
+		.right_margin	= 48,
+		.upper_margin	= 23,
+		.lower_margin	= 3,
+		.hsync_len	= 104,
+		.vsync_len	= 4,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
+	.bpp		= 16,
+};
+
+/* Sanyo TM38QV67A02A - 3.8 inch QVGA (320x240) Color TFT */
+static struct clcd_panel sanyo_tm38qv67a02a = {
+	.mode		= {
+		.name		= "Sanyo TM38QV67A02A",
+		.refresh	= 116,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= 100000,
+		.left_margin	= 6,
+		.right_margin	= 6,
+		.upper_margin	= 5,
+		.lower_margin	= 5,
+		.hsync_len	= 6,
+		.vsync_len	= 6,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.bpp		= 16,
+};
+
+static struct clcd_panel sanyo_2_5_in = {
+	.mode		= {
+		.name		= "Sanyo QVGA Portrait",
+		.refresh	= 116,
+		.xres		= 240,
+		.yres		= 320,
+		.pixclock	= 100000,
+		.left_margin	= 20,
+		.right_margin	= 10,
+		.upper_margin	= 2,
+		.lower_margin	= 2,
+		.hsync_len	= 10,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_IVS | TIM2_IHS | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.bpp		= 16,
+};
+
+/* Epson L2F50113T00 - 2.2 inch 176x220 Color TFT */
+static struct clcd_panel epson_l2f50113t00 = {
+	.mode		= {
+		.name		= "Epson L2F50113T00",
+		.refresh	= 390,
+		.xres		= 176,
+		.yres		= 220,
+		.pixclock	= 62500,
+		.left_margin	= 3,
+		.right_margin	= 2,
+		.upper_margin	= 1,
+		.lower_margin	= 0,
+		.hsync_len	= 3,
+		.vsync_len	= 2,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.bpp		= 16,
+};
+
+static struct clcd_panel *panels[] = {
+	&vga,
+	&xvga,
+	&sanyo_tm38qv67a02a,
+	&sanyo_2_5_in,
+	&epson_l2f50113t00,
+};
+
+struct clcd_panel *versatile_clcd_get_panel(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(panels); i++)
+		if (strcmp(panels[i]->mode.name, name) == 0)
+			break;
+
+	if (i < ARRAY_SIZE(panels))
+		return panels[i];
+
+	pr_err("CLCD: couldn't get parameters for panel %s\n", name);
+
+	return NULL;
+}
+
+int versatile_clcd_setup_dma(struct clcd_fb *fb, unsigned long framesize)
+{
+	dma_addr_t dma;
+
+	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
+						    &dma, GFP_KERNEL);
+	if (!fb->fb.screen_base) {
+		pr_err("CLCD: unable to map framebuffer\n");
+		return -ENOMEM;
+	}
+
+	fb->fb.fix.smem_start	= dma;
+	fb->fb.fix.smem_len	= framesize;
+
+	return 0;
+}
+
+int versatile_clcd_mmap_dma(struct clcd_fb *fb, struct vm_area_struct *vma)
+{
+	return dma_mmap_writecombine(&fb->dev->dev, vma,
+				     fb->fb.screen_base,
+				     fb->fb.fix.smem_start,
+				     fb->fb.fix.smem_len);
+}
+
+void versatile_clcd_remove_dma(struct clcd_fb *fb)
+{
+	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
+			      fb->fb.screen_base, fb->fb.fix.smem_start);
+}
diff --git a/arch/arm/plat-versatile/include/plat/clcd.h b/arch/arm/plat-versatile/include/plat/clcd.h
new file mode 100644
index 0000000..6bb6a1d
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/clcd.h
@@ -0,0 +1,9 @@
+#ifndef PLAT_CLCD_H
+#define PLAT_CLCD_H
+
+struct clcd_panel *versatile_clcd_get_panel(const char *);
+int versatile_clcd_setup_dma(struct clcd_fb *, unsigned long);
+int versatile_clcd_mmap_dma(struct clcd_fb *, struct vm_area_struct *);
+void versatile_clcd_remove_dma(struct clcd_fb *);
+
+#endif
-- 
1.6.2.5
