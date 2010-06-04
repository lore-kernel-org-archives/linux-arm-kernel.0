From: jason77.wang@gmail.com (Jason Wang)
Date: Fri,  4 Jun 2010 22:32:57 +0800
Subject: [PATCH V3 7/7] mx31_3ds: revert cpld debug board relate code
In-Reply-To: <1275661977-8077-7-git-send-email-jason77.wang@gmail.com>
References: <1275661977-8077-1-git-send-email-jason77.wang@gmail.com>
	<1275661977-8077-2-git-send-email-jason77.wang@gmail.com>
	<1275661977-8077-3-git-send-email-jason77.wang@gmail.com>
	<1275661977-8077-4-git-send-email-jason77.wang@gmail.com>
	<1275661977-8077-5-git-send-email-jason77.wang@gmail.com>
	<1275661977-8077-6-git-send-email-jason77.wang@gmail.com>
	<1275661977-8077-7-git-send-email-jason77.wang@gmail.com>
Message-ID: <1275661977-8077-8-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because we add a cpld debug board support in mxc level, we remove
those redudent codes from board level.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx3/Kconfig                       |    1 +
 arch/arm/mach-mx3/mach-mx31_3ds.c               |  168 +----------------------
 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h |   42 ------
 3 files changed, 4 insertions(+), 207 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 344753f..fd422cf 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -58,6 +58,7 @@ config MACH_MX31LITE
 config MACH_MX31_3DS
 	bool "Support MX31PDK (3DS)"
 	select ARCH_MX31
+	select MXC_DEBUG_BOARD
 	help
 	  Include support for MX31PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 58e5729..d8af726 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
-#include <linux/smsc911x.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
@@ -38,6 +37,7 @@
 #include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/board-mx31_3ds.h>
+#include <mach/cpld_debugboard.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/mxc_nand.h>
@@ -213,173 +213,11 @@ static struct imxuart_platform_data uart_pdata = {
 };
 
 /*
- * Support for the SMSC9217 on the Debug board.
- */
-
-static struct smsc911x_platform_config smsc911x_config = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.flags		= SMSC911X_USE_16BIT | SMSC911X_FORCE_INTERNAL_PHY,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
-static struct resource smsc911x_resources[] = {
-	{
-		.start		= LAN9217_BASE_ADDR,
-		.end		= LAN9217_BASE_ADDR + 0xff,
-		.flags		= IORESOURCE_MEM,
-	}, {
-		.start		= EXPIO_INT_ENET,
-		.end		= EXPIO_INT_ENET,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smsc911x_resources),
-	.resource	= smsc911x_resources,
-	.dev		= {
-		.platform_data = &smsc911x_config,
-	},
-};
-
-/*
- * Routines for the CPLD on the debug board. It contains a CPLD handling
- * LEDs, switches, interrupts for Ethernet.
- */
-
-static void mx31_3ds_expio_irq_handler(uint32_t irq, struct irq_desc *desc)
-{
-	uint32_t imr_val;
-	uint32_t int_valid;
-	uint32_t expio_irq;
-
-	imr_val = __raw_readw(CPLD_INT_MASK_REG);
-	int_valid = __raw_readw(CPLD_INT_STATUS_REG) & ~imr_val;
-
-	expio_irq = MXC_EXP_IO_BASE;
-	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
-		if ((int_valid & 1) == 0)
-			continue;
-		generic_handle_irq(expio_irq);
-	}
-}
-
-/*
- * Disable an expio pin's interrupt by setting the bit in the imr.
- * @param irq           an expio virtual irq number
- */
-static void expio_mask_irq(uint32_t irq)
-{
-	uint16_t reg;
-	uint32_t expio = MXC_IRQ_TO_EXPIO(irq);
-
-	/* mask the interrupt */
-	reg = __raw_readw(CPLD_INT_MASK_REG);
-	reg |= 1 << expio;
-	__raw_writew(reg, CPLD_INT_MASK_REG);
-}
-
-/*
- * Acknowledge an expanded io pin's interrupt by clearing the bit in the isr.
- * @param irq           an expanded io virtual irq number
- */
-static void expio_ack_irq(uint32_t irq)
-{
-	uint32_t expio = MXC_IRQ_TO_EXPIO(irq);
-
-	/* clear the interrupt status */
-	__raw_writew(1 << expio, CPLD_INT_RESET_REG);
-	__raw_writew(0, CPLD_INT_RESET_REG);
-	/* mask the interrupt */
-	expio_mask_irq(irq);
-}
-
-/*
- * Enable a expio pin's interrupt by clearing the bit in the imr.
- * @param irq           a expio virtual irq number
- */
-static void expio_unmask_irq(uint32_t irq)
-{
-	uint16_t reg;
-	uint32_t expio = MXC_IRQ_TO_EXPIO(irq);
-
-	/* unmask the interrupt */
-	reg = __raw_readw(CPLD_INT_MASK_REG);
-	reg &= ~(1 << expio);
-	__raw_writew(reg, CPLD_INT_MASK_REG);
-}
-
-static struct irq_chip expio_irq_chip = {
-	.ack = expio_ack_irq,
-	.mask = expio_mask_irq,
-	.unmask = expio_unmask_irq,
-};
-
-static int __init mx31_3ds_init_expio(void)
-{
-	int i;
-	int ret;
-
-	/* Check if there's a debug board connected */
-	if ((__raw_readw(CPLD_MAGIC_NUMBER1_REG) != 0xAAAA) ||
-	    (__raw_readw(CPLD_MAGIC_NUMBER2_REG) != 0x5555) ||
-	    (__raw_readw(CPLD_MAGIC_NUMBER3_REG) != 0xCAFE)) {
-		/* No Debug board found */
-		return -ENODEV;
-	}
-
-	pr_info("i.MX31 3DS Debug board detected, rev = 0x%04X\n",
-		__raw_readw(CPLD_CODE_VER_REG));
-
-	/*
-	 * Configure INT line as GPIO input
-	 */
-	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1), "sms9217-irq");
-	if (ret)
-		pr_warning("could not get LAN irq gpio\n");
-	else
-		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
-
-	/* Disable the interrupts and clear the status */
-	__raw_writew(0, CPLD_INT_MASK_REG);
-	__raw_writew(0xFFFF, CPLD_INT_RESET_REG);
-	__raw_writew(0, CPLD_INT_RESET_REG);
-	__raw_writew(0x1F, CPLD_INT_MASK_REG);
-	for (i = MXC_EXP_IO_BASE;
-	     i < (MXC_EXP_IO_BASE + MXC_MAX_EXP_IO_LINES);
-	     i++) {
-		set_irq_chip(i, &expio_irq_chip);
-		set_irq_handler(i, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-	}
-	set_irq_type(EXPIO_PARENT_INT, IRQ_TYPE_LEVEL_LOW);
-	set_irq_chained_handler(EXPIO_PARENT_INT, mx31_3ds_expio_irq_handler);
-
-	return 0;
-}
-
-/*
- * This structure defines the MX31 memory map.
- */
-static struct map_desc mx31_3ds_io_desc[] __initdata = {
-	{
-		.virtual = MX31_CS5_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX31_CS5_BASE_ADDR),
-		.length = MX31_CS5_SIZE,
-		.type = MT_DEVICE,
-	},
-};
-
-/*
  * Set up static virtual mappings.
  */
 static void __init mx31_3ds_map_io(void)
 {
 	mx31_map_io();
-	iotable_init(mx31_3ds_io_desc, ARRAY_SIZE(mx31_3ds_io_desc));
 }
 
 /*!
@@ -402,8 +240,8 @@ static void __init mxc_board_init(void)
 	mx31_3ds_usbotg_init();
 	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
 
-	if (!mx31_3ds_init_expio())
-		platform_device_register(&smsc911x_device);
+	if (!mxc_expio_init(CS5_BASE_ADDR, EXPIO_PARENT_INT))
+		platform_device_register(&smsc_lan9217_device);
 }
 
 static void __init mx31_3ds_timer_init(void)
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
index da92933..c26d88d 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
@@ -12,48 +12,6 @@
 #define __ASM_ARCH_MXC_BOARD_MX31_3DS_H__
 
 /* Definitions for components on the Debug board */
