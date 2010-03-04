From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:57 +0000
Subject: [PATCH] ARM: Versatile Express: support adjusting clock rates for
	CLCD
References: <git-1267729916-22c6a14e4a304af9afdfe1ccf493570f862ba05f@rmk-PC>
Message-ID: <git-1267729916-55b8a145f52901366d2c992bd2294da807c7a14d@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/ct-ca9x4.c            |   16 +++++++++++++++-
 arch/arm/mach-vexpress/include/mach/clkdev.h |    5 ++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 7258398..5a0449c 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -103,7 +103,6 @@ static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
 {
 	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE_DB1, 0);
 	v2m_cfg_write(SYS_CFG_DVIMODE | SYS_CFG_SITE_DB1, 2);
-	v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE_DB1 | 1, 63500127);
 }
 
 static int ct_ca9x4_clcd_setup(struct clcd_fb *fb)
@@ -160,8 +159,23 @@ static struct amba_device *ct_ca9x4_amba_devs[] __initdata = {
 };
 
 
+static long ct_round(struct clk *clk, unsigned long rate)
+{
+	return rate;
+}
+
+static int ct_set(struct clk *clk, unsigned long rate)
+{
+	return v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE_DB1 | 1, rate);
+}
+
+static const struct clk_ops osc1_clk_ops = {
+	.round	= ct_round,
+	.set	= ct_set,
+};
 
 static struct clk osc1_clk = {
+	.ops	= &osc1_clk_ops,
 	.rate	= 24000000,
 };
 
diff --git a/arch/arm/mach-vexpress/include/mach/clkdev.h b/arch/arm/mach-vexpress/include/mach/clkdev.h
index baea03c..3f8307d 100644
--- a/arch/arm/mach-vexpress/include/mach/clkdev.h
+++ b/arch/arm/mach-vexpress/include/mach/clkdev.h
@@ -1,13 +1,12 @@
 #ifndef __ASM_MACH_CLKDEV_H
 #define __ASM_MACH_CLKDEV_H
 
-#include <asm/hardware/icst.h>
+#include <plat/clock.h>
 
 struct clk {
+	const struct clk_ops	*ops;
 	unsigned long		rate;
 	const struct icst_params *params;
-	void __iomem		*vcoreg;
-	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
 
 #define __clk_get(clk) ({ 1; })
