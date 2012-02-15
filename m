From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 10:47:44 -0800
Subject: [PATCH v2 3/7] ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
In-Reply-To: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1329331668-30325-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes all the static gpio irq number assigning with
IMX_GPIO_TO_IRQ() to run-time assigning with gpio_to_irq call, and
in turn eliminates the macro IMX_GPIO_TO_IRQ().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-cpuimx35.c            |    3 ++-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    3 ++-
 arch/arm/mach-imx/mach-vpr200.c              |    3 ++-
 arch/arm/mach-mx5/board-cpuimx51.c           |   12 ++++++++----
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    6 ++++--
 arch/arm/mach-mx5/board-mx53_ard.c           |    5 +++--
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    3 ++-
 arch/arm/mach-mx5/mx51_efika.c               |    3 ++-
 arch/arm/plat-mxc/include/mach/hardware.h    |    2 --
 9 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 8ecc872..ad52a61 100644
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
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 18f3581..0b0d9f0 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -356,7 +356,7 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 		.bus_num	= 1,
 		.chip_select	= 0, /* SS0 */
 		.platform_data	= &mc13783_pdata,
-		.irq = IMX_GPIO_TO_IRQ(PMIC_INT),
+		/* irq number is run-time assigned */
 		.mode = SPI_CS_HIGH,
 	}, {
 		.modalias	= "l4f00242t03",
@@ -398,6 +398,7 @@ static void __init mx27pdk_init(void)
 
 	imx27_add_spi_imx1(&spi2_pdata);
 	imx27_add_spi_imx0(&spi1_pdata);
+	mx27_3ds_spi_devs[0].irq = gpio_to_irq(PMIC_INT);
 	spi_register_board_info(mx27_3ds_spi_devs,
 						ARRAY_SIZE(mx27_3ds_spi_devs));
 
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 033257e..7b06020 100644
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
 
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 944025d..156a692 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -54,7 +54,7 @@
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x400000),
-		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTA_GPIO),
+		/* irq number is run-time assigned */
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -62,7 +62,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x800000),
-		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTB_GPIO),
+		/* irq number is run-time assigned */
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -70,7 +70,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x1000000),
-		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTC_GPIO),
+		/* irq number is run-time assigned */
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -78,7 +78,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
-		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTD_GPIO),
+		/* irq number is run-time assigned */
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -260,6 +260,10 @@ static void __init eukrea_cpuimx51_init(void)
 	gpio_free(CPUIMX51_QUARTD_GPIO);
 
 	imx51_add_fec(NULL);
+	serial_platform_data[0].irq = gpio_to_irq(CPUIMX51_QUARTA_GPIO);
+	serial_platform_data[1].irq = gpio_to_irq(CPUIMX51_QUARTB_GPIO);
+	serial_platform_data[2].irq = gpio_to_irq(CPUIMX51_QUARTC_GPIO);
+	serial_platform_data[3].irq = gpio_to_irq(CPUIMX51_QUARTD_GPIO);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx51_add_imx_i2c(1, &eukrea_cpuimx51_i2c_data);
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index 9fbe923..674fd10 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -126,7 +126,7 @@ static struct i2c_board_info eukrea_cpuimx51sd_i2c_devices[] = {
 		I2C_BOARD_INFO("tsc2007", 0x49),
 		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
-		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
+		/* irq number is run-time assigned */
 	},
 };
 
@@ -242,7 +242,7 @@ static struct spi_board_info cpuimx51sd_spi_device[] = {
 		.mode		= SPI_MODE_0,
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
-		.irq             = IMX_GPIO_TO_IRQ(CAN_IRQGPIO)
+		/* irq number is run-time assigned */
 	},
 };
 
@@ -288,6 +288,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 	msleep(20);
 	gpio_set_value(CAN_RST, 1);
 	imx51_add_ecspi(0, &cpuimx51sd_ecspi1_pdata);
+	cpuimx51sd_spi_device[0].irq = gpio_to_irq(CAN_IRQGPIO);
 	spi_register_board_info(cpuimx51sd_spi_device,
 				ARRAY_SIZE(cpuimx51sd_spi_device));
 
@@ -295,6 +296,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 	gpio_direction_input(TSC2007_IRQGPIO);
 	gpio_free(TSC2007_IRQGPIO);
 
+	eukrea_cpuimx51sd_i2c_devices[1].irq = gpio_to_irq(TSC2007_IRQGPIO);
 	i2c_register_board_info(0, eukrea_cpuimx51sd_i2c_devices,
 			ARRAY_SIZE(eukrea_cpuimx51sd_i2c_devices));
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 5f224f1..4a24765 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -134,8 +134,7 @@ static struct resource ard_smsc911x_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
-		.end =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
+		/* irq number is run-time assigned */
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -231,6 +230,8 @@ static void __init mx53_ard_board_init(void)
 
 	imx53_ard_common_init();
 	mx53_ard_io_init();
+	ard_smsc911x_resources[1].start = gpio_to_irq(ARD_ETHERNET_INT_B);
+	ard_smsc911x_resources[1].end = gpio_to_irq(ARD_ETHERNET_INT_B);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index a6a3ab8..2e686f2 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -159,7 +159,7 @@ struct tsc2007_platform_data tsc2007_data = {
 static struct i2c_board_info mbimx51_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("tsc2007", 0x49),
-		.irq  = IMX_GPIO_TO_IRQ(MBIMX51_TSC2007_GPIO),
+		/* irq number is run-time assigned */
 		.platform_data = &tsc2007_data,
 	}, {
 		I2C_BOARD_INFO("tlv320aic23", 0x1a),
@@ -198,6 +198,7 @@ void __init eukrea_mbimx51_baseboard_init(void)
 	gpio_direction_input(MBIMX51_TSC2007_GPIO);
 	irq_set_irq_type(gpio_to_irq(MBIMX51_TSC2007_GPIO),
 					IRQF_TRIGGER_FALLING);
+	mbimx51_i2c_devices[0].irq = gpio_to_irq(MBIMX51_TSC2007_GPIO);
 	i2c_register_board_info(1, mbimx51_i2c_devices,
 				ARRAY_SIZE(mbimx51_i2c_devices));
 
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index ec6ca91..ee870c4 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
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
index a599f01..f743a95 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -131,6 +131,4 @@
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
-#define IMX_GPIO_TO_IRQ(gpio)	(MXC_GPIO_IRQ_START + (gpio))
-
 #endif /* __ASM_ARCH_MXC_HARDWARE_H__ */
-- 
1.7.5.4
