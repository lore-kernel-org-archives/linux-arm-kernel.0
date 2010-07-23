From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Jul 2010 18:21:21 +0200
Subject: [PATCH v3 6/8] ARM: s5pv210: enable FIMC on Goni
In-Reply-To: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279902083-21250-7-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    4 ++++
 arch/arm/mach-s5pv210/mach-goni.c |    7 +++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index b81b91b..51e2d73 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -72,9 +72,13 @@ config MACH_AQUILA
 config MACH_GONI
 	bool "GONI"
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
 	  Machine support for Samsung GONI board
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 7b18505..1659217 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -35,6 +35,9 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/fimc.h>
+
+#include "common-aquila-goni.h"
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -426,6 +429,9 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s5pc110_device_onenand,
 	&goni_i2c_gpio_pmic,
 	&goni_device_gpiokeys,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
 };
 
 static void __init goni_map_io(void)
@@ -445,6 +451,7 @@ static void __init goni_machine_init(void)
 	s3c_fb_set_platdata(&goni_lcd_pdata);
 
 	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
+	s5pv210_common_fimc_clk_init();
 }
 
 MACHINE_START(GONI, "GONI")
-- 
1.7.2
