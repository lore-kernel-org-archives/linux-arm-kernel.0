From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 12:49:57 +0200
Subject: [PATCH 2/6] ARM: imx: deconstruct mxc_rnga initialization
In-Reply-To: <20160624105001.3166287-1-arnd@arndb.de>
References: <20160624105001.3166287-1-arnd@arndb.de>
Message-ID: <20160624105001.3166287-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rnga platform device is initialized for all imx31 machines
from its own initcall, but is never initialized anywhere else.

This moves the platform device creation into both the imx31
dt and non-dt machine init sequences, which has basically the
exact same effect as before, but makes it more obvious what
is going on, while reducing the amount of code and removing
the last user of cpu_is_mx31().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig                     |  4 --
 arch/arm/mach-imx/devices/Kconfig             |  4 --
 arch/arm/mach-imx/devices/platform-mxc_rnga.c | 53 ---------------------------
 arch/arm/mach-imx/imx31-dt.c                  | 12 ++++++
 arch/arm/mach-imx/mm-imx3.c                   |  6 +++
 5 files changed, 18 insertions(+), 61 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_rnga.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7bc459f72985..4f4caa9c4637 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -44,9 +44,6 @@ config MXC_USE_EPIT
 	  uses the same clocks as the GPT. Anyway, on some systems the GPT
 	  may be in use for other purposes.
 
-config ARCH_HAS_RNGA
-	bool
-
 config HAVE_IMX_ANATOP
 	bool
 
@@ -90,7 +87,6 @@ config SOC_IMX27
 config SOC_IMX31
 	bool
 	select CPU_V6
-	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
 
diff --git a/arch/arm/mach-imx/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
index 3a552989248e..6ffe57267233 100644
--- a/arch/arm/mach-imx/devices/Kconfig
+++ b/arch/arm/mach-imx/devices/Kconfig
@@ -57,10 +57,6 @@ config IMX_HAVE_PLATFORM_MXC_MMC
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
-config IMX_HAVE_PLATFORM_MXC_RNGA
-	bool
-	select ARCH_HAS_RNGA
-
 config IMX_HAVE_PLATFORM_MXC_RTC
 	bool
 
diff --git a/arch/arm/mach-imx/devices/platform-mxc_rnga.c b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
deleted file mode 100644
index 851fbc8af7a9..000000000000
--- a/arch/arm/mach-imx/devices/platform-mxc_rnga.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright (C) 2010 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-#include "../hardware.h"
-#include "devices-common.h"
-
-struct imx_mxc_rnga_data {
-	resource_size_t iobase;
-};
-
-#define imx_mxc_rnga_data_entry_single(soc)				\
-	{								\
-		.iobase = soc ## _RNGA_BASE_ADDR,			\
-	}
-
-#ifdef CONFIG_SOC_IMX31
-static const struct imx_mxc_rnga_data imx31_mxc_rnga_data __initconst =
-	imx_mxc_rnga_data_entry_single(MX31);
-#endif /* ifdef CONFIG_SOC_IMX31 */
-
-static struct platform_device *__init imx_add_mxc_rnga(
-		const struct imx_mxc_rnga_data *data)
-{
-	struct resource res[] = {
-		{
-			.start = data->iobase,
-			.end = data->iobase + SZ_16K - 1,
-			.flags = IORESOURCE_MEM,
-		},
-	};
-	return imx_add_platform_device("mxc_rnga", -1,
-			res, ARRAY_SIZE(res), NULL, 0);
-}
-
-static int __init imxXX_add_mxc_rnga(void)
-{
-	struct platform_device *ret;
-
-#if defined(CONFIG_SOC_IMX31)
-	if (cpu_is_mx31())
-		ret = imx_add_mxc_rnga(&imx31_mxc_rnga_data);
-	else
-#endif /* if defined(CONFIG_SOC_IMX31) */
-		ret = ERR_PTR(-ENODEV);
-
-	return PTR_ERR_OR_ZERO(ret);
-}
-arch_initcall(imxXX_add_mxc_rnga);
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index 32100222a017..62e6b4fb5370 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -28,10 +28,22 @@ static void __init imx31_dt_timer_init(void)
 	mx31_clocks_init_dt();
 }
 
+/* FIXME: replace with DT binding */
+static const struct resource imx31_rnga_res[] __initconst = {
+	DEFINE_RES_MEM(MX31_RNGA_BASE_ADDR, SZ_16K),
+};
+
+static void __init imx31_dt_mach_init(void)
+{
+	platform_device_register_simple("mxc_rnga", -1, imx31_rnga_res,
+					ARRAY_SIZE(imx31_rnga_res));
+}
+
 DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
 	.init_time	= imx31_dt_timer_init,
+	.init_machine	= imx31_dt_mach_init,
 	.dt_compat	= imx31_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 0884ca90d15a..3b135cd4b043 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -167,6 +167,10 @@ static const struct resource imx31_audmux_res[] __initconst = {
 	DEFINE_RES_MEM(MX31_AUDMUX_BASE_ADDR, SZ_16K),
 };
 
+static const struct resource imx31_rnga_res[] __initconst = {
+	DEFINE_RES_MEM(MX31_RNGA_BASE_ADDR, SZ_16K),
+};
+
 void __init imx31_soc_init(void)
 {
 	int to_version = mx31_revision() >> 4;
@@ -195,6 +199,8 @@ void __init imx31_soc_init(void)
 
 	platform_device_register_simple("imx31-audmux", 0, imx31_audmux_res,
 					ARRAY_SIZE(imx31_audmux_res));
+	platform_device_register_simple("mxc_rnga", -1, imx31_rnga_res,
+					ARRAY_SIZE(imx31_rnga_res));
 }
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
-- 
2.9.0
