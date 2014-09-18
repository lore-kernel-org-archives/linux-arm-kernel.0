From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Sep 2014 22:38:36 +0200
Subject: [PATCH] ARM: at91: sama5: configure L2 cache
Message-ID: <1411072716-20769-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Ensure that the L2 cache configuration is optimal to avoid depending on the
bootloader to set it correctly.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/board-dt-sama5.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
index 548de4ad6937..7cbe0d9daf2b 100644
--- a/arch/arm/mach-at91/board-dt-sama5.c
+++ b/arch/arm/mach-at91/board-dt-sama5.c
@@ -13,12 +13,14 @@
 #include <linux/gpio.h>
 #include <linux/micrel_phy.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/clk-provider.h>
 
 #include <asm/setup.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -35,8 +37,52 @@ static void __init sama5_dt_timer_init(void)
 	at91sam926x_pit_init();
 }
 
+static void __init at91_l2x0_init(void)
+{
+	struct device_node *np;
+	void __iomem *l2cc_base;
+	u32 reg;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
+	if (!np)
+		return;
+
+	l2cc_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!l2cc_base) {
+		pr_err("L2C-310 unable to map registers\n");
+		return;
+	}
+
+	/* Prefetch Control */
+	reg = readl_relaxed(l2cc_base + L310_PREFETCH_CTRL);
+	reg &= ~L310_PREFETCH_CTRL_OFFSET_MASK;
+	reg |= 0x01 & L310_PREFETCH_CTRL_OFFSET_MASK;
+	reg |= L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;
+	reg |= L310_PREFETCH_CTRL_PREFETCH_DROP;
+	reg |= L310_PREFETCH_CTRL_DATA_PREFETCH;
+	reg |= L310_PREFETCH_CTRL_INSTR_PREFETCH;
+	reg |= L310_PREFETCH_CTRL_DBL_LINEFILL;
+	writel_relaxed(reg, l2cc_base + L310_PREFETCH_CTRL);
+
+	/* Power Control */
+	reg = readl_relaxed(l2cc_base + L310_POWER_CTRL);
+	reg |= L310_STNDBY_MODE_EN;
+	reg |= L310_DYNAMIC_CLK_GATING_EN;
+	writel_relaxed(reg, l2cc_base + L310_POWER_CTRL);
+
+	/* Disable interrupts */
+	writel_relaxed(0x00, l2cc_base + L2X0_INTR_MASK);
+	writel_relaxed(0x01ff, l2cc_base + L2X0_INTR_CLEAR);
+
+	l2x0_of_init(0, ~0UL);
+}
+
 static void __init sama5_dt_device_init(void)
 {
+	at91_l2x0_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -66,5 +112,4 @@ DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5 (Device Tree)")
 	.init_early	= at91_dt_initialize,
 	.init_machine	= sama5_dt_device_init,
 	.dt_compat	= sama5_alt_dt_board_compat,
-	.l2c_aux_mask	= ~0UL,
 MACHINE_END
-- 
1.9.1
