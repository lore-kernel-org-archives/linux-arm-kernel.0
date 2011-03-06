From: alberto@amarulasolutions.com (Alberto Panizzo)
Date: Sun, 06 Mar 2011 16:40:01 +0100
Subject: [PATCH 2/4] mach-mx31_3ds: Add support for the MMC slot of the
	personality board
In-Reply-To: <1299425878.2624.29.camel@realization>
References: <1299425878.2624.29.camel@realization>
Message-ID: <1299426001.2624.31.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |  116 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index f1dbb9d..cd73513 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -35,6 +35,7 @@
 #include <mach/iomux-mx3.h>
 #include <mach/3ds_debugboard.h>
 #include <mach/ulpi.h>
+#include <mach/mmc.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
@@ -99,6 +100,98 @@ static int mx31_3ds_pins[] = {
 	/* I2C1 */
 	MX31_PIN_I2C_CLK__I2C1_SCL,
 	MX31_PIN_I2C_DAT__I2C1_SDA,
+	/* SDHC1 */
+	MX31_PIN_SD1_DATA3__SD1_DATA3,
+	MX31_PIN_SD1_DATA2__SD1_DATA2,
+	MX31_PIN_SD1_DATA1__SD1_DATA1,
+	MX31_PIN_SD1_DATA0__SD1_DATA0,
+	MX31_PIN_SD1_CLK__SD1_CLK,
+	MX31_PIN_SD1_CMD__SD1_CMD,
+	MX31_PIN_GPIO3_1__GPIO3_1, /* Card detect */
+	MX31_PIN_GPIO3_0__GPIO3_0, /* OE */
+};
+
+/*
+ * Support for SD card slot in personality board
+ */
+static int mx31_3ds_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
+			       void *data)
+{
+	int ret;
+	int gpio_det, gpio_bus_en;
+
+	gpio_det = IOMUX_TO_GPIO(MX31_PIN_GPIO3_1);
+	gpio_bus_en = IOMUX_TO_GPIO(MX31_PIN_GPIO3_0);
+
+	ret = gpio_request(gpio_det, "sdhc1-card-detect");
+	if (ret) {
+		pr_warning("Unable to request the SD/MMC card-detect GPIO.\n");
+		return ret;
+	}
+
+	ret = gpio_request(gpio_bus_en, "sdhc1-bus-enable");
+	if (ret) {
+		pr_warning("Unable to request the SD/MMC bus enable GPIO.\n");
+		goto gpio_free_be;
+	}
+
+	ret = gpio_direction_input(gpio_det);
+	if (ret) {
+		pr_warning("Unable to manage the SD/MMC card-detect GPIO.\n");
+		goto gpio_free_all;
+	}
+
+	ret = gpio_direction_output(gpio_bus_en, 0);
+	if (ret) {
+		pr_warning("Unable to manage the SD/MMC bus enable GPIO.\n");
+		goto gpio_free_all;
+	}
+
+	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
+			  detect_irq, IRQF_DISABLED |
+			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			  "sdhc1-detect", data);
+	if (ret) {
+		pr_warning("Unable to request the SD/MMC card-detect IRQ.\n");
+		goto gpio_free_all;
+	}
+
+	return 0;
+
+gpio_free_all:
+	gpio_free(gpio_bus_en);
+gpio_free_be:
+	gpio_free(gpio_det);
+	return ret;
+}
+
+static void mx31_3ds_sdhc1_exit(struct device *dev, void *data)
+{
+	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1), data);
+	gpio_free(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+	gpio_free(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0));
+}
+
+static void mx31_3ds_sdhc1_setpower(struct device *dev, unsigned int vdd)
+{
+	/*
+	 * While the voltage stuff is done by the driver, activate the
+	 * Buffer Enable Pin only if there is a card in slot to fix the card
+	 * voltage issue caused by bi-directional chip TXB0108 on 3Stack.
+	 * Done here because at this stage we have for sure a debounced value
+	 * of the presence of the card, showed by the value of vdd.
+	 * 7 == ilog2(MMC_VDD_165_195)
+	 */
+	if (vdd > 7)
+		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0), 1);
+	else
+		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0), 0);
+}
+
+static struct imxmmc_platform_data sdhc1_pdata = {
+	.init	= mx31_3ds_sdhc1_init,
+	.exit	= mx31_3ds_sdhc1_exit,
+	.setpower = mx31_3ds_sdhc1_setpower,
 };
 
 /*
@@ -132,11 +225,26 @@ static struct regulator_init_data pwgtx_init = {
 
 static struct regulator_init_data gpo_init = {
 	.constraints = {
-		.boot_on = 1,
-		.always_on = 1,
+		.boot_on	= 1,
+		.always_on	= 1,
 	}
 };
 
+static struct regulator_consumer_supply vmmc2_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "mxc-mmc.0"),
+};
+
+static struct regulator_init_data vmmc2_init = {
+	.constraints = {
+		.min_uV = 3000000,
+		.max_uV = 3000000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vmmc2_consumers),
+	.consumer_supplies = vmmc2_consumers,
+};
+
 static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_PWGT1SPI, /* Power Gate for ARM core. */
@@ -151,6 +259,9 @@ static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_GPO3, /* Turn on 3.3V */
 		.init_data = &gpo_init,
+	}, {
+		.id = MC13783_REG_VMMC2, /* Power MMC/SD, WiFi/Bluetooth. */
+		.init_data = &vmmc2_init,
 	},
 };
 
@@ -362,6 +473,7 @@ static void __init mx31_3ds_init(void)
 				    "devices on the debug board are unusable.\n");
 	imx31_add_imx2_wdt(NULL);
 	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
+	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 }
 
 static void __init mx31_3ds_timer_init(void)
-- 
1.7.1
