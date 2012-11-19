From: sr@denx.de (Stefan Roese)
Date: Mon, 19 Nov 2012 12:09:43 +0100
Subject: [PATCH 4/4] ARM: sunxi: Add sunxi restart function via onchip watchdog
In-Reply-To: <1353323383-11827-1-git-send-email-sr@denx.de>
References: <1353323383-11827-1-git-send-email-sr@denx.de>
Message-ID: <1353323383-11827-4-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-sunxi/sunxi.c       |  1 +
 arch/arm/mach-sunxi/sunxi.h       |  2 ++
 drivers/clocksource/sunxi_timer.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 13d4d96..6b1186c 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -57,5 +57,6 @@ DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
 	.init_irq	= sunxi_init_irq,
 	.handle_irq	= sunxi_handle_irq,
 	.timer		= &sunxi_timer,
+	.restart	= sunxi_restart,
 	.dt_compat	= sunxi_board_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-sunxi/sunxi.h b/arch/arm/mach-sunxi/sunxi.h
index 33b5871..806c5fd 100644
--- a/arch/arm/mach-sunxi/sunxi.h
+++ b/arch/arm/mach-sunxi/sunxi.h
@@ -17,4 +17,6 @@
 #define SUNXI_REGS_VIRT_BASE	IOMEM(0xf1c00000)
 #define SUNXI_REGS_SIZE		(SZ_2M + SZ_1M)
 
+void sunxi_restart(char mode, const char *cmd);
+
 #endif /* __MACH_SUNXI_H */
diff --git a/drivers/clocksource/sunxi_timer.c b/drivers/clocksource/sunxi_timer.c
index 3c46434..dfbf879 100644
--- a/drivers/clocksource/sunxi_timer.c
+++ b/drivers/clocksource/sunxi_timer.c
@@ -34,6 +34,8 @@
 #define TIMER0_CTL_ONESHOT		(1 << 7)
 #define TIMER0_INTVAL_REG	0x14
 #define TIMER0_CNTVAL_REG	0x18
+#define WATCH_DOG_CTRL_REG	0x90
+#define WATCH_DOG_MODE_REG	0x94
 
 #define TIMER_SCAL		16
 
@@ -103,6 +105,18 @@ static struct of_device_id sunxi_timer_dt_ids[] = {
 	{ .compatible = "allwinner,sunxi-timer" },
 };
 
+void sunxi_restart(char mode, const char *cmd)
+{
+	/* Use watchdog to reset system */
+
+	/* Enable timer and set reset bit */
+	writel(3, timer_base + WATCH_DOG_MODE_REG);
+	writel(0xa57 << 1 | 1, timer_base + WATCH_DOG_CTRL_REG);
+
+	while(1)
+		;
+}
+
 static void __init sunxi_timer_init(void)
 {
 	struct device_node *node;
-- 
1.8.0
