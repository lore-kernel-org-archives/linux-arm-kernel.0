From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 12:49:56 +0200
Subject: [PATCH 1/6] ARM: imx: remove cpu_is_mx1 check
In-Reply-To: <20160624105001.3166287-1-arnd@arndb.de>
References: <20160624105001.3166287-1-arnd@arndb.de>
Message-ID: <20160624105001.3166287-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one call site for this, and it's easily replaced
by initializing the reset value at boot time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/common.h  |  1 +
 arch/arm/mach-imx/mm-imx1.c |  2 +-
 arch/arm/mach-imx/system.c  | 16 +++++++++-------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 60d9ae63f76e..0a1d1f175b7a 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -54,6 +54,7 @@ struct platform_device *mxc_register_gpio(char *name, int id,
 void mxc_set_cpu_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
+void imx1_reset_init(void __iomem *);
 void imx_set_aips(void __iomem *);
 void imx_aips_allow_unprivileged_access(const char *compat);
 int mxc_device_init(void);
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index e065fedb3ad4..9a42f19be81e 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -50,7 +50,7 @@ void __init mx1_init_irq(void)
 
 void __init imx1_soc_init(void)
 {
-	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
+	imx1_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
 	mxc_device_init();
 
 	mxc_register_gpio("imx1-gpio", 0, MX1_GPIO1_BASE_ADDR, SZ_256,
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index e442ed7f7ff5..c06af650e6b1 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -34,25 +34,19 @@
 
 static void __iomem *wdog_base;
 static struct clk *wdog_clk;
+static int wcr_enable = (1 << 2);
 
 /*
  * Reset the system. It is called by machine_restart().
  */
 void mxc_restart(enum reboot_mode mode, const char *cmd)
 {
-	unsigned int wcr_enable;
-
 	if (!wdog_base)
 		goto reset_fallback;
 
 	if (!IS_ERR(wdog_clk))
 		clk_enable(wdog_clk);
 
-	if (cpu_is_mx1())
-		wcr_enable = (1 << 0);
-	else
-		wcr_enable = (1 << 2);
-
 	/* Assert SRS signal */
 	imx_writew(wcr_enable, wdog_base);
 	/*
@@ -89,6 +83,14 @@ void __init mxc_arch_reset_init(void __iomem *base)
 		clk_prepare(wdog_clk);
 }
 
+#ifdef CONFIG_SOC_IMX1
+void __init imx1_reset_init(void __iomem *base)
+{
+	wcr_enable = (1 << 0);
+	mxc_arch_reset_init(base);
+}
+#endif
+
 #ifdef CONFIG_CACHE_L2X0
 void __init imx_init_l2cache(void)
 {
-- 
2.9.0
