From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  2 Mar 2011 12:01:21 +0100
Subject: [PATCH 2/4] ARM i.MX: iomux v1 initialization away from initcall
In-Reply-To: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
References: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1299063683-24903-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves us from soc level dispatching in generic files

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx1.c               |    3 +++
 arch/arm/mach-imx/mm-imx21.c              |    3 +++
 arch/arm/mach-imx/mm-imx27.c              |    3 +++
 arch/arm/plat-mxc/include/mach/iomux-v1.h |    2 ++
 arch/arm/plat-mxc/iomux-v1.c              |   24 +++---------------------
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 8613e44..2e482ba 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -25,6 +25,7 @@
 #include <mach/hardware.h>
 #include <mach/gpio.h>
 #include <mach/irqs.h>
+#include <mach/iomux-v1.h>
 
 static struct map_desc imx_io_desc[] __initdata = {
 	imx_map_entry(MX1, IO, MT_DEVICE),
@@ -39,6 +40,8 @@ void __init imx1_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX1);
 	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
+	imx_iomuxv1_init(MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
+			MX1_NUM_GPIO_PORT);
 }
 
 static struct mxc_gpio_port imx1_gpio_ports[] = {
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 6027e35..7a0c500 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -26,6 +26,7 @@
 #include <asm/mach/map.h>
 #include <mach/gpio.h>
 #include <mach/irqs.h>
+#include <mach/iomux-v1.h>
 
 /* MX21 memory map definition */
 static struct map_desc imx21_io_desc[] __initdata = {
@@ -65,6 +66,8 @@ void __init imx21_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX21);
 	mxc_arch_reset_init(MX21_IO_ADDRESS(MX21_WDOG_BASE_ADDR));
+	imx_iomuxv1_init(MX21_IO_ADDRESS(MX21_GPIO_BASE_ADDR),
+			MX21_NUM_GPIO_PORT);
 }
 
 static struct mxc_gpio_port imx21_gpio_ports[] = {
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index e172e3e..a6761a3 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -26,6 +26,7 @@
 #include <asm/mach/map.h>
 #include <mach/gpio.h>
 #include <mach/irqs.h>
+#include <mach/iomux-v1.h>
 
 /* MX27 memory map definition */
 static struct map_desc imx27_io_desc[] __initdata = {
@@ -65,6 +66,8 @@ void __init imx27_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX27);
 	mxc_arch_reset_init(MX27_IO_ADDRESS(MX27_WDOG_BASE_ADDR));
+	imx_iomuxv1_init(MX27_IO_ADDRESS(MX27_GPIO_BASE_ADDR),
+			MX27_NUM_GPIO_PORT);
 }
 
 static struct mxc_gpio_port imx27_gpio_ports[] = {
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
index 884f575..c07d302 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
@@ -100,4 +100,6 @@ extern int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
 		const char *label);
 extern void mxc_gpio_release_multiple_pins(const int *pin_list, int count);
 
+extern int __init imx_iomuxv1_init(void __iomem *base, int numports);
+
 #endif /* __MACH_IOMUX_V1_H__ */
diff --git a/arch/arm/plat-mxc/iomux-v1.c b/arch/arm/plat-mxc/iomux-v1.c
index 960a02c..3238c10 100644
--- a/arch/arm/plat-mxc/iomux-v1.c
+++ b/arch/arm/plat-mxc/iomux-v1.c
@@ -211,28 +211,10 @@ void mxc_gpio_release_multiple_pins(const int *pin_list, int count)
 }
 EXPORT_SYMBOL(mxc_gpio_release_multiple_pins);
 
-static int imx_iomuxv1_init(void)
+int __init imx_iomuxv1_init(void __iomem *base, int numports)
 {
-#ifdef CONFIG_ARCH_MX1
-	if (cpu_is_mx1()) {
-		imx_iomuxv1_baseaddr = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR);
-		imx_iomuxv1_numports = MX1_NUM_GPIO_PORT;
-	} else
-#endif
-#ifdef CONFIG_MACH_MX21
-	if (cpu_is_mx21()) {
-		imx_iomuxv1_baseaddr = MX21_IO_ADDRESS(MX21_GPIO_BASE_ADDR);
-		imx_iomuxv1_numports = MX21_NUM_GPIO_PORT;
-	} else
-#endif
-#ifdef CONFIG_MACH_MX27
-	if (cpu_is_mx27()) {
-		imx_iomuxv1_baseaddr = MX27_IO_ADDRESS(MX27_GPIO_BASE_ADDR);
-		imx_iomuxv1_numports = MX27_NUM_GPIO_PORT;
-	} else
-#endif
-		return -ENODEV;
+	imx_iomuxv1_baseaddr = base;
+	imx_iomuxv1_numports = numports;
 
 	return 0;
 }
-pure_initcall(imx_iomuxv1_init);
-- 
1.7.2.3
