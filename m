From: robh@kernel.org (Rob Herring)
Date: Tue,  8 Dec 2015 14:44:16 -0600
Subject: [PATCH 2/4] ARM: versatile: switch to DT only booting and remove
 legacy code
In-Reply-To: <1449607458-16850-1-git-send-email-robh@kernel.org>
References: <1449607458-16850-1-git-send-email-robh@kernel.org>
Message-ID: <1449607458-16850-3-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT support for clocks, irqchips, timers, and PCI now in place, DT
based booting has feature parity with non-DT legacy boot. The final
piece is actually enabling common clock support on Versatile. Enabling
full DT support requires either removing the old Versatile clock code,
updating the legacy boot to use the common clock code, or making DT and
legacy boot mutually exclusive. Given that removing legacy boot code is
the goal anyway, I am going with the 1st option.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/Kconfig                                |  13 +-
 arch/arm/mach-versatile/Kconfig                 |  33 --
 arch/arm/mach-versatile/Makefile                |   6 +-
 arch/arm/mach-versatile/core.c                  | 497 +-----------------------
 arch/arm/mach-versatile/core.h                  |   9 +-
 arch/arm/mach-versatile/include/mach/clkdev.h   |  16 -
 arch/arm/mach-versatile/include/mach/hardware.h |   6 -
 arch/arm/mach-versatile/include/mach/irqs.h     | 134 -------
 arch/arm/mach-versatile/include/mach/platform.h | 174 ---------
 arch/arm/mach-versatile/pci.c                   | 368 ------------------
 arch/arm/mach-versatile/versatile_ab.c          |  44 ---
 arch/arm/mach-versatile/versatile_dt.c          |   1 +
 arch/arm/mach-versatile/versatile_pb.c          |  91 -----
 drivers/clk/versatile/Kconfig                   |   4 +-
 14 files changed, 24 insertions(+), 1372 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/Kconfig
 delete mode 100644 arch/arm/mach-versatile/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-versatile/pci.c
 delete mode 100644 arch/arm/mach-versatile/versatile_ab.c
 delete mode 100644 arch/arm/mach-versatile/versatile_pb.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab1cc50..dcbcce0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -368,13 +368,16 @@ config ARCH_VERSATILE
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select ARM_VIC
-	select CLKDEV_LOOKUP
+	select CLKSRC_VERSATILE
+	select COMMON_CLK
+	select COMMON_CLK_VERSATILE
+	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-	select HAVE_MACH_CLKDEV
 	select ICST
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLOCK
-	select PLAT_VERSATILE_SCHED_CLOCK
+	select MIGHT_HAVE_PCI
+	select SPARSE_IRQ
+	select USE_OF
 	select VERSATILE_FPGA_IRQ
 	help
 	  This enables support for ARM Ltd Versatile board.
@@ -926,8 +929,6 @@ source "arch/arm/mach-uniphier/Kconfig"
 
 source "arch/arm/mach-ux500/Kconfig"
 
-source "arch/arm/mach-versatile/Kconfig"
-
 source "arch/arm/mach-vexpress/Kconfig"
 source "arch/arm/plat-versatile/Kconfig"
 
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
deleted file mode 100644
index 1dba368..0000000
--- a/arch/arm/mach-versatile/Kconfig
+++ /dev/null
@@ -1,33 +0,0 @@
-menu "Versatile platform type"
-	depends on ARCH_VERSATILE
-
-config ARCH_VERSATILE_PB
-	bool "Support Versatile Platform Baseboard for ARM926EJ-S"
-	default y
-	select CPU_ARM926T
-	select MIGHT_HAVE_PCI
-	help
-	  Include support for the ARM(R) Versatile Platform Baseboard
-	  for the ARM926EJ-S.
-
-config MACH_VERSATILE_AB
-	bool "Support Versatile Application Baseboard for ARM926EJ-S"
-	select CPU_ARM926T
-	help
-	  Include support for the ARM(R) Versatile Application Baseboard
-	  for the ARM926EJ-S.
-
-config MACH_VERSATILE_DT
-	bool "Support Versatile platform from device tree"
-	select CPU_ARM926T
-	select USE_OF
-	help
-	  Include support for the ARM(R) Versatile/PB platform,
-	  using the device tree for discovery
-
-config MACH_VERSATILE_AUTO
-	def_bool y
-	depends on !ARCH_VERSATILE_PB && !MACH_VERSATILE_AB
-	select MACH_VERSATILE_DT
-
-endmenu
diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index 81fa3fe..ccef512 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -2,8 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= core.o
-obj-$(CONFIG_ARCH_VERSATILE_PB)		+= versatile_pb.o
-obj-$(CONFIG_MACH_VERSATILE_AB)		+= versatile_ab.o
-obj-$(CONFIG_MACH_VERSATILE_DT)		+= versatile_dt.o
-obj-$(CONFIG_PCI)			+= pci.o
+obj-y					:= core.o versatile_dt.o
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 23a04fe..072ae19 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -23,111 +23,22 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/irqdomain.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/platform_data/video-clcd-versatile.h>
-#include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
-#include <linux/amba/pl022.h>
 #include <linux/io.h>
-#include <linux/irqchip/arm-vic.h>
-#include <linux/irqchip/versatile-fpga.h>
-#include <linux/gfp.h>
-#include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
-#include <linux/bitops.h>
 #include <linux/reboot.h>
 
-#include <clocksource/timer-sp804.h>
-
-#include <asm/irq.h>
-#include <asm/hardware/icst.h>
-#include <asm/mach-types.h>
-
 #include <asm/mach/arch.h>
-#include <asm/mach/irq.h>
-#include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 
-#include <plat/sched_clock.h>
-
 #include "core.h"
 
