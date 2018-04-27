From: david@lechnology.com (David Lechner)
Date: Thu, 26 Apr 2018 19:17:43 -0500
Subject: [PATCH v9 25/27] ARM: davinci: add device tree support to timer
In-Reply-To: <20180427001745.4116-1-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
Message-ID: <20180427001745.4116-26-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree support to the davinci timer so that when clocks
are moved to device tree, the timer will still work.

Signed-off-by: David Lechner <david@lechnology.com>
---

v9 changes:
- none (there were supposed to be changed, but apparently they got squashed
  into the next commit - will fix on the next round)

v8 changes:
- none

v7 changes:
- rebased
- add davinci prefix to commit message

v6 changes:
- rebased

 arch/arm/mach-davinci/Kconfig |  1 +
 arch/arm/mach-davinci/time.c  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index ba9912b4dfab..da8a039d65f9 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -59,6 +59,7 @@ config MACH_DA8XX_DT
 	default y
 	depends on ARCH_DAVINCI_DA850
 	select PINCTRL
+	select TIMER_OF
 	help
 	  Say y here to include support for TI DaVinci DA850 based using
 	  Flattened Device Tree. More information at Documentation/devicetree
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 7ea3db0ff062..7a8c6fada644 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 
@@ -397,3 +398,33 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
+
+static int __init of_davinci_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		struct of_phandle_args clkspec;
+
+		/*
+		 * Fall back to using ref_clk if the actual clock is not
+		 * available. This currently always happens because platform
+		 * clocks (i.e PLLs and PSCs) are registered as platform
+		 * devices and therefore are not available@this point in
+		 * the boot process.
+		 */
+		clkspec.np = of_find_node_by_name(NULL, "ref_clk");
+		if (IS_ERR(clkspec.np)) {
+			pr_err("%s: No clock available for timer!\n", __func__);
+			return PTR_ERR(clkspec.np);
+		}
+		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
+	}
+
+	davinci_timer_init(clk);
+
+	return 0;
+}
+TIMER_OF_DECLARE(davinci_timer, "ti,davinci-timer", of_davinci_timer_init);
-- 
2.17.0
