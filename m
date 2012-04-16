From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2012 10:25:46 +0100
Subject: [PATCH 6.1/7] ARM: ux500: Enable Device Tree support mmci for Snowball
In-Reply-To: <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
Message-ID: <4F8BE59A.6060106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 16 Apr 2012 10:11:03 +0100
Subject: [PATCH 6.1/7] ARM: ux500: Enable Device Tree support mmci for Snowball

Allow proper initialisation for MMC via the mmci driver
for the Snowball low-cost development board using DT. At
the moment we continue to use DMA setup from platform code.
Once the DMA generic DT bindings have been completed we
can then port the remainder over to DT.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts         |   21 ++++++++++++++++++---
 arch/arm/mach-ux500/board-mop500-sdi.c |    4 ++--
 arch/arm/mach-ux500/board-mop500.c     |    3 ++-
 arch/arm/mach-ux500/board-mop500.h     |    4 ++++
 4 files changed, 26 insertions(+), 6 deletions(-)

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
-- 
1.7.9.1
