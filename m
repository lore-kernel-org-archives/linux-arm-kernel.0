From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Sat, 14 Nov 2009 20:27:54 +0100
Subject: [PATCH v1] MXC: Add SPI and MC13783 support for i.MX31 Litekit board.
Message-ID: <1258226874-7340-1-git-send-email-lilja.magnus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
---

Tested with the mc13783-rtc/adc.c drivers from pengutronix (not in 
mainline yet) on actual hardware.

 arch/arm/mach-mx3/mx31lite.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index a8d57de..228f6ac 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mx31lite.c
@@ -25,6 +25,8 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -39,6 +41,8 @@
 #include <mach/iomux-mx3.h>
 #include <mach/irqs.h>
 #include <mach/mxc_nand.h>
+#include <mach/spi.h>
+
 #include "devices.h"
 
 /*
@@ -53,6 +57,13 @@ static unsigned int mx31lite_pins[] = {
 	MX31_PIN_RXD1__RXD1,
 	/* LAN9117 IRQ pin */
 	IOMUX_MODE(MX31_PIN_SFS6, IOMUX_CONFIG_GPIO),
+	/* MC13783 IRQ */
+	MX31_PIN_GPIO1_3__GPIO1_3,
+	/* SPI2 */
+	MX31_PIN_CSPI2_MOSI__MOSI,
+	MX31_PIN_CSPI2_MISO__MISO,
+	MX31_PIN_CSPI2_SCLK__SCLK,
+	MX31_PIN_CSPI2_SS0__SS0,
 };
 
 static struct imxuart_platform_data uart_pdata = {
@@ -92,6 +103,30 @@ static struct platform_device smsc911x_device = {
 	},
 };
 
+static int mx31lite_spi1_cs[] = {
+	MXC_SPI_CS(0),
+};
+
+static struct spi_imx_master mx31lite_spi1_master = {
+	.chipselect	= mx31lite_spi1_cs,
+	.num_chipselect	= ARRAY_SIZE(mx31lite_spi1_cs),
+};
+
+static struct mc13783_platform_data mc13783_data = {
+	.flags = MC13783_USE_ADC | MC13783_USE_RTC,
+};
+
+static struct spi_board_info mx31lite_spi_devs[] = {
+	{
+		.modalias = "mc13783",
+		.irq = IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		.max_speed_hz = 1000000,
+		.bus_num = 1,
+		.chip_select = 0,
+		.platform_data = &mc13783_data,
+	},
+};
+
 /*
  * This structure defines the MX31 memory map.
  */
@@ -139,6 +174,13 @@ static void __init mxc_board_init(void)
 		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_SFS6));
 		platform_device_register(&smsc911x_device);
 	}
+
+	/* SPI and MC13783 setup */
+	mxc_register_device(&mxc_spi_device1, &mx31lite_spi1_master);
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
+	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+	spi_register_board_info(mx31lite_spi_devs,
+				ARRAY_SIZE(mx31lite_spi_devs));
 }
 
 static void __init mx31lite_timer_init(void)
-- 
1.5.6
