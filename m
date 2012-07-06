From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  6 Jul 2012 09:47:20 +0200
Subject: [PATCH v2] ARM: imx: select USE_OF
In-Reply-To: <20120706071247.GC30009@pengutronix.de>
References: <20120706071247.GC30009@pengutronix.de>
Message-ID: <1341560840-30400-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit

      544496a (ARM: imx: move irq_domain_add_legacy call into avic driver)

introduced unconditional calls to irq_find_mapping and
irq_domain_add_legacy, but it's still possible to have a .config without
CONFIG_IRQ_DOMAIN=y resulting in

	  CC      arch/arm/plat-mxc/avic.o
	arch/arm/plat-mxc/avic.c: In function 'avic_handle_irq':
	arch/arm/plat-mxc/avic.c:172: error: implicit declaration of function 'irq_find_mapping'
	arch/arm/plat-mxc/avic.c: In function 'mxc_init_irq':
	arch/arm/plat-mxc/avic.c:207: error: implicit declaration of function 'irq_domain_add_legacy'
	arch/arm/plat-mxc/avic.c:208: error: 'irq_domain_simple_ops' undeclared (first use in this function)
	arch/arm/plat-mxc/avic.c:208: error: (Each undeclared identifier is reported only once
	arch/arm/plat-mxc/avic.c:208: error: for each function it appears in.)
	arch/arm/plat-mxc/avic.c:208: warning: assignment makes pointer from integer without a cast
	make[3]: *** [arch/arm/plat-mxc/avic.o] Error 1
	make[2]: *** [arch/arm/plat-mxc/avic.o] Error 2
	make[1]: *** [sub-make] Error 2
	make: *** [all] Error 2

While selecting CONFIG_IRQ_DOMAIN would be enough, USE_OF is the future
and implies CONFIG_IRQ_DOMAIN. So select USE_OF for ARCH_MXC and drop
other explicit selects that are superflous now.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig          |    1 +
 arch/arm/mach-imx/Kconfig |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..97a33c5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -446,6 +446,7 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select MULTI_IRQ_HANDLER
+	select USE_OF
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0021f72..7793c63 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -380,7 +380,6 @@ config MACH_IMX27IPCAM
 config MACH_IMX27_DT
 	bool "Support i.MX27 platforms from device tree"
 	select SOC_IMX27
-	select USE_OF
 	help
 	  Include support for Freescale i.MX27 based platforms
 	  using the device tree for discovery
@@ -662,7 +661,6 @@ comment "i.MX51 machines:"
 config MACH_IMX51_DT
 	bool "Support i.MX51 platforms from device tree"
 	select SOC_IMX51
-	select USE_OF
 	select MACH_MX51_BABBAGE
 	help
 	  Include support for Freescale i.MX51 based platforms
@@ -758,7 +756,6 @@ comment "i.MX53 machines:"
 config MACH_IMX53_DT
 	bool "Support i.MX53 platforms from device tree"
 	select SOC_IMX53
-	select USE_OF
 	select MACH_MX53_ARD
 	select MACH_MX53_EVK
 	select MACH_MX53_LOCO
@@ -831,7 +828,6 @@ config SOC_IMX6Q
 	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_IMX6Q
-	select USE_OF
 
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
-- 
1.7.10
