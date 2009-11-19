From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 19 Nov 2009 12:02:07 +0100
Subject: [PATCH 2/6] ARM: MX3: add MMC/SDHC support to mx31lite-db.c
In-Reply-To: <1258628531-15783-1-git-send-email-daniel@caiaq.de>
References: <1258628531-15783-1-git-send-email-daniel@caiaq.de>
Message-ID: <1258628531-15783-2-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lite-db.c |   70 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 751d15e..45abae1 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -38,6 +38,7 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lite.h>
+#include <mach/mmc.h>
 
 #include "devices.h"
 
@@ -61,11 +62,80 @@ static struct imxuart_platform_data uart_pdata __initdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
+/* MMC */
+
+static int gpio_det, gpio_wp;
+
+#define MMC_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+static int mxc_mmc1_get_ro(struct device *dev)
+{
+	return gpio_get_value(IOMUX_TO_GPIO(MX31_PIN_LCS0));
+}
+
+static int mxc_mmc1_init(struct device *dev,
+			 irq_handler_t detect_irq, void *data)
+{
+	int ret;
+
+	gpio_det = IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1);
+	gpio_wp = IOMUX_TO_GPIO(MX31_PIN_GPIO1_6);
+
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA0, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA1, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA2, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA3, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_CLK, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_CMD, MMC_PAD_CFG);
+
+	ret = gpio_request(gpio_det, "MMC detect");
+	if (ret)
+		return ret;
+
+	ret = gpio_request(gpio_wp, "MMC w/p");
+	if (ret)
+		goto exit_free_det;
+
+	gpio_direction_input(gpio_det);
+	gpio_direction_input(gpio_wp);
+
+	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_DCD_DCE1), detect_irq,
+			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			  "MMC detect", data);
+	if (ret)
+		goto exit_free_wp;
+
+	return 0;
+
+exit_free_wp:
+	gpio_free(gpio_wp);
+
+exit_free_det:
+	gpio_free(gpio_det);
+
+	return ret;
+}
+
+static void mxc_mmc1_exit(struct device *dev, void *data)
+{
+	gpio_free(gpio_det);
+	gpio_free(gpio_wp);
+	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO1_1), data);
+}
+
+static struct imxmmc_platform_data mmc_pdata = {
+	.get_ro	 = mxc_mmc1_get_ro,
+	.init	   = mxc_mmc1_init,
+	.exit	   = mxc_mmc1_exit,
+};
+
 void __init mx31lite_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
 					ARRAY_SIZE(litekit_db_board_pins),
 					"development board pins");
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
 }
 
-- 
1.6.5.2
