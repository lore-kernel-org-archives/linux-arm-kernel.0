From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 09:32:08 +0800
Subject: [PATCH 3/3] ARM: imx: create imx_arch_reset_init() for DT boot
In-Reply-To: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
References: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1368408728-12264-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc_arch_reset_init() uses static mapping and calls clk_get_sys() to
get clock.  It's suitable for non-DT boot but not for DT boot where
dynamic mapping and of_clk_get() should be used instead.  Create
imx_arch_reset_init() as the DT variant of mxc_arch_reset_init(),
and change DT platforms to use it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h     |    1 +
 arch/arm/mach-imx/imx25-dt.c   |    3 +--
 arch/arm/mach-imx/imx27-dt.c   |    3 +--
 arch/arm/mach-imx/imx31-dt.c   |    3 +--
 arch/arm/mach-imx/imx51-dt.c   |    3 +--
 arch/arm/mach-imx/mach-imx53.c |    2 +-
 arch/arm/mach-imx/system.c     |   20 ++++++++++++++++++++
 7 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c08ae3f..3ef909b 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -74,6 +74,7 @@ extern struct platform_device *mxc_register_gpio(char *name, int id,
 extern void mxc_set_cpu_type(unsigned int type);
 extern void mxc_restart(char, const char *);
 extern void mxc_arch_reset_init(void __iomem *);
+extern void imx_arch_reset_init(void);
 extern int mx53_revision(void);
 extern int imx6q_revision(void);
 extern int mx53_display_revision(void);
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index ec33991..a2575267 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -15,12 +15,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include "common.h"
-#include "hardware.h"
 #include "mx25.h"
 
 static void __init imx25_dt_init(void)
 {
-	mxc_arch_reset_init(MX25_IO_ADDRESS(MX25_WDOG_BASE_ADDR));
+	imx_arch_reset_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 93aef1a..174e441 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -16,14 +16,13 @@
 #include <asm/mach/time.h>
 
 #include "common.h"
-#include "hardware.h"
 #include "mx27.h"
 
 static void __init imx27_dt_init(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
 
-	mxc_arch_reset_init(MX27_IO_ADDRESS(MX27_WDOG_BASE_ADDR));
+	imx_arch_reset_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index d8b3b22..a07cdec 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -16,12 +16,11 @@
 #include <asm/mach/time.h>
 
 #include "common.h"
-#include "hardware.h"
 #include "mx31.h"
 
 static void __init imx31_dt_init(void)
 {
-	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
+	imx_arch_reset_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 55f47a0..b2f5830 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -17,14 +17,13 @@
 #include <asm/mach/time.h>
 
 #include "common.h"
-#include "hardware.h"
 #include "mx51.h"
 
 static void __init imx51_dt_init(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
 
-	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
+	imx_arch_reset_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_full(&devinfo);
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 7a56561..e0da2cc 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -39,7 +39,7 @@ static void __init imx53_qsb_init(void)
 
 static void __init imx53_dt_init(void)
 {
-	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG1_BASE_ADDR));
+	imx_arch_reset_init();
 
 	if (of_machine_is_compatible("fsl,imx53-qsb"))
 		imx53_qsb_init();
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 02cf449..973f01d 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/system_misc.h>
 #include <asm/proc-fns.h>
@@ -75,3 +77,21 @@ void __init mxc_arch_reset_init(void __iomem *base)
 
 	clk_prepare(wdog_clk);
 }
+
+void __init imx_arch_reset_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx21-wdt");
+	wdog_base = of_iomap(np, 0);
+	WARN_ON(!wdog_base);
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
-- 
1.7.9.5
