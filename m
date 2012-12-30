From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 16:33:39 -0800
Subject: [PATCH v5 10/12] ARM: Exynos4: remove auxdata table from machine file
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1356827621-27617-11-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With support for device tree based clock lookup now available, remove the
auxdata table from exynos4 dt-enabled machine file.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-exynos4-dt.c |   69 +-------------------------------
 1 files changed, 2 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index a7471ae..c02a537 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -11,78 +11,14 @@
  * published by the Free Software Foundation.
 */
 
+#include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <linux/serial_core.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
-#include <mach/map.h>
-
-#include <plat/cpu.h>
-#include <plat/regs-serial.h>
 
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
-	{},
-};
-
 static void __init exynos4_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
@@ -90,8 +26,7 @@ static void __init exynos4_dt_map_io(void)
 
 static void __init exynos4_dt_machine_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-				exynos4_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static char const *exynos4_dt_compat[] __initdata = {
-- 
1.7.5.4
