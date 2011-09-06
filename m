From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  6 Sep 2011 17:58:39 +0800
Subject: [PATCH 5/6] arm/imx6q: add device tree machine support
In-Reply-To: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1315303120-24203-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds generic device tree based machine support for imx6q.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig               |   13 +++++
 arch/arm/mach-imx/Makefile              |    1 +
 arch/arm/mach-imx/mach-imx6q.c          |   81 +++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                     |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |   13 +++++
 5 files changed, 109 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx6q.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 13e0301..3364b59 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -624,3 +624,16 @@ config MACH_VPR200
 	  configurations for the board and its peripherals.
 
 endif
+
+if ARCH_MX6
+comment "i.MX6 machines:"
+
+config MACH_IMX6Q
+	bool "Support i.MX6 Quad platforms from device tree"
+	select SOC_IMX6Q
+	select USE_OF
+	help
+	  Include support for Freescale i.MX6 Quad based platforms
+	  using the device tree for discovery
+
+endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d46b2e7..84bd18c 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -71,3 +71,4 @@ obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o
+obj-$(CONFIG_MACH_IMX6Q) += mach-imx6q.o
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
new file mode 100644
index 0000000..b55f972
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -0,0 +1,81 @@
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
+}
+
+static void __init imx6q_map_io(void)
+{
+	imx_lluart_map_io();
+	imx_scu_map_io();
+}
+
+static void __init imx6q_init_irq(void)
+{
+	struct device_node *np;
+	struct of_intc_desc desc;
+	int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
+
+	l2x0_of_init(0, ~0UL);
+
+	memset(&desc, 0, sizeof(desc));
+	desc.controller = of_find_compatible_node(NULL, NULL,
+						  "arm,cortex-a9-gic");
+	gic_of_init(&desc);
+	imx_gpc_init();
+
+	np = desc.controller;
+	for_each_child_of_node(np, desc.controller)
+		gic_of_ppi_init(&desc);
+
+	for_each_compatible_node(np, NULL, "fsl,imx6q-gpio") {
+		gpio_irq_base -= 32;
+		irq_domain_add_simple(np, gpio_irq_base);
+	}
+}
+
+static void __init imx6q_timer_init(void)
+{
+	mx6q_clocks_init(32768, 24000000, 0, 0);
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
index 73da910..ff86063 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -64,6 +64,8 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
+extern int mx6q_clocks_init(unsigned long ckil, unsigned long osc,
+			unsigned long ckih1, unsigned long ckih2);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern int mxc_register_device(struct platform_device *pdev, void *data);
@@ -73,6 +75,17 @@ extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
 
+#ifdef CONFIG_DEBUG_LL
+extern void imx_lluart_map_io(void);
+#else
+static inline void imx_lluart_map_io(void) {}
+#endif
+#ifdef CONFIG_SMP
+extern void imx_scu_map_io(void);
+#else
+static inline void imx_scu_map_io(void) {}
+#endif
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
+extern void imx_gpc_init(void);
 #endif
-- 
1.7.4.1
