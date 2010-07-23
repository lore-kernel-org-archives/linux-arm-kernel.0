From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Jul 2010 18:21:20 +0200
Subject: [PATCH v3 5/8] ARM: s5pv210: enable FIMC on Aquila
In-Reply-To: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279902083-21250-6-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for FIMC on Samsung Aquila board.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    4 ++++
 arch/arm/mach-s5pv210/mach-aquila.c |    7 +++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 039ba8c..b81b91b 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -58,9 +58,13 @@ menu "S5PC110 Machines"
 config MACH_AQUILA
 	bool "Aquila"
 	select CPU_S5PV210
+	select COMMON_AQUILA_GONI
 	select ARCH_SPARSEMEM_ENABLE
 	select S5PV210_SETUP_FB_24BPP
 	select S3C_DEV_FB
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
 	select S5PC110_DEV_ONENAND
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 0992618..7528514 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -35,6 +35,9 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/fimc.h>
+
+#include "common-aquila-goni.h"
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -445,6 +448,9 @@ static struct platform_device *aquila_devices[] __initdata = {
 	&aquila_device_gpiokeys,
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
 };
 
 static void __init aquila_map_io(void)
@@ -465,6 +471,7 @@ static void __init aquila_machine_init(void)
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
 	platform_add_devices(aquila_devices, ARRAY_SIZE(aquila_devices));
+	s5pv210_common_fimc_clk_init();
 }
 
 MACHINE_START(AQUILA, "Aquila")
-- 
1.7.2
