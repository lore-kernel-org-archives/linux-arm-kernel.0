From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 12:49:59 +0200
Subject: [PATCH 4/6] ARM: imx: rework mx27_pm_init() call
In-Reply-To: <20160624105001.3166287-1-arnd@arndb.de>
References: <20160624105001.3166287-1-arnd@arndb.de>
Message-ID: <20160624105001.3166287-5-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27_pm_init() uses its own initcall, unlike all of the other
functions like it. Replacing the initcall with a .init_late()
callback makes imx27 more like the others and lets us remove
the last caller of cpu_is_mx27().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/common.h   | 1 +
 arch/arm/mach-imx/imx27-dt.c | 1 +
 arch/arm/mach-imx/mm-imx27.c | 2 ++
 arch/arm/mach-imx/pm-imx27.c | 8 +-------
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 0a1d1f175b7a..a8f469333027 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -67,6 +67,7 @@ void imx_gpc_set_arm_power_in_lpm(bool power_off);
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
 void imx25_pm_init(void);
+void imx27_pm_init(void);
 
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 26490de9c038..6a94553dc13d 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -26,5 +26,6 @@ static const char * const imx27_dt_board_compat[] __initconst = {
 DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
 	.map_io		= mx27_map_io,
 	.init_irq	= mx27_init_irq,
+	.init_late	= imx27_pm_init,
 	.dt_compat	= imx27_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 7d82a5a5b16b..862b9b7762c7 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -98,4 +98,6 @@ void __init imx27_soc_init(void)
 	/* imx27 has the imx21 type audmux */
 	platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
 					ARRAY_SIZE(imx27_audmux_res));
+
+	imx27_pm_init();
 }
diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.c
index 43096c8990d4..d943535566c8 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -37,13 +37,7 @@ static const struct platform_suspend_ops mx27_suspend_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init mx27_pm_init(void)
+void __init imx27_pm_init(void)
 {
-	if (!cpu_is_mx27())
-		return 0;
-
 	suspend_set_ops(&mx27_suspend_ops);
-	return 0;
 }
-
-device_initcall(mx27_pm_init);
-- 
2.9.0
