From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Wed, 21 Dec 2011 19:13:36 +0530
Subject: [PATCH v7 3/8] davinci: eliminate use of IO_ADDRESS() on sysmod
In-Reply-To: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1324475021-32509-4-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current devices.c file has a number of instances where
IO_ADDRESS() is used for system module register
access. Eliminate this in favor of a ioremap()
based access.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/davinci.h               |    9 +++++++++
 arch/arm/mach-davinci/devices.c               |   25 ++++++++++++++++---------
 arch/arm/mach-davinci/dm355.c                 |    1 +
 arch/arm/mach-davinci/dm365.c                 |    1 +
 arch/arm/mach-davinci/dm644x.c                |    1 +
 arch/arm/mach-davinci/dm646x.c                |    1 +
 arch/arm/mach-davinci/include/mach/hardware.h |    2 --
 7 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 238c282..065b3a0 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -23,10 +23,19 @@
 
 #include <mach/asp.h>
 #include <mach/keyscan.h>
+#include <mach/hardware.h>
 
 #include <media/davinci/vpfe_capture.h>
 #include <media/davinci/vpif_types.h>
 
+#define DAVINCI_SYSTEM_MODULE_BASE        0x01c40000
+
+#ifndef __ASSEMBLER__
+extern void __iomem *davinci_sysmodbase;
+#define DAVINCI_SYSMODULE_VIRT(x)	(davinci_sysmodbase + (x))
+void davinci_map_sysmod(void);
+#endif
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 806a2f0..faff29a 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -23,6 +23,7 @@
 #include <mach/mmc.h>
 #include <mach/time.h>
 
+#include "davinci.h"
 #include "clock.h"
 
 #define DAVINCI_I2C_BASE	     0x01C21000
@@ -36,6 +37,14 @@
 /* System control register offsets */
 #define DM64XX_VDD3P3V_PWDN	0x48
 
+void __iomem  *davinci_sysmodbase;
+
+void davinci_map_sysmod(void)
+{
+	davinci_sysmodbase = ioremap_nocache(DAVINCI_SYSTEM_MODULE_BASE, 0x800);
+	WARN_ON(!davinci_sysmodbase);
+}
+
 static struct resource i2c_resources[] = {
 	{
 		.start		= DAVINCI_I2C_BASE,
@@ -212,12 +221,12 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			davinci_cfg_reg(DM355_SD1_DATA2);
 			davinci_cfg_reg(DM355_SD1_DATA3);
 		} else if (cpu_is_davinci_dm365()) {
-			void __iomem *pupdctl1 =
-				IO_ADDRESS(DAVINCI_SYSTEM_MODULE_BASE + 0x7c);
-
 			/* Configure pull down control */
-			__raw_writel((__raw_readl(pupdctl1) & ~0xfc0),
-					pupdctl1);
+			void __iomem *pupdctl1 = DAVINCI_SYSMODULE_VIRT(0x7c);
+			unsigned v;
+
+			v = __raw_readl(pupdctl1);
+			__raw_writel(v & ~0xfc0, pupdctl1);
 
 			mmcsd1_resources[0].start = DM365_MMCSD1_BASE;
 			mmcsd1_resources[0].end = DM365_MMCSD1_BASE +
@@ -246,11 +255,9 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd0_resources[2].start = IRQ_DM365_SDIOINT0;
 		} else if (cpu_is_davinci_dm644x()) {
 			/* REVISIT: should this be in board-init code? */
-			void __iomem *base =
-				IO_ADDRESS(DAVINCI_SYSTEM_MODULE_BASE);
-
 			/* Power-on 3.3V IO cells */
-			__raw_writel(0, base + DM64XX_VDD3P3V_PWDN);
+			__raw_writel(0,
+				DAVINCI_SYSMODULE_VIRT(DM64XX_VDD3P3V_PWDN));
 			/*Set up the pull regiter for MMC */
 			davinci_cfg_reg(DM644X_MSTK);
 		}
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 68423d2..43b4dc3 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -872,6 +872,7 @@ void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata)
 void __init dm355_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
+	davinci_map_sysmod();
 }
 
 static int __init dm355_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index d3f5642..3758762 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1139,6 +1139,7 @@ void __init dm365_init_rtc(void)
 void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
+	davinci_map_sysmod();
 }
 
 static struct resource dm365_vpss_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b1a3567..6b95b4b 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -787,6 +787,7 @@ void __init dm644x_init_asp(struct snd_platform_data *pdata)
 void __init dm644x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
+	davinci_map_sysmod();
 }
 
 static int __init dm644x_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index ef4e753..2f28a49 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -913,6 +913,7 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 void __init dm646x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
+	davinci_map_sysmod();
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 414e0b9..0209b1f 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -19,8 +19,6 @@
  * and the chip/board init code should then explicitly include
  * <chipname>.h
  */
-#define DAVINCI_SYSTEM_MODULE_BASE        0x01C40000
-
 /*
  * I/O mapping
  */
-- 
1.6.2.4
