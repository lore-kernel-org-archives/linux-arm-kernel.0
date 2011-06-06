From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Jun 2011 09:42:58 +0200
Subject: [PATCH v2 1/2] ARM: mx5/mx51_3ds: Fix build due to missing
	header and wrong define
In-Reply-To: <1307212185-18184-1-git-send-email-festevam@gmail.com>
References: <1307212185-18184-1-git-send-email-festevam@gmail.com>
Message-ID: <20110606074258.GX23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Sat, Jun 04, 2011 at 03:29:44PM -0300, Fabio Estevam wrote:
> commit b50d28 (ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage) broke mx51_3ds build.
> 
> Fix it by adding the missing gpio header and also removed the extra parenthesis for 
> EXPIO_PARENT_INT definition.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - removed extra parenthesis in EXPIO_PARENT_INT
> 
>  arch/arm/mach-mx5/board-mx51_3ds.c |    3 ++-

I squashed these two patches into the original commit which breaks the
build. Can I have you ack for the following?

8<------------------------------------------------------
[PATCH] ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage

There are several occurences where MXC_INTERNAL_IRQ is
assumed to be the start of the gpio interrupts. It was never
meant this way. Replace these with gpio_to_irq.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c            |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c           |   12 ++++--------
 arch/arm/mach-mx5/board-mx51_3ds.c           |    3 ++-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    6 +++---
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |    3 ---
 6 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 6e1accf..fcbac6e 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -45,7 +45,7 @@
 #define SD1_EN_GPIO (GPIO_PORTB + 25)
 #define OTG_PHY_RESET_GPIO (GPIO_PORTB + 23)
 #define SPI2_SS0 (GPIO_PORTD + 21)
-#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTC + 28)
+#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(3, 28))
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 882880a..c10221d 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -43,7 +43,7 @@
 
 #include "devices-imx35.h"
 
-#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 1)
+#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 1))
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 4efa02e..7fbfd06 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -43,10 +43,6 @@
 #define CPUIMX51_QUARTB_GPIO	IMX_GPIO_NR(3, 25)
 #define CPUIMX51_QUARTC_GPIO	IMX_GPIO_NR(3, 26)
 #define CPUIMX51_QUARTD_GPIO	IMX_GPIO_NR(3, 27)
-#define CPUIMX51_QUARTA_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTA_GPIO)
-#define CPUIMX51_QUARTB_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTB_GPIO)
-#define CPUIMX51_QUARTC_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTC_GPIO)
-#define CPUIMX51_QUARTD_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTD_GPIO)
 #define CPUIMX51_QUART_XTAL	14745600
 #define CPUIMX51_QUART_REGSHIFT	17
 
@@ -61,7 +57,7 @@
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x400000),
-		.irq = CPUIMX51_QUARTA_IRQ,
+		.irq = gpio_to_irq(CPUIMX51_QUARTA_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -69,7 +65,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x800000),
-		.irq = CPUIMX51_QUARTB_IRQ,
+		.irq = gpio_to_irq(CPUIMX51_QUARTB_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -77,7 +73,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x1000000),
-		.irq = CPUIMX51_QUARTC_IRQ,
+		.irq = gpio_to_irq(CPUIMX51_QUARTC_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -85,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
-		.irq = CPUIMX51_QUARTD_IRQ,
+		.irq = irq_to_gpio(CPUIMX51_QUARTD_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 63dfbea..11b2c7a 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -26,7 +27,7 @@
 #include "devices-imx51.h"
 #include "devices.h"
 
-#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
+#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 6))
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
 static iomux_v3_cfg_t mx51_3ds_pads[] = {
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index 02ce720..bbf4564 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -31,7 +31,6 @@
 #include "devices.h"
 
 #define MBIMX51_TSC2007_GPIO	IMX_GPIO_NR(3, 30)
-#define MBIMX51_TSC2007_IRQ	(MXC_INTERNAL_IRQS + MBIMX51_TSC2007_GPIO)
 #define MBIMX51_LED0		IMX_GPIO_NR(3, 5)
 #define MBIMX51_LED1		IMX_GPIO_NR(3, 6)
 #define MBIMX51_LED2		IMX_GPIO_NR(3, 7)
@@ -161,7 +160,7 @@ struct tsc2007_platform_data tsc2007_data = {
 static struct i2c_board_info mbimx51_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("tsc2007", 0x49),
-		.irq  = MBIMX51_TSC2007_IRQ,
+		.irq  = gpio_to_irq(MBIMX51_TSC2007_GPIO),
 		.platform_data = &tsc2007_data,
 	}, {
 		I2C_BOARD_INFO("tlv320aic23", 0x1a),
@@ -198,7 +197,8 @@ void __init eukrea_mbimx51_baseboard_init(void)
 
 	gpio_request(MBIMX51_TSC2007_GPIO, "tsc2007_irq");
 	gpio_direction_input(MBIMX51_TSC2007_GPIO);
-	irq_set_irq_type(MBIMX51_TSC2007_IRQ, IRQF_TRIGGER_FALLING);
+	irq_set_irq_type(gpio_to_irq(MBIMX51_TSC2007_GPIO),
+					IRQF_TRIGGER_FALLING);
 	i2c_register_board_info(1, mbimx51_i2c_devices,
 				ARRAY_SIZE(mbimx51_i2c_devices));
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
index c07d302..a7fc51e 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
@@ -85,9 +85,6 @@
 #define GPIO_BOUT_0	(2 << GPIO_BOUT_SHIFT)
 #define GPIO_BOUT_1	(3 << GPIO_BOUT_SHIFT)
 
-/* decode irq number to use with IMR(x), ISR(x) and friends */
-#define IRQ_TO_REG(irq) ((irq - MXC_INTERNAL_IRQS) >> 5)
-
 #define IRQ_GPIOA(x)  (MXC_GPIO_IRQ_START + x)
 #define IRQ_GPIOB(x)  (IRQ_GPIOA(32) + x)
 #define IRQ_GPIOC(x)  (IRQ_GPIOB(32) + x)
-- 
1.7.5.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
