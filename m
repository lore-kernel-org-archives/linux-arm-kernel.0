From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:58:30 +0000
Subject: [PATCH 02/10] ARM: integrator: support CLCD RGB5551 layout for 16bpp
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRQk-0003me-8g@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the CLCD is in anything but RGB888 mode, its outputs are configured
for RGB5551 output.  Integrator/CP supports RGB565 via an external
multiplexer, which we configure for RGB5551 or RGB565 based only on the
bits per pixel.  So when userspace asks for the RGB555 layout, the mux
remains in RGB565 mode, and we produce incorrect colours.  Fix this.

Note that Integrator doesn't support BGR565 mode, but does support
BGR5551.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/include/mach/cm.h |    4 ++--
 arch/arm/mach-integrator/integrator_cp.c   |   14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-integrator/include/mach/cm.h b/arch/arm/mach-integrator/include/mach/cm.h
index 1ab353e..445d57a 100644
--- a/arch/arm/mach-integrator/include/mach/cm.h
+++ b/arch/arm/mach-integrator/include/mach/cm.h
@@ -24,9 +24,9 @@ void cm_control(u32, u32);
 #define CM_CTRL_LCDBIASDN		(1 << 10)
 #define CM_CTRL_LCDMUXSEL_MASK		(7 << 11)
 #define CM_CTRL_LCDMUXSEL_GENLCD	(1 << 11)
-#define CM_CTRL_LCDMUXSEL_VGA_16BPP	(2 << 11)
+#define CM_CTRL_LCDMUXSEL_VGA565_TFT555	(2 << 11)
 #define CM_CTRL_LCDMUXSEL_SHARPLCD	(3 << 11)
-#define CM_CTRL_LCDMUXSEL_VGA_8421BPP	(4 << 11)
+#define CM_CTRL_LCDMUXSEL_VGA555_TFT555	(4 << 11)
 #define CM_CTRL_LCDEN0			(1 << 14)
 #define CM_CTRL_LCDEN1			(1 << 15)
 #define CM_CTRL_STATIC1			(1 << 16)
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index e9327da..8600902 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -478,14 +478,16 @@ static struct clcd_panel vga = {
  */
 static void cp_clcd_enable(struct clcd_fb *fb)
 {
-	u32 val;
+	struct fb_var_screeninfo *var = &fb->fb.var;
+	u32 val = CM_CTRL_STATIC1 | CM_CTRL_STATIC2;
 
-	if (fb->fb.var.bits_per_pixel <= 8)
-		val = CM_CTRL_LCDMUXSEL_VGA_8421BPP;
+	if (var->bits_per_pixel <= 8 ||
+	    (var->bits_per_pixel == 16 && var->green.length == 5))
+		/* Pseudocolor, RGB555, BGR555 */
+		val |= CM_CTRL_LCDMUXSEL_VGA555_TFT555;
 	else if (fb->fb.var.bits_per_pixel <= 16)
-		val = CM_CTRL_LCDMUXSEL_VGA_16BPP
-			| CM_CTRL_LCDEN0 | CM_CTRL_LCDEN1
-			| CM_CTRL_STATIC1 | CM_CTRL_STATIC2;
+		/* truecolor RGB565 */
+		val |= CM_CTRL_LCDMUXSEL_VGA565_TFT555;
 	else
 		val = 0; /* no idea for this, don't trust the docs */
 
-- 
1.6.2.5
