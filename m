From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 05:42:18 +0300
Subject: [PATCH 1/2] ARM: imx31: remove mx31_clocks_init_dt() function calls
In-Reply-To: <1474252939-12579-1-git-send-email-vz@mleia.com>
References: <1474252939-12579-1-git-send-email-vz@mleia.com>
Message-ID: <1474252939-12579-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock initialization for i.MX31 powered machines with DT support
should be done by a call of an init function registered with
CLK_OF_DECLARE() in common clock framework.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/common.h   | 1 -
 arch/arm/mach-imx/imx31-dt.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index a8f4693..e97d8cb 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -48,7 +48,6 @@ int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
 int mx31_clocks_init(unsigned long fref);
 int mx35_clocks_init(void);
-int mx31_clocks_init_dt(void);
 struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index 62e6b4f..668d74b 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -23,11 +23,6 @@ static const char * const imx31_dt_board_compat[] __initconst = {
 	NULL
 };
 
-static void __init imx31_dt_timer_init(void)
-{
-	mx31_clocks_init_dt();
-}
-
 /* FIXME: replace with DT binding */
 static const struct resource imx31_rnga_res[] __initconst = {
 	DEFINE_RES_MEM(MX31_RNGA_BASE_ADDR, SZ_16K),
@@ -43,7 +38,6 @@ DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
-	.init_time	= imx31_dt_timer_init,
 	.init_machine	= imx31_dt_mach_init,
 	.dt_compat	= imx31_dt_board_compat,
 MACHINE_END
-- 
2.8.1
