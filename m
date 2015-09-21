From: javiermartin@by.com.es (Javier Martin)
Date: Mon, 21 Sep 2015 18:25:40 +0200
Subject: [RFC] imx6: Fix reboot routine for boards using WDOG2 as reset.
Message-ID: <1442852740-29313-1-git-send-email-javiermartin@by.com.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
we are using a var-som-dual board from Variscite with kernel 4.1.

It looks like, in this board, the source for the watchdog reset
needs to be WDOG2 sicne the external pmic uses that signal in
bypass mode.

We have gound a patch from Variscite where they use a new device tree 
property which is not mainlined to tell the difference between the 
"regular" reset case and this one which is present in the above
mentioned board.

The patch below works in our board but I would like to come up
with a more suitabl solution that everyone is happy with and can
be mainlined.

Please, any feedback on the matter will be more than welcome.

---
 arch/arm/mach-imx/common.h      |  1 +
 arch/arm/mach-imx/mach-imx6q.c  |  3 +++
 arch/arm/mach-imx/mach-imx6sl.c |  3 +++
 arch/arm/mach-imx/system.c      | 47 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 0f04e30..3f1a6a1 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -56,6 +56,7 @@ struct platform_device *mxc_register_gpio(char *name, int id,
 void mxc_set_cpu_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
+void mxc_arch_reset_init_dt(void);
 int mx51_revision(void);
 int mx53_revision(void);
 void imx_set_aips(void __iomem *);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 3ab6154..983c9cc 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -269,6 +269,8 @@ static void __init imx6q_init_machine(void)
 	imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 			      imx_get_soc_revision());
 
+	mxc_arch_reset_init_dt();
+
 	parent = imx_soc_device_init();
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
@@ -408,4 +410,5 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
 	.init_machine	= imx6q_init_machine,
 	.init_late      = imx6q_init_late,
 	.dt_compat	= imx6q_dt_compat,
+	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 12a1b09..716242f 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -48,6 +48,8 @@ static void __init imx6sl_init_machine(void)
 {
 	struct device *parent;
 
+	mxc_arch_reset_init_dt();
+
 	parent = imx_soc_device_init();
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
@@ -78,4 +80,5 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
 	.init_machine	= imx6sl_init_machine,
 	.init_late      = imx6sl_init_late,
 	.dt_compat	= imx6sl_dt_compat,
+	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 51c3501..43cad8f 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -34,6 +34,7 @@
 
 static void __iomem *wdog_base;
 static struct clk *wdog_clk;
+static u32 wdog_source = 1; /* use WDOG1 default */
 
 /*
  * Reset the system. It is called by machine_restart().
@@ -50,6 +51,17 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 
 	if (cpu_is_mx1())
 		wcr_enable = (1 << 0);
+	/*
+	 * Some i.MX6 boards use WDOG2 to reset external pmic in bypass mode,
+	 * so do WDOG2 reset here. Do not set SRS, since we will
+	 * trigger external POR later. Use WDOG1 to reset in ldo-enable
+	 * mode. You can set it by "fsl,wdog-reset" in dts.
+	 * For i.MX6SX we have to trigger wdog-reset to reset QSPI-NOR flash to
+	 * workaround qspi-nor reboot issue whatever ldo-bypass or not.
+	 */
+	else if ((wdog_source == 2 && (cpu_is_imx6q() || cpu_is_imx6dl() ||
+			cpu_is_imx6sl())) || cpu_is_imx6sx())
+		wcr_enable = 0x14;
 	else
 		wcr_enable = (1 << 2);
 
@@ -89,6 +101,41 @@ void __init mxc_arch_reset_init(void __iomem *base)
 		clk_prepare(wdog_clk);
 }
 
+void __init mxc_arch_reset_init_dt(void)
+{
+	struct device_node *np = NULL;
+
+	if (cpu_is_imx6q() || cpu_is_imx6dl())
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
+	else if (cpu_is_imx6sl())
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-gpc");
+
+	if (np)
+		of_property_read_u32(np, "fsl,wdog-reset", &wdog_source);
+	pr_info("Use WDOG%d as reset source\n", wdog_source);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx21-wdt");
+	wdog_base = of_iomap(np, 0);
+	WARN_ON(!wdog_base);
+
+	/* Some i.MX6 boards use WDOG2 to reset board in ldo-bypass mode */
+	if (wdog_source == 2 && (cpu_is_imx6q() || cpu_is_imx6dl() ||
+		cpu_is_imx6sl())) {
+		np = of_find_compatible_node(np, NULL, "fsl,imx21-wdt");
+		wdog_base = of_iomap(np, 0);
+		WARN_ON(!wdog_base);
+	}
+
+	wdog_clk = of_clk_get(np, 0);
+	if (IS_ERR(wdog_clk)) {
+		pr_warn("%s: failed to get wdog clock\n", __func__);
+		wdog_clk = NULL;
+		return;
+	}
+
+	clk_prepare(wdog_clk);
+}
+
 #ifdef CONFIG_CACHE_L2X0
 void __init imx_init_l2cache(void)
 {
-- 
1.9.1
