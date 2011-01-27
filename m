From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:58:10 +0000
Subject: [PATCH 01/10] ARM: versatile: support CLCD RGB565 layout with blue LSB
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRQQ-0003ma-4F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RGB565 with blue in the LSB wasn't supported.  Add support for this
layout.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-versatile/core.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 136c32e..2866c11 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -630,18 +630,22 @@ static void versatile_clcd_disable(struct clcd_fb *fb)
  */
 static void versatile_clcd_enable(struct clcd_fb *fb)
 {
+	struct fb_var_screeninfo *var = &fb->fb.var;
 	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
 	u32 val;
 
 	val = readl(sys_clcd);
 	val &= ~SYS_CLCD_MODE_MASK;
 
-	switch (fb->fb.var.green.length) {
+	switch (var->green.length) {
 	case 5:
 		val |= SYS_CLCD_MODE_5551;
 		break;
 	case 6:
-		val |= SYS_CLCD_MODE_565_RLSB;
+		if (var->red.offset == 0)
+			val |= SYS_CLCD_MODE_565_RLSB;
+		else
+			val |= SYS_CLCD_MODE_565_BLSB;
 		break;
 	case 8:
 		val |= SYS_CLCD_MODE_888;
@@ -709,10 +713,19 @@ static void versatile_clcd_remove(struct clcd_fb *fb)
 			      fb->fb.screen_base, fb->fb.fix.smem_start);
 }
 
+static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
+{
+	clcdfb_decode(fb, regs);
+
+	/* Always clear BGR for RGB565: we do the routing externally */
+	if (fb->fb.var.green.length == 6)
+		regs->cntl &= ~CNTL_BGR;
+}
+
 static struct clcd_board clcd_plat_data = {
 	.name		= "Versatile",
 	.check		= clcdfb_check,
-	.decode		= clcdfb_decode,
+	.decode		= versatile_clcd_decode,
 	.disable	= versatile_clcd_disable,
 	.enable		= versatile_clcd_enable,
 	.setup		= versatile_clcd_setup,
-- 
1.6.2.5
