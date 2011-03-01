From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:01:03 +0530
Subject: [PATCH V6 14/17] ST SPEAr: Adding support for SSP PL022
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <4d54593ee6552eced7178ed6360cbb6e99fcb581.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   10 +++
 arch/arm/mach-spear13xx/spear1310_evb.c        |   10 +++
 arch/arm/mach-spear13xx/spear13xx.c            |   31 ++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +
 arch/arm/mach-spear3xx/spear300_evb.c          |   25 ++++++++
 arch/arm/mach-spear3xx/spear310_evb.c          |   37 ++++++++++++
 arch/arm/mach-spear3xx/spear320.c              |   42 +++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |   13 ++++
 arch/arm/mach-spear3xx/spear3xx.c              |   31 ++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c          |   12 ++++
 arch/arm/mach-spear6xx/spear6xx.c              |   68 ++++++++++++++++++++++
 arch/arm/plat-spear/include/plat/spi.h         |   74 ++++++++++++++++++++++++
 14 files changed, 357 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/spi.h

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index f332f96..15f5e03 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -222,6 +222,7 @@ extern struct pmx_dev pmx_uart1_modem;
 
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_gpio_device[];
+extern struct amba_device spear13xx_ssp_device;
 extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 9aafa91..8500e10 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -12,11 +12,15 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <plat/keyboard.h>
+#include <plat/spi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 #include <mach/pcie.h>
@@ -43,6 +47,7 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_gpio_device[0],
 	&spear13xx_gpio_device[1],
+	&spear13xx_ssp_device,
 	&spear13xx_uart_device,
 };
 
