From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:00 +0800
Subject: [PATCH v4 03/18] arm: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Roland Stigge <stigge@antcom.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/kernel/setup.c                 |  6 +-----
 arch/arm/mach-artpec/board-artpec6.c    |  3 ---
 arch/arm/mach-bcm/board_bcm21664.c      |  2 --
 arch/arm/mach-bcm/board_bcm281xx.c      |  2 --
 arch/arm/mach-bcm/board_bcm2835.c       | 10 ----------
 arch/arm/mach-exynos/exynos.c           |  3 ---
 arch/arm/mach-highbank/highbank.c       |  3 ---
 arch/arm/mach-imx/imx27-dt.c            |  2 --
 arch/arm/mach-imx/mach-imx51.c          |  2 --
 arch/arm/mach-imx/mach-imx53.c          |  2 --
 arch/arm/mach-imx/mach-imx6ul.c         |  1 -
 arch/arm/mach-imx/mach-imx7d.c          |  1 -
 arch/arm/mach-keystone/keystone.c       |  1 -
 arch/arm/mach-mvebu/board-v7.c          |  3 ---
 arch/arm/mach-mvebu/dove.c              |  2 --
 arch/arm/mach-picoxcell/common.c        |  2 --
 arch/arm/mach-rockchip/rockchip.c       |  1 -
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |  2 --
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c |  3 ---
 arch/arm/mach-shmobile/setup-r8a7740.c  |  3 ---
 arch/arm/mach-shmobile/setup-sh73a0.c   |  2 --
 arch/arm/mach-spear/spear1310.c         |  2 --
 arch/arm/mach-spear/spear1340.c         |  1 -
 arch/arm/mach-vt8500/vt8500.c           |  3 ---
 24 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 18a29a0..5397cb3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -903,11 +903,7 @@ static int __init customize_machine(void)
 	 */
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
-#ifdef CONFIG_OF
-	else
-		of_platform_populate(NULL, of_default_bus_match_table,
-					NULL, NULL);
-#endif
+
 	return 0;
 }
 arch_initcall(customize_machine);
diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
index 71513df..a0b1979 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -13,7 +13,6 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_platform.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk-provider.h>
@@ -44,8 +43,6 @@ static void __init artpec6_init_machine(void)
 		regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
 			     ARTPEC6_DMACFG_UARTS_BURST);
 	};
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
diff --git a/arch/arm/mach-bcm/board_bcm21664.c b/arch/arm/mach-bcm/board_bcm21664.c
index 82ad568..0d7034c 100644
--- a/arch/arm/mach-bcm/board_bcm21664.c
+++ b/arch/arm/mach-bcm/board_bcm21664.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/io.h>
 
 #include <asm/mach/arch.h>
@@ -60,7 +59,6 @@ static void bcm21664_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init bcm21664_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	kona_l2_cache_init();
 }
 
diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index 2e367bd..b81bb38 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -13,7 +13,6 @@
 
 #include <linux/clocksource.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 
@@ -58,7 +57,6 @@ static void bcm281xx_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init bcm281xx_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	kona_l2_cache_init();
 }
 
diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 834d676..0c1edfc 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/clk/bcm2835.h>
 
 #include <asm/mach/arch.h>
