From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 20 Dec 2010 13:55:47 +0530
Subject: [PATCH V3 27/63] ST SPEAr: Adding support for SSP PL022
In-Reply-To: <cover.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
Message-ID: <7d4726534a5aa6100144795bd74fed7bd6198539.1292833228.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   15 +++++
 arch/arm/mach-spear13xx/spear13xx.c            |   31 ++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +
 arch/arm/mach-spear3xx/spear300_evb.c          |   30 ++++++++++
 arch/arm/mach-spear3xx/spear310_evb.c          |   42 +++++++++++++
 arch/arm/mach-spear3xx/spear320.c              |   42 +++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |   14 +++++
 arch/arm/mach-spear3xx/spear3xx.c              |   31 ++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/include/mach/spear.h    |    4 +-
 arch/arm/mach-spear6xx/spear600_evb.c          |   18 ++++++
 arch/arm/mach-spear6xx/spear6xx.c              |   68 ++++++++++++++++++++++
 arch/arm/plat-spear/include/plat/spi.h         |   74 ++++++++++++++++++++++++
 14 files changed, 371 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/spi.h

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 1ad2352..847c919 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -30,6 +30,7 @@
 
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_gpio_device[];
+extern struct amba_device spear13xx_ssp_device;
 extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 0d1b01d..e4c4f53 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -12,7 +12,10 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -21,10 +24,12 @@
 #include <mach/pcie.h>
 #include <plat/keyboard.h>
 #include <plat/fsmc.h>
+#include <plat/spi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_gpio_device[0],
 	&spear13xx_gpio_device[1],
+	&spear13xx_ssp_device,
 	&spear13xx_uart_device,
 };
 
@@ -51,6 +56,14 @@ static struct kbd_platform_data kbd_data = {
 	.rep = 1,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 /* this function is needed for PCIE host and device driver. Same
  * controller can not be programmed as host as well as device. So host
@@ -105,6 +118,8 @@ static void __init spear1300_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR1300, "ST-SPEAR1300-EVB")
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index e6b00ea..4958fcd 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -64,6 +65,36 @@ struct amba_device spear13xx_gpio_device[] = {
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
index 2820977..0c6e58a 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
+extern struct amba_device ssp0_device;
 extern struct amba_device uart_device;
 extern struct amba_device wdt_device;
 extern struct platform_device ehci_device;
@@ -175,6 +176,7 @@ void __init spear310_init(void);
 #elif defined(CONFIG_MACH_SPEAR320)
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
+extern struct amba_device ssp_device[];
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 40589b0..c9f871b 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -15,10 +15,14 @@
 #include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
 #include <plat/keyboard.h>
+#include <plat/spi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -39,6 +43,7 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
+	&ssp0_device,
 	&uart_device,
 	&wdt_device,
 
@@ -72,6 +77,29 @@ static struct kbd_platform_data kbd_data = {
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
+		.max_speed_hz = 400000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_1,
+	}
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear300_evb_init(void)
 {
 	unsigned int i;
@@ -100,6 +128,8 @@ static void __init spear300_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 5ae2580..cf84207 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -15,9 +15,13 @@
 #include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
+#include <plat/spi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -46,6 +50,7 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
+	&ssp0_device,
 	&uart_device,
 	&wdt_device,
 
@@ -65,6 +70,41 @@ static struct platform_device *plat_devs[] __initdata = {
 	&plgpio_device,
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
+		.max_speed_hz = 10000000,
+		.bus_num = 0,
+		.chip_select = 0,
+		.mode = SPI_MODE_1,
+	}, {
+		.modalias = "m25p80",
+		.controller_data = &spi0_flash_chip_info,
+		.max_speed_hz = 400000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_1,
+	}
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear310_evb_init(void)
 {
 	unsigned int i;
@@ -90,6 +130,8 @@ static void __init spear310_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index d3c64f7..c79fb26 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/amba/pl022.h>
 #include <linux/ptrace.h>
 #include <linux/mtd/fsmc.h>
 #include <asm/irq.h>
@@ -403,6 +404,47 @@ struct amba_device clcd_device = {
 	.irq = {VIRQ_CLCD, NO_IRQ},
 };
 
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
+struct amba_device ssp_device[] = {
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
+		.irq = {VIRQ_SSP1, NO_IRQ},
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
+		.irq = {VIRQ_SSP2, NO_IRQ},
+	}
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index dbaeec2..bf3efda 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -15,9 +15,13 @@
 #include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
+#include <plat/spi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -65,6 +69,14 @@ static struct platform_device *plat_devs[] __initdata = {
 	&pwm_device,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear320_evb_init(void)
 {
 	unsigned int i;
@@ -90,6 +102,8 @@ static void __init spear320_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 6271c32..1444604 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -41,6 +42,36 @@ struct amba_device gpio_device = {
 	.irq = {IRQ_BASIC_GPIO, NO_IRQ},
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
+struct amba_device ssp0_device = {
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
+	.irq = {IRQ_SSP, NO_IRQ},
+};
+
 /* uart device registeration */
 struct amba_device uart_device = {
 	.dev = {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 4745182..f5f4d7c 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -31,6 +31,7 @@
 /* Add spear6xx family device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
+extern struct amba_device ssp_device[];
 extern struct amba_device uart_device[];
 extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
diff --git a/arch/arm/mach-spear6xx/include/mach/spear.h b/arch/arm/mach-spear6xx/include/mach/spear.h
index a835f5b..31486e5 100644
--- a/arch/arm/mach-spear6xx/include/mach/spear.h
+++ b/arch/arm/mach-spear6xx/include/mach/spear.h
@@ -68,8 +68,8 @@
 #define SPEAR6XX_ICM2_GPIO_BASE		0xD8100000
 #define SPEAR6XX_ICM2_GPIO_SIZE		0x00080000
 
-#define SPEAR6XX_ICM2_SPI2_BASE		0xD8180000
-#define SPEAR6XX_ICM2_SPI2_SIZE		0x00080000
+#define SPEAR6XX_ICM2_SSP2_BASE		0xD8180000
+#define SPEAR6XX_ICM2_SSP2_SIZE		0x00080000
 
 #define SPEAR6XX_ICM2_ADC_BASE		0xD8200000
 #define SPEAR6XX_ICM2_ADC_SIZE		0x00080000
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index d8b0592..20f6ad7 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -15,15 +15,23 @@
 #include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/gpio.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
+#include <plat/spi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&clcd_device,
 	&gpio_device[0],
 	&gpio_device[1],
 	&gpio_device[2],
+	&ssp_device[0],
+	&ssp_device[1],
+	&ssp_device[2],
 	&uart_device[0],
 	&uart_device[1],
 	&wdt_device,
@@ -39,6 +47,14 @@ static struct platform_device *plat_devs[] __initdata = {
 	&rtc_device,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear600_evb_init(void)
 {
 	unsigned int i;
@@ -59,6 +75,8 @@ static void __init spear600_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index aaa5f93..bbd5078 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -41,6 +42,73 @@ struct amba_device clcd_device = {
 	.irq = {IRQ_BASIC_CLCD, NO_IRQ},
 };
 
+/* ssp device registeration */
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
 /* uart device registeration */
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
