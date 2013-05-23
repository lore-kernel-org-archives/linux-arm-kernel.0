From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 23 May 2013 19:59:53 +0200
Subject: [PATCH 23/23 v2] ARM: u300: delete all static board data
Message-ID: <1369331993-28916-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We have now transferred all the U300 peripherals to the device
tree, so we just select USE_OF, and delete all static board data,
then require that this platform shall be booted using the device
tree and nothing else.

This gets rid of the MMCI (PL180), PL022, and serial PL011
platform data entries and more.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Delete MORE static data! (Platform data and static DMA channel
  assignments for PL011, PL022, PL180...
---
 arch/arm/Kconfig               |   1 +
 arch/arm/mach-u300/Makefile    |   2 -
 arch/arm/mach-u300/core.c      | 548 +----------------------------------------
 arch/arm/mach-u300/i2c.c       | 285 ---------------------
 arch/arm/mach-u300/i2c.h       |  23 --
 arch/arm/mach-u300/regulator.c |  12 +-
 arch/arm/mach-u300/spi.c       | 102 --------
 arch/arm/mach-u300/spi.h       |  26 --
 arch/arm/mach-u300/timer.c     |  38 +--
 arch/arm/mach-u300/timer.h     |   2 -
 arch/arm/mach-u300/u300-gpio.h |  70 ------
 11 files changed, 22 insertions(+), 1087 deletions(-)
 delete mode 100644 arch/arm/mach-u300/i2c.c
 delete mode 100644 arch/arm/mach-u300/i2c.h
 delete mode 100644 arch/arm/mach-u300/spi.c
 delete mode 100644 arch/arm/mach-u300/spi.h
 delete mode 100644 arch/arm/mach-u300/timer.h
 delete mode 100644 arch/arm/mach-u300/u300-gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fbad333..2689643 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -827,6 +827,7 @@ config ARCH_U300
 	select GENERIC_CLOCKEVENTS
 	select HAVE_TCM
 	select SPARSE_IRQ
+	select USE_OF
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 5a86c58..0f362b6 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -7,7 +7,5 @@ obj-m		:=
 obj-n		:=
 obj-		:=
 
-obj-$(CONFIG_SPI_PL022)           += spi.o
 obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
-obj-$(CONFIG_I2C_STU300)          += i2c.o
 obj-$(CONFIG_REGULATOR_AB3100)    += regulator.o
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 8f9e77a..13d4812 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -9,50 +9,20 @@
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/mm.h>
-#include <linux/termios.h>
-#include <linux/dmaengine.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/mmci.h>
-#include <linux/amba/pl022.h>
-#include <linux/amba/serial.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/fsmc.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf-generic.h>
-#include <linux/dma-mapping.h>
 #include <linux/platform_data/clk-u300.h>
 #include <linux/platform_data/pinctrl-coh901.h>
-#include <linux/platform_data/dma-coh901318.h>
-#include <linux/irqchip/arm-vic.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <linux/clocksource.h>
+#include <linux/clk.h>
 
-#include <asm/types.h>
-#include <asm/setup.h>
-#include <asm/memory.h>
 #include <asm/mach/map.h>
-#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
+#include <mach/u300-regs.h>
 #include <mach/syscon.h>
-#include <mach/irqs.h>
-
-#include "timer.h"
-#include "spi.h"
-#include "i2c.h"
-#include "u300-gpio.h"
 
 /*
  * Static I/O mappings that are needed for booting the U300 platforms. The
@@ -87,287 +57,6 @@ static void __init u300_map_io(void)
 }
 
 /*
- * Declaration of devices found on the U300 board and
- * their respective memory locations.
- */
-
-static struct amba_pl011_data uart0_plat_data = {
-#ifdef CONFIG_COH901318
-	.dma_filter = coh901318_filter_id,
-	.dma_rx_param = (void *) U300_DMA_UART0_RX,
-	.dma_tx_param = (void *) U300_DMA_UART0_TX,
-#endif
-};
-
-/* Slow device at 0x3000 offset */
-static AMBA_APB_DEVICE(uart0, "uart0", 0, U300_UART0_BASE,
-	{ IRQ_U300_UART0 }, &uart0_plat_data);
-
-/* The U335 have an additional UART1 on the APP CPU */
-static struct amba_pl011_data uart1_plat_data = {
-#ifdef CONFIG_COH901318
-	.dma_filter = coh901318_filter_id,
-	.dma_rx_param = (void *) U300_DMA_UART1_RX,
-	.dma_tx_param = (void *) U300_DMA_UART1_TX,
-#endif
-};
-
-/* Fast device at 0x7000 offset */
-static AMBA_APB_DEVICE(uart1, "uart1", 0, U300_UART1_BASE,
-	{ IRQ_U300_UART1 }, &uart1_plat_data);
-
-/* AHB device at 0x4000 offset */
-static AMBA_APB_DEVICE(pl172, "pl172", 0, U300_EMIF_CFG_BASE, { }, NULL);
-
-/* Fast device at 0x6000 offset */
-static AMBA_APB_DEVICE(pl022, "pl022", 0, U300_SPI_BASE,
-	{ IRQ_U300_SPI }, NULL);
-
-/* Fast device at 0x1000 offset */
-#define U300_MMCSD_IRQS	{ IRQ_U300_MMCSD_MCIINTR0, IRQ_U300_MMCSD_MCIINTR1 }
-
-static struct mmci_platform_data mmcsd_platform_data = {
-	/*
-	 * Do not set ocr_mask or voltage translation function,
-	 * we have a regulator we can control instead.
-	 */
-	.f_max = 24000000,
-	.gpio_wp = -1,
-	.gpio_cd = U300_GPIO_PIN_MMC_CD,
-	.cd_invert = true,
-	.capabilities = MMC_CAP_MMC_HIGHSPEED |
-	MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
-#ifdef CONFIG_COH901318
-	.dma_filter = coh901318_filter_id,
-	.dma_rx_param = (void *) U300_DMA_MMCSD_RX_TX,
-	/* Don't specify a TX channel, this RX channel is bidirectional */
-#endif
-};
-
-static AMBA_APB_DEVICE(mmcsd, "mmci", 0, U300_MMCSD_BASE,
-	U300_MMCSD_IRQS, &mmcsd_platform_data);
-
-/*
- * The order of device declaration may be important, since some devices
- * have dependencies on other devices being initialized first.
- */
-static struct amba_device *amba_devs[] __initdata = {
-	&uart0_device,
-	&uart1_device,
-	&pl022_device,
-	&pl172_device,
-	&mmcsd_device,
-};
-
-/* Here follows a list of all hw resources that the platform devices
- * allocate. Note, clock dependencies are not included
- */
-
-static struct resource gpio_resources[] = {
-	{
-		.start = U300_GPIO_BASE,
-		.end   = (U300_GPIO_BASE + SZ_4K - 1),
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name  = "gpio0",
-		.start = IRQ_U300_GPIO_PORT0,
-		.end   = IRQ_U300_GPIO_PORT0,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "gpio1",
-		.start = IRQ_U300_GPIO_PORT1,
-		.end   = IRQ_U300_GPIO_PORT1,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "gpio2",
-		.start = IRQ_U300_GPIO_PORT2,
-		.end   = IRQ_U300_GPIO_PORT2,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "gpio3",
-		.start = IRQ_U300_GPIO_PORT3,
-		.end   = IRQ_U300_GPIO_PORT3,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "gpio4",
-		.start = IRQ_U300_GPIO_PORT4,
-		.end   = IRQ_U300_GPIO_PORT4,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "gpio5",
-		.start = IRQ_U300_GPIO_PORT5,
-		.end   = IRQ_U300_GPIO_PORT5,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "gpio6",
-		.start = IRQ_U300_GPIO_PORT6,
-		.end   = IRQ_U300_GPIO_PORT6,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource keypad_resources[] = {
-	{
-		.start = U300_KEYPAD_BASE,
-		.end   = U300_KEYPAD_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name  = "coh901461-press",
-		.start = IRQ_U300_KEYPAD_KEYBF,
-		.end   = IRQ_U300_KEYPAD_KEYBF,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "coh901461-release",
-		.start = IRQ_U300_KEYPAD_KEYBR,
-		.end   = IRQ_U300_KEYPAD_KEYBR,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource rtc_resources[] = {
-	{
-		.start = U300_RTC_BASE,
-		.end   = U300_RTC_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = IRQ_U300_RTC,
-		.end   = IRQ_U300_RTC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-/*
- * Fsmc does have IRQs: #43 and #44 (NFIF and NFIF2)
- * but these are not yet used by the driver.
- */
-static struct resource fsmc_resources[] = {
-	{
-		.name  = "nand_addr",
-		.start = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_ALE,
-		.end   = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_ALE + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name  = "nand_cmd",
-		.start = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_CLE,
-		.end   = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_CLE + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name  = "nand_data",
-		.start = U300_NAND_CS0_PHYS_BASE,
-		.end   = U300_NAND_CS0_PHYS_BASE + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name  = "fsmc_regs",
-		.start = U300_NAND_IF_PHYS_BASE,
-		.end   = U300_NAND_IF_PHYS_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static struct resource i2c0_resources[] = {
-	{
-		.start = U300_I2C0_BASE,
-		.end   = U300_I2C0_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = IRQ_U300_I2C0,
-		.end   = IRQ_U300_I2C0,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource i2c1_resources[] = {
-	{
-		.start = U300_I2C1_BASE,
-		.end   = U300_I2C1_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = IRQ_U300_I2C1,
-		.end   = IRQ_U300_I2C1,
-		.flags = IORESOURCE_IRQ,
-	},
-
-};
-
-static struct resource wdog_resources[] = {
-	{
-		.start = U300_WDOG_BASE,
-		.end   = U300_WDOG_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = IRQ_U300_WDOG,
-		.end   = IRQ_U300_WDOG,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static struct resource dma_resource[] = {
-	{
-		.start = U300_DMAC_BASE,
-		.end = U300_DMAC_BASE + PAGE_SIZE - 1,
-		.flags =  IORESOURCE_MEM,
-	},
-	{
-		.start = IRQ_U300_DMA,
-		.end = IRQ_U300_DMA,
-		.flags =  IORESOURCE_IRQ,
-	}
-};
-
-
-static struct resource pinctrl_resources[] = {
-	{
-		.start = U300_SYSCON_BASE,
-		.end   = U300_SYSCON_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device wdog_device = {
-	.name = "coh901327_wdog",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(wdog_resources),
-	.resource = wdog_resources,
-};
-
-static struct platform_device i2c0_device = {
-	.name = "stu300",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(i2c0_resources),
-	.resource = i2c0_resources,
-};
-
-static struct platform_device i2c1_device = {
-	.name = "stu300",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(i2c1_resources),
-	.resource = i2c1_resources,
-};
-
-static struct platform_device pinctrl_device = {
-	.name = "pinctrl-u300",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(pinctrl_resources),
-	.resource = pinctrl_resources,
-};
-
-/*
  * The different variants have a few different versions of the
  * GPIO block, with different number of ports.
  */
@@ -376,75 +65,6 @@ static struct u300_gpio_platform u300_gpio_plat = {
 	.gpio_base = 0,
 };
 
-static struct platform_device gpio_device = {
-	.name = "u300-gpio",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(gpio_resources),
-	.resource = gpio_resources,
-	.dev = {
-		.platform_data = &u300_gpio_plat,
-	},
-};
-
-static struct platform_device keypad_device = {
-	.name = "keypad",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(keypad_resources),
-	.resource = keypad_resources,
-};
-
-static struct platform_device rtc_device = {
-	.name = "rtc-coh901331",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(rtc_resources),
-	.resource = rtc_resources,
-};
-
-static struct mtd_partition u300_partitions[] = {
-	{
-		.name = "bootrecords",
-		.offset = 0,
-		.size = SZ_128K,
-	},
-	{
-		.name = "free",
-		.offset = SZ_128K,
-		.size = 8064 * SZ_1K,
-	},
-	{
-		.name = "platform",
-		.offset = 8192 * SZ_1K,
-		.size = 253952 * SZ_1K,
-	},
-};
-
-static struct fsmc_nand_platform_data nand_platform_data = {
-	.partitions = u300_partitions,
-	.nr_partitions = ARRAY_SIZE(u300_partitions),
-	.options = NAND_SKIP_BBTSCAN,
-	.width = FSMC_NAND_BW8,
-};
-
-static struct platform_device nand_device = {
-	.name = "fsmc-nand",
-	.id = -1,
-	.resource = fsmc_resources,
-	.num_resources = ARRAY_SIZE(fsmc_resources),
-	.dev = {
-		.platform_data = &nand_platform_data,
-	},
-};
-
-static struct platform_device dma_device = {
-	.name		= "coh901318",
-	.id		= -1,
-	.resource	= dma_resource,
-	.num_resources  = ARRAY_SIZE(dma_resource),
-	.dev = {
-		.coherent_dma_mask = ~0,
-	},
-};
-
 static unsigned long pin_pullup_conf[] = {
 	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 1),
 };
@@ -471,61 +91,6 @@ static struct pinctrl_map __initdata u300_pinmux_map[] = {
 				    pin_highz_conf),
 };
 
-/*
- * Notice that AMBA devices are initialized before platform devices.
- *
- */
-static struct platform_device *platform_devs[] __initdata = {
-	&dma_device,
-	&i2c0_device,
-	&i2c1_device,
-	&keypad_device,
-	&rtc_device,
-	&pinctrl_device,
-	&gpio_device,
-	&nand_device,
-	&wdog_device,
-};
-
-/*
- * Interrupts: the U300 platforms have two pl190 ARM PrimeCells connected
- * together so some interrupts are connected to the first one and some
- * to the second one.
- */
-static void __init u300_init_irq(void)
-{
-	u32 mask[2] = {0, 0};
-	struct clk *clk;
-	int i;
-
-	/* initialize clocking early, we want to clock the INTCON */
-	u300_clk_init(U300_SYSCON_VBASE);
-
-	/* Bootstrap EMIF and SEMI clocks */
-	clk = clk_get_sys("pl172", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
-	clk = clk_get_sys("semi", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
-
-	/* Clock the interrupt controller */
-	clk = clk_get_sys("intcon", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
-
-	for (i = 0; i < U300_VIC_IRQS_END; i++)
-		set_bit(i, (unsigned long *) &mask[0]);
-	vic_init((void __iomem *) U300_INTCON0_VBASE, IRQ_U300_INTCON0_START,
-		 mask[0], mask[0]);
-	vic_init((void __iomem *) U300_INTCON1_VBASE, IRQ_U300_INTCON1_START,
-		 mask[1], mask[1]);
-}
-
-
-/*
- * U300 platforms peripheral handling
- */
 struct db_chip {
 	u16 chipid;
 	const char *name;
@@ -604,74 +169,6 @@ static void __init u300_init_check_chip(void)
 	}
 }
 
-/*
- * Some devices and their resources require reserved physical memory from
- * the end of the available RAM. This function traverses the list of devices
- * and assigns actual addresses to these.
- */
-static void __init u300_assign_physmem(void)
-{
-	unsigned long curr_start = __pa(high_memory);
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(platform_devs); i++) {
-		for (j = 0; j < platform_devs[i]->num_resources; j++) {
-			struct resource *const res =
-			  &platform_devs[i]->resource[j];
-
-			if (IORESOURCE_MEM == res->flags &&
-				     0 == res->start) {
-				res->start  = curr_start;
-				res->end   += curr_start;
-				curr_start += resource_size(res);
-
-				printk(KERN_INFO "core.c: Mapping RAM " \
-				       "%#x-%#x to device %s:%s\n",
-					res->start, res->end,
-				       platform_devs[i]->name, res->name);
-			}
-		}
-	}
-}
-
-static void __init u300_init_machine(void)
-{
-	int i;
-	u16 val;
-
-	/* Check what platform we run and print some status information */
-	u300_init_check_chip();
-
-	/* Initialize SPI device with some board specifics */
-	u300_spi_init(&pl022_device);
-
-	/* Register the AMBA devices in the AMBA bus abstraction layer */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-
-	u300_assign_physmem();
-
-	/* Initialize pinmuxing */
-	pinctrl_register_mappings(u300_pinmux_map,
-				  ARRAY_SIZE(u300_pinmux_map));
-
-	/* Register subdevices on the I2C buses */
-	u300_i2c_register_board_devices();
-
-	/* Register the platform devices */
-	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
-
-	/* Register subdevices on the SPI bus */
-	u300_spi_register_board_devices();
-
-	/* Enable SEMI self refresh */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_SMCR) |
-		U300_SYSCON_SMCR_SEMI_SREFREQ_ENABLE;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_SMCR);
-}
-
 /* Forward declare this function from the watchdog */
 void coh901327_watchdog_reset(void);
 
@@ -692,35 +189,6 @@ static void u300_restart(char mode, const char *cmd)
 	while (1);
 }
 
-MACHINE_START(U300, "Ericsson AB U335 S335/B335 Prototype Board")
-	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
-	.atag_offset	= 0x100,
-	.map_io		= u300_map_io,
-	.nr_irqs	= 0,
-	.init_irq	= u300_init_irq,
-	.init_time	= u300_timer_init,
-	.init_machine	= u300_init_machine,
-	.restart	= u300_restart,
-MACHINE_END
-
-#ifdef CONFIG_OF
-
-static struct pl022_ssp_controller spi_plat_data = {
-	/* If you have several SPI buses this varies, we have only bus 0 */
-	.bus_id = 0,
-	/*
-	 * On the APP CPU GPIO 4, 5 and 6 are connected as generic
-	 * chip selects for SPI. (Same on U330, U335 and U365.)
-	 * TODO: make sure the GPIO driver can select these properly
-	 * and do padmuxing accordingly too.
-	 */
-	.num_chipselect = 3,
-	.enable_dma = 1,
-	.dma_filter = coh901318_filter_id,
-	.dma_rx_param = (void *) U300_DMA_SPI_RX,
-	.dma_tx_param = (void *) U300_DMA_SPI_TX,
-};
-
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,pinctrl-u300", U300_SYSCON_BASE,
@@ -736,17 +204,17 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,fsmc-nand", U300_NAND_IF_PHYS_BASE,
 		"fsmc-nand", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
-		"uart0", &uart0_plat_data),
+		"uart0", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
-		"uart1", &uart1_plat_data),
+		"uart1", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_SPI_BASE,
-		"pl022", &spi_plat_data),
+		"pl022", NULL),
 	OF_DEV_AUXDATA("st,ddci2c", U300_I2C0_BASE,
 		"stu300.0", NULL),
 	OF_DEV_AUXDATA("st,ddci2c", U300_I2C1_BASE,
 		"stu300.1", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_MMCSD_BASE,
-		"mmci", &mmcsd_platform_data),
+		"mmci", NULL),
 	{ /* sentinel */ },
 };
 
@@ -780,8 +248,6 @@ static void __init u300_init_machine_dt(void)
 	/* Check what platform we run and print some status information */
 	u300_init_check_chip();
 
-	u300_assign_physmem();
-
 	/* Initialize pinmuxing */
 	pinctrl_register_mappings(u300_pinmux_map,
 				  ARRAY_SIZE(u300_pinmux_map));
@@ -808,5 +274,3 @@ DT_MACHINE_START(U300_DT, "U300 S335/B335 (Device Tree)")
 	.restart	= u300_restart,
 	.dt_compat      = u300_board_compat,
 MACHINE_END
-
-#endif /* CONFIG_OF */
diff --git a/arch/arm/mach-u300/i2c.c b/arch/arm/mach-u300/i2c.c
deleted file mode 100644
index 96800aa..0000000
--- a/arch/arm/mach-u300/i2c.c
+++ /dev/null
@@ -1,285 +0,0 @@
-/*
- * arch/arm/mach-u300/i2c.c
- *
- * Copyright (C) 2009-2012 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- *
- * Register board i2c devices
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#include <linux/kernel.h>
-#include <linux/i2c.h>
-#include <linux/mfd/ab3100.h>
-#include <linux/regulator/machine.h>
-#include <linux/amba/bus.h>
-#include <mach/irqs.h>
-
-/*
- * Initial settings of ab3100 registers.
- * Common for below LDO regulator settings are that
- * bit 7-5 controls voltage. Bit 4 turns regulator ON(1) or OFF(0).
- * Bit 3-2 controls sleep enable and bit 1-0 controls sleep mode.
- */
-
-/* LDO_A 0x16: 2.75V, ON, SLEEP_A, SLEEP OFF GND */
-#define LDO_A_SETTING		0x16
-/* LDO_C 0x10: 2.65V, ON, SLEEP_A or B, SLEEP full power */
-#define LDO_C_SETTING		0x10
-/* LDO_D 0x10: 2.65V, ON, sleep mode not used */
-#define LDO_D_SETTING		0x10
-/* LDO_E 0x10: 1.8V, ON, SLEEP_A or B, SLEEP full power */
-#define LDO_E_SETTING		0x10
-/* LDO_E SLEEP 0x00: 1.8V, not used, SLEEP_A or B, not used */
-#define LDO_E_SLEEP_SETTING	0x00
-/* LDO_F 0xD0: 2.5V, ON, SLEEP_A or B, SLEEP full power */
-#define LDO_F_SETTING		0xD0
-/* LDO_G 0x00: 2.85V, OFF, SLEEP_A or B, SLEEP full power */
-#define LDO_G_SETTING		0x00
-/* LDO_H 0x18: 2.75V, ON, SLEEP_B, SLEEP full power */
-#define LDO_H_SETTING		0x18
-/* LDO_K 0x00: 2.75V, OFF, SLEEP_A or B, SLEEP full power */
-#define LDO_K_SETTING		0x00
-/* LDO_EXT 0x00: Voltage not set, OFF, not used, not used */
-#define LDO_EXT_SETTING		0x00
-/* BUCK 0x7D: 1.2V, ON, SLEEP_A and B, SLEEP low power */
-#define BUCK_SETTING	0x7D
-/* BUCK SLEEP 0xAC: 1.05V, Not used, SLEEP_A and B, Not used */
-#define BUCK_SLEEP_SETTING	0xAC
-
-#ifdef CONFIG_AB3100_CORE
-static struct regulator_consumer_supply supply_ldo_c[] = {
-	{
-		.dev_name = "ab3100-codec",
-		.supply = "vaudio", /* Powers the codec */
-	},
-};
-
-/*
- * This one needs to be a supply so we can turn it off
- * in order to shut down the system.
- */
-static struct regulator_consumer_supply supply_ldo_d[] = {
-	{
-		.supply = "vana15", /* Powers the SoC (CPU etc) */
-	},
-};
-
-static struct regulator_consumer_supply supply_ldo_g[] = {
-	{
-		.dev_name = "mmci",
-		.supply = "vmmc", /* Powers MMC/SD card */
-	},
-};
-
-static struct regulator_consumer_supply supply_ldo_h[] = {
-	{
-		.dev_name = "xgam_pdi",
-		.supply = "vdisp", /* Powers camera, display etc */
-	},
-};
-
-static struct regulator_consumer_supply supply_ldo_k[] = {
-	{
-		.dev_name = "irda",
-		.supply = "vir", /* Power IrDA */
-	},
-};
-
-/*
- * This is a placeholder for whoever wish to use the
- * external power.
- */
-static struct regulator_consumer_supply supply_ldo_ext[] = {
-	{
-		.supply = "vext", /* External power */
-	},
-};
-
-/* Preset (hardware defined) voltages for these regulators */
-#define LDO_A_VOLTAGE 2750000
-#define LDO_C_VOLTAGE 2650000
-#define LDO_D_VOLTAGE 2650000
-
-static struct ab3100_platform_data ab3100_plf_data = {
-	.reg_constraints = {
-		/* LDO A routing and constraints */
-		{
-			.constraints = {
-				.name = "vrad",
-				.min_uV = LDO_A_VOLTAGE,
-				.max_uV = LDO_A_VOLTAGE,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.always_on = 1,
-				.boot_on = 1,
-			},
-		},
-		/* LDO C routing and constraints */
-		{
-			.constraints = {
-				.min_uV = LDO_C_VOLTAGE,
-				.max_uV = LDO_C_VOLTAGE,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-			},
-			.num_consumer_supplies = ARRAY_SIZE(supply_ldo_c),
-			.consumer_supplies = supply_ldo_c,
-		},
-		/* LDO D routing and constraints */
-		{
-			.constraints = {
-				.min_uV = LDO_D_VOLTAGE,
-				.max_uV = LDO_D_VOLTAGE,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-				/*
-				 * Actually this is boot_on but we need
-				 * to reference count it externally to
-				 * be able to shut down the system.
-				 */
-			},
-			.num_consumer_supplies = ARRAY_SIZE(supply_ldo_d),
-			.consumer_supplies = supply_ldo_d,
-		},
-		/* LDO E routing and constraints */
-		{
-			.constraints = {
-				.name = "vio",
-				.min_uV = 1800000,
-				.max_uV = 1800000,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.always_on = 1,
-				.boot_on = 1,
-			},
-		},
-		/* LDO F routing and constraints */
-		{
-			.constraints = {
-				.name = "vana25",
-				.min_uV = 2500000,
-				.max_uV = 2500000,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.always_on = 1,
-				.boot_on = 1,
-			},
-		},
-		/* LDO G routing and constraints */
-		{
-			.constraints = {
-				.min_uV = 1500000,
-				.max_uV = 2850000,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask =
-				REGULATOR_CHANGE_VOLTAGE |
-				REGULATOR_CHANGE_STATUS,
-			},
-			.num_consumer_supplies = ARRAY_SIZE(supply_ldo_g),
-			.consumer_supplies = supply_ldo_g,
-		},
-		/* LDO H routing and constraints */
-		{
-			.constraints = {
-				.min_uV = 1200000,
-				.max_uV = 2750000,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask =
-				REGULATOR_CHANGE_VOLTAGE |
-				REGULATOR_CHANGE_STATUS,
-			},
-			.num_consumer_supplies = ARRAY_SIZE(supply_ldo_h),
-			.consumer_supplies = supply_ldo_h,
-		},
-		/* LDO K routing and constraints */
-		{
-			.constraints = {
-				.min_uV = 1800000,
-				.max_uV = 2750000,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask =
-				REGULATOR_CHANGE_VOLTAGE |
-				REGULATOR_CHANGE_STATUS,
-			},
-			.num_consumer_supplies = ARRAY_SIZE(supply_ldo_k),
-			.consumer_supplies = supply_ldo_k,
-		},
-		/* External regulator interface. No fixed voltage specified.
-		 * If we knew the voltage of the external regulator and it
-		 * was connected on the board, we could add the (fixed)
-		 * voltage for it here.
-		 */
-		{
-			.constraints = {
-				.min_uV = 0,
-				.max_uV = 0,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask =
-				REGULATOR_CHANGE_STATUS,
-			},
-			.num_consumer_supplies = ARRAY_SIZE(supply_ldo_ext),
-			.consumer_supplies = supply_ldo_ext,
-		},
-		/* Buck converter routing and constraints */
-		{
-			.constraints = {
-				.name = "vcore",
-				.min_uV = 1200000,
-				.max_uV = 1800000,
-				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask =
-				REGULATOR_CHANGE_VOLTAGE,
-				.always_on = 1,
-				.boot_on = 1,
-			},
-		},
-	},
-	.reg_initvals = {
-		LDO_A_SETTING,
-		LDO_C_SETTING,
-		LDO_E_SETTING,
-		LDO_E_SLEEP_SETTING,
-		LDO_F_SETTING,
-		LDO_G_SETTING,
-		LDO_H_SETTING,
-		LDO_K_SETTING,
-		LDO_EXT_SETTING,
-		BUCK_SETTING,
-		BUCK_SLEEP_SETTING,
-		LDO_D_SETTING,
-	},
-};
-#endif
-
-static struct i2c_board_info __initdata bus0_i2c_board_info[] = {
-#ifdef CONFIG_AB3100_CORE
-	{
-		.type = "ab3100",
-		.addr = 0x48,
-		.irq = IRQ_U300_IRQ0_EXT,
-		.platform_data = &ab3100_plf_data,
-	},
-#else
-	{ },
-#endif
-};
-
-static struct i2c_board_info __initdata bus1_i2c_board_info[] = {
-	{
-		.type = "fwcam",
-		.addr = 0x10,
-	},
-	{
-		.type = "fwcam",
-		.addr = 0x5d,
-	},
-};
-
-void __init u300_i2c_register_board_devices(void)
-{
-	i2c_register_board_info(0, bus0_i2c_board_info,
-				ARRAY_SIZE(bus0_i2c_board_info));
-	/*
-	 * This makes the core shut down all unused regulators
-	 * after all the initcalls have completed.
-	 */
-	regulator_has_full_constraints();
-	i2c_register_board_info(1, bus1_i2c_board_info,
-				ARRAY_SIZE(bus1_i2c_board_info));
-}
diff --git a/arch/arm/mach-u300/i2c.h b/arch/arm/mach-u300/i2c.h
deleted file mode 100644
index 485c02e..0000000
--- a/arch/arm/mach-u300/i2c.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * arch/arm/mach-u300/i2c.h
- *
- * Copyright (C) 2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- *
- * Register board i2c devices
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-
-#ifndef MACH_U300_I2C_H
-#define MACH_U300_I2C_H
-
-#ifdef CONFIG_I2C_STU300
-void __init u300_i2c_register_board_devices(void);
-#else
-/* Compile out this stuff if no I2C adapter is available */
-static inline void __init u300_i2c_register_board_devices(void)
-{
-}
-#endif
-
-#endif
diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index 8a67dc6..bbda954 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -58,10 +58,7 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 	u32 val;
 
 	pr_info("U300: setting up board power\n");
-	if (pdev)
-		main_power_15 = regulator_get(&pdev->dev, "vana15");
-	else
-		main_power_15 = regulator_get(NULL, "vana15");
+	main_power_15 = regulator_get(&pdev->dev, "vana15");
 
 	if (IS_ERR(main_power_15)) {
 		pr_err("could not get vana15");
@@ -114,11 +111,8 @@ static struct platform_driver s365_board_driver = {
  */
 static int __init u300_init_boardpower(void)
 {
-	if (of_have_populated_dt())
-		return platform_driver_probe(&s365_board_driver,
-					     s365_board_probe);
-	/* Only call this on non-DT boots */
-	return __u300_init_boardpower(NULL);
+	return platform_driver_probe(&s365_board_driver,
+				     s365_board_probe);
 }
 
 device_initcall(u300_init_boardpower);
diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
deleted file mode 100644
index 9106982..0000000
--- a/arch/arm/mach-u300/spi.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * arch/arm/mach-u300/spi.c
- *
- * Copyright (C) 2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- *
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#include <linux/device.h>
-#include <linux/amba/bus.h>
-#include <linux/spi/spi.h>
-#include <linux/amba/pl022.h>
-#include <linux/platform_data/dma-coh901318.h>
-#include <linux/err.h>
-
-/*
- * The following is for the actual devices on the SSP/SPI bus
- */
-#ifdef CONFIG_MACH_U300_SPIDUMMY
-static void select_dummy_chip(u32 chipselect)
-{
-	pr_debug("CORE: %s called with CS=0x%x (%s)\n",
-		 __func__,
-		 chipselect,
-		 chipselect ? "unselect chip" : "select chip");
-	/*
-	 * Here you would write the chip select value to the GPIO pins if
-	 * this was a real chip (but this is a loopback dummy).
-	 */
-}
-
-struct pl022_config_chip dummy_chip_info = {
-	/* available POLLING_TRANSFER, INTERRUPT_TRANSFER, DMA_TRANSFER */
-	.com_mode = DMA_TRANSFER,
-	.iface = SSP_INTERFACE_MOTOROLA_SPI,
-	/* We can only act as master but SSP_SLAVE is possible in theory */
-	.hierarchy = SSP_MASTER,
-	/* 0 = drive TX even as slave, 1 = do not drive TX as slave */
-	.slave_tx_disable = 0,
-	.rx_lev_trig = SSP_RX_4_OR_MORE_ELEM,
-	.tx_lev_trig = SSP_TX_4_OR_MORE_EMPTY_LOC,
-	.ctrl_len = SSP_BITS_12,
-	.wait_state = SSP_MWIRE_WAIT_ZERO,
-	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
-	/*
-	 * This is where you insert a call to a function to enable CS
-	 * (usually GPIO) for a certain chip.
-	 */
-	.cs_control = select_dummy_chip,
-};
-#endif
-
-static struct spi_board_info u300_spi_devices[] = {
-#ifdef CONFIG_MACH_U300_SPIDUMMY
-	{
-		/* A dummy chip used for loopback tests */
-		.modalias       = "spi-dummy",
-		/* Really dummy, pass in additional chip config here */
-		.platform_data  = NULL,
-		/* This defines how the controller shall handle the device */
-		.controller_data = &dummy_chip_info,
-		/* .irq - no external IRQ routed from this device */
-		.max_speed_hz   = 1000000,
-		.bus_num        = 0, /* Only one bus on this chip */
-		.chip_select    = 0,
-		/* Means SPI_CS_HIGH, change if e.g low CS */
-		.mode           = SPI_MODE_1 | SPI_LOOP,
-	},
-#endif
-};
-
-static struct pl022_ssp_controller ssp_platform_data = {
-	/* If you have several SPI buses this varies, we have only bus 0 */
-	.bus_id = 0,
-	/*
-	 * On the APP CPU GPIO 4, 5 and 6 are connected as generic
-	 * chip selects for SPI. (Same on U330, U335 and U365.)
-	 * TODO: make sure the GPIO driver can select these properly
-	 * and do padmuxing accordingly too.
-	 */
-	.num_chipselect = 3,
-#ifdef CONFIG_COH901318
-	.enable_dma = 1,
-	.dma_filter = coh901318_filter_id,
-	.dma_rx_param = (void *) U300_DMA_SPI_RX,
-	.dma_tx_param = (void *) U300_DMA_SPI_TX,
-#else
-	.enable_dma = 0,
-#endif
-};
-
-
-void __init u300_spi_init(struct amba_device *adev)
-{
-	adev->dev.platform_data = &ssp_platform_data;
-}
-
-void __init u300_spi_register_board_devices(void)
-{
-	/* Register any SPI devices */
-	spi_register_board_info(u300_spi_devices, ARRAY_SIZE(u300_spi_devices));
-}
diff --git a/arch/arm/mach-u300/spi.h b/arch/arm/mach-u300/spi.h
deleted file mode 100644
index bd3d867..0000000
--- a/arch/arm/mach-u300/spi.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/mach-u300/spi.h
- *
- * Copyright (C) 2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- *
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#ifndef SPI_H
-#define SPI_H
-#include <linux/amba/bus.h>
-
-#ifdef CONFIG_SPI_PL022
-void __init u300_spi_init(struct amba_device *adev);
-void __init u300_spi_register_board_devices(void);
-#else
-/* Compile out SPI support if PL022 is not selected */
-static inline void __init u300_spi_init(struct amba_device *adev)
-{
-}
-static inline void __init u300_spi_register_board_devices(void)
-{
-}
-#endif
-
-#endif
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index df1e3b5..f3efef0 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -30,8 +30,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include "timer.h"
-
 /*
  * APP side special timer registers
  * This timer contains four timers which can fire an interrupt each.
@@ -361,12 +359,22 @@ static struct delay_timer u300_delay_timer;
 /*
  * This sets up the system timers, clock source and clock event.
  */
-static void __init u300_timer_setup(void __iomem *base, int irq)
+static void __init u300_timer_init_of(struct device_node *np)
 {
+	struct resource irq_res;
+	int irq;
 	struct clk *clk;
 	unsigned long rate;
 
-	u300_timer_base = base;
+	u300_timer_base = of_iomap(np, 0);
+	if (!u300_timer_base)
+		panic("could not ioremap system timer\n");
+
+	/* Get the IRQ for the GP1 timer */
+	irq = of_irq_to_resource(np, 2, &irq_res);
+	if (irq <= 0)
+		panic("no IRQ for system timer\n");
+
 	pr_info("U300 GP1 timer @ base: %p, IRQ: %d\n", u300_timer_base, irq);
 
 	/* Clock the interrupt controller */
@@ -433,27 +441,5 @@ static void __init u300_timer_setup(void __iomem *base, int irq)
 	 */
 }
 
-
-void __init u300_timer_init()
-{
-	u300_timer_setup(U300_TIMER_APP_VBASE, IRQ_U300_TIMER_APP_GP1);
-}
-
-#ifdef CONFIG_OF
-
-static void __init u300_timer_init_of(struct device_node *np)
-{
-	void __iomem *base;
-	struct resource irq_res;
-	int irq;
-
-	base = of_iomap(np, 0);
-	/* Get the IRQ for the GP1 timer */
-	irq = of_irq_to_resource(np, 2, &irq_res);
-	u300_timer_setup(base, irq);
-}
-
 CLOCKSOURCE_OF_DECLARE(u300_timer, "stericsson,u300-apptimer",
 		       u300_timer_init_of);
-
-#endif
diff --git a/arch/arm/mach-u300/timer.h b/arch/arm/mach-u300/timer.h
deleted file mode 100644
index 7766dfa..0000000
--- a/arch/arm/mach-u300/timer.h
+++ /dev/null
@@ -1,2 +0,0 @@
-extern void u300_timer_init(void);
-
diff --git a/arch/arm/mach-u300/u300-gpio.h b/arch/arm/mach-u300/u300-gpio.h
deleted file mode 100644
index 83f5077..0000000
--- a/arch/arm/mach-u300/u300-gpio.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * Individual pin assignments for the B335/S335.
- * Notice that the actual usage of these pins depends on the
- * PAD MUX settings, that is why the same number can potentially
- * appear several times. In the reference design each pin is only
- * used for one purpose. These were determined by inspecting the
- * S365 schematic.
- */
-#define U300_GPIO_PIN_UART_RX		0
-#define U300_GPIO_PIN_UART_TX		1
-#define U300_GPIO_PIN_UART_CTS		2
-#define U300_GPIO_PIN_UART_RTS		3
-#define U300_GPIO_PIN_CAM_MAIN_STANDBY	4 /* Camera MAIN standby */
-#define U300_GPIO_PIN_GPIO05		5 /* Unrouted */
-#define U300_GPIO_PIN_MS_CD		6 /* Memory Stick Card insertion */
-#define U300_GPIO_PIN_GPIO07		7 /* Test point TP2430 */
-
-#define U300_GPIO_PIN_GPIO08		8 /* Test point TP2437 */
-#define U300_GPIO_PIN_GPIO09		9 /* Test point TP2431 */
-#define U300_GPIO_PIN_GPIO10		10 /* Test point TP2432 */
-#define U300_GPIO_PIN_MMC_CLKRET	11 /* Clock return from MMC/SD card */
-#define U300_GPIO_PIN_MMC_CD		12 /* MMC Card insertion detection */
-#define U300_GPIO_PIN_CAM_SUB_STANDBY	13 /* Camera SUB standby */
-#define U300_GPIO_PIN_GPIO14		14 /* Test point TP2436 */
-#define U300_GPIO_PIN_GPIO15		15 /* Unrouted */
-
-#define U300_GPIO_PIN_GPIO16		16 /* Test point TP2438 */
-#define U300_GPIO_PIN_PHFSENSE		17 /* Headphone jack sensing */
-#define U300_GPIO_PIN_GPIO18		18 /* Test point TP2439 */
-#define U300_GPIO_PIN_GPIO19		19 /* Routed somewhere */
-#define U300_GPIO_PIN_GPIO20		20 /* Unrouted */
-#define U300_GPIO_PIN_GPIO21		21 /* Unrouted */
-#define U300_GPIO_PIN_GPIO22		22 /* Unrouted */
-#define U300_GPIO_PIN_GPIO23		23 /* Unrouted */
-
-#define U300_GPIO_PIN_GPIO24		24 /* Unrouted */
-#define U300_GPIO_PIN_GPIO25		25 /* Unrouted */
-#define U300_GPIO_PIN_GPIO26		26 /* Unrouted */
-#define U300_GPIO_PIN_GPIO27		27 /* Unrouted */
-#define U300_GPIO_PIN_GPIO28		28 /* Unrouted */
-#define U300_GPIO_PIN_GPIO29		29 /* Unrouted */
-#define U300_GPIO_PIN_GPIO30		30 /* Unrouted */
-#define U300_GPIO_PIN_GPIO31		31 /* Unrouted */
-
-#define U300_GPIO_PIN_GPIO32		32 /* Unrouted */
-#define U300_GPIO_PIN_GPIO33		33 /* Unrouted */
-#define U300_GPIO_PIN_GPIO34		34 /* Unrouted */
-#define U300_GPIO_PIN_GPIO35		35 /* Unrouted */
-#define U300_GPIO_PIN_GPIO36		36 /* Unrouted */
-#define U300_GPIO_PIN_GPIO37		37 /* Unrouted */
-#define U300_GPIO_PIN_GPIO38		38 /* Unrouted */
-#define U300_GPIO_PIN_GPIO39		39 /* Unrouted */
-
-#define U300_GPIO_PIN_GPIO40		40 /* Unrouted */
-#define U300_GPIO_PIN_GPIO41		41 /* Unrouted */
-#define U300_GPIO_PIN_GPIO42		42 /* Unrouted */
-#define U300_GPIO_PIN_GPIO43		43 /* Unrouted */
-#define U300_GPIO_PIN_GPIO44		44 /* Unrouted */
-#define U300_GPIO_PIN_GPIO45		45 /* Unrouted */
-#define U300_GPIO_PIN_GPIO46		46 /* Unrouted */
-#define U300_GPIO_PIN_GPIO47		47 /* Unrouted */
-
-#define U300_GPIO_PIN_GPIO48		48 /* Unrouted */
-#define U300_GPIO_PIN_GPIO49		49 /* Unrouted */
-#define U300_GPIO_PIN_GPIO50		50 /* Unrouted */
-#define U300_GPIO_PIN_GPIO51		51 /* Unrouted */
-#define U300_GPIO_PIN_GPIO52		52 /* Unrouted */
-#define U300_GPIO_PIN_GPIO53		53 /* Unrouted */
-#define U300_GPIO_PIN_GPIO54		54 /* Unrouted */
-#define U300_GPIO_PIN_GPIO55		55 /* Unrouted */
-- 
1.7.11.3
