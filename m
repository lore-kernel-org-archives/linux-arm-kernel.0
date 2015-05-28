From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 16:15:51 +0200
Subject: [PATCH] ARM: imx: imx7d requires anatop
Message-ID: <2067135.qgAceiU7yZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like i.MX6, the i.MX7 code calls into the anatop driver, which fails
if that is disabled:

arch/arm/mach-imx/built-in.o: In function `imx7d_init_machine':
arch/arm/mach-imx/mach-imx7d.c:24: undefined reference to `imx_anatop_init'
arch/arm/mach-imx/built-in.o: In function `imx7d_init_irq':
arch/arm/mach-imx/mach-imx7d.c:29: undefined reference to `imx_init_revision_from_anatop'

This patch ensures that for an imx7-only build, we still get anatop
built-in, matching what we do for imx6.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index bb2d058f4d11..e472746b01d2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -551,6 +551,7 @@ config SOC_IMX7D
 	bool "i.MX7 Dual support"
 	select PINCTRL_IMX7D
 	select ARM_GIC
+	select HAVE_IMX_ANATOP
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
