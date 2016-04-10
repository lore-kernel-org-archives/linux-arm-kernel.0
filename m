From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 10 Apr 2016 21:29:59 +0200
Subject: [PATCH 2/3] ARM: pxa: add pxa25x device-tree support
In-Reply-To: <1460316600-15978-1-git-send-email-robert.jarzmik@free.fr>
References: <1460316600-15978-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1460316600-15978-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device-tree machine entry (DT_MACHINE_START) for pxa25x based
platforms.

Take the opportunity to sort the file machine descriptions by
alphabetical order.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/Kconfig  | 11 +++++++++++
 arch/arm/mach-pxa/Makefile |  3 ++-
 arch/arm/mach-pxa/pxa-dt.c | 37 ++++++++++++++++++++++++++-----------
 arch/arm/mach-pxa/pxa25x.c | 12 ++++++------
 4 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index cd894d69e766..76fbc115ec33 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -4,6 +4,17 @@ menu "Intel PXA2xx/PXA3xx Implementations"
 
 comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 
+config MACH_PXA25X_DT
+	bool "Support PXA25x platforms from device tree"
+	select PINCTRL
+	select POWER_SUPPLY
+	select PXA25x
+	select USE_OF
+	help
+	  Include support for Marvell PXA25x based platforms using
+	  the device tree. Needn't select any other machine while
+	  MACH_PXA25x_DT is enabled.
+
 config MACH_PXA27X_DT
 	bool "Support PXA27x platforms from device tree"
 	select PINCTRL
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 2ceed407eda9..ef25dc597f30 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -19,8 +19,9 @@ obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 # NOTE: keep the order of boards in accordance to their order in Kconfig
 
 # Device Tree support
-obj-$(CONFIG_MACH_PXA3XX_DT)	+= pxa-dt.o
+obj-$(CONFIG_MACH_PXA25X_DT)	+= pxa-dt.o
 obj-$(CONFIG_MACH_PXA27X_DT)	+= pxa-dt.o
+obj-$(CONFIG_MACH_PXA3XX_DT)	+= pxa-dt.o
 
 # Intel/Marvell Dev Platforms
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index f128133a8f30..3e331e61f995 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -18,20 +18,18 @@
 
 #include "generic.h"
 
-#ifdef CONFIG_PXA3xx
-static const char *const pxa3xx_dt_board_compat[] __initconst = {
-	"marvell,pxa300",
-	"marvell,pxa310",
-	"marvell,pxa320",
+#ifdef CONFIG_PXA25x
+static const char * const pxa25x_dt_board_compat[] __initconst = {
+	"marvell,pxa250",
 	NULL,
 };
 
-DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
-	.map_io		= pxa3xx_map_io,
-	.init_irq	= pxa3xx_dt_init_irq,
-	.handle_irq	= pxa3xx_handle_irq,
+DT_MACHINE_START(PXA25X_DT, "Marvell PXA25x (Device Tree Support)")
+	.map_io		= pxa25x_map_io,
+	.init_irq	= pxa25x_dt_init_irq,
+	.handle_irq	= pxa25x_handle_irq,
 	.restart	= pxa_restart,
-	.dt_compat	= pxa3xx_dt_board_compat,
+	.dt_compat	= pxa25x_dt_board_compat,
 MACHINE_END
 #endif
 
@@ -41,7 +39,7 @@ static const char * const pxa27x_dt_board_compat[] __initconst = {
 	NULL,
 };
 
-DT_MACHINE_START(PXA27X_DT, "Marvell PXA2xx (Device Tree Support)")
+DT_MACHINE_START(PXA27X_DT, "Marvell PXA27x (Device Tree Support)")
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_dt_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
@@ -49,3 +47,20 @@ DT_MACHINE_START(PXA27X_DT, "Marvell PXA2xx (Device Tree Support)")
 	.dt_compat	= pxa27x_dt_board_compat,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_PXA3xx
+static const char *const pxa3xx_dt_board_compat[] __initconst = {
+	"marvell,pxa300",
+	"marvell,pxa310",
+	"marvell,pxa320",
+	NULL,
+};
+
+DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
+	.map_io		= pxa3xx_map_io,
+	.init_irq	= pxa3xx_dt_init_irq,
+	.handle_irq	= pxa3xx_handle_irq,
+	.restart	= pxa_restart,
+	.dt_compat	= pxa3xx_dt_board_compat,
+MACHINE_END
+#endif
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index a0de9a9ae64e..6110fa91be5e 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -212,12 +212,12 @@ static int __init pxa25x_init(void)
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 
-		pxa2xx_set_dmac_info(16, 40);
-		pxa_register_device(&pxa25x_device_gpio, &pxa25x_gpio_info);
-		ret = platform_add_devices(pxa25x_devices,
-					   ARRAY_SIZE(pxa25x_devices));
-		if (ret)
-			return ret;
+		if (!of_have_populated_dt()) {
+			pxa2xx_set_dmac_info(16, 40);
+			pxa_register_device(&pxa25x_device_gpio, &pxa25x_gpio_info);
+			ret = platform_add_devices(pxa25x_devices,
+						   ARRAY_SIZE(pxa25x_devices));
+		}
 	}
 
 	return ret;
-- 
2.1.4
