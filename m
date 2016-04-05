From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 13:59:29 +0800
Subject: [PATCH v3 01/14] arm: use of_platform_default_populate() to populate
 default bus
In-Reply-To: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1459835982-26473-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Acked-by: Shawn Guo <shawnguo@kernel.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lars Persson <larper@axis.com>
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
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/kernel/setup.c                  | 3 +--
 arch/arm/mach-artpec/board-artpec6.c     | 2 +-
 arch/arm/mach-at91/at91rm9200.c          | 2 +-
 arch/arm/mach-at91/at91sam9.c            | 2 +-
 arch/arm/mach-at91/sama5.c               | 2 +-
 arch/arm/mach-bcm/board_bcm21664.c       | 2 +-
 arch/arm/mach-bcm/board_bcm281xx.c       | 2 +-
 arch/arm/mach-bcm/board_bcm2835.c        | 5 ++---
 arch/arm/mach-cns3xxx/core.c             | 3 +--
 arch/arm/mach-davinci/da8xx-dt.c         | 3 +--
 arch/arm/mach-exynos/exynos.c            | 2 +-
 arch/arm/mach-highbank/highbank.c        | 2 +-
 arch/arm/mach-imx/imx27-dt.c             | 2 +-
 arch/arm/mach-imx/mach-imx51.c           | 2 +-
 arch/arm/mach-imx/mach-imx53.c           | 2 +-
 arch/arm/mach-imx/mach-imx6q.c           | 2 +-
 arch/arm/mach-imx/mach-imx6sl.c          | 2 +-
 arch/arm/mach-imx/mach-imx6sx.c          | 2 +-
 arch/arm/mach-imx/mach-imx6ul.c          | 2 +-
 arch/arm/mach-imx/mach-imx7d.c           | 2 +-
 arch/arm/mach-integrator/integrator_ap.c | 3 +--
 arch/arm/mach-integrator/integrator_cp.c | 3 +--
 arch/arm/mach-keystone/keystone.c        | 2 +-
 arch/arm/mach-lpc32xx/phy3250.c          | 3 +--
 arch/arm/mach-mvebu/board-v7.c           | 2 +-
 arch/arm/mach-mvebu/dove.c               | 2 +-
 arch/arm/mach-mvebu/kirkwood.c           | 2 +-
 arch/arm/mach-mxs/mach-mxs.c             | 3 +--
 arch/arm/mach-nspire/nspire.c            | 3 +--
 arch/arm/mach-orion5x/board-dt.c         | 3 +--
 arch/arm/mach-picoxcell/common.c         | 2 +-
 arch/arm/mach-rockchip/rockchip.c        | 2 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c  | 2 +-
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c  | 2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c   | 3 +--
 arch/arm/mach-shmobile/setup-sh73a0.c    | 2 +-
 arch/arm/mach-spear/spear1310.c          | 2 +-
 arch/arm/mach-spear/spear1340.c          | 2 +-
 arch/arm/mach-spear/spear300.c           | 3 +--
 arch/arm/mach-spear/spear310.c           | 3 +--
 arch/arm/mach-spear/spear320.c           | 3 +--
 arch/arm/mach-spear/spear6xx.c           | 3 +--
 arch/arm/mach-tegra/tegra.c              | 2 +-
 arch/arm/mach-u300/core.c                | 3 +--
 arch/arm/mach-versatile/versatile_dt.c   | 3 +--
 arch/arm/mach-vt8500/vt8500.c            | 2 +-
 arch/arm/mach-zynq/common.c              | 2 +-
 47 files changed, 48 insertions(+), 65 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 139791e..3da5aec 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -905,8 +905,7 @@ static int __init customize_machine(void)
 		machine_desc->init_machine();
 #ifdef CONFIG_OF
 	else
-		of_platform_populate(NULL, of_default_bus_match_table,
-					NULL, NULL);
+		of_platform_default_populate(NULL, NULL, NULL);
 #endif
 	return 0;
 }
diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
index 71513df..932ea52 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -45,7 +45,7 @@ static void __init artpec6_init_machine(void)
 			     ARTPEC6_DMACFG_UARTS_BURST);
 	};
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 63b4fa2..d068ec3 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -30,7 +30,7 @@ static void __init at91rm9200_dt_device_init(void)
 	if (soc != NULL)
 		soc_dev = soc_device_to_device(soc);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, soc_dev);
 
 	at91rm9200_pm_init();
 }
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index cada2a6..ba28e9c 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -61,7 +61,7 @@ static void __init at91sam9_common_init(void)
 	if (soc != NULL)
 		soc_dev = soc_device_to_device(soc);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, soc_dev);
 }
 
 static void __init at91sam9_dt_device_init(void)
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index df8fdf1..c7d17df 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -50,7 +50,7 @@ static void __init sama5_dt_device_init(void)
 	if (soc != NULL)
 		soc_dev = soc_device_to_device(soc);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, soc_dev);
 	sama5_pm_init();
 }
 
diff --git a/arch/arm/mach-bcm/board_bcm21664.c b/arch/arm/mach-bcm/board_bcm21664.c
index 82ad568..b35c31c 100644
--- a/arch/arm/mach-bcm/board_bcm21664.c
+++ b/arch/arm/mach-bcm/board_bcm21664.c
@@ -60,7 +60,7 @@ static void bcm21664_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init bcm21664_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	kona_l2_cache_init();
 }
 
diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index 2e367bd..bf74547 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -58,7 +58,7 @@ static void bcm281xx_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init bcm281xx_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	kona_l2_cache_init();
 }
 
diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 834d676..fd190bb 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -27,10 +27,9 @@ static void __init bcm2835_init(void)
 
 	bcm2835_init_clocks();
 
-	ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
-				   NULL);
+	ret = of_platform_default_populate(NULL, NULL, NULL);
 	if (ret) {
-		pr_err("of_platform_populate failed: %d\n", ret);
+		pr_err("of_platform_default_populate failed: %d\n", ret);
 		BUG();
 	}
 }
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 9b1dc22..03da381 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -395,8 +395,7 @@ static void __init cns3xxx_init(void)
 
 	pm_power_off = cns3xxx_power_off;
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-                        cns3xxx_auxdata, NULL);
+	of_platform_default_populate(NULL, cns3xxx_auxdata, NULL);
 }
 
 static const char *const cns3xxx_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c4b5808..da46dc7 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -54,8 +54,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     da850_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 
 }
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bbf51a4..a0b5182 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -264,7 +264,7 @@ static void __init exynos_dt_machine_init(void)
 
 	exynos_cpufreq_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static char const *const exynos_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 6050a14..2e2d5df 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -163,7 +163,7 @@ static void __init highbank_init(void)
 
 	pl320_ipc_register_notifier(&hb_keys_nb);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	if (psci_ops.cpu_suspend)
 		platform_device_register(&highbank_cpuidle_device);
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index bd42d1b..265dd08 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -22,7 +22,7 @@ static void __init imx27_dt_init(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	platform_device_register_full(&devinfo);
 }
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 6883fba..8db1fd6 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -55,7 +55,7 @@ static void __init imx51_dt_init(void)
 	imx51_ipu_mipi_setup();
 	imx_src_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	platform_device_register_full(&devinfo);
 }
 
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 86316a9..6e915c3 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -32,7 +32,7 @@ static void __init imx53_dt_init(void)
 {
 	imx_src_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index cb27d56..e394070 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -278,7 +278,7 @@ static void __init imx6q_init_machine(void)
 
 	imx6q_enet_phy_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 3003263..37ae87d 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -52,7 +52,7 @@ static void __init imx6sl_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	imx6sl_fec_init();
 	imx_anatop_init();
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 6a0b061..107cfc1 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -72,7 +72,7 @@ static void __init imx6sx_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	imx6sx_enet_init();
 	imx_anatop_init();
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index a38b16b..fa9b512 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -64,7 +64,7 @@ static void __init imx6ul_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	imx6ul_enet_init();
 	imx_anatop_init();
 	imx6ul_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 5a27f20..f5a60fb 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -93,7 +93,7 @@ static void __init imx7d_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	imx_anatop_init();
 	imx7d_enet_init();
 }
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 5b0e363..4c2facd 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -302,8 +302,7 @@ static void __init ap_init_of(void)
 	if (!ebi_base)
 		return;
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			ap_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, ap_auxdata_lookup, NULL);
 
 	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index b5fb71a..31d893e 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -282,8 +282,7 @@ static void __init intcp_init_of(void)
 	if (!intcp_con_base)
 		return;
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     intcp_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, intcp_auxdata_lookup, NULL);
 }
 
 static const char * intcp_dt_board_compat[] = {
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e6b9cb1..1c98bca 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -60,7 +60,7 @@ static void __init keystone_init(void)
 		bus_register_notifier(&platform_bus_type, &platform_nb);
 	}
 	keystone_pm_runtime_init();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static unsigned long keystone_virt_to_idmap(unsigned long x)
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index b2f9e22..c6ec7ba 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -191,8 +191,7 @@ static void __init lpc3250_machine_init(void)
 		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
 		LPC32XX_CLKPWR_TEST_CLK_SEL);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     lpc32xx_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, lpc32xx_auxdata_lookup, NULL);
 }
 
 static const char *const lpc32xx_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 1648edd..3482539 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -145,7 +145,7 @@ static void __init mvebu_dt_init(void)
 	if (of_machine_is_compatible("marvell,armadaxp"))
 		i2c_quirk();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static const char * const armada_370_xp_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-mvebu/dove.c b/arch/arm/mach-mvebu/dove.c
