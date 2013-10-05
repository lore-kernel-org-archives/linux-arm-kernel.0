From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  5 Oct 2013 16:39:19 +0200
Subject: [PATCH 3/4] ARM: sunxi: Register the A31 reset IP in init_time
In-Reply-To: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1380983960-11087-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has a reset IP that maintains a few other IPs in reset by
default. Among these IPs are the UARTs, and most notably the timers. We
thus need to register the reset driver before initializing the timers so
that the reset timer can use the reset framework.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index f184f6c..db4dff1 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -142,9 +142,29 @@ static const char * const sun6i_board_dt_compat[] = {
 	NULL,
 };
 
+static const struct of_device_id sun6i_reset_dt_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
+	{ .compatible = "allwinner,sun6i-a31-apb1-reset", },
+	{ .compatible = "allwinner,sun6i-a31-apb2-reset", },
+	{ /* sentinel */ }
+};
+
+extern void __init sun6i_reset_init(struct device_node *np);
+static void __init sun6i_timer_init(void)
+{
+	struct device_node *np;
+
+	sunxi_init_clocks();
+
+	for_each_matching_node(np, sun6i_reset_dt_ids)
+		sun6i_reset_init(np);
+
+	clocksource_of_init();
+}
+
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
 	.init_machine	= sunxi_dt_init,
-	.init_time	= sunxi_timer_init,
+	.init_time	= sun6i_timer_init,
 	.dt_compat	= sun6i_board_dt_compat,
 	.restart	= sun6i_restart,
 MACHINE_END
-- 
1.8.4
