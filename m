From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 3 Apr 2013 01:06:26 +0200
Subject: [PATCH 2/3] clk: ux500: abx500: Define clock tree for ab850x
In-Reply-To: <1364943987-1338-1-git-send-email-ulf.hansson@stericsson.com>
References: <1364943987-1338-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1364943987-1338-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The patch setups the first version of the clock tree for ab850x, which
is used by u8500 platforms. Mainly sysctrl clocks are used.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/abx500-clk.c |   71 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ux500/abx500-clk.c b/drivers/clk/ux500/abx500-clk.c
index 9f7400d..a0fca00 100644
--- a/drivers/clk/ux500/abx500-clk.c
+++ b/drivers/clk/ux500/abx500-clk.c
@@ -12,13 +12,78 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/abx500/ab8500.h>
-
-/* TODO: Add clock implementations here */
-
+#include <linux/mfd/abx500/ab8500-sysctrl.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include "clk.h"
 
 /* Clock definitions for ab8500 */
 static int ab8500_reg_clks(struct device *dev)
 {
+	int ret;
+	struct clk *clk;
+
+	const char *intclk_parents[] = {"ab8500_sysclk", "ulpclk"};
+	u16 intclk_reg_sel[] = {0 , AB8500_SYSULPCLKCTRL1};
+	u8 intclk_reg_mask[] = {0 , AB8500_SYSULPCLKCTRL1_SYSULPCLKINTSEL_MASK};
+	u8 intclk_reg_bits[] = {
+		0 ,
+		(1 << AB8500_SYSULPCLKCTRL1_SYSULPCLKINTSEL_SHIFT)
+	};
+
+	dev_info(dev, "register clocks for ab850x\n");
+
+	/* Enable SWAT */
+	ret = ab8500_sysctrl_set(AB8500_SWATCTRL, AB8500_SWATCTRL_SWATENABLE);
+	if (ret)
+		return ret;
+
+	/* ab8500_sysclk */
+	clk = clk_reg_prcmu_gate("ab8500_sysclk", NULL, PRCMU_SYSCLK,
+				CLK_IS_ROOT);
+	clk_register_clkdev(clk, "sysclk", "ab8500-usb.0");
+	clk_register_clkdev(clk, "sysclk", "ab-iddet.0");
+	clk_register_clkdev(clk, "sysclk", "ab85xx-codec.0");
+	clk_register_clkdev(clk, "sysclk", "shrm_bus");
+
+	/* ab8500_sysclk2 */
+	clk = clk_reg_sysctrl_gate(dev , "ab8500_sysclk2", "ab8500_sysclk",
+		AB8500_SYSULPCLKCTRL1, AB8500_SYSULPCLKCTRL1_SYSCLKBUF2REQ,
+		AB8500_SYSULPCLKCTRL1_SYSCLKBUF2REQ, 0, 0);
+	clk_register_clkdev(clk, "sysclk", "0-0070");
+
+	/* ab8500_sysclk3 */
+	clk = clk_reg_sysctrl_gate(dev , "ab8500_sysclk3", "ab8500_sysclk",
+		AB8500_SYSULPCLKCTRL1, AB8500_SYSULPCLKCTRL1_SYSCLKBUF3REQ,
+		AB8500_SYSULPCLKCTRL1_SYSCLKBUF3REQ, 0, 0);
+	clk_register_clkdev(clk, "sysclk", "cg1960_core.0");
+
+	/* ab8500_sysclk4 */
+	clk = clk_reg_sysctrl_gate(dev , "ab8500_sysclk4", "ab8500_sysclk",
+		AB8500_SYSULPCLKCTRL1, AB8500_SYSULPCLKCTRL1_SYSCLKBUF4REQ,
+		AB8500_SYSULPCLKCTRL1_SYSCLKBUF4REQ, 0, 0);
+
+	/* ab_ulpclk */
+	clk = clk_reg_sysctrl_gate_fixed_rate(dev, "ulpclk", NULL,
+		AB8500_SYSULPCLKCTRL1, AB8500_SYSULPCLKCTRL1_ULPCLKREQ,
+		AB8500_SYSULPCLKCTRL1_ULPCLKREQ,
+		38400000, 9000, CLK_IS_ROOT);
+	clk_register_clkdev(clk, "ulpclk", "ab85xx-codec.0");
+
+	/* ab8500_intclk */
+	clk = clk_reg_sysctrl_set_parent(dev , "intclk", intclk_parents, 2,
+		intclk_reg_sel, intclk_reg_mask, intclk_reg_bits, 0);
+	clk_register_clkdev(clk, "intclk", "ab85xx-codec.0");
+	clk_register_clkdev(clk, NULL, "ab8500-pwm.1");
+
+	/* ab8500_audioclk */
+	clk = clk_reg_sysctrl_gate(dev , "audioclk", "intclk",
+		AB8500_SYSULPCLKCTRL1, AB8500_SYSULPCLKCTRL1_AUDIOCLKENA,
+		AB8500_SYSULPCLKCTRL1_AUDIOCLKENA, 0, 0);
+	clk_register_clkdev(clk, "audioclk", "ab85xx-codec.0");
+
 	return 0;
 }
 
-- 
1.7.10
