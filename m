From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 15:05:08 +0100
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500 variants
In-Reply-To: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a means to collect attributes specific to ST-Ericsson's
ux500 variant series. This patch registers itself as the AMBA
driver to be called during the probe process. Once all
attributes and ux500 specifics are are collected the normal
mmci core probe is called.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts         |   21 ++++++++++--
 arch/arm/mach-ux500/board-mop500-sdi.c |    4 +-
 arch/arm/mach-ux500/board-mop500.c     |    3 +-
 arch/arm/mach-ux500/board-mop500.h     |    4 ++
 drivers/mmc/host/mmci.c                |   58 +++++++++++++++++++++++++++++--
 5 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 0cec47b..fb2a037 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -87,13 +87,28 @@
 			};
 		};
 
+		// External Micro SD slot
 		sdi at 80126000 {
-			status = "enabled";
-			cd-gpios = <&gpio6 26>;
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <50000000>;
+			bus-width = <8>;
+			mmc-cap-mmc-highspeed;
+
+			#gpio-cells = <1>;
+			cd-gpios  = <&gpio6 26>; // 218
+			cd-inverted;
+
+			status = "okay";
 		};
 
+		// On-board eMMC
 		sdi at 80114000 {
-			status = "enabled";
+			arm,primecell-periphid = <0x10480180>;
+		        max-frequency = <50000000>;
+			bus-width = <8>;
+			mmc-cap-mmc-highspeed;
+
+			status = "okay";
 		};
 
 		uart at 80120000 {
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 920251c..18ff781 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -80,7 +80,7 @@ static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
 };
 #endif
 
-static struct mmci_platform_data mop500_sdi0_data = {
+struct mmci_platform_data mop500_sdi0_data = {
 	.ios_handler	= mop500_sdi0_ios_handler,
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 50000000,
@@ -227,7 +227,7 @@ static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
 };
 #endif
 
-static struct mmci_platform_data mop500_sdi4_data = {
+struct mmci_platform_data mop500_sdi4_data = {
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 50000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 5064140..d68a73c 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -752,6 +752,8 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),
 	/* Requires DMA bindings. */
 	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
+	OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  &mop500_sdi0_data),
+	OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  &mop500_sdi4_data),
 	/* Requires clock name bindings. */
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e000, "gpio.0", NULL),
 	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e080, "gpio.1", NULL),
@@ -801,7 +803,6 @@ static void __init u8500_init_machine(void)
 		platform_add_devices(snowball_platform_devs,
 				ARRAY_SIZE(snowball_platform_devs));
 
-		snowball_sdi_init(parent);
 	} else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
 		/*
 		 * The HREFv60 board removed a GPIO expander and routed
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index fdcfa87..384baf7 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -7,6 +7,8 @@
 #ifndef __BOARD_MOP500_H
 #define __BOARD_MOP500_H
 
+#include <linux/amba/mmci.h>
+
 /* Snowball specific GPIO assignments, this board has no GPIO expander */
 #define SNOWBALL_ACCEL_INT1_GPIO	163
 #define SNOWBALL_ACCEL_INT2_GPIO	164
@@ -74,6 +76,8 @@
 #define SNOWBALL_EN_3V3_ETH_GPIO	MOP500_AB8500_PIN_GPIO(26)	/* GPIO26 */
 
 struct i2c_board_info;
+extern struct mmci_platform_data mop500_sdi0_data;
+extern struct mmci_platform_data mop500_sdi4_data;
 
 extern void mop500_sdi_init(struct device *parent);
 extern void snowball_sdi_init(struct device *parent);
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 032b847..5a7da17 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/highmem.h>
@@ -1196,21 +1197,70 @@ static const struct mmc_host_ops mmci_ops = {
 	.get_cd		= mmci_get_cd,
 };
 
+#ifdef CONFIG_OF
+static void mmci_dt_populate_generic_pdata(struct device_node *np,
+					struct mmci_platform_data *pdata)
+{
+	int bus_width = 0;
+
+	of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
+	if (!pdata->gpio_wp)
+		pdata->gpio_wp = -1;
+
+	of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
+	if (!pdata->gpio_cd)
+		pdata->gpio_cd = -1;
+
+	if (of_get_property(np, "cd-inverted", NULL))
+		pdata->cd_invert = true;
+	else
+		pdata->cd_invert = false;
+
+	of_property_read_u32(np, "max-frequency", &pdata->f_max);
+	if (!pdata->f_max)
+		pr_warn("%s has no 'max-frequency' property\n", np->full_name);
+
+	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
+		pdata->capabilities |= MMC_CAP_MMC_HIGHSPEED;
+	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
+		pdata->capabilities |= MMC_CAP_SD_HIGHSPEED;
+
+	of_property_read_u32(np, "bus-width", &bus_width);
+	switch (bus_width) {
+	case 0 :
+		/* No bus-width supplied. */
+		break;
+	case 4 :
+		pdata->capabilities |= MMC_CAP_4_BIT_DATA;
+		break;
+	case 8 :
+		pdata->capabilities |= MMC_CAP_8_BIT_DATA;
+		break;
+	default :
+		pr_warn("%s: Unsupported bus width\n", np->full_name);
+	}
+}
+#endif
+
 static int __devinit mmci_probe(struct amba_device *dev,
 	const struct amba_id *id)
 {
 	struct mmci_platform_data *plat = dev->dev.platform_data;
+	struct device_node *np = dev->dev.of_node;
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
 	int ret;
 
-	/* must have platform data */
-	if (!plat) {
-		ret = -EINVAL;
-		goto out;
+	/* Must have platform data or Device Tree. */
+	if (!plat && !np) {
+		dev_err(&dev->dev, "No plat data or DT found\n");
+		return -EINVAL;
 	}
 
+	if (np)
+		mmci_dt_populate_generic_pdata(np, plat);
+
 	ret = amba_request_regions(dev, DRIVER_NAME);
 	if (ret)
 		goto out;
-- 
1.7.9.1
