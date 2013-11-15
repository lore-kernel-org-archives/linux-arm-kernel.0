From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Nov 2013 19:19:06 +0100
Subject: [PATCH v4 3/4] ARM: sunxi: Register the A31 reset IP in init_time
In-Reply-To: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1384539547-29463-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has a reset IP that maintains a few other IPs in reset by
default. Among these IPs are the UARTs, and most notably the timers. We
thus need to register the reset driver before initializing the timers so
that the reset timer can use the reset framework.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index f184f6c2fa33..2e79736abe95 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -142,9 +142,17 @@ static const char * const sun6i_board_dt_compat[] = {
 	NULL,
 };
 
+extern void __init sun6i_reset_init(void);
+static void __init sun6i_timer_init(void)
+{
+	sunxi_init_clocks();
+	sun6i_reset_init();
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
1.8.4.2
