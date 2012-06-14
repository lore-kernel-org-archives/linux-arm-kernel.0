From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:40 +0800
Subject: [PATCH 09/16] ARM: imx: pass gpio than irq number into mxc_expio_init
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change mxc_expio_init interface a little bit to have gpio than irq
number passed in.  With the change, gpio_to_irq can be called inside
mxc_expio_init to get irq number, so that MXC_IRQ_TO_GPIO can be
removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-mx27_3ds.c               |    3 +--
 arch/arm/mach-imx/mach-mx31_3ds.c               |    3 +--
 arch/arm/mach-imx/mach-mx35_3ds.c               |    4 +---
 arch/arm/mach-imx/mach-mx51_3ds.c               |    3 +--
 arch/arm/plat-mxc/3ds_debugboard.c              |    8 ++++----
 arch/arm/plat-mxc/include/mach/3ds_debugboard.h |    2 +-
 6 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 18b9bca..eeff0b6 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -48,7 +48,6 @@
 #define SD1_EN_GPIO		IMX_GPIO_NR(2, 25)
 #define OTG_PHY_RESET_GPIO	IMX_GPIO_NR(2, 23)
 #define SPI2_SS0		IMX_GPIO_NR(4, 21)
-#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(3, 28))
 #define PMIC_INT		IMX_GPIO_NR(3, 14)
 #define SPI1_SS0		IMX_GPIO_NR(4, 28)
 #define SD1_CD			IMX_GPIO_NR(2, 26)
@@ -500,7 +499,7 @@ static void __init mx27pdk_init(void)
 	spi_register_board_info(mx27_3ds_spi_devs,
 						ARRAY_SIZE(mx27_3ds_spi_devs));
 
-	if (mxc_expio_init(MX27_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+	if (mxc_expio_init(MX27_CS5_BASE_ADDR, IMX_GPIO_NR(3, 28)))
 		pr_warn("Init of the debugboard failed, all devices on the debugboard are unusable.\n");
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 618935e..f37d9b5 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -730,8 +730,7 @@ static void __init mx31_3ds_init(void)
 	if (!otg_mode_host)
 		imx31_add_fsl_usb2_udc(&usbotg_pdata);
 
-	if (mxc_expio_init(MX31_CS5_BASE_ADDR,
-			   gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1))))
+	if (mxc_expio_init(MX31_CS5_BASE_ADDR, IOMUX_TO_GPIO(MX31_PIN_GPIO1_1)))
 		printk(KERN_WARNING "Init of the debug board failed, all "
 				    "devices on the debug board are unusable.\n");
 	imx31_add_imx2_wdt(NULL);
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index ad63e6e..596f237 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -132,8 +132,6 @@ static struct platform_device mx35_3ds_lcd = {
 	.dev.platform_data = &mx35_3ds_lcd_data,
 };
 
-#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 1))
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -580,7 +578,7 @@ static void __init mx35_3ds_init(void)
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 	imx35_add_sdhci_esdhc_imx(0, NULL);
 
-	if (mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+	if (mxc_expio_init(MX35_CS5_BASE_ADDR, IMX_GPIO_NR(1, 1)))
 		pr_warn("Init of the debugboard failed, all "
 				"devices on the debugboard are unusable.\n");
 	imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
diff --git a/arch/arm/mach-imx/mach-mx51_3ds.c b/arch/arm/mach-imx/mach-mx51_3ds.c
index 3c5b163..ebb9188 100644
--- a/arch/arm/mach-imx/mach-mx51_3ds.c
+++ b/arch/arm/mach-imx/mach-mx51_3ds.c
@@ -26,7 +26,6 @@
 
 #include "devices-imx51.h"
 
-#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 6))
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
 static iomux_v3_cfg_t mx51_3ds_pads[] = {
@@ -148,7 +147,7 @@ static void __init mx51_3ds_init(void)
 	spi_register_board_info(mx51_3ds_spi_nor_device,
 				ARRAY_SIZE(mx51_3ds_spi_nor_device));
 
-	if (mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+	if (mxc_expio_init(MX51_CS5_BASE_ADDR, IMX_GPIO_NR(1, 6)))
 		printk(KERN_WARNING "Init of the debugboard failed, all "
 				    "devices on the board are unusable.\n");
 
diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
index 5cac2c5..3b48a08 100644
--- a/arch/arm/plat-mxc/3ds_debugboard.c
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -49,7 +49,6 @@
 #define MCU_BOARD_ID_REG	0x68
 
 #define MXC_IRQ_TO_EXPIO(irq)   ((irq) - MXC_BOARD_IRQ_START)
-#define MXC_IRQ_TO_GPIO(irq)	((irq) - MXC_INTERNAL_IRQS)
 
 #define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
 #define MXC_MAX_EXP_IO_LINES	16
@@ -155,8 +154,9 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vddvario", "smsc911x"),
 };
 
-int __init mxc_expio_init(u32 base, u32 p_irq)
+int __init mxc_expio_init(u32 base, u32 intr_gpio)
 {
+	u32 p_irq = gpio_to_irq(intr_gpio);
 	int i;
 
 	brd_io = ioremap(BOARD_IO_ADDR(base), SZ_4K);
@@ -178,8 +178,8 @@ int __init mxc_expio_init(u32 base, u32 p_irq)
 	/*
 	 * Configure INT line as GPIO input
 	 */
-	gpio_request(MXC_IRQ_TO_GPIO(p_irq), "expio_pirq");
-	gpio_direction_input(MXC_IRQ_TO_GPIO(p_irq));
+	gpio_request(intr_gpio, "expio_pirq");
+	gpio_direction_input(intr_gpio);
 
 	/* disable the interrupt and clear the status */
 	__raw_writew(0, brd_io + INTR_MASK_REG);
diff --git a/arch/arm/plat-mxc/include/mach/3ds_debugboard.h b/arch/arm/plat-mxc/include/mach/3ds_debugboard.h
index a384fdd..9fd6cb3 100644
--- a/arch/arm/plat-mxc/include/mach/3ds_debugboard.h
+++ b/arch/arm/plat-mxc/include/mach/3ds_debugboard.h
@@ -13,6 +13,6 @@
 #ifndef __ASM_ARCH_MXC_3DS_DB_H__
 #define __ASM_ARCH_MXC_3DS_DB_H__
 
-extern int __init mxc_expio_init(u32 base, u32 p_irq);
+extern int __init mxc_expio_init(u32 base, u32 intr_gpio);
 
 #endif /* __ASM_ARCH_MXC_3DS_DB_H__ */
-- 
1.7.5.4
