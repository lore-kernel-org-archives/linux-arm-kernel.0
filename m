From: mcuos.com@gmail.com (Wan ZongShun)
Date: Mon, 14 Jun 2010 01:28:34 +0800
Subject: [PATCH 2/2] NUC900: Add platform support for nuc900 i2c driver
Message-ID: <4C151542.5000609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add platform support for i2c driver.
For get i2c work clock, I implemented the 'nuc900_get_cpuclock'
api for getting cpu,apb,ahb clock.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/cpu.c |   43 +++++++++++++++++++++++++++++++++
 arch/arm/mach-w90x900/cpu.h |    3 +-
 arch/arm/mach-w90x900/dev.c |   56 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 642207e..2396548 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -195,6 +195,49 @@ static int __init nuc900_set_cpufreq(char *str)

 __setup("cpufreq=", nuc900_set_cpufreq);

+void nuc900_get_cpuclock(unsigned int *cpuclk_khz,
+			unsigned int *ahbclk_khz, unsigned int *apbclk_khz) {
+
+	int ahbspeed = 0, apbspeed = 0, cpuspeed = 0;
+
+	if (cpuclk_khz) {
+		cpuspeed = __raw_readl(REG_PLLCON0);
+		if (cpuspeed == PLL_200MHZ)
+			cpuspeed = 200 * 1000;
+		else if (cpuspeed == PLL_166MHZ)
+			cpuspeed = 166 * 1000;
+		else if (cpuspeed == PLL_120MHZ)
+			cpuspeed = 120 * 1000;
+		else if (cpuspeed == PLL_100MHZ)
+			cpuspeed = 100 * 1000;
+		else if (cpuspeed == PLL_66MHZ)
+			cpuspeed = 66 * 1000;
+		else
+			printk(KERN_ERR "Can not read true cpuspeed!\n");
+		*cpuclk_khz = cpuspeed;
+	}
+
+	if (ahbclk_khz) {
+		ahbspeed = (__raw_readl(REG_CLKDIV) >> 24) & 0x03;
+		if (ahbspeed == AHB_CPUCLK_1_1)
+			ahbspeed = cpuspeed;
+		else if (ahbspeed == AHB_CPUCLK_1_2)
+			ahbspeed = cpuspeed / 2;
+		else
+			printk(KERN_ERR "Can not read true ahbspeed!\n");
+		*ahbclk_khz = ahbspeed;
+	}
+
+	if (apbclk_khz) {
+		apbspeed = (__raw_readl(REG_CLKDIV) >> 26) & 0x03;
+		if (apbspeed == APB_AHB_1_2)
+			apbspeed = ahbspeed / 2;
+		else
+			printk(KERN_ERR "Can not read true apbspeed!\n");
+		*apbclk_khz = apbspeed;
+	}
+}
+
 /*Init NUC900 evb io*/

 void __init nuc900_map_io(struct map_desc *mach_desc, int mach_size)
diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
index f8730b6..00217ad 100644
--- a/arch/arm/mach-w90x900/cpu.h
+++ b/arch/arm/mach-w90x900/cpu.h
@@ -49,7 +49,8 @@ extern void nuc900_clock_source(struct device *dev, unsigned char *src);
 extern void nuc900_init_clocks(void);
 extern void nuc900_map_io(struct map_desc *mach_desc, int mach_size);
 extern void nuc900_board_init(struct platform_device **device, int size);
-
+extern void nuc900_get_cpuclock(unsigned int *cpuclk_khz,
+			unsigned int *ahbclk_khz, unsigned int *apbclk_khz);
 /* for either public between 910 and 920, or between 920 and 950 */

 extern struct platform_device nuc900_serial_device;
diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index b2eda4d..7287002 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -36,6 +36,7 @@
 #include <mach/nuc900_spi.h>
 #include <mach/map.h>
 #include <mach/fb.h>
+#include <mach/i2c.h>

 #include "cpu.h"

@@ -45,6 +46,7 @@
 #define NUC900_FLASH_SIZE	0x400000
 #define SPIOFFSET		0x200
 #define SPIOREG_SIZE		0x100
+#define I2C_SIZE		0x100

 static struct mtd_partition nuc900_flash_partitions[] = {
 	{
@@ -450,6 +452,59 @@ struct platform_device nuc900_device_audio = {
 	}
 };

+/* I2C0, I2C1 controller */
+
+static struct nuc900_platform_i2c nuc900_i2c0_data = {
+	.bus_num	=	0,
+	.bus_freq	=	100,
+	.get_clock	=	nuc900_get_cpuclock,
+};
+
+static struct resource nuc900_i2c0_resource[] = {
+	[0] = {
+		.start = W90X900_PA_I2C,
+		.end   = W90X900_PA_I2C + I2C_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_I2CGROUP,
+		.end   = IRQ_I2CGROUP,
+		.flags = IORESOURCE_IRQ,
+	}
+
+};
+
+struct platform_device nuc900_device_i2c0 = {
+	.name		  = "nuc900-i2c0",
+	.id		  = -1,
+	.num_resources	  = ARRAY_SIZE(nuc900_i2c0_resource),
+	.resource	  = nuc900_i2c0_resource,
+	.dev		= {
+				.platform_data = &nuc900_i2c0_data,
+			}
+};
+
+static struct resource nuc900_i2c1_resource[] = {
+	[0] = {
+		.start = W90X900_PA_I2C,
+		.end   = W90X900_PA_I2C + 2*I2C_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_I2CGROUP,
+		.end   = IRQ_I2CGROUP,
+		.flags = IORESOURCE_IRQ,
+	}
+
+};
+
+struct platform_device nuc900_device_i2c1 = {
+	.name		  = "nuc900-i2c1",
+	.id		  = -1,
+	.num_resources	  = ARRAY_SIZE(nuc900_i2c1_resource),
+	.resource	  = nuc900_i2c1_resource,
+};
+
 /*Here should be your evb resourse,such as LCD*/

 static struct platform_device *nuc900_public_dev[] __initdata = {
@@ -462,6 +517,7 @@ static struct platform_device *nuc900_public_dev[] __initdata = {
 	&nuc900_device_spi,
 	&nuc900_device_wdt,
 	&nuc900_device_audio,
+	&nuc900_device_i2c0,
 };

 /* Provide adding specific CPU platform devices API */
-- 
1.6.3.3
