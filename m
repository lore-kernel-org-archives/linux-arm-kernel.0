From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  9 Jan 2013 18:17:18 +0100
Subject: [RFC PATCH 4/5] ARM i.MX5: Add System Reset Controller (SRC) support
 for i.MX51 and i.MX53
In-Reply-To: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1357751839-19680-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SRC in i.MX51 and i.MX53 is similar to the one in i.MX6q minus
the IPU2 reset line and multi core CPU reset/enable bits.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig      |    1 +
 arch/arm/mach-imx/common.h     |    3 ++-
 arch/arm/mach-imx/mach-imx6q.c |    2 +-
 arch/arm/mach-imx/mm-imx5.c    |    2 ++
 arch/arm/mach-imx/src.c        |   11 ++++++++++-
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3e628fd..d7924e5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -829,6 +829,7 @@ config	SOC_IMX53
 	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select HAVE_IMX_SRC
 	select PINCTRL
 	select PINCTRL_IMX53
 	select SOC_IMX5
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 7191ab4..f36be3c 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -133,7 +133,8 @@ static inline void imx_smp_prepare(void) {}
 #endif
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
-extern void imx_src_init(void);
+extern void imx5_src_init(void);
+extern void imx6q_src_init(void);
 extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index cd277a0..b1e076c 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -229,7 +229,7 @@ static const struct of_device_id imx6q_irq_match[] __initconst = {
 static void __init imx6q_init_irq(void)
 {
 	l2x0_of_init(0, ~0UL);
-	imx_src_init();
+	imx6q_src_init();
 	imx_gpc_init();
 	of_irq_init(imx6q_irq_match);
 }
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 79d71cf..53f87be 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -106,6 +106,7 @@ void __init imx51_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
+	imx5_src_init();
 }
 
 void __init imx53_init_early(void)
@@ -113,6 +114,7 @@ void __init imx53_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX53);
 	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG1_BASE_ADDR));
+	imx5_src_init();
 }
 
 void __init mx50_init_irq(void)
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 10658b4..7dbc08cb 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -97,7 +97,16 @@ void imx_src_prepare_restart(void)
 	writel_relaxed(0, src_base + SRC_GPR1);
 }
 
-void __init imx_src_init(void)
+void __init imx5_src_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx5-src");
+	src_base = of_iomap(np, 0);
+	WARN_ON(!src_base);
+}
+
+void __init imx6q_src_init(void)
 {
 	struct device_node *np;
 	u32 val;
-- 
1.7.10.4
