From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 05:50:44 +0200
Subject: [PATCH 4/4] ARM: S5PC110: use common FIMC clock setup code
In-Reply-To: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1283745044-15514-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Aquila and GONI the bootloader doesn't set FIMC parent clocks
correctly. Use common FIMC setup code to fix this during machne boot.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    2 ++
 arch/arm/mach-s5pv210/mach-aquila.c |    3 +++
 arch/arm/mach-s5pv210/mach-goni.c   |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 48489bb..7b5e816 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -79,6 +79,7 @@ config MACH_AQUILA
 	select S3C_DEV_HSMMC2
 	select S5PC110_DEV_ONENAND
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_FIMC
 	select S5PV210_SETUP_SDHCI
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
@@ -96,6 +97,7 @@ config MACH_GONI
 	select S3C_DEV_HSMMC2
 	select S5PC110_DEV_ONENAND
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_FIMC
 	select S5PV210_SETUP_SDHCI
 	help
 	  Machine support for Samsung GONI board
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 0dda801..65f616b 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -35,7 +35,9 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/fimc.h>
 #include <plat/fimc-core.h>
+
 #include <plat/sdhci.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
@@ -510,6 +512,7 @@ static void __init aquila_machine_init(void)
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
 	platform_add_devices(aquila_devices, ARRAY_SIZE(aquila_devices));
+	s5pv210_fimc_setup_clks();
 }
 
 MACHINE_START(AQUILA, "Aquila")
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 53754d7..9f3b52d 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -35,6 +35,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/fimc.h>
 #include <plat/sdhci.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
@@ -487,6 +488,7 @@ static void __init goni_machine_init(void)
 	s3c_fb_set_platdata(&goni_lcd_pdata);
 
 	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
+	s5pv210_fimc_setup_clks();
 }
 
 MACHINE_START(GONI, "GONI")
-- 
1.7.2.2
