From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 11 Feb 2014 07:48:32 +0100
Subject: [PATCH] video: xilinxfb: Move xilinxfb_platform_data directly to the
 driver
Message-ID: <af8de8bd8803b319c0f6a02ca5109768e5ef8457.1392101292.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No reason to have separate file in header in include/linux folder
if this is purely driver specific structure.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I have this patch in my devel tree for a while and would like
to hear your opinion. I can't see any reason to have
xilinxfb_platform_data in header if this is purely OF driver
used on OF archs.
---
 drivers/video/xilinxfb.c | 15 ++++++++++++++-
 include/linux/xilinxfb.h | 30 ------------------------------
 2 files changed, 14 insertions(+), 31 deletions(-)
 delete mode 100644 include/linux/xilinxfb.h

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 6ff1a91..553cff2 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -33,7 +33,6 @@
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
-#include <linux/xilinxfb.h>
 #include <linux/slab.h>

 #ifdef CONFIG_PPC_DCR
@@ -84,6 +83,20 @@

 #define PALETTE_ENTRIES_NO	16	/* passed to fb_alloc_cmap() */

+/* ML300/403 reference design framebuffer driver platform data struct */
+struct xilinxfb_platform_data {
+	u32 rotate_screen;      /* Flag to rotate display 180 degrees */
+	u32 screen_height_mm;   /* Physical dimensions of screen in mm */
+	u32 screen_width_mm;
+	u32 xres, yres;         /* resolution of screen in pixels */
+	u32 xvirt, yvirt;       /* resolution of memory buffer */
+
+	/* Physical address of framebuffer memory; If non-zero, driver
+	* will use provided memory address instead of allocating one from
+	* the consistent pool. */
+	u32 fb_phys;
+};
+
 /*
  * Default xilinxfb configuration
  */
diff --git a/include/linux/xilinxfb.h b/include/linux/xilinxfb.h
deleted file mode 100644
index 5a155a9..0000000
--- a/include/linux/xilinxfb.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Platform device data for Xilinx Framebuffer device
- *
- * Copyright 2007 Secret Lab Technologies Ltd.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#ifndef __XILINXFB_H__
-#define __XILINXFB_H__
-
-#include <linux/types.h>
-
-/* ML300/403 reference design framebuffer driver platform data struct */
-struct xilinxfb_platform_data {
-	u32 rotate_screen;	/* Flag to rotate display 180 degrees */
-	u32 screen_height_mm;	/* Physical dimensions of screen in mm */
-	u32 screen_width_mm;
-	u32 xres, yres;		/* resolution of screen in pixels */
-	u32 xvirt, yvirt;	/* resolution of memory buffer */
-
-	/* Physical address of framebuffer memory; If non-zero, driver
-	 * will use provided memory address instead of allocating one from
-	 * the consistent pool. */
-	u32 fb_phys;
-};
-
-#endif  /* __XILINXFB_H__ */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/a20eda0d/attachment.sig>
