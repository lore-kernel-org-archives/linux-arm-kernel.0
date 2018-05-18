From: david@lechnology.com (David Lechner)
Date: Fri, 18 May 2018 11:48:27 -0500
Subject: [PATCH v11 25/27] ARM: davinci: add device tree support to timer
In-Reply-To: <20180518164829.27052-1-david@lechnology.com>
References: <20180518164829.27052-1-david@lechnology.com>
Message-ID: <20180518164829.27052-26-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree support to the davinci timer so that when clocks
are moved to device tree, the timer will still work.

Signed-off-by: David Lechner <david@lechnology.com>
---

v11 changes:
- drop fallback to ref_clk

v10 changes:
- change compatible to "ti,da830-timer"
- remove comment clocks as platform devices

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
 arch/arm/mach-davinci/time.c  | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

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
index 7ea3db0ff062..5a6de5368ab0 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 
@@ -397,3 +398,17 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
+
+static int __init of_davinci_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	davinci_timer_init(clk);
+
+	return 0;
+}
+TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_init);
-- 
2.17.0
