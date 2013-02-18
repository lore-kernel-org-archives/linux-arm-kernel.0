From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:19 +0530
Subject: [PATCH v6 09/16] ARM: Exynos: remove auxdata table from exynos4/5 dt
 machine file
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-10-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With support for device tree based clock lookup now available, remove the
auxdata table from exynos4/5 dt-enabled machine file.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-exynos4-dt.c |   69 +----------------------
 arch/arm/mach-exynos/mach-exynos5-dt.c |   98 +-------------------------------
 2 files changed, 3 insertions(+), 164 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 6c5e068..809c274 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
 */
 
+#include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 #include <linux/serial_core.h>
@@ -19,75 +20,10 @@
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
-#include <mach/map.h>
-
-#include <plat/cpu.h>
-#include <plat/regs-serial.h>
 #include <plat/mfc.h>
 
 #include "common.h"
 
-/*
- * The following lookup table is used to override device names when devices
- * are registered from device tree. This is temporarily added to enable
- * device tree support addition for the Exynos4 architecture.
- *
- * For drivers that require platform data to be provided from the machine
- * file, a platform data pointer can also be supplied along with the
- * devices names. Usually, the platform data elements that cannot be parsed
- * from the device tree by the drivers (example: function pointers) are
- * supplied. But it should be noted that this is a temporary mechanism and
- * at some point, the drivers should be capable of parsing all the platform
- * data from the device tree.
- */
-static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS4_PA_UART0,
-				"exynos4210-uart.0", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS4_PA_UART1,
-				"exynos4210-uart.1", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS4_PA_UART2,
-				"exynos4210-uart.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS4_PA_UART3,
-				"exynos4210-uart.3", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-sdhci", EXYNOS4_PA_HSMMC(0),
-				"exynos4-sdhci.0", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-sdhci", EXYNOS4_PA_HSMMC(1),
-				"exynos4-sdhci.1", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-sdhci", EXYNOS4_PA_HSMMC(2),
-				"exynos4-sdhci.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-sdhci", EXYNOS4_PA_HSMMC(3),
-				"exynos4-sdhci.3", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(0),
-				"s3c2440-i2c.0", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(1),
-				"s3c2440-i2c.1", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(2),
-				"s3c2440-i2c.2", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(3),
-				"s3c2440-i2c.3", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(4),
-				"s3c2440-i2c.4", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(5),
-				"s3c2440-i2c.5", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(6),
-				"s3c2440-i2c.6", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(7),
-				"s3c2440-i2c.7", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI0,
-				"exynos4210-spi.0", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI1,
-				"exynos4210-spi.1", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI2,
-				"exynos4210-spi.2", NULL),
-	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA0, "dma-pl330.0", NULL),
-	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA1, "dma-pl330.1", NULL),
-	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_MDMA1, "dma-pl330.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-tmu", EXYNOS4_PA_TMU,
-				"exynos-tmu", NULL),
-	OF_DEV_AUXDATA("samsung,mfc-v5", 0x13400000, "s5p-mfc", NULL),
-	{},
-};
-
 static void __init exynos4_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
@@ -95,8 +31,7 @@ static void __init exynos4_dt_map_io(void)
 
 static void __init exynos4_dt_machine_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-				exynos4_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static char const *exynos4_dt_compat[] __initdata = {
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index dfe51ee..7027bb9 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -11,110 +11,19 @@
 
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
-#include <linux/serial_core.h>
 #include <linux/memblock.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
-#include <mach/map.h>
 #include <mach/regs-pmu.h>
 
 #include <plat/cpu.h>
-#include <plat/regs-serial.h>
 #include <plat/mfc.h>
 
 #include "common.h"
 
-/*
- * The following lookup table is used to override device names when devices
- * are registered from device tree. This is temporarily added to enable
- * device tree support addition for the EXYNOS5 architecture.
- *
- * For drivers that require platform data to be provided from the machine
- * file, a platform data pointer can also be supplied along with the
- * devices names. Usually, the platform data elements that cannot be parsed
- * from the device tree by the drivers (example: function pointers) are
- * supplied. But it should be noted that this is a temporary mechanism and
- * at some point, the drivers should be capable of parsing all the platform
- * data from the device tree.
- */
-static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART0,
-				"exynos4210-uart.0", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART1,
-				"exynos4210-uart.1", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART2,
-				"exynos4210-uart.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART3,
-				"exynos4210-uart.3", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(0),
-				"s3c2440-i2c.0", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
-				"s3c2440-i2c.1", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(2),
-				"s3c2440-i2c.2", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(3),
-				"s3c2440-i2c.3", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(4),
-				"s3c2440-i2c.4", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(5),
-				"s3c2440-i2c.5", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(6),
-				"s3c2440-i2c.6", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(7),
-				"s3c2440-i2c.7", NULL),
-	OF_DEV_AUXDATA("samsung,s3c2440-hdmiphy-i2c", EXYNOS5_PA_IIC(8),
-				"s3c2440-hdmiphy-i2c", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI0,
-				"dw_mmc.0", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI1,
-				"dw_mmc.1", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI2,
-				"dw_mmc.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI3,
-				"dw_mmc.3", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI0,
-				"exynos4210-spi.0", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI1,
-				"exynos4210-spi.1", NULL),
-	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI2,
-				"exynos4210-spi.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-sata-ahci", 0x122F0000,
-				"exynos5-sata", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-sata-phy", 0x12170000,
-				"exynos5-sata-phy", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-sata-phy-i2c", 0x121D0000,
-				"exynos5-sata-phy-i2c", NULL),
-	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
-	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
-	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC0,
-				"exynos-gsc.0", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC1,
-				"exynos-gsc.1", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC2,
-				"exynos-gsc.2", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC3,
-				"exynos-gsc.3", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-hdmi", 0x14530000,
-				"exynos5-hdmi", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-mixer", 0x14450000,
-				"exynos5-mixer", NULL),
-	OF_DEV_AUXDATA("samsung,mfc-v6", 0x11000000, "s5p-mfc-v6", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5250-tmu", 0x10060000,
-				"exynos-tmu", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-dp", 0x145B0000, "exynos-dp", NULL),
-	{},
-};
-
-static const struct of_dev_auxdata exynos5440_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5440_PA_UART0,
-				"exynos4210-uart.0", NULL),
-	{},
-};
-
 static void __init exynos5_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
@@ -144,12 +53,7 @@ static void __init exynos5_dt_machine_init(void)
 		}
 	}
 
-	if (of_machine_is_compatible("samsung,exynos5250"))
-		of_platform_populate(NULL, of_default_bus_match_table,
-				     exynos5250_auxdata_lookup, NULL);
-	else if (of_machine_is_compatible("samsung,exynos5440"))
-		of_platform_populate(NULL, of_default_bus_match_table,
-				     exynos5440_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static char const *exynos5_dt_compat[] __initdata = {
-- 
1.7.5.4