-/*
- * All IO addresses are mapped onto VA 0xFFFx.xxxx, where x.xxxx
- * is the (PA >> 12).
- *
- * Setup a VA for the Versatile Vectored Interrupt Controller.
- */
-#define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
-#define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
-
-/* These PIC IRQs are valid in each configuration */
-#define PIC_VALID_ALL	BIT(SIC_INT_KMI0) | BIT(SIC_INT_KMI1) | \
-			BIT(SIC_INT_SCI3) | BIT(SIC_INT_UART3) | \
-			BIT(SIC_INT_CLCD) | BIT(SIC_INT_TOUCH) | \
-			BIT(SIC_INT_KEYPAD) | BIT(SIC_INT_DoC) | \
-			BIT(SIC_INT_USB) | BIT(SIC_INT_PCI0) | \
-			BIT(SIC_INT_PCI1) | BIT(SIC_INT_PCI2) | \
-			BIT(SIC_INT_PCI3)
-#if 1
-#define IRQ_MMCI0A	IRQ_VICSOURCE22
-#define IRQ_AACI	IRQ_VICSOURCE24
-#define IRQ_ETH		IRQ_VICSOURCE25
-#define PIC_MASK	0xFFD00000
-#define PIC_VALID	PIC_VALID_ALL
-#else
-#define IRQ_MMCI0A	IRQ_SIC_MMCI0A
-#define IRQ_AACI	IRQ_SIC_AACI
-#define IRQ_ETH		IRQ_SIC_ETH
-#define PIC_MASK	0
-#define PIC_VALID	PIC_VALID_ALL | BIT(SIC_INT_MMCI0A) | \
-			BIT(SIC_INT_MMCI1A) | BIT(SIC_INT_AACI) | \
-			BIT(SIC_INT_ETH)
-#endif
-
-/* Lookup table for finding a DT node that represents the vic instance */
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-vic", },
-	{}
-};
-
-static const struct of_device_id sic_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-sic", },
-	{}
-};
-
-void __init versatile_init_irq(void)
-{
-	struct device_node *np;
-
-	np = of_find_matching_node_by_address(NULL, vic_of_match,
-					      VERSATILE_VIC_BASE);
-	__vic_init(VA_VIC_BASE, 0, IRQ_VIC_START, ~0, 0, np);
-
-	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
-
-	np = of_find_matching_node_by_address(NULL, sic_of_match,
-					      VERSATILE_SIC_BASE);
-
-	fpga_irq_init(VA_SIC_BASE, "SIC", IRQ_SIC_START,
-		IRQ_VICSOURCE31, PIC_VALID, np);
-
-	/*
-	 * Interrupts on secondary controller from 0 to 8 are routed to
-	 * source 31 on PIC.
-	 * Interrupts from 21 to 31 are routed directly to the VIC on
-	 * the corresponding number on primary controller. This is controlled
-	 * by setting PIC_ENABLEx.
-	 */
-	writel(PIC_MASK, VA_SIC_BASE + SIC_INT_PIC_ENABLE);
-}
-
 static struct map_desc versatile_io_desc[] __initdata __maybe_unused = {
 	{
 		.virtual	=  IO_ADDRESS(VERSATILE_SYS_BASE),
@@ -135,59 +46,22 @@ static struct map_desc versatile_io_desc[] __initdata __maybe_unused = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	=  IO_ADDRESS(VERSATILE_SIC_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_SIC_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	=  IO_ADDRESS(VERSATILE_VIC_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_VIC_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	=  IO_ADDRESS(VERSATILE_SCTL_BASE),
 		.pfn		= __phys_to_pfn(VERSATILE_SCTL_BASE),
 		.length		= SZ_4K * 9,
 		.type		= MT_DEVICE
 	},
-#ifdef CONFIG_MACH_VERSATILE_AB
  	{
 		.virtual	=  IO_ADDRESS(VERSATILE_IB2_BASE),
 		.pfn		= __phys_to_pfn(VERSATILE_IB2_BASE),
 		.length		= SZ_64M,
 		.type		= MT_DEVICE
 	},
-#endif
-#ifdef CONFIG_DEBUG_LL
- 	{
-		.virtual	=  IO_ADDRESS(VERSATILE_UART0_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_UART0_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	},
-#endif
-#ifdef CONFIG_PCI
- 	{
-		.virtual	=  IO_ADDRESS(VERSATILE_PCI_CORE_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_CORE_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	=  (unsigned long)VERSATILE_PCI_VIRT_BASE,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_BASE),
-		.length		= VERSATILE_PCI_BASE_SIZE,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	=  (unsigned long)VERSATILE_PCI_CFG_VIRT_BASE,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_CFG_BASE),
-		.length		= VERSATILE_PCI_CFG_BASE_SIZE,
-		.type		= MT_DEVICE
-	},
-#endif
 };
 
 void __init versatile_map_io(void)
 {
+	debug_ll_io_init();
 	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
 }
 
@@ -217,7 +91,7 @@ static struct resource versatile_flash_resource = {
 	.flags			= IORESOURCE_MEM,
 };
 
-static struct platform_device versatile_flash_device = {
+struct platform_device versatile_flash_device = {
 	.name			= "physmap-flash",
 	.id			= 0,
 	.dev			= {
@@ -227,52 +101,6 @@ static struct platform_device versatile_flash_device = {
 	.resource		= &versatile_flash_resource,
 };
 
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.start		= VERSATILE_ETH_BASE,
-		.end		= VERSATILE_ETH_BASE + SZ_64K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= IRQ_ETH,
-		.end		= IRQ_ETH,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-
-static struct resource versatile_i2c_resource = {
-	.start			= VERSATILE_I2C_BASE,
-	.end			= VERSATILE_I2C_BASE + SZ_4K - 1,
-	.flags			= IORESOURCE_MEM,
-};
-
-static struct platform_device versatile_i2c_device = {
-	.name			= "versatile-i2c",
-	.id			= 0,
-	.num_resources		= 1,
-	.resource		= &versatile_i2c_resource,
-};
-
-static struct i2c_board_info versatile_i2c_board_info[] = {
-	{
-		I2C_BOARD_INFO("ds1338", 0xd0 >> 1),
-	},
-};
-
-static int __init versatile_i2c_init(void)
-{
-	return i2c_register_board_info(0, versatile_i2c_board_info,
-				       ARRAY_SIZE(versatile_i2c_board_info));
-}
-arch_initcall(versatile_i2c_init);
-
 #define VERSATILE_SYSMCI	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_MCI_OFFSET)
 
 unsigned int mmc_status(struct device *dev)
@@ -295,126 +123,11 @@ static struct mmci_platform_data mmc0_plat_data = {
 	.gpio_cd	= -1,
 };
 
-static struct resource char_lcd_resources[] = {
-	{
-		.start = VERSATILE_CHAR_LCD_BASE,
-		.end   = (VERSATILE_CHAR_LCD_BASE + SZ_4K - 1),
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device char_lcd_device = {
-	.name           =       "arm-charlcd",
-	.id             =       -1,
-	.num_resources  =       ARRAY_SIZE(char_lcd_resources),
-	.resource       =       char_lcd_resources,
-};
-
-static struct resource leds_resources[] = {
-	{
-		.start	= VERSATILE_SYS_BASE + VERSATILE_SYS_LED_OFFSET,
-		.end	= VERSATILE_SYS_BASE + VERSATILE_SYS_LED_OFFSET + 4,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device leds_device = {
-	.name		= "versatile-leds",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(leds_resources),
-	.resource	= leds_resources,
-};
-
-/*
- * Clock handling
- */
-static const struct icst_params versatile_oscvco_params = {
-	.ref		= 24000000,
-	.vco_max	= ICST307_VCO_MAX,
-	.vco_min	= ICST307_VCO_MIN,
-	.vd_min		= 4 + 8,
-	.vd_max		= 511 + 8,
-	.rd_min		= 1 + 2,
-	.rd_max		= 127 + 2,
-	.s2div		= icst307_s2div,
-	.idx2s		= icst307_idx2s,
-};
-
-static void versatile_oscvco_set(struct clk *clk, struct icst_vco vco)
-{
-	void __iomem *sys_lock = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LOCK_OFFSET;
-	u32 val;
-
-	val = readl(clk->vcoreg) & ~0x7ffff;
-	val |= vco.v | (vco.r << 9) | (vco.s << 16);
-
-	writel(0xa05f, sys_lock);
-	writel(val, clk->vcoreg);
-	writel(0, sys_lock);
-}
-
-static const struct clk_ops osc4_clk_ops = {
-	.round	= icst_clk_round,
-	.set	= icst_clk_set,
-	.setvco	= versatile_oscvco_set,
-};
-
-static struct clk osc4_clk = {
-	.ops	= &osc4_clk_ops,
-	.params	= &versatile_oscvco_params,
-};
-
-/*
- * These are fixed clocks.
- */
-static struct clk ref24_clk = {
-	.rate	= 24000000,
-};
-
-static struct clk sp804_clk = {
-	.rate	= 1000000,
-};
-
-static struct clk dummy_apb_pclk;
-
-static struct clk_lookup lookups[] = {
-	{	/* AMBA bus clock */
-		.con_id		= "apb_pclk",
-		.clk		= &dummy_apb_pclk,
-	}, {	/* UART0 */
-		.dev_id		= "dev:f1",
-		.clk		= &ref24_clk,
-	}, {	/* UART1 */
-		.dev_id		= "dev:f2",
-		.clk		= &ref24_clk,
-	}, {	/* UART2 */
-		.dev_id		= "dev:f3",
-		.clk		= &ref24_clk,
-	}, {	/* UART3 */
-		.dev_id		= "fpga:09",
-		.clk		= &ref24_clk,
-	}, {	/* KMI0 */
-		.dev_id		= "fpga:06",
-		.clk		= &ref24_clk,
-	}, {	/* KMI1 */
-		.dev_id		= "fpga:07",
-		.clk		= &ref24_clk,
-	}, {	/* MMC0 */
-		.dev_id		= "fpga:05",
-		.clk		= &ref24_clk,
-	}, {	/* MMC1 */
-		.dev_id		= "fpga:0b",
-		.clk		= &ref24_clk,
-	}, {	/* SSP */
-		.dev_id		= "dev:f4",
-		.clk		= &ref24_clk,
-	}, {	/* CLCD */
-		.dev_id		= "dev:20",
-		.clk		= &osc4_clk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.clk		= &sp804_clk,
-	},
+static struct mmci_platform_data mmc1_plat_data = {
+	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.status		= mmc_status,
+	.gpio_wp	= -1,
+	.gpio_cd	= -1,
 };
 
 /*
@@ -449,11 +162,10 @@ static void versatile_clcd_disable(struct clcd_fb *fb)
 	val &= ~SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
 	writel(val, sys_clcd);
 
-#ifdef CONFIG_MACH_VERSATILE_AB
 	/*
 	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light off
 	 */
-	if (machine_is_versatile_ab() && is_sanyo_2_5_lcd) {
+	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
 		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
 		unsigned long ctrl;
 
@@ -461,7 +173,6 @@ static void versatile_clcd_disable(struct clcd_fb *fb)
 		ctrl &= ~0x01;
 		writel(ctrl, versatile_ib2_ctrl);
 	}
-#endif
 }
 
 /*
@@ -502,11 +213,10 @@ static void versatile_clcd_enable(struct clcd_fb *fb)
 	val |= SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
 	writel(val, sys_clcd);
 
-#ifdef CONFIG_MACH_VERSATILE_AB
 	/*
 	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light on
 	 */
-	if (machine_is_versatile_ab() && is_sanyo_2_5_lcd) {
+	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
 		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
 		unsigned long ctrl;
 
@@ -514,7 +224,6 @@ static void versatile_clcd_enable(struct clcd_fb *fb)
 		ctrl |= 0x01;
 		writel(ctrl, versatile_ib2_ctrl);
 	}
-#endif
 }
 
 /*
@@ -575,113 +284,6 @@ static struct clcd_board clcd_plat_data = {
 	.remove		= versatile_clcd_remove_dma,
 };
 
-static struct pl061_platform_data gpio0_plat_data = {
-	.gpio_base	= 0,
-	.irq_base	= IRQ_GPIO0_START,
-};
-
-static struct pl061_platform_data gpio1_plat_data = {
-	.gpio_base	= 8,
-	.irq_base	= IRQ_GPIO1_START,
-};
-
-static struct pl061_platform_data gpio2_plat_data = {
-	.gpio_base	= 16,
-	.irq_base	= IRQ_GPIO2_START,
-};
-
-static struct pl061_platform_data gpio3_plat_data = {
-	.gpio_base	= 24,
-	.irq_base	= IRQ_GPIO3_START,
-};
-
-static struct pl022_ssp_controller ssp0_plat_data = {
-	.bus_id = 0,
-	.enable_dma = 0,
-	.num_chipselect = 1,
-};
-
-#define AACI_IRQ	{ IRQ_AACI }
-#define MMCI0_IRQ	{ IRQ_MMCI0A,IRQ_SIC_MMCI0B }
-#define KMI0_IRQ	{ IRQ_SIC_KMI0 }
-#define KMI1_IRQ	{ IRQ_SIC_KMI1 }
-
-/*
- * These devices are connected directly to the multi-layer AHB switch
- */
-#define SMC_IRQ		{ }
-#define MPMC_IRQ	{ }
-#define CLCD_IRQ	{ IRQ_CLCDINT }
-#define DMAC_IRQ	{ IRQ_DMAINT }
-
-/*
- * These devices are connected via the core APB bridge
- */
-#define SCTL_IRQ	{ }
-#define WATCHDOG_IRQ	{ IRQ_WDOGINT }
-#define GPIO0_IRQ	{ IRQ_GPIOINT0 }
-#define GPIO1_IRQ	{ IRQ_GPIOINT1 }
-#define GPIO2_IRQ	{ IRQ_GPIOINT2 }
-#define GPIO3_IRQ	{ IRQ_GPIOINT3 }
-#define RTC_IRQ		{ IRQ_RTCINT }
-
-/*
- * These devices are connected via the DMA APB bridge
- */
-#define SCI_IRQ		{ IRQ_SCIINT }
-#define UART0_IRQ	{ IRQ_UARTINT0 }
-#define UART1_IRQ	{ IRQ_UARTINT1 }
-#define UART2_IRQ	{ IRQ_UARTINT2 }
-#define SSP_IRQ		{ IRQ_SSPINT }
-
-/* FPGA Primecells */
-APB_DEVICE(aaci,  "fpga:04", AACI,     NULL);
-APB_DEVICE(mmc0,  "fpga:05", MMCI0,    &mmc0_plat_data);
-APB_DEVICE(kmi0,  "fpga:06", KMI0,     NULL);
-APB_DEVICE(kmi1,  "fpga:07", KMI1,     NULL);
-
-/* DevChip Primecells */
-AHB_DEVICE(smc,   "dev:00",  SMC,      NULL);
-AHB_DEVICE(mpmc,  "dev:10",  MPMC,     NULL);
-AHB_DEVICE(clcd,  "dev:20",  CLCD,     &clcd_plat_data);
-AHB_DEVICE(dmac,  "dev:30",  DMAC,     NULL);
-APB_DEVICE(sctl,  "dev:e0",  SCTL,     NULL);
-APB_DEVICE(wdog,  "dev:e1",  WATCHDOG, NULL);
-APB_DEVICE(gpio0, "dev:e4",  GPIO0,    &gpio0_plat_data);
-APB_DEVICE(gpio1, "dev:e5",  GPIO1,    &gpio1_plat_data);
-APB_DEVICE(gpio2, "dev:e6",  GPIO2,    &gpio2_plat_data);
-APB_DEVICE(gpio3, "dev:e7",  GPIO3,    &gpio3_plat_data);
-APB_DEVICE(rtc,   "dev:e8",  RTC,      NULL);
-APB_DEVICE(sci0,  "dev:f0",  SCI,      NULL);
-APB_DEVICE(uart0, "dev:f1",  UART0,    NULL);
-APB_DEVICE(uart1, "dev:f2",  UART1,    NULL);
-APB_DEVICE(uart2, "dev:f3",  UART2,    NULL);
-APB_DEVICE(ssp0,  "dev:f4",  SSP,      &ssp0_plat_data);
-
-static struct amba_device *amba_devs[] __initdata = {
-	&dmac_device,
-	&uart0_device,
-	&uart1_device,
-	&uart2_device,
-	&smc_device,
-	&mpmc_device,
-	&clcd_device,
-	&sctl_device,
-	&wdog_device,
-	&gpio0_device,
-	&gpio1_device,
-	&gpio2_device,
-	&gpio3_device,
-	&rtc_device,
-	&sci0_device,
-	&ssp0_device,
-	&aaci_device,
-	&mmc0_device,
-	&kmi0_device,
-	&kmi1_device,
-};
-
-#ifdef CONFIG_OF
 /*
  * Lookup table for attaching a specific name and platform_data pointer to
  * devices as they get created by of_platform_populate().  Ideally this table
@@ -690,43 +292,12 @@ static struct amba_device *amba_devs[] __initdata = {
  */
 struct of_dev_auxdata versatile_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI0_BASE, "fpga:05", &mmc0_plat_data),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_KMI0_BASE, "fpga:06", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_KMI1_BASE, "fpga:07", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART3_BASE, "fpga:09", NULL),
-	/* FIXME: this is buggy, the platform data is needed for this MMC instance too */
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI1_BASE, "fpga:0b", NULL),
+	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI1_BASE, "fpga:0b", &mmc1_plat_data),
 
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_CLCD_BASE, "dev:20", &clcd_plat_data),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART0_BASE, "dev:f1", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART1_BASE, "dev:f2", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_UART2_BASE, "dev:f3", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_SSP_BASE, "dev:f4", &ssp0_plat_data),
 
-#if 0
-	/*
-	 * These entries are unnecessary because no clocks referencing
-	 * them.  I've left them in for now as place holders in case
-	 * any of them need to be added back, but they should be
-	 * removed before actually committing this patch.  --gcl
-	 */
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_AACI_BASE, "fpga:04", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_SCI1_BASE, "fpga:0a", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_SMC_BASE, "dev:00", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MPMC_BASE, "dev:10", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_DMAC_BASE, "dev:30", NULL),
-
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_SCTL_BASE, "dev:e0", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_WATCHDOG_BASE, "dev:e1", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_GPIO0_BASE, "dev:e4", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_GPIO1_BASE, "dev:e5", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_GPIO2_BASE, "dev:e6", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_GPIO3_BASE, "dev:e7", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_RTC_BASE, "dev:e8", NULL),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_SCI_BASE, "dev:f0", NULL),
-#endif
 	{}
 };
