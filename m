From: agust@denx.de (Anatolij Gustschin)
Date: Mon,  9 Nov 2009 13:37:14 +0100
Subject: [PATCH 2/2] qong: add mc13783 support
In-Reply-To: <1257770234-1851-1-git-send-email-agust@denx.de>
References: <1257770234-1851-1-git-send-email-agust@denx.de>
Message-ID: <1257770234-1851-2-git-send-email-agust@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables using MC13783's touchscreen interface on qong
board.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/arm/mach-mx3/qong.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/qong.c b/arch/arm/mach-mx3/qong.c
index 6626cc0..7422fdb 100644
--- a/arch/arm/mach-mx3/qong.c
+++ b/arch/arm/mach-mx3/qong.c
@@ -39,6 +39,12 @@
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/mc13783.h>
+
+#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
+#include <mach/spi.h>
+#endif
 #include "devices.h"
 
 /* FPGA defines */
@@ -329,6 +335,42 @@ void qong_init_lcd(void)
 	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_D3_CLS, IOMUX_CONFIG_FUNC));
 }
 
+void qong_init_spi(void)
+{
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_SPI_RDY, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_SCLK, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_MISO, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_MOSI, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_SS0, IOMUX_CONFIG_FUNC));
+
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_3, IOMUX_CONFIG_GPIO));
+
+	if (!gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "spi1_irq"))
+		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+}
+
+static struct mc13783_platform_data mc13783_pdata __initdata = {
+	.flags = MC13783_USE_TOUCHSCREEN,
+};
+
+static struct spi_board_info qong_spi_devs[] __initdata = {
+	{
+		.modalias	= "mc13783",
+		.max_speed_hz	= 1000000,
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		.platform_data	= &mc13783_pdata,
+	},
+};
+
+static int qong_spi1_cs[] = { MXC_SPI_CS(0) };
+
+struct spi_imx_master qong_spi1_master = {
+	.chipselect = qong_spi1_cs,
+	.num_chipselect = ARRAY_SIZE(qong_spi1_cs),
+};
+
 /*
  * Board specific initialization.
  */
@@ -338,8 +380,11 @@ static void __init mxc_board_init(void)
 	qong_init_nor_mtd();
 	qong_init_fpga();
 	qong_init_lcd();
+	qong_init_spi();
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+	spi_register_board_info(qong_spi_devs, ARRAY_SIZE(qong_spi_devs));
+	mxc_register_device(&mxc_spi_device1, &qong_spi1_master);
 }
 
 static void __init qong_timer_init(void)
-- 
1.5.6.3