-
-/* Base address of CPLD controller on the Debug board */
-#define DEBUG_BASE_ADDRESS		CS5_IO_ADDRESS(CS5_BASE_ADDR)
-
-/* LAN9217 ethernet base address */
-#define LAN9217_BASE_ADDR		CS5_BASE_ADDR
-
-/* CPLD config and interrupt base address */
-#define CPLD_ADDR			(DEBUG_BASE_ADDRESS + 0x20000)
-
-/* LED switchs */
-#define CPLD_LED_REG			(CPLD_ADDR + 0x00)
-/* buttons */
-#define CPLD_SWITCH_BUTTONS_REG	(EXPIO_ADDR + 0x08)
-/* status, interrupt */
-#define CPLD_INT_STATUS_REG		(CPLD_ADDR + 0x10)
-#define CPLD_INT_MASK_REG		(CPLD_ADDR + 0x38)
-#define CPLD_INT_RESET_REG		(CPLD_ADDR + 0x20)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER1_REG		(CPLD_ADDR + 0x40)
-#define CPLD_MAGIC_NUMBER2_REG		(CPLD_ADDR + 0x48)
-/* CPLD code version */
-#define CPLD_CODE_VER_REG		(CPLD_ADDR + 0x50)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER3_REG		(CPLD_ADDR + 0x58)
-/* module reset register */
-#define CPLD_MODULE_RESET_REG		(CPLD_ADDR + 0x60)
-/* CPU ID and Personality ID */
-#define CPLD_MCU_BOARD_ID_REG		(CPLD_ADDR + 0x68)
-
-/* CPLD IRQ line for external uart, external ethernet etc */
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
 
-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
-#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
-
-#define EXPIO_INT_ENET		(MXC_EXP_IO_BASE + 0)
-#define EXPIO_INT_XUART_A	(MXC_EXP_IO_BASE + 1)
-#define EXPIO_INT_XUART_B	(MXC_EXP_IO_BASE + 2)
-#define EXPIO_INT_BUTTON_A	(MXC_EXP_IO_BASE + 3)
-#define EXPIO_INT_BUTTON_B	(MXC_EXP_IO_BASE + 4)
-
-#define MXC_MAX_EXP_IO_LINES	16
-
 #endif /* __ASM_ARCH_MXC_BOARD_MX31_3DS_H__ */
-- 
1.5.6.5