-#endif
 
 void versatile_restart(enum reboot_mode mode, const char *cmd)
 {
@@ -745,12 +316,6 @@ void versatile_restart(enum reboot_mode mode, const char *cmd)
 void __init versatile_init_early(void)
 {
 	u32 val;
-	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
-
-	osc4_clk.vcoreg	= sys + VERSATILE_SYS_OSCCLCD_OFFSET;
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	versatile_sched_clock_init(sys + VERSATILE_SYS_24MHz_OFFSET, 24000000);
 
 	/*
 	 * set clock frequency:
@@ -764,45 +329,3 @@ void __init versatile_init_early(void)
 	       (VERSATILE_TIMCLK << VERSATILE_TIMER4_EnSel) | val,
 	       __io_address(VERSATILE_SCTL_BASE));
 }
-
-void __init versatile_init(void)
-{
-	int i;
-
-	platform_device_register(&versatile_flash_device);
-	platform_device_register(&versatile_i2c_device);
-	platform_device_register(&smc91x_device);
-	platform_device_register(&char_lcd_device);
-	platform_device_register(&leds_device);
-
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-}
-
-/*
- * Where is the timer (VA)?
- */
-#define TIMER0_VA_BASE		 __io_address(VERSATILE_TIMER0_1_BASE)
-#define TIMER1_VA_BASE		(__io_address(VERSATILE_TIMER0_1_BASE) + 0x20)
-#define TIMER2_VA_BASE		 __io_address(VERSATILE_TIMER2_3_BASE)
-#define TIMER3_VA_BASE		(__io_address(VERSATILE_TIMER2_3_BASE) + 0x20)
-
-/*
- * Set up timer interrupt, and return the current time in seconds.
- */
-void __init versatile_timer_init(void)
-{
-
-	/*
-	 * Initialise to a known state (all timers off)
-	 */
-	sp804_timer_disable(TIMER0_VA_BASE);
-	sp804_timer_disable(TIMER1_VA_BASE);
-	sp804_timer_disable(TIMER2_VA_BASE);
-	sp804_timer_disable(TIMER3_VA_BASE);
-
-	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
-	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, "timer0");
-}
diff --git a/arch/arm/mach-versatile/core.h b/arch/arm/mach-versatile/core.h
index f06d576..c3d7157 100644
--- a/arch/arm/mach-versatile/core.h
+++ b/arch/arm/mach-versatile/core.h
@@ -26,7 +26,8 @@
 #include <linux/of_platform.h>
 #include <linux/reboot.h>
 
-extern void __init versatile_init(void);
+extern struct platform_device versatile_flash_device;
+
 extern void __init versatile_init_early(void);
 extern void __init versatile_init_irq(void);
 extern void __init versatile_map_io(void);
@@ -37,10 +38,4 @@ extern unsigned int mmc_status(struct device *dev);
 extern struct of_dev_auxdata versatile_auxdata_lookup[];
 #endif
 
-#define APB_DEVICE(name, busid, base, plat)	\
-static AMBA_APB_DEVICE(name, busid, 0, VERSATILE_##base##_BASE, base##_IRQ, plat)
-
-#define AHB_DEVICE(name, busid, base, plat)	\
-static AMBA_AHB_DEVICE(name, busid, 0, VERSATILE_##base##_BASE, base##_IRQ, plat)
-
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/clkdev.h b/arch/arm/mach-versatile/include/mach/clkdev.h
deleted file mode 100644
index e58d077..0000000
--- a/arch/arm/mach-versatile/include/mach/clkdev.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#include <plat/clock.h>
-
-struct clk {
-	unsigned long		rate;
-	const struct clk_ops	*ops;
-	const struct icst_params *params;
-	void __iomem		*vcoreg;
-};
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index 3e5d425..22a1158 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -24,12 +24,6 @@
 
 #include <asm/sizes.h>
 
-/*
- * PCI space virtual addresses
- */
-#define VERSATILE_PCI_VIRT_BASE		(void __iomem *)0xe8000000ul
-#define VERSATILE_PCI_CFG_VIRT_BASE	(void __iomem *)0xe9000000ul
-
 /* macro to get at MMIO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
 
diff --git a/arch/arm/mach-versatile/include/mach/irqs.h b/arch/arm/mach-versatile/include/mach/irqs.h
deleted file mode 100644
index 0fd771c..0000000
--- a/arch/arm/mach-versatile/include/mach/irqs.h
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/irqs.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <mach/platform.h>
-
-/* 
- *  IRQ interrupts definitions are the same as the INT definitions
- *  held within platform.h
- */
-#define IRQ_VIC_START		32
-#define IRQ_WDOGINT		(IRQ_VIC_START + INT_WDOGINT)
-#define IRQ_SOFTINT		(IRQ_VIC_START + INT_SOFTINT)
-#define IRQ_COMMRx		(IRQ_VIC_START + INT_COMMRx)
-#define IRQ_COMMTx		(IRQ_VIC_START + INT_COMMTx)
-#define IRQ_TIMERINT0_1		(IRQ_VIC_START + INT_TIMERINT0_1)
-#define IRQ_TIMERINT2_3		(IRQ_VIC_START + INT_TIMERINT2_3)
-#define IRQ_GPIOINT0		(IRQ_VIC_START + INT_GPIOINT0)
-#define IRQ_GPIOINT1		(IRQ_VIC_START + INT_GPIOINT1)
-#define IRQ_GPIOINT2		(IRQ_VIC_START + INT_GPIOINT2)
-#define IRQ_GPIOINT3		(IRQ_VIC_START + INT_GPIOINT3)
-#define IRQ_RTCINT		(IRQ_VIC_START + INT_RTCINT)
-#define IRQ_SSPINT		(IRQ_VIC_START + INT_SSPINT)
-#define IRQ_UARTINT0		(IRQ_VIC_START + INT_UARTINT0)
-#define IRQ_UARTINT1		(IRQ_VIC_START + INT_UARTINT1)
-#define IRQ_UARTINT2		(IRQ_VIC_START + INT_UARTINT2)
-#define IRQ_SCIINT		(IRQ_VIC_START + INT_SCIINT)
-#define IRQ_CLCDINT		(IRQ_VIC_START + INT_CLCDINT)
-#define IRQ_DMAINT		(IRQ_VIC_START + INT_DMAINT)
-#define IRQ_PWRFAILINT 		(IRQ_VIC_START + INT_PWRFAILINT)
-#define IRQ_MBXINT		(IRQ_VIC_START + INT_MBXINT)
-#define IRQ_GNDINT		(IRQ_VIC_START + INT_GNDINT)
-#define IRQ_VICSOURCE21		(IRQ_VIC_START + INT_VICSOURCE21)
-#define IRQ_VICSOURCE22		(IRQ_VIC_START + INT_VICSOURCE22)
-#define IRQ_VICSOURCE23		(IRQ_VIC_START + INT_VICSOURCE23)
-#define IRQ_VICSOURCE24		(IRQ_VIC_START + INT_VICSOURCE24)
-#define IRQ_VICSOURCE25		(IRQ_VIC_START + INT_VICSOURCE25)
-#define IRQ_VICSOURCE26		(IRQ_VIC_START + INT_VICSOURCE26)
-#define IRQ_VICSOURCE27		(IRQ_VIC_START + INT_VICSOURCE27)
-#define IRQ_VICSOURCE28		(IRQ_VIC_START + INT_VICSOURCE28)
-#define IRQ_VICSOURCE29		(IRQ_VIC_START + INT_VICSOURCE29)
-#define IRQ_VICSOURCE30		(IRQ_VIC_START + INT_VICSOURCE30)
-#define IRQ_VICSOURCE31		(IRQ_VIC_START + INT_VICSOURCE31)
-#define IRQ_VIC_END		(IRQ_VIC_START + 31)
-
-/* 
- *  FIQ interrupts definitions are the same as the INT definitions.
- */
-#define FIQ_WDOGINT		INT_WDOGINT
-#define FIQ_SOFTINT		INT_SOFTINT
-#define FIQ_COMMRx		INT_COMMRx
-#define FIQ_COMMTx		INT_COMMTx
-#define FIQ_TIMERINT0_1		INT_TIMERINT0_1
-#define FIQ_TIMERINT2_3		INT_TIMERINT2_3
-#define FIQ_GPIOINT0		INT_GPIOINT0
-#define FIQ_GPIOINT1		INT_GPIOINT1
-#define FIQ_GPIOINT2		INT_GPIOINT2
-#define FIQ_GPIOINT3		INT_GPIOINT3
-#define FIQ_RTCINT		INT_RTCINT
-#define FIQ_SSPINT		INT_SSPINT
-#define FIQ_UARTINT0		INT_UARTINT0
-#define FIQ_UARTINT1		INT_UARTINT1
-#define FIQ_UARTINT2		INT_UARTINT2
-#define FIQ_SCIINT		INT_SCIINT
-#define FIQ_CLCDINT		INT_CLCDINT
-#define FIQ_DMAINT		INT_DMAINT
-#define FIQ_PWRFAILINT 		INT_PWRFAILINT
-#define FIQ_MBXINT		INT_MBXINT
-#define FIQ_GNDINT		INT_GNDINT
-#define FIQ_VICSOURCE21		INT_VICSOURCE21
-#define FIQ_VICSOURCE22		INT_VICSOURCE22
-#define FIQ_VICSOURCE23		INT_VICSOURCE23
-#define FIQ_VICSOURCE24		INT_VICSOURCE24
-#define FIQ_VICSOURCE25		INT_VICSOURCE25
-#define FIQ_VICSOURCE26		INT_VICSOURCE26
-#define FIQ_VICSOURCE27		INT_VICSOURCE27
-#define FIQ_VICSOURCE28		INT_VICSOURCE28
-#define FIQ_VICSOURCE29		INT_VICSOURCE29
-#define FIQ_VICSOURCE30		INT_VICSOURCE30
-#define FIQ_VICSOURCE31		INT_VICSOURCE31
-
-
-/*
- * Secondary interrupt controller
- */
-#define IRQ_SIC_START		64
-#define IRQ_SIC_MMCI0B 		(IRQ_SIC_START + SIC_INT_MMCI0B)
-#define IRQ_SIC_MMCI1B 		(IRQ_SIC_START + SIC_INT_MMCI1B)
-#define IRQ_SIC_KMI0		(IRQ_SIC_START + SIC_INT_KMI0)
-#define IRQ_SIC_KMI1		(IRQ_SIC_START + SIC_INT_KMI1)
-#define IRQ_SIC_SCI3		(IRQ_SIC_START + SIC_INT_SCI3)
-#define IRQ_SIC_UART3		(IRQ_SIC_START + SIC_INT_UART3)
-#define IRQ_SIC_CLCD		(IRQ_SIC_START + SIC_INT_CLCD)
-#define IRQ_SIC_TOUCH		(IRQ_SIC_START + SIC_INT_TOUCH)
-#define IRQ_SIC_KEYPAD 		(IRQ_SIC_START + SIC_INT_KEYPAD)
-#define IRQ_SIC_DoC		(IRQ_SIC_START + SIC_INT_DoC)
-#define IRQ_SIC_MMCI0A 		(IRQ_SIC_START + SIC_INT_MMCI0A)
-#define IRQ_SIC_MMCI1A 		(IRQ_SIC_START + SIC_INT_MMCI1A)
-#define IRQ_SIC_AACI		(IRQ_SIC_START + SIC_INT_AACI)
-#define IRQ_SIC_ETH		(IRQ_SIC_START + SIC_INT_ETH)
-#define IRQ_SIC_USB		(IRQ_SIC_START + SIC_INT_USB)
-#define IRQ_SIC_PCI0		(IRQ_SIC_START + SIC_INT_PCI0)
-#define IRQ_SIC_PCI1		(IRQ_SIC_START + SIC_INT_PCI1)
-#define IRQ_SIC_PCI2		(IRQ_SIC_START + SIC_INT_PCI2)
-#define IRQ_SIC_PCI3		(IRQ_SIC_START + SIC_INT_PCI3)
-#define IRQ_SIC_END		95
-
-#define IRQ_GPIO0_START		(IRQ_SIC_END + 1)
-#define IRQ_GPIO0_END		(IRQ_GPIO0_START + 31)
-#define IRQ_GPIO1_START		(IRQ_GPIO0_END + 1)
-#define IRQ_GPIO1_END		(IRQ_GPIO1_START + 31)
-#define IRQ_GPIO2_START		(IRQ_GPIO1_END + 1)
-#define IRQ_GPIO2_END		(IRQ_GPIO2_START + 31)
-#define IRQ_GPIO3_START		(IRQ_GPIO2_END + 1)
-#define IRQ_GPIO3_END		(IRQ_GPIO3_START + 31)
-
-#define NR_IRQS			(IRQ_GPIO3_END + 1)
diff --git a/arch/arm/mach-versatile/include/mach/platform.h b/arch/arm/mach-versatile/include/mach/platform.h
index 6f938cc..7fe008b 100644
--- a/arch/arm/mach-versatile/include/mach/platform.h
+++ b/arch/arm/mach-versatile/include/mach/platform.h
@@ -185,79 +185,13 @@
 /*
  * VERSATILE peripheral addresses
  */
-#define VERSATILE_PCI_CORE_BASE        0x10001000	/* PCI core control */
-#define VERSATILE_I2C_BASE             0x10002000	/* I2C control */
-#define VERSATILE_SIC_BASE             0x10003000	/* Secondary interrupt controller */
-#define VERSATILE_AACI_BASE            0x10004000	/* Audio */
 #define VERSATILE_MMCI0_BASE           0x10005000	/* MMC interface */
-#define VERSATILE_KMI0_BASE            0x10006000	/* KMI interface */
-#define VERSATILE_KMI1_BASE            0x10007000	/* KMI 2nd interface */
-#define VERSATILE_CHAR_LCD_BASE        0x10008000	/* Character LCD */
-#define VERSATILE_UART3_BASE           0x10009000	/* UART 3 */
-#define VERSATILE_SCI1_BASE            0x1000A000
 #define VERSATILE_MMCI1_BASE           0x1000B000    /* MMC Interface */
-	/* 0x1000C000 - 0x1000CFFF = reserved */
-#define VERSATILE_ETH_BASE             0x10010000	/* Ethernet */
-#define VERSATILE_USB_BASE             0x10020000	/* USB */
-	/* 0x10030000 - 0x100FFFFF = reserved */
-#define VERSATILE_SMC_BASE             0x10100000	/* SMC */
-#define VERSATILE_MPMC_BASE            0x10110000	/* MPMC */
 #define VERSATILE_CLCD_BASE            0x10120000	/* CLCD */
-#define VERSATILE_DMAC_BASE            0x10130000	/* DMA controller */
-#define VERSATILE_VIC_BASE             0x10140000	/* Vectored interrupt controller */
-#define VERSATILE_PERIPH_BASE          0x10150000	/* off-chip peripherals alias from */
-                                                /* 0x10000000 - 0x100FFFFF */
-#define VERSATILE_AHBM_BASE            0x101D0000	/* AHB monitor */
 #define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
-#define VERSATILE_WATCHDOG_BASE        0x101E1000	/* Watchdog */
-#define VERSATILE_TIMER0_1_BASE        0x101E2000	/* Timer 0 and 1 */
-#define VERSATILE_TIMER2_3_BASE        0x101E3000	/* Timer 2 and 3 */
-#define VERSATILE_GPIO0_BASE           0x101E4000	/* GPIO port 0 */
-#define VERSATILE_GPIO1_BASE           0x101E5000	/* GPIO port 1 */
-#define VERSATILE_GPIO2_BASE           0x101E6000	/* GPIO port 2 */
-#define VERSATILE_GPIO3_BASE           0x101E7000	/* GPIO port 3 */
-#define VERSATILE_RTC_BASE             0x101E8000	/* Real Time Clock */
-	/* 0x101E9000 - reserved */
-#define VERSATILE_SCI_BASE             0x101F0000	/* Smart card controller */
-#define VERSATILE_UART0_BASE           0x101F1000	/* Uart 0 */
-#define VERSATILE_UART1_BASE           0x101F2000	/* Uart 1 */
-#define VERSATILE_UART2_BASE           0x101F3000	/* Uart 2 */
-#define VERSATILE_SSP_BASE             0x101F4000	/* Synchronous Serial Port */
-
-#define VERSATILE_SSMC_BASE            0x20000000	/* SSMC */
 #define VERSATILE_IB2_BASE             0x24000000	/* IB2 module */
-#define VERSATILE_MBX_BASE             0x40000000	/* MBX */
-
-/* PCI space */
-#define VERSATILE_PCI_BASE             0x41000000	/* PCI Interface */
-#define VERSATILE_PCI_CFG_BASE	       0x42000000
-#define VERSATILE_PCI_IO_BASE          0x43000000
-#define VERSATILE_PCI_MEM_BASE0        0x44000000
-#define VERSATILE_PCI_MEM_BASE1        0x50000000
-#define VERSATILE_PCI_MEM_BASE2        0x60000000
-/* Sizes of above maps */
-#define VERSATILE_PCI_BASE_SIZE	       0x01000000
-#define VERSATILE_PCI_CFG_BASE_SIZE    0x02000000
-#define VERSATILE_PCI_IO_BASE_SIZE     0x01000000
-#define VERSATILE_PCI_MEM_BASE0_SIZE   0x0c000000	/* 32Mb */
-#define VERSATILE_PCI_MEM_BASE1_SIZE   0x10000000	/* 256Mb */
-#define VERSATILE_PCI_MEM_BASE2_SIZE   0x10000000	/* 256Mb */
-
-#define VERSATILE_SDRAM67_BASE         0x70000000	/* SDRAM banks 6 and 7 */
-#define VERSATILE_LT_BASE              0x80000000	/* Logic Tile expansion */
 
 /*
- * Disk on Chip
- */
-#define VERSATILE_DOC_BASE             0x2C000000
-#define VERSATILE_DOC_SIZE             (16 << 20)
-#define VERSATILE_DOC_PAGE_SIZE        512
-#define VERSATILE_DOC_TOTAL_PAGES     (DOC_SIZE / PAGE_SIZE)
-
-#define ERASE_UNIT_PAGES    32
-#define START_PAGE          0x80
-
-/* 
  *  LED settings, bits [7:0]
  */
 #define VERSATILE_SYS_LED0             (1 << 0)
@@ -281,106 +215,6 @@
 #define VERSATILE_INTREG_OFFSET		0x8	/* Interrupt control */
 #define VERSATILE_DECODE_OFFSET		0xC	/* Fitted logic modules */
 
-
-/* ------------------------------------------------------------------------
- *  Versatile Interrupt Controller - control registers
- * ------------------------------------------------------------------------
- * 
- *  Offsets from interrupt controller base 
- * 
- *  System Controller interrupt controller base is
- * 
- * 	VERSATILE_IC_BASE
- * 
- *  Core Module interrupt controller base is
- * 
- * 	VERSATILE_SYS_IC 
- * 
- */
-/* VIC definitions in include/asm-arm/hardware/vic.h */
-
-#define SIC_IRQ_STATUS                  0
-#define SIC_IRQ_RAW_STATUS              0x04
-#define SIC_IRQ_ENABLE                  0x08
-#define SIC_IRQ_ENABLE_SET              0x08
-#define SIC_IRQ_ENABLE_CLEAR            0x0C
-#define SIC_INT_SOFT_SET                0x10
-#define SIC_INT_SOFT_CLEAR              0x14
-#define SIC_INT_PIC_ENABLE              0x20	/* read status of pass through mask */
-#define SIC_INT_PIC_ENABLES             0x20	/* set interrupt pass through bits */
-#define SIC_INT_PIC_ENABLEC             0x24	/* Clear interrupt pass through bits */
-
-/* ------------------------------------------------------------------------
- *  Interrupts - bit assignment (primary)
- * ------------------------------------------------------------------------
- */
-
-#define INT_WDOGINT                     0	/* Watchdog timer */
-#define INT_SOFTINT                     1	/* Software interrupt */
-#define INT_COMMRx                      2	/* Debug Comm Rx interrupt */
-#define INT_COMMTx                      3	/* Debug Comm Tx interrupt */
-#define INT_TIMERINT0_1                 4	/* Timer 0 and 1 */
-#define INT_TIMERINT2_3                 5	/* Timer 2 and 3 */
-#define INT_GPIOINT0                    6	/* GPIO 0 */
-#define INT_GPIOINT1                    7	/* GPIO 1 */
-#define INT_GPIOINT2                    8	/* GPIO 2 */
-#define INT_GPIOINT3                    9	/* GPIO 3 */
-#define INT_RTCINT                      10	/* Real Time Clock */
-#define INT_SSPINT                      11	/* Synchronous Serial Port */
-#define INT_UARTINT0                    12	/* UART 0 on development chip */
-#define INT_UARTINT1                    13	/* UART 1 on development chip */
-#define INT_UARTINT2                    14	/* UART 2 on development chip */
-#define INT_SCIINT                      15	/* Smart Card Interface */
-#define INT_CLCDINT                     16	/* CLCD controller */
-#define INT_DMAINT                      17	/* DMA controller */
-#define INT_PWRFAILINT                  18	/* Power failure */
-#define INT_MBXINT                      19	/* Graphics processor */
-#define INT_GNDINT                      20	/* Reserved */
-	/* External interrupt signals from logic tiles or secondary controller */
-#define INT_VICSOURCE21                 21	/* Disk on Chip */
-#define INT_VICSOURCE22                 22	/* MCI0A */
-#define INT_VICSOURCE23                 23	/* MCI1A */
-#define INT_VICSOURCE24                 24	/* AACI */
-#define INT_VICSOURCE25                 25	/* Ethernet */
-#define INT_VICSOURCE26                 26	/* USB */
-#define INT_VICSOURCE27                 27	/* PCI 0 */
-#define INT_VICSOURCE28                 28	/* PCI 1 */
-#define INT_VICSOURCE29                 29	/* PCI 2 */
-#define INT_VICSOURCE30                 30	/* PCI 3 */
-#define INT_VICSOURCE31                 31	/* SIC source */
-
-#define VERSATILE_SC_VALID_INT               0x003FFFFF
-
-#define MAXIRQNUM                       31
-#define MAXFIQNUM                       31
-#define MAXSWINUM                       31
-
-/* ------------------------------------------------------------------------
- *  Interrupts - bit assignment (secondary)
- * ------------------------------------------------------------------------
- */
-#define SIC_INT_MMCI0B                  1	/* Multimedia Card 0B */
-#define SIC_INT_MMCI1B                  2	/* Multimedia Card 1B */
-#define SIC_INT_KMI0                    3	/* Keyboard/Mouse port 0 */
-#define SIC_INT_KMI1                    4	/* Keyboard/Mouse port 1 */
-#define SIC_INT_SCI3                    5	/* Smart Card interface */
-#define SIC_INT_UART3                   6	/* UART 3 empty or data available */
-#define SIC_INT_CLCD                    7	/* Character LCD */
-#define SIC_INT_TOUCH                   8	/* Touchscreen */
-#define SIC_INT_KEYPAD                  9	/* Key pressed on display keypad */
-	/* 10:20 - reserved */
-#define SIC_INT_DoC                     21	/* Disk on Chip memory controller */
-#define SIC_INT_MMCI0A                  22	/* MMC 0A */
-#define SIC_INT_MMCI1A                  23	/* MMC 1A */
-#define SIC_INT_AACI                    24	/* Audio Codec */
-#define SIC_INT_ETH                     25	/* Ethernet controller */
-#define SIC_INT_USB                     26	/* USB controller */
-#define SIC_INT_PCI0                    27
-#define SIC_INT_PCI1                    28
-#define SIC_INT_PCI2                    29
-#define SIC_INT_PCI3                    30
-
-
 /*
  * System controller bit assignment
  */
@@ -393,16 +227,9 @@
 #define VERSATILE_TIMER4_EnSel	21
 
 
-#define VERSATILE_CSR_BASE             0x10000000
-#define VERSATILE_CSR_SIZE             0x10000000
-
-#ifdef CONFIG_MACH_VERSATILE_AB
 /*
  * IB2 Versatile/AB expansion board definitions
  */
-#define VERSATILE_IB2_CAMERA_BANK	VERSATILE_IB2_BASE
-#define VERSATILE_IB2_KBD_DATAREG	(VERSATILE_IB2_BASE + 0x01000000)
-
 /* VICINTSOURCE27 */
 #define VERSATILE_IB2_INT_BASE		(VERSATILE_IB2_BASE + 0x02000000)
 #define VERSATILE_IB2_IER		(VERSATILE_IB2_INT_BASE + 0)
@@ -411,6 +238,5 @@
 #define VERSATILE_IB2_CTL_BASE		(VERSATILE_IB2_BASE + 0x03000000)
 #define VERSATILE_IB2_CTRL		(VERSATILE_IB2_CTL_BASE + 0)
 #define VERSATILE_IB2_STAT		(VERSATILE_IB2_CTL_BASE + 4)
-#endif
 
 #endif
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
deleted file mode 100644
index c97be4e..0000000
--- a/arch/arm/mach-versatile/pci.c
+++ /dev/null
@@ -1,368 +0,0 @@
-/*
- *  linux/arch/arm/mach-versatile/pci.c
- *
- * (C) Copyright Koninklijke Philips Electronics NV 2004. All rights reserved.
- * You can redistribute and/or modify this software under the terms of version 2
- * of the GNU General Public License as published by the Free Software Foundation.
- * THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
- * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- * Koninklijke Philips Electronics nor its subsidiaries is obligated to provide any support for this software.
- *
- * ARM Versatile PCI driver.
- *
- * 14/04/2005 Initial version, colin.king@philips.com
- *
- */
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-
-/*
- * these spaces are mapped using the following base registers:
- *
- * Usage Local Bus Memory         Base/Map registers used
- *
- * Mem   50000000 - 5FFFFFFF      LB_BASE0/LB_MAP0,  non prefetch
- * Mem   60000000 - 6FFFFFFF      LB_BASE1/LB_MAP1,  prefetch
- * IO    44000000 - 4FFFFFFF      LB_BASE2/LB_MAP2,  IO
- * Cfg   42000000 - 42FFFFFF	  PCI config
- *
- */
-#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
-#define SYS_PCICTL		__IO_ADDRESS(VERSATILE_SYS_PCICTL)
-#define PCI_IMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x0)
-#define PCI_IMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x4)
-#define PCI_IMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x8)
-#define PCI_SMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x14)
-#define PCI_SMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x18)
-#define PCI_SMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x1c)
-#define PCI_SELFID		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0xc)
-
-#define DEVICE_ID_OFFSET		0x00
-#define CSR_OFFSET			0x04
-#define CLASS_ID_OFFSET			0x08
-
-#define VP_PCI_DEVICE_ID		0x030010ee
-#define VP_PCI_CLASS_ID			0x0b400000
-
-static unsigned long pci_slot_ignore = 0;
-
-static int __init versatile_pci_slot_ignore(char *str)
-{
-	int retval;
-	int slot;
-
-	while ((retval = get_option(&str,&slot))) {
-		if ((slot < 0) || (slot > 31)) {
-			printk("Illegal slot value: %d\n",slot);
-		} else {
-			pci_slot_ignore |= (1 << slot);
-		}
-	}
-	return 1;
-}
-
-__setup("pci_slot_ignore=", versatile_pci_slot_ignore);
-
-
-static void __iomem *__pci_addr(struct pci_bus *bus,
-				unsigned int devfn, int offset)
-{
-	unsigned int busnr = bus->number;
-
-	/*
-	 * Trap out illegal values
-	 */
-	if (offset > 255)
-		BUG();
-	if (busnr > 255)
-		BUG();
-	if (devfn > 255)
-		BUG();
-
-	return VERSATILE_PCI_CFG_VIRT_BASE + ((busnr << 16) |
-		(PCI_SLOT(devfn) << 11) | (PCI_FUNC(devfn) << 8) | offset);
-}
-
-static int versatile_read_config(struct pci_bus *bus, unsigned int devfn, int where,
-				 int size, u32 *val)
-{
-	void __iomem *addr = __pci_addr(bus, devfn, where & ~3);
-	u32 v;
-	int slot = PCI_SLOT(devfn);
-
-	if (pci_slot_ignore & (1 << slot)) {
-		/* Ignore this slot */
-		switch (size) {
-		case 1:
-			v = 0xff;
-			break;
-		case 2:
-			v = 0xffff;
-			break;
-		default:
-			v = 0xffffffff;
-		}
-	} else {
-		switch (size) {
-		case 1:
-			v = __raw_readl(addr);
-			if (where & 2) v >>= 16;
-			if (where & 1) v >>= 8;
- 			v &= 0xff;
-			break;
-
-		case 2:
-			v = __raw_readl(addr);
-			if (where & 2) v >>= 16;
- 			v &= 0xffff;
-			break;
-
-		default:
-			v = __raw_readl(addr);
-			break;
-		}
-	}
-
-	*val = v;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int versatile_write_config(struct pci_bus *bus, unsigned int devfn, int where,
-				  int size, u32 val)
-{
-	void __iomem *addr = __pci_addr(bus, devfn, where);
-	int slot = PCI_SLOT(devfn);
-
-	if (pci_slot_ignore & (1 << slot)) {
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	switch (size) {
-	case 1:
-		__raw_writeb((u8)val, addr);
-		break;
-
-	case 2:
-		__raw_writew((u16)val, addr);
-		break;
-
-	case 4:
-		__raw_writel(val, addr);
-		break;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static struct pci_ops pci_versatile_ops = {
-	.read	= versatile_read_config,
-	.write	= versatile_write_config,
-};
-
-static struct resource unused_mem = {
-	.name	= "PCI unused",
-	.start	= VERSATILE_PCI_MEM_BASE0,
-	.end	= VERSATILE_PCI_MEM_BASE0+VERSATILE_PCI_MEM_BASE0_SIZE-1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct resource non_mem = {
-	.name	= "PCI non-prefetchable",
-	.start	= VERSATILE_PCI_MEM_BASE1,
-	.end	= VERSATILE_PCI_MEM_BASE1+VERSATILE_PCI_MEM_BASE1_SIZE-1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct resource pre_mem = {
-	.name	= "PCI prefetchable",
-	.start	= VERSATILE_PCI_MEM_BASE2,
-	.end	= VERSATILE_PCI_MEM_BASE2+VERSATILE_PCI_MEM_BASE2_SIZE-1,
-	.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
-};
-
-static int __init pci_versatile_setup_resources(struct pci_sys_data *sys)
-{
-	int ret = 0;
-
-	ret = request_resource(&iomem_resource, &unused_mem);
-	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate unused "
-		       "memory region (%d)\n", ret);
-		goto out;
-	}
-	ret = request_resource(&iomem_resource, &non_mem);
-	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate non-prefetchable "
-		       "memory region (%d)\n", ret);
-		goto release_unused_mem;
-	}
-	ret = request_resource(&iomem_resource, &pre_mem);
-	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate prefetchable "
-		       "memory region (%d)\n", ret);
-		goto release_non_mem;
-	}
-
-	/*
-	 * the mem resource for this bus
-	 * the prefetch mem resource for this bus
-	 */
-	pci_add_resource_offset(&sys->resources, &non_mem, sys->mem_offset);
-	pci_add_resource_offset(&sys->resources, &pre_mem, sys->mem_offset);
-
-	goto out;
-
- release_non_mem:
-	release_resource(&non_mem);
- release_unused_mem:
-	release_resource(&unused_mem);
- out:
-	return ret;
-}
-
-int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
-{
-	int ret = 0;
-        int i;
-        int myslot = -1;
-	unsigned long val;
-	void __iomem *local_pci_cfg_base;
-
-	val = __raw_readl(SYS_PCICTL);
-	if (!(val & 1)) {
-		printk("Not plugged into PCI backplane!\n");
-		ret = -EIO;
-		goto out;
-	}
-
-	ret = pci_ioremap_io(0, VERSATILE_PCI_IO_BASE);
-	if (ret)
-		goto out;
-
-	if (nr == 0) {
-		ret = pci_versatile_setup_resources(sys);
-		if (ret < 0) {
-			printk("pci_versatile_setup: resources... oops?\n");
-			goto out;
-		}
-	} else {
-		printk("pci_versatile_setup: resources... nr == 0??\n");
-		goto out;
-	}
-
-	/*
-	 *  We need to discover the PCI core first to configure itself
-	 *  before the main PCI probing is performed
-	 */
-	for (i=0; i<32; i++)
-		if ((__raw_readl(VERSATILE_PCI_VIRT_BASE+(i<<11)+DEVICE_ID_OFFSET) == VP_PCI_DEVICE_ID) &&
-		    (__raw_readl(VERSATILE_PCI_VIRT_BASE+(i<<11)+CLASS_ID_OFFSET) == VP_PCI_CLASS_ID)) {
-			myslot = i;
-			break;
-		}
-
-	if (myslot == -1) {
-		printk("Cannot find PCI core!\n");
-		ret = -EIO;
-		goto out;
-	}
-
-	printk("PCI core found (slot %d)\n",myslot);
-
-	__raw_writel(myslot, PCI_SELFID);
-	local_pci_cfg_base = VERSATILE_PCI_CFG_VIRT_BASE + (myslot << 11);
-
-	val = __raw_readl(local_pci_cfg_base + CSR_OFFSET);
-	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
-	__raw_writel(val, local_pci_cfg_base + CSR_OFFSET);
-
-	/*
-	 * Configure the PCI inbound memory windows to be 1:1 mapped to SDRAM
-	 */
-	__raw_writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_0);
-	__raw_writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_1);
-	__raw_writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_2);
-
-	/*
-	 * For many years the kernel and QEMU were symbiotically buggy
-	 * in that they both assumed the same broken IRQ mapping.
-	 * QEMU therefore attempts to auto-detect old broken kernels
-	 * so that they still work on newer QEMU as they did on old
-	 * QEMU. Since we now use the correct (ie matching-hardware)
-	 * IRQ mapping we write a definitely different value to a
-	 * PCI_INTERRUPT_LINE register to tell QEMU that we expect
-	 * real hardware behaviour and it need not be backwards
-	 * compatible for us. This write is harmless on real hardware.
-	 */
-	__raw_writel(0, VERSATILE_PCI_VIRT_BASE+PCI_INTERRUPT_LINE);
-
-	/*
-	 * Do not to map Versatile FPGA PCI device into memory space
-	 */
-	pci_slot_ignore |= (1 << myslot);
-	ret = 1;
-
- out:
-	return ret;
-}
-
-
-void __init pci_versatile_preinit(void)
-{
-	pcibios_min_mem = 0x50000000;
-
-	__raw_writel(VERSATILE_PCI_MEM_BASE0 >> 28, PCI_IMAP0);
-	__raw_writel(VERSATILE_PCI_MEM_BASE1 >> 28, PCI_IMAP1);
-	__raw_writel(VERSATILE_PCI_MEM_BASE2 >> 28, PCI_IMAP2);
-
-	__raw_writel(PHYS_OFFSET >> 28, PCI_SMAP0);
-	__raw_writel(PHYS_OFFSET >> 28, PCI_SMAP1);
-	__raw_writel(PHYS_OFFSET >> 28, PCI_SMAP2);
-
-	__raw_writel(1, SYS_PCICTL);
-}
-
-/*
- * map the specified device/slot/pin to an IRQ.   Different backplanes may need to modify this.
- */
-static int __init versatile_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq;
-
-	/*
-	 * Slot	INTA	INTB	INTC	INTD
-	 * 31	PCI1	PCI2	PCI3	PCI0
-	 * 30	PCI0	PCI1	PCI2	PCI3
-	 * 29	PCI3	PCI0	PCI1	PCI2
-	 */
-	irq = IRQ_SIC_PCI0 + ((slot + 2 + pin - 1) & 3);
-
-	return irq;
-}
-
-static struct hw_pci versatile_pci __initdata = {
-	.map_irq		= versatile_map_irq,
-	.nr_controllers		= 1,
-	.ops			= &pci_versatile_ops,
-	.setup			= pci_versatile_setup,
-	.preinit		= pci_versatile_preinit,
-};
-
-static int __init versatile_pci_init(void)
-{
-	pci_common_init(&versatile_pci);
-	return 0;
-}
-
-subsys_initcall(versatile_pci_init);
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
deleted file mode 100644
index 1caef10..0000000
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- *  linux/arch/arm/mach-versatile/versatile_ab.c
- *
- *  Copyright (C) 2004 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/amba/bus.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/mach-types.h>
-
-#include <asm/mach/arch.h>
-
-#include "core.h"
-
-MACHINE_START(VERSATILE_AB, "ARM-Versatile AB")
-	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.atag_offset	= 0x100,
-	.map_io		= versatile_map_io,
-	.init_early	= versatile_init_early,
-	.init_irq	= versatile_init_irq,
-	.init_time	= versatile_timer_init,
-	.init_machine	= versatile_init,
-	.restart	= versatile_restart,
-MACHINE_END
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index a585758..86fa2d3 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -81,6 +81,7 @@ static void __init versatile_dt_init(void)
 
 	versatile_dt_pci_init();
 
