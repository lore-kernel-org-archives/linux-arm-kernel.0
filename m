From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Dec 2011 14:32:14 +0800
Subject: [PATCH v2] arm/imx6: add restart support for imx6q
Message-ID: <1323066734-29994-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The restart support was missed from the initial imx6q submission.
The mxc_restart() does not work for imx6q.  Instead, this patch adds
the restart for imx6q.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
 * Fall into soft_restart in case that iomap for wdog_base fails

 arch/arm/mach-imx/clock-imx6q.c         |    2 -
 arch/arm/mach-imx/mach-imx6q.c          |   35 ++++++++++++++++++++++++++++++-
 arch/arm/mach-imx/src.c                 |   23 ++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 613a1b9..2234031 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1931,14 +1931,12 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x1 << BP_CLPCR_LPM;
 		val &= ~BM_CLPCR_VSTBY;
 		val &= ~BM_CLPCR_SBYOS;
-		val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
 		break;
 	case STOP_POWER_OFF:
 		val |= 0x2 << BP_CLPCR_LPM;
 		val |= 0x3 << BP_CLPCR_STBY_COUNT;
 		val |= BM_CLPCR_VSTBY;
 		val |= BM_CLPCR_SBYOS;
-		val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
 		break;
 	default:
 		return -EINVAL;
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index dc8b6e2..b8236f3 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -10,10 +10,13 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -23,6 +26,36 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 
+void imx6q_restart(char mode, const char *cmd)
+{
+	struct device_node *np;
+	void __iomem *wdog_base;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
+	wdog_base = of_iomap(np, 0);
+	if (!wdog_base)
+		goto soft;
+
+	imx_src_prepare_restart();
+
+	/* enable wdog */
+	writew_relaxed(1 << 2, wdog_base);
+	/* write twice to ensure the request will not get ignored */
+	writew_relaxed(1 << 2, wdog_base);
+
+	/* wait for reset to assert ... */
+	mdelay(500);
+
+	pr_err("Watchdog reset failed to assert reset\n");
+
+	/* delay to allow the serial port to show the message */
+	mdelay(50);
+
+soft:
+	/* we'll take a jump through zero as a poor second */
+	soft_restart(0);
+}
+
 static void __init imx6q_init_machine(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -81,5 +114,5 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
 	.timer		= &imx6q_timer,
 	.init_machine	= imx6q_init_machine,
 	.dt_compat	= imx6q_dt_compat,
-	.restart	= mxc_restart,
+	.restart	= imx6q_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 36cacbd..117538c 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -18,6 +18,7 @@
 
 #define SRC_SCR				0x000
 #define SRC_GPR1			0x020
+#define BP_SRC_SCR_WARM_RESET_ENABLE	0
 #define BP_SRC_SCR_CORE1_RST		14
 #define BP_SRC_SCR_CORE1_ENABLE		22
 
@@ -39,11 +40,33 @@ void imx_set_cpu_jump(int cpu, void *jump_addr)
 		       src_base + SRC_GPR1 + cpu * 8);
 }
 
+void imx_src_prepare_restart(void)
+{
+	u32 val;
+
+	/* clear enable bits of secondary cores */
+	val = readl_relaxed(src_base + SRC_SCR);
+	val &= ~(0x7 << BP_SRC_SCR_CORE1_ENABLE);
+	writel_relaxed(val, src_base + SRC_SCR);
+
+	/* clear persistent entry register of primary core */
+	writel_relaxed(0, src_base + SRC_GPR1);
+}
+
 void __init imx_src_init(void)
 {
 	struct device_node *np;
+	u32 val;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
 	src_base = of_iomap(np, 0);
 	WARN_ON(!src_base);
+
+	/*
+	 * force warm reset sources to generate cold reset
+	 * for a more reliable restart
+	 */
+	val = readl_relaxed(src_base + SRC_SCR);
+	val &= ~(1 << BP_SRC_SCR_WARM_RESET_ENABLE);
+	writel_relaxed(val, src_base + SRC_SCR);
 }
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4ee98d5..5ad0497 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -123,6 +123,7 @@ static inline void imx_smp_prepare(void) {}
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern void imx_src_init(void);
+extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
-- 
1.7.4.1
