From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 29 Jun 2014 15:48:53 +0200
Subject: [PATCH] ARM: sunxi: Reintroduce the restart code for A10/A20 SoCs
Message-ID: <1404049733-26226-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This partly reverts commits 553600502b84 (ARM: sunxi: Remove reset code from
the platform) and 5e669ec583e2 (ARM: sunxi: Remove init_machine callback) for
the sun4i, sun5i and sun7i families.

This is needed because the watchdog counterpart of these commits was dropped,
and didn't make it into 3.16. In order to still be able to reboot the board, we
need to reintroduce that code. Of course, the long term view is still to get
rid of that code in mach-sunxi.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Hi Arnd, Kevin, Olof,

Could you apply this patch directly and queue this as 3.16 fixes?

Thanks,
Maxime


 arch/arm/mach-sunxi/sunxi.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 4d09469320c8..42d4753683ce 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -12,8 +12,81 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/reboot.h>
 
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/system_misc.h>
+
+#define SUN4I_WATCHDOG_CTRL_REG		0x00
+#define SUN4I_WATCHDOG_CTRL_RESTART		BIT(0)
+#define SUN4I_WATCHDOG_MODE_REG		0x04
+#define SUN4I_WATCHDOG_MODE_ENABLE		BIT(0)
+#define SUN4I_WATCHDOG_MODE_RESET_ENABLE	BIT(1)
+
+#define SUN6I_WATCHDOG1_IRQ_REG		0x00
+#define SUN6I_WATCHDOG1_CTRL_REG	0x10
+#define SUN6I_WATCHDOG1_CTRL_RESTART		BIT(0)
+#define SUN6I_WATCHDOG1_CONFIG_REG	0x14
+#define SUN6I_WATCHDOG1_CONFIG_RESTART		BIT(0)
+#define SUN6I_WATCHDOG1_CONFIG_IRQ		BIT(1)
+#define SUN6I_WATCHDOG1_MODE_REG	0x18
+#define SUN6I_WATCHDOG1_MODE_ENABLE		BIT(0)
+
+static void __iomem *wdt_base;
+
+static void sun4i_restart(enum reboot_mode mode, const char *cmd)
+{
+	if (!wdt_base)
+		return;
+
+	/* Enable timer and set reset bit in the watchdog */
+	writel(SUN4I_WATCHDOG_MODE_ENABLE | SUN4I_WATCHDOG_MODE_RESET_ENABLE,
+	       wdt_base + SUN4I_WATCHDOG_MODE_REG);
+
+	/*
+	 * Restart the watchdog. The default (and lowest) interval
+	 * value for the watchdog is 0.5s.
+	 */
+	writel(SUN4I_WATCHDOG_CTRL_RESTART, wdt_base + SUN4I_WATCHDOG_CTRL_REG);
+
+	while (1) {
+		mdelay(5);
+		writel(SUN4I_WATCHDOG_MODE_ENABLE | SUN4I_WATCHDOG_MODE_RESET_ENABLE,
+		       wdt_base + SUN4I_WATCHDOG_MODE_REG);
+	}
+}
+
+static struct of_device_id sunxi_restart_ids[] = {
+	{ .compatible = "allwinner,sun4i-a10-wdt" },
+	{ /*sentinel*/ }
+};
+
+static void sunxi_setup_restart(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, sunxi_restart_ids);
+	if (WARN(!np, "unable to setup watchdog restart"))
+		return;
+
+	wdt_base = of_iomap(np, 0);
+	WARN(!wdt_base, "failed to map watchdog base address");
+}
+
+static void __init sunxi_dt_init(void)
+{
+	sunxi_setup_restart();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
 
 static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
@@ -23,7 +96,9 @@ static const char * const sunxi_board_dt_compat[] = {
 };
 
 DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
+	.init_machine	= sunxi_dt_init,
 	.dt_compat	= sunxi_board_dt_compat,
+	.restart	= sun4i_restart,
 MACHINE_END
 
 static const char * const sun6i_board_dt_compat[] = {
@@ -51,7 +126,9 @@ static const char * const sun7i_board_dt_compat[] = {
 };
 
 DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
+	.init_machine	= sunxi_dt_init,
 	.dt_compat	= sun7i_board_dt_compat,
+	.restart	= sun4i_restart,
 MACHINE_END
 
 static const char * const sun8i_board_dt_compat[] = {
-- 
2.0.0