+	platform_device_register(&versatile_flash_device);
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     versatile_auxdata_lookup, NULL);
 }
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
deleted file mode 100644
index 9a53d0b..0000000
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- *  linux/arch/arm/mach-versatile/versatile_pb.c
- *
- *  Copyright (C) 2004 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/pl061.h>
-#include <linux/amba/mmci.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/mach-types.h>
-
-#include <asm/mach/arch.h>
-
-#include "core.h"
-
-#if 1
-#define IRQ_MMCI1A	IRQ_VICSOURCE23
-#else
-#define IRQ_MMCI1A	IRQ_SIC_MMCI1A
-#endif
-
-static struct mmci_platform_data mmc1_plat_data = {
-	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.status		= mmc_status,
-	.gpio_wp	= -1,
-	.gpio_cd	= -1,
-};
-
-#define UART3_IRQ	{ IRQ_SIC_UART3 }
-#define SCI1_IRQ	{ IRQ_SIC_SCI3 }
-#define MMCI1_IRQ	{ IRQ_MMCI1A, IRQ_SIC_MMCI1B }
-
-/*
- * These devices are connected via the DMA APB bridge
- */
-
-/* FPGA Primecells */
-APB_DEVICE(uart3, "fpga:09", UART3,    NULL);
-APB_DEVICE(sci1,  "fpga:0a", SCI1,     NULL);
-APB_DEVICE(mmc1,  "fpga:0b", MMCI1,    &mmc1_plat_data);
-
-
-static struct amba_device *amba_devs[] __initdata = {
-	&uart3_device,
-	&sci1_device,
-	&mmc1_device,
-};
-
-static void __init versatile_pb_init(void)
-{
-	int i;
-
-	versatile_init();
-
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-}
-
-MACHINE_START(VERSATILE_PB, "ARM-Versatile PB")
-	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.atag_offset	= 0x100,
-	.map_io		= versatile_map_io,
-	.init_early	= versatile_init_early,
-	.init_irq	= versatile_init_irq,
-	.init_time	= versatile_timer_init,
-	.init_machine	= versatile_pb_init,
-	.restart	= versatile_restart,
-MACHINE_END
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index fc50b62..369a2dc 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,6 +1,8 @@
 config COMMON_CLK_VERSATILE
 	bool "Clock driver for ARM Reference designs"
-	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || ARCH_VEXPRESS || ARM64 || COMPILE_TEST
+	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
+		ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
+		COMPILE_TEST
 	---help---
           Supports clocking on ARM Reference designs:
 	  - Integrator/AP and Integrator/CP
-- 
2.5.0
