From: rpimentel.silva@gmail.com (Rogerio Pimentel)
Date: Fri, 22 Oct 2010 11:03:54 -0200
Subject: [PATCH v2] MX27 3ds: Add SDHC1 support to mx27 3ds
Message-ID: <AANLkTimUwquL=JEcVPCXpmP2L+x0YNquCOpB=iY7fFZ=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SDHC1 support to MX27 3ds

Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>

---
Change since v1: Fix e-mailer like break as pointed by Sascha Hauer
 arch/arm/mach-imx/mach-mx27_3ds.c |   38 +++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c
b/arch/arm/mach-imx/mach-mx27_3ds.c
index a69dba2..a02a00a 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -23,16 +23,20 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/irq.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
+#include <mach/mmc.h>

 #include "devices-imx27.h"
 #include "devices.h"

+#define SD1_EN_GPIO (GPIO_PORTB + 25)
+
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
 	PE12_PF_UART1_TXD,
@@ -58,6 +62,14 @@ static const int mx27pdk_pins[] __initconst = {
 	PD15_AOUT_FEC_COL,
 	PD16_AIN_FEC_TX_ER,
 	PF23_AIN_FEC_TX_EN,
+	/* SDHC1 */
+	PE18_PF_SD1_D0,
+	PE19_PF_SD1_D1,
+	PE20_PF_SD1_D2,
+	PE21_PF_SD1_D3,
+	PE22_PF_SD1_CMD,
+	PE23_PF_SD1_CLK,
+	SD1_EN_GPIO | GPIO_GPIO | GPIO_OUT,
 };

 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -85,13 +97,39 @@ static struct matrix_keymap_data mx27_3ds_keymap_data = {
 	.keymap_size	= ARRAY_SIZE(mx27_3ds_keymap),
 };

+static int mx27_3ds_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
+				void *data)
+{
+	return request_irq(IRQ_GPIOB(26), detect_irq, IRQF_TRIGGER_FALLING |
+			IRQF_TRIGGER_RISING, "sdhc1-card-detect", data);
+}
+
+static void mx27_3ds_sdhc1_exit(struct device *dev, void *data)
+{
+	free_irq(IRQ_GPIOB(26), data);
+}
+
+static struct imxmmc_platform_data sdhc1_pdata = {
+	.init = mx27_3ds_sdhc1_init,
+	.exit = mx27_3ds_sdhc1_exit,
+};
+
+static void mx27_3ds_sdhc1_enable_level_translator(void)
+{
+	/* Turn on TXB0108 OE pin */
+	gpio_request(SD1_EN_GPIO, "sd1_enable");
+	gpio_direction_output(SD1_EN_GPIO, 1);
+}
+
 static void __init mx27pdk_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
 		"mx27pdk");
+	mx27_3ds_sdhc1_enable_level_translator();
 	imx27_add_imx_uart0(&uart_pdata);
 	imx27_add_fec(NULL);
 	mxc_register_device(&imx_kpp_device, &mx27_3ds_keymap_data);
+	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 }

 static void __init mx27pdk_timer_init(void)
-- 
1.7.0.4
