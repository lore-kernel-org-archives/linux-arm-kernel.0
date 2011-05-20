From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:19 +0200
Subject: [PATCH 3/9] ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several occurences where MXC_INTERNAL_IRQ is
assumed to be the start of the gpio interrupts. It was never
meant this way. Replace these with gpio_to_irq.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c            |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c           |   12 ++++--------
 arch/arm/mach-mx5/board-mx51_3ds.c           |    2 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    3 +--
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |    3 ---
 6 files changed, 8 insertions(+), 16 deletions(-)

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
index 63dfbea..288965d 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -26,7 +26,7 @@
 #include "devices-imx51.h"
 #include "devices.h"
 
-#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
+#define EXPIO_PARENT_INT	gpio_to_irq((IMX_GPIO_NR(1, 6))
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
 static iomux_v3_cfg_t mx51_3ds_pads[] = {
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index 97292d2..66d24ea 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -31,7 +31,6 @@
 #include "devices.h"
 
 #define MBIMX51_TSC2007_GPIO	IMX_GPIO_NR(3, 30)
-#define MBIMX51_TSC2007_IRQ	(MXC_INTERNAL_IRQS + MBIMX51_TSC2007_GPIO)
 #define MBIMX51_LED0		IMX_GPIO_NR(3, 5)
 #define MBIMX51_LED1		IMX_GPIO_NR(3, 6)
 #define MBIMX51_LED2		IMX_GPIO_NR(3, 7)
@@ -173,7 +172,7 @@ struct tsc2007_platform_data tsc2007_data = {
 static struct i2c_board_info mbimx51_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("tsc2007", 0x49),
-		.irq  = MBIMX51_TSC2007_IRQ,
+		.irq  = gpio_to_irq(MBIMX51_TSC2007_GPIO),
 		.platform_data = &tsc2007_data,
 	}, {
 		I2C_BOARD_INFO("tlv320aic23", 0x1a),
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
1.7.4.1
