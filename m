From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 14 Dec 2012 15:17:02 +0100
Subject: [PATCH] ARM: u300: delete custom pin hog code
Message-ID: <1355494622-26022-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

With recent changes in the kernel, the MMCI and PL011 UART
drivers will autonomously request their pins to be muxed in,
so this machine-specific pin hogging code is just interfering
with the proper mechanism and causing regressions in the v3.8
kernel. Delete it and the problems go away.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC guys: please line up this one U300 patch for the
ARM fixes during/following the v3.8 merge window.
---
 arch/arm/mach-u300/core.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 12f3994..0374b98 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -27,7 +27,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
 #include <linux/pinctrl/machine.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/clk-u300.h>
@@ -1543,39 +1542,6 @@ static struct pinctrl_map __initdata u300_pinmux_map[] = {
 				    pin_highz_conf),
 };
 
-struct u300_mux_hog {
-	struct device *dev;
-	struct pinctrl *p;
-};
-
-static struct u300_mux_hog u300_mux_hogs[] = {
-	{
-		.dev = &uart0_device.dev,
-	},
-	{
-		.dev = &mmcsd_device.dev,
-	},
-};
-
-static int __init u300_pinctrl_fetch(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(u300_mux_hogs); i++) {
-		struct pinctrl *p;
-
-		p = pinctrl_get_select_default(u300_mux_hogs[i].dev);
-		if (IS_ERR(p)) {
-			pr_err("u300: could not get pinmux hog for dev %s\n",
-			       dev_name(u300_mux_hogs[i].dev));
-			continue;
-		}
-		u300_mux_hogs[i].p = p;
-	}
-	return 0;
-}
-subsys_initcall(u300_pinctrl_fetch);
-
 /*
  * Notice that AMBA devices are initialized before platform devices.
  *
-- 
1.7.11.3
