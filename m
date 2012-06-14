From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:32 +0800
Subject: [PATCH 01/16] ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes all the static gpio irq number assigning with
IMX_GPIO_TO_IRQ() to run-time assigning with gpio_to_irq call, and
in turn eliminates the macro IMX_GPIO_TO_IRQ().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-cpuimx35.c         |    3 ++-
 arch/arm/mach-imx/mach-cpuimx51sd.c       |    3 ++-
 arch/arm/mach-imx/mach-mx27_3ds.c         |    3 ++-
 arch/arm/mach-imx/mach-mx35_3ds.c         |    3 ++-
 arch/arm/mach-imx/mach-mx53_ard.c         |    5 +++--
 arch/arm/mach-imx/mach-vpr200.c           |    3 ++-
 arch/arm/mach-imx/mx51_efika.c            |    3 ++-
 arch/arm/plat-mxc/include/mach/hardware.h |    2 --
 8 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index c515f8e..73c4b65 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -72,7 +72,7 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 		I2C_BOARD_INFO("tsc2007", 0x48),
 		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
-		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
+		/* irq number is run-time assigned */
 	},
 };
 
@@ -173,6 +173,7 @@ static void __init eukrea_cpuimx35_init(void)
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&eukrea_cpuimx35_nand_board_info);
 
+	eukrea_cpuimx35_i2c_devices[1].irq = gpio_to_irq(TSC2007_IRQGPIO);
 	i2c_register_board_info(0, eukrea_cpuimx35_i2c_devices,
 			ARRAY_SIZE(eukrea_cpuimx35_i2c_devices));
 	imx35_add_imx_i2c0(&eukrea_cpuimx35_i2c0_data);
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index ac50f16..e42c6f8 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -259,7 +259,7 @@ static struct spi_board_info cpuimx51sd_spi_device[] = {
 		.mode		= SPI_MODE_0,
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
-		.irq             = IMX_GPIO_TO_IRQ(CAN_IRQGPIO)
+		/* irq number is run-time assigned */
 	},
 };
 
@@ -310,6 +310,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 	msleep(20);
 	gpio_set_value(CAN_RST, 1);
 	imx51_add_ecspi(0, &cpuimx51sd_ecspi1_pdata);
+	cpuimx51sd_spi_device[0].irq = gpio_to_irq(CAN_IRQGPIO);
 	spi_register_board_info(cpuimx51sd_spi_device,
 				ARRAY_SIZE(cpuimx51sd_spi_device));
 
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index c6d385c..18b9bca 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -445,7 +445,7 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 		.bus_num	= 1,
 		.chip_select	= 0, /* SS0 */
 		.platform_data	= &mc13783_pdata,
-		.irq = IMX_GPIO_TO_IRQ(PMIC_INT),
+		/* irq number is run-time assigned */
 		.mode = SPI_CS_HIGH,
 	}, {
 		.modalias	= "l4f00242t03",
@@ -496,6 +496,7 @@ static void __init mx27pdk_init(void)
 
 	imx27_add_spi_imx1(&spi2_pdata);
 	imx27_add_spi_imx0(&spi1_pdata);
+	mx27_3ds_spi_devs[0].irq = gpio_to_irq(PMIC_INT);
 	spi_register_board_info(mx27_3ds_spi_devs,
 						ARRAY_SIZE(mx27_3ds_spi_devs));
 
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 28aa194..fa1ea74 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -492,7 +492,7 @@ static struct i2c_board_info mx35_3ds_i2c_mc13892 = {
 
 	I2C_BOARD_INFO("mc13892", 0x08),
 	.platform_data = &mx35_3ds_mc13892_data,
-	.irq = IMX_GPIO_TO_IRQ(GPIO_PMIC_INT),
+	/* irq number is run-time assigned */
 };
 
 static void __init imx35_3ds_init_mc13892(void)
@@ -504,6 +504,7 @@ static void __init imx35_3ds_init_mc13892(void)
 		return;
 	}
 
+	mx35_3ds_i2c_mc13892.irq = gpio_to_irq(GPIO_PMIC_INT);
 	i2c_register_board_info(0, &mx35_3ds_i2c_mc13892, 1);
 }
 
diff --git a/arch/arm/mach-imx/mach-mx53_ard.c b/arch/arm/mach-imx/mach-mx53_ard.c
index 0564198..fe3f396 100644
--- a/arch/arm/mach-imx/mach-mx53_ard.c
+++ b/arch/arm/mach-imx/mach-mx53_ard.c
@@ -135,8 +135,7 @@ static struct resource ard_smsc911x_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
-		.end =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
+		/* irq number is run-time assigned */
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -240,6 +239,8 @@ static void __init mx53_ard_board_init(void)
 	imx53_ard_common_init();
 	mx53_ard_io_init();
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	ard_smsc911x_resources[1].start = gpio_to_irq(ARD_ETHERNET_INT_B);
+	ard_smsc911x_resources[1].end = gpio_to_irq(ARD_ETHERNET_INT_B);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index add8c69..e36eb2c 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -162,7 +162,7 @@ static struct i2c_board_info vpr200_i2c_devices[] = {
 	}, {
 		I2C_BOARD_INFO("mc13892", 0x08),
 		.platform_data = &vpr200_pmic,
-		.irq = IMX_GPIO_TO_IRQ(GPIO_PMIC_INT),
+		/* irq number is run-time assigned */
 	}
 };
 
@@ -299,6 +299,7 @@ static void __init vpr200_board_init(void)
 	imx35_add_mxc_nand(&vpr200_nand_board_info);
 	imx35_add_sdhci_esdhc_imx(0, NULL);
 
+	vpr200_i2c_devices[1].irq = gpio_to_irq(GPIO_PMIC_INT);
 	i2c_register_board_info(0, vpr200_i2c_devices,
 			ARRAY_SIZE(vpr200_i2c_devices));
 
diff --git a/arch/arm/mach-imx/mx51_efika.c b/arch/arm/mach-imx/mx51_efika.c
index ec6ca91..ee870c4 100644
--- a/arch/arm/mach-imx/mx51_efika.c
+++ b/arch/arm/mach-imx/mx51_efika.c
@@ -587,7 +587,7 @@ static struct spi_board_info mx51_efika_spi_board_info[] __initdata = {
 		.bus_num = 0,
 		.chip_select = 0,
 		.platform_data = &mx51_efika_mc13892_data,
-		.irq = IMX_GPIO_TO_IRQ(EFIKAMX_PMIC),
+		/* irq number is run-time assigned */
 	},
 };
 
@@ -620,6 +620,7 @@ void __init efika_board_common_init(void)
 
 	gpio_request(EFIKAMX_PMIC, "pmic irq");
 	gpio_direction_input(EFIKAMX_PMIC);
+	mx51_efika_spi_board_info[1].irq = gpio_to_irq(EFIKAMX_PMIC);
 	spi_register_board_info(mx51_efika_spi_board_info,
 		ARRAY_SIZE(mx51_efika_spi_board_info));
 	imx51_add_ecspi(0, &mx51_efika_spi_pdata);
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 0630513..1d432a7 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -128,6 +128,4 @@
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
-#define IMX_GPIO_TO_IRQ(gpio)	(MXC_GPIO_IRQ_START + (gpio))
-
 #endif /* __ASM_ARCH_MXC_HARDWARE_H__ */
-- 
1.7.5.4
