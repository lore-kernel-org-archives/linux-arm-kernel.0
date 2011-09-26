From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 26 Sep 2011 15:20:50 +0800
Subject: [PATCH v3 5/6] arm/imx6q: add device tree machine support
In-Reply-To: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
References: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317021651-17359-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds generic device tree based machine support for imx6q.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile              |    2 +-
 arch/arm/mach-imx/mach-imx6q.c          |   84 +++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                     |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |   13 +++++
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx6q.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d46b2e7..16737ba 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -70,4 +70,4 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
new file mode 100644
index 0000000..8bf5fa3
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+
+static void __init imx6q_init_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	imx6q_pm_init();
+}
+
+static void __init imx6q_map_io(void)
+{
+	imx_lluart_map_io();
+	imx_scu_map_io();
+}
+
+static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
+				   32 * 7; /* imx6q gets 7 gpio ports */
+
+	irq_domain_add_simple(np, gpio_irq_base);
+	gpio_irq_base += 32;
+}
+
+static const struct of_device_id imx6q_irq_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ .compatible = "fsl,imx6q-gpio", .data = imx6q_gpio_add_irq_domain, },
+	{ /* sentinel */ }
+};
+
+static void __init imx6q_init_irq(void)
+{
+	l2x0_of_init(0, ~0UL);
+	imx_src_init();
+	imx_gpc_init();
+	of_irq_init(imx6q_irq_match);
+}
+
+static void __init imx6q_timer_init(void)
+{
+	mx6q_clocks_init();
+}
+
+static struct sys_timer imx6q_timer = {
+	.init = imx6q_timer_init,
+};
+
+static const char *imx6q_dt_compat[] __initdata = {
+	"fsl,imx6q-sabreauto",
+	NULL,
+};
+
+DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
+	.map_io		= imx6q_map_io,
+	.init_irq	= imx6q_init_irq,
+	.handle_irq	= imx6q_handle_irq,
+	.timer		= &imx6q_timer,
+	.init_machine	= imx6q_init_machine,
+	.dt_compat	= imx6q_dt_compat,
+MACHINE_END
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 88633fe..c3ce146 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -822,7 +822,7 @@ config CACHE_L2X0
 		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
 		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
-		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX
+		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_MX6
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 5b24f5d..2c2eafa 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -64,6 +64,7 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
+extern int mx6q_clocks_init(void);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern int mxc_register_device(struct platform_device *pdev, void *data);
@@ -90,7 +91,19 @@ void gic_handle_irq(struct pt_regs *);
 
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
+#ifdef CONFIG_DEBUG_LL
+extern void imx_lluart_map_io(void);
+#else
+static inline void imx_lluart_map_io(void) {}
+#endif
 #ifdef CONFIG_SMP
 extern void v7_secondary_startup(void);
+extern void imx_scu_map_io(void);
+#else
+static inline void imx_scu_map_io(void) {}
 #endif
+extern void imx_enable_cpu(int cpu, bool enable);
+extern void imx_set_cpu_jump(int cpu, void *jump_addr);
+extern void imx_src_init(void);
+extern void imx_gpc_init(void);
 #endif
-- 
1.7.4.1