@@ -76,6 +81,9 @@ static const struct kbd_platform_data kbd_data __initconst = {
 	.rep = 1,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
 #ifdef CONFIG_PCIEPORTBUS
 /*
  * This function is needed for PCIE host and device driver. Same
@@ -129,6 +137,8 @@ static void __init spear1300_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index d4ef083..ec3d617 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -12,11 +12,15 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <plat/keyboard.h>
+#include <plat/spi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 #include <mach/pcie.h>
@@ -50,6 +54,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear13xx specific devices */
 	&spear13xx_gpio_device[0],
 	&spear13xx_gpio_device[1],
+	&spear13xx_ssp_device,
 	&spear13xx_uart_device,
 
 	/* spear1310 specific devices */
@@ -96,6 +101,9 @@ static const struct kbd_platform_data kbd_data __initconst = {
 	.rep = 1,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
 #ifdef CONFIG_PCIEPORTBUS
 /*
  * This function is needed for PCIE host and device driver. Same
@@ -152,6 +160,8 @@ static void __init spear1310_evb_init(void)
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 4e8cd35..47f45d5 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -65,6 +66,36 @@ struct amba_device spear13xx_gpio_device[] = {
 	}
 };
 
+/* ssp device registeration */
+static struct pl022_ssp_controller ssp_platform_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	/*
+	 * This is number of spi devices that can be connected to spi. There are
+	 * two type of chipselects on which slave devices can work. One is chip
+	 * select provided by spi masters other is controlled through external
+	 * gpio's. We can't use chipselect provided from spi master (because as
+	 * soon as FIFO becomes empty, CS is disabled and transfer ends). So
+	 * this number now depends on number of gpios available for spi. each
+	 * slave on each master requires a separate gpio pin.
+	 */
+	.num_chipselect = 2,
+};
+
+struct amba_device spear13xx_ssp_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "ssp-pl022",
+		.platform_data = &ssp_platform_data,
+	},
+	.res = {
+		.start = SPEAR13XX_SSP_BASE,
+		.end = SPEAR13XX_SSP_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_SSP, NO_IRQ},
+};
+
 /* uart device registeration */
 struct amba_device spear13xx_uart_device = {
 	.dev = {
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 189aed4..39cc43f 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device spear3xx_gpio_device;
+extern struct amba_device spear3xx_ssp0_device;
 extern struct amba_device spear3xx_uart_device;
 extern struct amba_device spear3xx_wdt_device;
 extern struct platform_device spear3xx_ehci_device;
@@ -185,6 +186,7 @@ void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* spear320 declarations */
 #ifdef CONFIG_MACH_SPEAR320
 /* Add spear320 machine device structure declarations here */
+extern struct amba_device spear320_ssp_device[];
 extern struct amba_device spear320_uart1_device;
 extern struct amba_device spear320_uart2_device;
 extern struct platform_device spear320_can0_device;
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 92f9346..7ab29d4 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -11,11 +11,15 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <plat/keyboard.h>
+#include <plat/spi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
@@ -38,6 +42,7 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
+	&spear3xx_ssp0_device,
 	&spear3xx_uart_device,
 	&spear3xx_wdt_device,
 
@@ -76,6 +81,24 @@ static const struct kbd_platform_data kbd_data __initconst = {
 	.rep = 1,
 };
 
+/* spi board information */
+/* spi0 flash Chip Select Control function, controlled by gpio pin mentioned */
+DECLARE_SPI_CS_CONTROL(0, flash, RAS_GPIO_3);
+/* spi0 flash Chip Info structure */
+DECLARE_SPI_CHIP_INFO(0, flash, spi0_flash_cs_control);
+
+static struct spi_board_info __initdata spi_board_info[] = {
+	/* spi0 board info */
+	{
+		.modalias = "m25p80",
+		.controller_data = &spi0_flash_chip_info,
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_1,
+	}
+};
+
 static void __init spear300_evb_init(void)
 {
 	unsigned int i;
@@ -99,6 +122,8 @@ static void __init spear300_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 9c5c9b1..45abb1c 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -11,10 +11,14 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <plat/spi.h>
 #include <mach/emi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
@@ -76,6 +80,7 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
+	&spear3xx_ssp0_device,
 	&spear3xx_uart_device,
 	&spear3xx_wdt_device,
 
@@ -107,6 +112,36 @@ static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
 	.width = FSMC_NAND_BW8,
 };
 
+/* spi board information */
+/* spi0 flash Chip Select Control function, controlled by gpio pin mentioned */
+DECLARE_SPI_CS_CONTROL(0, flash, BASIC_GPIO_3);
+/* spi0 flash Chip Info structure */
+DECLARE_SPI_CHIP_INFO(0, flash, spi0_flash_cs_control);
+
+/* spi0 spidev Chip Select Control function, controlled by gpio pin mentioned */
+DECLARE_SPI_CS_CONTROL(0, dev, BASIC_GPIO_4);
+/* spi0 spidev Chip Info structure */
+DECLARE_SPI_CHIP_INFO(0, dev, spi0_dev_cs_control);
+
+static struct spi_board_info __initdata spi_board_info[] = {
+	/* spi0 board info */
+	{
+		.modalias = "spidev",
+		.controller_data = &spi0_dev_chip_info,
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 0,
+		.mode = SPI_MODE_1,
+	}, {
+		.modalias = "m25p80",
+		.controller_data = &spi0_flash_chip_info,
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_1,
+	}
+};
+
 static void __init spear310_evb_init(void)
 {
 	unsigned int i;
@@ -126,6 +161,8 @@ static void __init spear310_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 4a5041f..ac5dfb4 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/amba/pl022.h>
 #include <linux/ptrace.h>
 #include <asm/irq.h>
 #include <plat/gpio.h>
@@ -712,6 +713,47 @@ static struct spear_shirq shirq_intrcomm_ras = {
 };
 
 /* Add spear320 specific devices here */
+/* ssp device registeration */
+static struct pl022_ssp_controller ssp_platform_data[] = {
+	{
+		.bus_id = 1,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}, {
+		.bus_id = 2,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}
+};
+
+struct amba_device spear320_ssp_device[] = {
+	{
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.1",
+			.platform_data = &ssp_platform_data[0],
+		},
+		.res = {
+			.start = SPEAR320_SSP0_BASE,
+			.end = SPEAR320_SSP0_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {SPEAR320_VIRQ_SSP1, NO_IRQ},
+	}, {
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.2",
+			.platform_data = &ssp_platform_data[1],
+		},
+		.res = {
+			.start = SPEAR320_SSP1_BASE,
+			.end = SPEAR320_SSP1_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {SPEAR320_VIRQ_SSP2, NO_IRQ},
+	}
+};
+
 /* uart1 device registeration */
 struct amba_device spear320_uart1_device = {
 	.dev = {
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index bfe5d09..a1a76f2 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -11,10 +11,14 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <plat/spi.h>
 #include <mach/emi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
@@ -73,10 +77,13 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
+	&spear3xx_ssp0_device,
 	&spear3xx_uart_device,
 	&spear3xx_wdt_device,
 
 	/* spear320 specific devices */
+	&spear320_ssp_device[0],
+	&spear320_ssp_device[1],
 	&spear320_uart1_device,
 	&spear320_uart2_device,
 };
@@ -105,6 +112,10 @@ static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
 	.width = FSMC_NAND_BW8,
 };
 
+/* spi board information */
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
 static void __init spear320_evb_init(void)
 {
 	unsigned int i;
@@ -125,6 +136,8 @@ static void __init spear320_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 574e93a..16ca683 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -41,6 +42,36 @@ struct amba_device spear3xx_gpio_device = {
 	.irq = {SPEAR3XX_IRQ_BASIC_GPIO, NO_IRQ},
 };
 
+/* ssp device registration */
+static struct pl022_ssp_controller ssp_platform_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	/*
+	 * This is number of spi devices that can be connected to spi. There are
+	 * two type of chipselects on which slave devices can work. One is chip
+	 * select provided by spi masters other is controlled through external
+	 * gpio's. We can't use chipselect provided from spi master (because as
+	 * soon as FIFO becomes empty, CS is disabled and transfer ends). So
+	 * this number now depends on number of gpios available for spi. each
+	 * slave on each master requires a separate gpio pin.
+	 */
+	.num_chipselect = 2,
+};
+
+struct amba_device spear3xx_ssp0_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "ssp-pl022.0",
+		.platform_data = &ssp_platform_data,
+	},
+	.res = {
+		.start = SPEAR3XX_ICM1_SSP_BASE,
+		.end = SPEAR3XX_ICM1_SSP_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR3XX_IRQ_SSP, NO_IRQ},
+};
+
 /* uart device registration */
 struct amba_device spear3xx_uart_device = {
 	.dev = {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index df2606f..c802cb3 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -30,6 +30,7 @@
 
 /* Add spear6xx family device structure declarations here */
 extern struct amba_device gpio_device[];
+extern struct amba_device ssp_device[];
 extern struct amba_device uart_device[];
 extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 93cc614..dbfab1d 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -11,10 +11,14 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <plat/spi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
@@ -22,6 +26,9 @@ static struct amba_device *amba_devs[] __initdata = {
 	&gpio_device[0],
 	&gpio_device[1],
 	&gpio_device[2],
+	&ssp_device[0],
+	&ssp_device[1],
+	&ssp_device[2],
 	&uart_device[0],
 	&uart_device[1],
 	&wdt_device,
@@ -43,6 +50,9 @@ static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
 	.width = FSMC_NAND_BW8,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
 static void __init spear600_evb_init(void)
 {
 	unsigned int i;
@@ -59,6 +69,8 @@ static void __init spear600_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 927812d..00336e9 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -23,6 +24,73 @@
 #include <mach/irqs.h>
 
 /* Add spear6xx machines common devices here */
+/* ssp device registration */
+static struct pl022_ssp_controller ssp_platform_data[] = {
+	{
+		.bus_id = 0,
+		.enable_dma = 0,
+		/*
+		 * This is number of spi devices that can be connected to spi.
+		 * There are two type of chipselects on which slave devices can
+		 * work. One is chip select provided by spi masters other is
+		 * controlled through external gpio's. We can't use chipselect
+		 * provided from spi master (because as soon as FIFO becomes
+		 * empty, CS is disabled and transfer ends). So this number now
+		 * depends on number of gpios available for spi. each slave on
+		 * each master requires a separate gpio pin.
+		 */
+		.num_chipselect = 2,
+	}, {
+		.bus_id = 1,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}, {
+		.bus_id = 2,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}
+};
+
+struct amba_device ssp_device[] = {
+	{
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.0",
+			.platform_data = &ssp_platform_data[0],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM1_SSP0_BASE,
+			.end = SPEAR6XX_ICM1_SSP0_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_SSP_1, NO_IRQ},
+	}, {
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.1",
+			.platform_data = &ssp_platform_data[1],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM1_SSP1_BASE,
+			.end = SPEAR6XX_ICM1_SSP1_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_SSP_2, NO_IRQ},
+	}, {
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.2",
+			.platform_data = &ssp_platform_data[2],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM2_SSP2_BASE,
+			.end = SPEAR6XX_ICM2_SSP2_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_APPL_SSP, NO_IRQ},
+	}
+};
+
 /* uart device registration */
 struct amba_device uart_device[] = {
 	{
diff --git a/arch/arm/plat-spear/include/plat/spi.h b/arch/arm/plat-spear/include/plat/spi.h
new file mode 100644
index 0000000..24d57e1
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/spi.h
@@ -0,0 +1,74 @@
+/*
+ * arch/arm/plat-spear/include/plat/spi.h
+ *
+ * SPI board specific definitions common to multiple boards on multiple
+ * machines.
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_SPI_H
+#define __PLAT_SPI_H
+
+#include <linux/amba/pl022.h>
+#include <linux/gpio.h>
+
+/* spi board information */
+static inline int spi_cs_gpio_request(u32 gpio_pin)
+{
+	int ret;
+
+	ret = gpio_request(gpio_pin, "SPI_CS");
+	if (ret < 0) {
+		printk(KERN_ERR "SPI: gpio:%d request fail\n", gpio_pin);
+		return ret;
+	} else {
+		ret = gpio_direction_output(gpio_pin, 1);
+		if (ret) {
+			printk(KERN_ERR "SPI: gpio:%d direction set fail\n",
+					gpio_pin);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/* This will define cs_control function for a specific spi slave */
+#define DECLARE_SPI_CS_CONTROL(id, type, gpio)		\
+static void spi##id##_##type##_cs_control(u32 control)	\
+{							\
+	static int count, ret;				\
+							\
+	if (unlikely(!count)) {				\
+		count++;				\
+		ret = spi_cs_gpio_request(gpio);	\
+	}						\
+							\
+	if (!ret)					\
+		gpio_set_value(gpio, control);		\
+}
+
+/* This will define CHIP_INFO structure for a specific spi slave */
+#define DECLARE_SPI_CHIP_INFO(id, type, chip_select_control)	\
+static struct pl022_config_chip spi##id##_##type##_chip_info = {\
+	.iface = SSP_INTERFACE_MOTOROLA_SPI,		\
+	.hierarchy = SSP_MASTER,			\
+	.slave_tx_disable = 0,				\
+	.com_mode = INTERRUPT_TRANSFER,			\
+	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,		\
+	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,	\
+	.ctrl_len = SSP_BITS_12,			\
+	.wait_state = SSP_MWIRE_WAIT_ZERO,		\
+	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,	\
+	.cs_control = chip_select_control,		\
+};
+
+#define DECLARE_SPI_CHIP_INFO_NULL_ID(chip_select_control)	\
+DECLARE_SPI_CHIP_INFO(, chip_select_control)
+
+#endif /* __PLAT_SPI_H */
-- 
1.7.2.2
