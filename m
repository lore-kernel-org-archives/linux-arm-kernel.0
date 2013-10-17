From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Oct 2013 11:17:14 +0800
Subject: [PATCH 4/4] ARM: imx: enable suspend for imx6sl
In-Reply-To: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
References: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1381979834-20998-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6sl low power mode implementation inherits imx6q/dl one,
and pm-imx6q.c can just work for imx6sl with some minor updates.
Let's enable imx6sl suspend support by reusing pm-imx6q.c and use
cpu_is_imxXX() to handle the those minor differences between imx6sl
and imx6q/dl.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6sl.dtsi   |    3 ++-
 arch/arm/mach-imx/Makefile      |    2 ++
 arch/arm/mach-imx/clk-imx6sl.c  |    3 +++
 arch/arm/mach-imx/mach-imx6sl.c |    3 +++
 arch/arm/mach-imx/mxc.h         |    5 +++++
 arch/arm/mach-imx/pm-imx6q.c    |    9 ++++++++-
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 17607b3..f2f6df6 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -535,7 +535,8 @@
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-				compatible = "fsl,imx6sl-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx6sl-iomuxc-gpr",
+					     "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x020e0000 0x38>;
 			};
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5383c58..bbe1f5b 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -102,6 +102,8 @@ obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
+# i.MX6SL reuses pm-imx6q.c
+obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o
 endif
 
 # i.MX5 based machines
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index a5c3c5d..c0c4ef5 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -127,6 +127,9 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
+	/* Reuse imx6q pm code */
+	imx6q_pm_set_ccm_base(base);
+
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clks[IMX6SL_CLK_STEP]             = imx_clk_mux("step",             base + 0xc,  8,  1, step_sels,         ARRAY_SIZE(step_sels));
 	clks[IMX6SL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",          base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 5c767f0..c7502f2 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -48,6 +48,9 @@ static void __init imx6sl_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 
 	imx6sl_fec_init();
+	imx_anatop_init();
+	/* Reuse imx6q pm code */
+	imx6q_pm_init();
 }
 
 static void __init imx6sl_init_irq(void)
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 99e03ea..b08ab3a 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -153,6 +153,11 @@ extern unsigned int __mxc_cpu_type;
 #endif
 
 #ifndef __ASSEMBLY__
+static inline bool cpu_is_imx6sl(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6SL;
+}
+
 static inline bool cpu_is_imx6dl(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6DL;
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index f303b56..aecd9f8 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -144,6 +144,12 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x3 << BP_CLPCR_STBY_COUNT;
 		val |= BM_CLPCR_VSTBY;
 		val |= BM_CLPCR_SBYOS;
+		if (cpu_is_imx6sl()) {
+			val |= BM_CLPCR_BYPASS_PMIC_READY;
+			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
+		} else {
+			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -181,7 +187,8 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx_set_cpu_jump(0, v7_cpu_resume);
 		/* Zzz ... */
 		cpu_suspend(0, imx6q_suspend_finish);
-		imx_smp_prepare();
+		if (cpu_is_imx6q() || cpu_is_imx6dl())
+			imx_smp_prepare();
 		imx_anatop_post_resume();
 		imx_gpc_post_resume();
 		imx6q_enable_rbc(false);
-- 
1.7.9.5
