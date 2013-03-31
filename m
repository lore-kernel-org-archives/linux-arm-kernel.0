From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 31 Mar 2013 22:48:07 +0800
Subject: [PATCH] ARM: imx: do not use regmap_read for ANADIG_DIGPROG
Message-ID: <1364741287-25618-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function imx_anatop_get_digprog() that reads register ANADIG_DIGPROG is
called to identify silicon version.  Users might query silicon version
earlier than regmap subsystem is ready.  For example, imx6q clock driver
query revision in mx6q_clocks_init(), where regmap is not initialized
yet.

Change imx_anatop_get_digprog() to map anatop block and read
ANADIG_DIGPROG in the native way, so that the function can work at very
early stage.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/anatop.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 472beee..0cfa07d 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -78,10 +78,19 @@ void imx_anatop_usb_chrg_detect_disable(void)
 
 u32 imx_anatop_get_digprog(void)
 {
-	u32  val;
+	struct device_node *np;
+	void __iomem *anatop_base;
+	static u32 digprog;
 
-	regmap_read(anatop, ANADIG_DIGPROG, &val);
-	return val;
+	if (digprog)
+		return digprog;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+	anatop_base = of_iomap(np, 0);
+	WARN_ON(!anatop_base);
+	digprog = readl_relaxed(anatop_base + ANADIG_DIGPROG);
+
+	return digprog;
 }
 
 void __init imx_anatop_init(void)
-- 
1.7.9.5