index 1aebb82..18130e9 100644
--- a/arch/arm/mach-mvebu/dove.c
+++ b/arch/arm/mach-mvebu/dove.c
@@ -26,7 +26,7 @@ static void __init dove_init(void)
 #endif
 	BUG_ON(mvebu_mbus_dt_init(false));
 	dove_init_pmu();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static const char * const dove_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index f9d8e1e..8f459ee 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -179,7 +179,7 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_pm_init();
 	kirkwood_dt_eth_fixup();
 
-	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
+	of_platform_default_populate(NULL, auxdata, NULL);
 }
 
 static const char * const kirkwood_dt_board_compat[] __initconst = {
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index f1ea470..0b7fe74 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -498,8 +498,7 @@ static void __init mxs_machine_init(void)
 	else if (of_machine_is_compatible("msr,m28cu3"))
 		m28cu3_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	mxs_restart_init();
 
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 34c2a1b3..f0808fc 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -57,8 +57,7 @@ static struct of_dev_auxdata nspire_auxdata[] __initdata = {
 
 static void __init nspire_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			nspire_auxdata, NULL);
+	of_platform_default_populate(NULL, nspire_auxdata, NULL);
 }
 
 static void nspire_restart(enum reboot_mode mode, const char *cmd)
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 6f4c2c4..3d36f1d 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -63,8 +63,7 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     orion5x_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, orion5x_auxdata_lookup, NULL);
 }
 
 static const char *orion5x_dt_compat[] = {
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index ec79fea..add8622 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -54,7 +54,7 @@ static void __init picoxcell_map_io(void)
 
 static void __init picoxcell_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	picoxcell_setup_restart();
 }
 
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 3f07cc5..07ef8ef 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -73,7 +73,7 @@ static void __init rockchip_timer_init(void)
 static void __init rockchip_dt_init(void)
 {
 	rockchip_suspend_init();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
 }
 
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index 5f028ff..5991e98 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -35,7 +35,7 @@ static void __init s3c2416_dt_map_io(void)
 
 static void __init s3c2416_dt_machine_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	s3c_pm_init();
 }
 
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index bbf74ed..ebc9d5f 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -48,7 +48,7 @@ static void __init s3c64xx_dt_map_io(void)
 static void __init s3c64xx_dt_init_machine(void)
 {
 	samsung_wdt_reset_of_init();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static void s3c64xx_dt_restart(enum reboot_mode mode, const char *cmd)
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index db6dbfb..049ed57 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -77,8 +77,7 @@ static void __init r8a7740_init_irq_of(void)
 static void __init r8a7740_generic_init(void)
 {
 	r8a7740_meram_workaround();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static const char *const r8a7740_boards_compat_dt[] __initconst = {
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 99a2004..af38daf 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -55,7 +55,7 @@ static void __init sh73a0_generic_init(void)
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
 #endif
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static const char *const sh73a0_boards_compat_dt[] __initconst = {
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index cd5d375..3f5efcb 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -27,7 +27,7 @@
 
 static void __init spear1310_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	platform_device_register_simple("spear-cpufreq", -1, NULL, 0);
 }
 
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 94594d5..30969b6 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -19,7 +19,7 @@
 
 static void __init spear1340_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	platform_device_register_simple("spear-cpufreq", -1, NULL, 0);
 }
 
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index 5b32edd..325b895 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -194,8 +194,7 @@ static void __init spear300_dt_init(void)
 	pl080_plat_data.slave_channels = spear300_dma_info;
 	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear300_dma_info);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear300_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear300_auxdata_lookup, NULL);
 }
 
 static const char * const spear300_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index 86a44ac..59e173d 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -236,8 +236,7 @@ static void __init spear310_dt_init(void)
 	pl080_plat_data.slave_channels = spear310_dma_info;
 	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear310_dma_info);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear310_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear310_auxdata_lookup, NULL);
 }
 
 static const char * const spear310_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index d45d751..0958f68 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -240,8 +240,7 @@ static void __init spear320_dt_init(void)
 	pl080_plat_data.slave_channels = spear320_dma_info;
 	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear320_dma_info);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear320_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear320_auxdata_lookup, NULL);
 }
 
 static const char * const spear320_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index da26fa5b..ccf3573 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -411,8 +411,7 @@ struct of_dev_auxdata spear6xx_auxdata_lookup[] __initdata = {
 
 static void __init spear600_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear6xx_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear6xx_auxdata_lookup, NULL);
 }
 
 static const char *spear600_dt_board_compat[] = {
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 2378fa56..6745a65 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -115,7 +115,7 @@ static void __init tegra_dt_init(void)
 	 * devices
 	 */
 out:
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 }
 
 static void __init paz00_init(void)
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 546338b..a4910ea 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -391,8 +391,7 @@ static void __init u300_init_machine_dt(void)
 	pinctrl_register_mappings(u300_pinmux_map,
 				  ARRAY_SIZE(u300_pinmux_map));
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			u300_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, u300_auxdata_lookup, NULL);
 
 	/* Enable SEMI self refresh */
 	val = readw(syscon_base + U300_SYSCON_SMCR) |
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index dff1c05..efcf7b9 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -391,8 +391,7 @@ static void __init versatile_dt_init(void)
 	versatile_dt_pci_init();
 
 	platform_device_register(&versatile_flash_device);
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     versatile_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, versatile_auxdata_lookup, NULL);
 }
 
 static const char *const versatile_dt_match[] __initconst = {
diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 3bc0dc9..69bb16c 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -159,7 +159,7 @@ static void __init vt8500_init(void)
 	else
 		pr_err("%s: PMC Hibernation register could not be remapped, not enabling power off!\n", __func__);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static const char * const vt8500_dt_compat[] = {
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 860ffb6..06abe29 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -142,7 +142,7 @@ out:
 	 * Finished with the static registrations now; fill in the missing
 	 * devices
 	 */
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	platform_device_register(&zynq_cpuidle_device);
 	platform_device_register_full(&devinfo);
-- 
2.6.0.GIT
