From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 15 Jul 2010 11:10:40 +0200
Subject: [PATCH 09/10 v2] ARM: s5pv210: enable FIMC on Goni
In-Reply-To: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279185041-6004-10-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    1 +
 arch/arm/mach-s5pv210/mach-goni.c |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index fed64f5..e9e033e 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -85,6 +85,7 @@ config MACH_AQUILA
 config MACH_GONI
 	bool "GONI"
 	select CPU_S5PV210
+	select COMMON_AQUILA_GONI
 	select ARCH_SPARSEMEM_ENABLE
 	select S5PV210_SETUP_FB_24BPP
 	select S3C_DEV_FB
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 4792bf8..fde12df 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -40,6 +40,9 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/fimc.h>
+
+#include "common-aquila-goni.h"
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -498,6 +501,9 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_usbgadget,
 	&goni_i2c_gpio_pmic,
 	&goni_device_gpiokeys,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
 };
 
 static void __init goni_map_io(void)
@@ -520,7 +526,19 @@ static void __init goni_machine_init(void)
 	/* SPI */
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 
+	/* FIMC */
+	s5p_fimc0_set_platdata(NULL);
+	s5p_fimc1_set_platdata(NULL);
+	s5p_fimc2_set_platdata(NULL);
+
+	/* FIMC->FB fifo links */
+	s5pv210_setup_fimc0_fb_link();
+	s5pv210_setup_fimc1_fb_link();
+	s5pv210_setup_fimc2_fb_link();
+
 	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
+
+	s5pv210_common_fimc_clk_init();
 }
 
 MACHINE_START(GONI, "GONI")
-- 
1.7.0.4