@@ -23,16 +22,7 @@
 
 static void __init bcm2835_init(void)
 {
-	int ret;
-
 	bcm2835_init_clocks();
-
-	ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
-				   NULL);
-	if (ret) {
-		pr_err("of_platform_populate failed: %d\n", ret);
-		BUG();
-	}
 }
 
 static const char * const bcm2835_compat[] = {
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bbf51a4..d4fa77e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -14,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/irqchip.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
@@ -263,8 +262,6 @@ static void __init exynos_dt_machine_init(void)
 		platform_device_register(&exynos_cpuidle);
 
 	exynos_cpufreq_init();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static char const *const exynos_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 6050a14..07f6098 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -23,7 +23,6 @@
 #include <linux/pl320-ipc.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/reboot.h>
 #include <linux/amba/bus.h>
@@ -163,8 +162,6 @@ static void __init highbank_init(void)
 
 	pl320_ipc_register_notifier(&hb_keys_nb);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
 	if (psci_ops.cpu_suspend)
 		platform_device_register(&highbank_cpuidle_device);
 }
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index bd42d1b..ae33ce4 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -22,8 +22,6 @@ static void __init imx27_dt_init(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
 	platform_device_register_full(&devinfo);
 }
 
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 6883fba..a4ada63 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -54,8 +54,6 @@ static void __init imx51_dt_init(void)
 
 	imx51_ipu_mipi_setup();
 	imx_src_init();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_full(&devinfo);
 }
 
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 86316a9..13a94a4 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -32,8 +32,6 @@ static void __init imx53_dt_init(void)
 {
 	imx_src_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index a38b16b..4078b1c 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -64,7 +64,6 @@ static void __init imx6ul_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	imx6ul_enet_init();
 	imx_anatop_init();
 	imx6ul_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 5a27f20..a924952 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -93,7 +93,6 @@ static void __init imx7d_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	imx_anatop_init();
 	imx7d_enet_init();
 }
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e6b9cb1..afe35d0 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -60,7 +60,6 @@ static void __init keystone_init(void)
 		bus_register_notifier(&platform_bus_type, &platform_nb);
 	}
 	keystone_pm_runtime_init();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static unsigned long keystone_virt_to_idmap(unsigned long x)
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 1648edd..ccca951 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
@@ -144,8 +143,6 @@ static void __init mvebu_dt_init(void)
 {
 	if (of_machine_is_compatible("marvell,armadaxp"))
 		i2c_quirk();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * const armada_370_xp_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-mvebu/dove.c b/arch/arm/mach-mvebu/dove.c
index 1aebb82..d076c57 100644
--- a/arch/arm/mach-mvebu/dove.c
+++ b/arch/arm/mach-mvebu/dove.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/soc/dove/pmu.h>
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/arch.h>
@@ -26,7 +25,6 @@ static void __init dove_init(void)
 #endif
 	BUG_ON(mvebu_mbus_dt_init(false));
 	dove_init_pmu();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * const dove_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index ec79fea..4e3d6d5 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -10,7 +10,6 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/reboot.h>
 
 #include <asm/mach/arch.h>
@@ -54,7 +53,6 @@ static void __init picoxcell_map_io(void)
 
 static void __init picoxcell_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	picoxcell_setup_restart();
 }
 
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 3f07cc5..5e00909 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -73,7 +73,6 @@ static void __init rockchip_timer_init(void)
 static void __init rockchip_dt_init(void)
 {
 	rockchip_suspend_init();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
 }
 
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index 5f028ff..c83c076 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -17,7 +17,6 @@
 
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
-#include <linux/of_platform.h>
 #include <linux/serial_s3c.h>
 
 #include <asm/mach/arch.h>
@@ -35,7 +34,6 @@ static void __init s3c2416_dt_map_io(void)
 
 static void __init s3c2416_dt_machine_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	s3c_pm_init();
 }
 
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index bbf74ed..5bf9afa 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -8,8 +8,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
@@ -48,7 +46,6 @@ static void __init s3c64xx_dt_map_io(void)
 static void __init s3c64xx_dt_init_machine(void)
 {
 	samsung_wdt_reset_of_init();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void s3c64xx_dt_restart(enum reboot_mode mode, const char *cmd)
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index db6dbfb..3849eef 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
-#include <linux/of_platform.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -77,8 +76,6 @@ static void __init r8a7740_init_irq_of(void)
 static void __init r8a7740_generic_init(void)
 {
 	r8a7740_meram_workaround();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *const r8a7740_boards_compat_dt[] __initconst = {
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 99a2004..a25ff18 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -18,7 +18,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
@@ -55,7 +54,6 @@ static void __init sh73a0_generic_init(void)
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
 #endif
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *const sh73a0_boards_compat_dt[] __initconst = {
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index cd5d375..a7d4f13 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -14,7 +14,6 @@
 #define pr_fmt(fmt) "SPEAr1310: " fmt
 
 #include <linux/amba/pl022.h>
-#include <linux/of_platform.h>
 #include <linux/pata_arasan_cf_data.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -27,7 +26,6 @@
 
 static void __init spear1310_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_simple("spear-cpufreq", -1, NULL, 0);
 }
 
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 94594d5..a212af9 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -19,7 +19,6 @@
 
 static void __init spear1340_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_simple("spear-cpufreq", -1, NULL, 0);
 }
 
diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 3bc0dc9..773c04f 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -30,7 +30,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 
 #define LEGACY_GPIO_BASE	0xD8110000
 #define LEGACY_PMC_BASE		0xD8130000
@@ -158,8 +157,6 @@ static void __init vt8500_init(void)
 		pm_power_off = &vt8500_power_off;
 	else
 		pr_err("%s: PMC Hibernation register could not be remapped, not enabling power off!\n", __func__);
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * const vt8500_dt_compat[] = {
-- 
1.7.12.4
