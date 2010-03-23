From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 23 Mar 2010 19:53:58 +0100
Subject: [PATCH 5/8] MXC: mach-mx31_3ds: Add support for SD card slot in
	the personality board.
In-Reply-To: <1269370305.3276.171.camel@realization>
References: <1269369741.3276.162.camel@realization>
	<1269370017.3276.165.camel@realization>
	<1269370175.3276.168.camel@realization>
	<1269370228.3276.169.camel@realization>
	<1269370305.3276.171.camel@realization>
Message-ID: <1269370438.3276.173.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lock detection goes through the pmic and need to be implemented.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |  164 +++++++++++++++++++++++++++++++++++++
 1 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index f54af1e..51e060c 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -26,6 +26,9 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/consumer.h>
+#include <linux/log2.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -39,6 +42,7 @@
 #include <mach/iomux-mx3.h>
 #include <mach/mxc_nand.h>
 #include <mach/spi.h>
+#include <mach/mmc.h>
 #include "devices.h"
 
 /*!
@@ -65,6 +69,112 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_CSPI2_SS2__SS2, /*CS for MC13783 */
 	/* MC13783 IRQ */
 	IOMUX_MODE(MX31_PIN_GPIO1_3, IOMUX_CONFIG_GPIO),
+	/* SDHC1 */
+	MX31_PIN_SD1_DATA3__SD1_DATA3,
+	MX31_PIN_SD1_DATA2__SD1_DATA2,
+	MX31_PIN_SD1_DATA1__SD1_DATA1,
+	MX31_PIN_SD1_DATA0__SD1_DATA0,
+	MX31_PIN_SD1_CLK__SD1_CLK,
+	MX31_PIN_SD1_CMD__SD1_CMD,
+	MX31_PIN_GPIO3_0__GPIO3_0, /*OE*/
+};
+
+/*
+ * Support for SD card slot in personality board
+ */
+static struct regulator *vmmc_reg;
+
+static int mx31_3ds_sd1_init(struct device *dev,
+				   irq_handler_t detect_irq, void *data)
+{
+	int ret;
+	int gpio_det, gpio_bus_en;
+
+	gpio_det = IOMUX_TO_GPIO(MX31_PIN_GPIO3_1);
+	gpio_bus_en = IOMUX_TO_GPIO(MX31_PIN_GPIO3_0);
+
+	ret = gpio_request(gpio_det, "sd1-card-detect");
+	if (ret) {
+		pr_warning("Unable to request sd card detect gpio.\n");
+		return ret;
+	}
+
+	ret = gpio_request(gpio_bus_en, "sd1-bus-enable");
+	if (ret) {
+		pr_warning("Unable to request sd card bus enable gpio.\n");
+		goto gpio_free;
+	}
+
+	gpio_direction_input(gpio_det);
+	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
+			  detect_irq, IRQF_DISABLED |
+			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			  "sd1-detect", data);
+
+	if (ret) {
+		pr_warning("Unable to request sd card detect irq.\n");
+		goto gpio_free_all;
+	}
+
+	vmmc_reg = regulator_get(dev, "sd1_vdd");
+
+	if (IS_ERR(vmmc_reg)) {
+		pr_err("%s: Unable to get VMMC2 regulator\n", __func__);
+		goto gpio_free_all;
+	}
+
+	return 0;
+
+gpio_free_all:
+	gpio_free(gpio_bus_en);
+gpio_free:
+	gpio_free(gpio_det);
+	return ret;
+}
+
+static void mx31_3ds_sd1_exit(struct device *dev, void *data)
+{
+	/* Free SD regulator, CardDetect irq and gpio */
+	regulator_put(vmmc_reg);
+	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1), data);
+	gpio_free(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+	gpio_free(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0));
+}
+
+static void mx31_3ds_setpower(struct device *dev, unsigned int vdd)
+{
+	int voltage = 0;
+
+	if (vdd <= ilog2(MMC_VDD_165_195))
+		voltage = 1800000;
+	else if (vdd == ilog2(MMC_VDD_20_21))
+		voltage = 2000000;
+	else
+		voltage = 2000000 + (vdd - 7) * 100000;
+
+	pr_debug("%s: vdd = %d -> REGU_VMMC2 = %d\n", __func__, vdd, voltage);
+
+	regulator_set_voltage(vmmc_reg, voltage, voltage);
+
+	/*
+	 * Active the Buffer Enable Pin only if there is
+	 * a card in slot.
+	 * To fix the card voltage issue caused by
+	 * bi-directional chip TXB0108 on 3Stack
+	 */
+	if (voltage > 1800000)
+		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0), 1);
+	else
+		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_GPIO3_0), 0);
+}
+
+static struct imxmmc_platform_data sdhc1_pdata = {
+	.init	= mx31_3ds_sd1_init,
+	.exit	= mx31_3ds_sd1_exit,
+	.ocr_avail = MMC_VDD_165_195 | MMC_VDD_20_21 | MMC_VDD_25_26 |
+		     MMC_VDD_26_27 | MMC_VDD_27_28 | MMC_VDD_28_29 |
+		     MMC_VDD_29_30,
+	.setpower = mx31_3ds_setpower,
 };
 
 /* Regulators */
@@ -75,6 +185,46 @@ static struct regulator_init_data pwgtx_init = {
 	},
 };
 
+static struct regulator_init_data gpo1_init = {
+	.constraints = {
+		.boot_on	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_consumer_supply gpo3_consumers[] = {
+	{
+		.dev	= &mxcsdhc_device0.dev,
+		.supply	= "vdd_sd1_io",
+	},
+};
+
+static struct regulator_init_data gpo3_init = {
+	.constraints = {
+		.boot_on	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(gpo3_consumers),
+	.consumer_supplies = gpo3_consumers,
+};
+
+static struct regulator_consumer_supply vmmc2_consumers[] = {
+	{
+		.dev	= &mxcsdhc_device0.dev,
+		.supply	= "sd1_vdd",
+	},
+};
+
+static struct regulator_init_data vmmc2_init = {
+	.constraints = {
+		.min_uV = 1600000,
+		.max_uV = 3000000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vmmc2_consumers),
+	.consumer_supplies = vmmc2_consumers,
+};
+
 static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REGU_PWGT1SPI, /* Power Gate for ARM core. */
@@ -82,6 +232,18 @@ static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REGU_PWGT2SPI, /* Power Gate for L2 Cache. */
 		.init_data = &pwgtx_init,
+	}, {
+		.id = MC13783_REGU_GPO1, /* GPO1 -> enables 3v
+					  * for personality. */
+		.init_data = &gpo1_init,
+	}, {
+		.id = MC13783_REGU_GPO3, /* GPO3 -> enables SW2B 1.8V out
+					  * this becomes 1V8 on personality
+					  * board. */
+		.init_data = &gpo3_init,
+	}, {
+		.id = MC13783_REGU_VMMC2,
+		.init_data = &vmmc2_init,
 	},
 };
 
@@ -315,6 +477,8 @@ static void __init mxc_board_init(void)
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
+	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
+
 	if (!mx31_3ds_init_expio())
 		platform_device_register(&smsc911x_device);
 }
-- 
1.6.3.3
