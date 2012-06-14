From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:00 +0200
Subject: [PATCH v2 10/23] ARM: LPC32xx: Add MMC controller support
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-11-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the MMC controller of the LPC32xx SoC to the
platform initialization via the pl08x primecell driver. Lacking more complete
DT support, done via DT auxdata.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/mach-lpc32xx/phy3250.c |   43 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -30,12 +30,13 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl022.h>
+#include <linux/amba/pl08x.h>
+#include <linux/amba/mmci.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
-#include <linux/amba/pl08x.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -50,9 +51,12 @@
 /*
  * Mapped GPIOLIB GPIOs
  */
-#define SPI0_CS_GPIO	LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
-#define LCD_POWER_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 0)
-#define BKL_POWER_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 4)
+#define SPI0_CS_GPIO		LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
+#define LCD_POWER_GPIO		LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 0)
+#define BKL_POWER_GPIO		LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 4)
+#define MMC_PWR_ENABLE_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 5)
+#define MMC_CD_GPIO		LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 1)
+#define MMC_WP_GPIO		LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 0)
 
 /*
  * AMBA LCD controller
@@ -260,11 +264,32 @@ static struct pl08x_platform_data pl08x_
 	.mem_buses = PL08X_AHB1,
 };
 
+static int mmc_handle_ios(struct device *dev, struct mmc_ios *ios)
+{
+	/* Only on and off are supported */
+	if (ios->power_mode == MMC_POWER_OFF)
+		gpio_set_value(MMC_PWR_ENABLE_GPIO, 0);
+	else
+		gpio_set_value(MMC_PWR_ENABLE_GPIO, 1);
+	return 0;
+}
+
+static struct mmci_platform_data lpc32xx_mmci_data = {
+	.ocr_mask	= MMC_VDD_30_31 | MMC_VDD_31_32 |
+			  MMC_VDD_32_33 | MMC_VDD_33_34,
+	.ios_handler	= mmc_handle_ios,
+	.dma_filter	= NULL,
+	/* No DMA for now since AMBA PL080 dmaengine driver only does scatter
+	 * gather, and the MMCI driver doesn't do it this way */
+};
+
 static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", &lpc32xx_ssp0_data),
 	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", &lpc32xx_ssp1_data),
 	OF_DEV_AUXDATA("arm,pl110", 0x31040000, "dev:clcd", &lpc32xx_clcd_data),
 	OF_DEV_AUXDATA("arm,pl080", 0x31000000, "pl08xdmac", &pl08x_pd),
+	OF_DEV_AUXDATA("arm,pl18x", 0x20098000, "20098000.sd",
+		       &lpc32xx_mmci_data),
 	{ }
 };
 
@@ -308,6 +333,11 @@ static void __init lpc3250_machine_init(
 	 * detection or a data fault will occur, so enable the clocks
 	 * here.
 	 */
+	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
+	tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
+		LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN;
+	__raw_writel(tmp, LPC32XX_CLKPWR_MS_CTRL);
+
 	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL);
 	__raw_writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
 		LPC32XX_CLKPWR_LCDCLK_CTRL);
@@ -335,6 +365,11 @@ static void __init lpc3250_machine_init(
 	else if (gpio_direction_output(SPI0_CS_GPIO, 1))
 		printk(KERN_ERR "Error setting gpio %u to output",
 			SPI0_CS_GPIO);
+
+	if (gpio_request(MMC_PWR_ENABLE_GPIO, "mmc_power_en"))
+		pr_err("Error requesting gpio %u", MMC_PWR_ENABLE_GPIO);
+	else if (gpio_direction_output(MMC_PWR_ENABLE_GPIO, 1))
+		pr_err("Error setting gpio %u to output", MMC_PWR_ENABLE_GPIO);
 }
 
 static char const *lpc32xx_dt_compat[] __initdata = {
