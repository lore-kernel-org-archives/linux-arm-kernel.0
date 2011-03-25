From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 25 Mar 2011 09:28:58 -0600
Subject: [PATCH 5/8] ux500: adding SDI support for snowball board
In-Reply-To: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
References: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1301066941-15877-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Makefile           |    2 +-
 arch/arm/mach-ux500/board-mop500-sdi.c |   31 ++++++++++++++++++++++++-------
 arch/arm/mach-ux500/board-mop500.h     |    5 +++++
 arch/arm/mach-ux500/board-snowball.c   |    1 +
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index d74f303..016cb9f 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-pins.o
 obj-$(CONFIG_MACH_U8500_SNOWBALL) += board-snowball.o \
 				board-snowball-pins.o \
-				board-mop500-regulators.o
+				board-mop500-regulators.o board-mop500-sdi.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index bf0b024..4ca069c 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -35,10 +35,17 @@
 static u32 mop500_sdi0_vdd_handler(struct device *dev, unsigned int vdd,
 				   unsigned char power_mode)
 {
+	int gpio;
+
+	if (!machine_is_snowball())
+		gpio = GPIO_SDMMC_EN;
+	else
+               gpio = SNOWBALL_SDMMC_EN_GPIO;
+
 	if (power_mode == MMC_POWER_UP)
-		gpio_set_value_cansleep(GPIO_SDMMC_EN, 1);
+		gpio_set_value_cansleep(gpio, 1);
 	else if (power_mode == MMC_POWER_OFF)
-		gpio_set_value_cansleep(GPIO_SDMMC_EN, 0);
+		gpio_set_value_cansleep(gpio, 0);
 
 	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
 	       MCI_DATA2DIREN | MCI_DATA31DIREN;
@@ -191,15 +198,25 @@ void __init mop500_sdi_init(void)
 	/* PoP:ed eMMC on top of DB8500 v1.0 has problems with high speed */
 	if (!cpu_is_u8500v10())
 		mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-	db8500_add_sdi2(&mop500_sdi2_data);
+
+	/* sdi2 on snowball is in ATL_B mode for FSMC (LAN) */
+	if (!machine_is_snowball())
+		db8500_add_sdi2(&mop500_sdi2_data);
 
 	/* On-board eMMC */
 	db8500_add_sdi4(&mop500_sdi4_data);
 
-	if (machine_is_hrefv60()) {
-		mop500_sdi0_data.gpio_cd = HREFV60_SDMMC_CD_GPIO;
-		sdi0_en = HREFV60_SDMMC_EN_GPIO;
-		sdi0_vsel = HREFV60_SDMMC_1V8_3V_GPIO;
+	if (machine_is_hrefv60() || machine_is_snowball()) {
+		if (machine_is_hrefv60()) {
+			mop500_sdi0_data.gpio_cd = HREFV60_SDMMC_CD_GPIO;
+			sdi0_en = HREFV60_SDMMC_EN_GPIO;
+			sdi0_vsel = HREFV60_SDMMC_1V8_3V_GPIO;
+		} else if (machine_is_snowball()) {
+			mop500_sdi0_data.gpio_cd = SNOWBALL_SDMMC_CD_GPIO;
+			mop500_sdi0_data.cd_invert = true;
+			sdi0_en = SNOWBALL_SDMMC_EN_GPIO;
+			sdi0_vsel = SNOWBALL_SDMMC_1V8_3V_GPIO;
+		}
 		sdi0_configure();
 	}
 	/*
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 56722f4..8c8e665 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -7,6 +7,11 @@
 #ifndef __BOARD_MOP500_H
 #define __BOARD_MOP500_H
 
+/* snowball GPIO for MMC card */
+#define SNOWBALL_SDMMC_EN_GPIO 217
+#define SNOWBALL_SDMMC_1V8_3V_GPIO 228
+#define SNOWBALL_SDMMC_CD_GPIO 218
+
 /* HREFv60-specific GPIO assignments, this board has no GPIO expander */
 #define HREFV60_TOUCH_RST_GPIO		143
 #define HREFV60_PROX_SENSE_GPIO		217
diff --git a/arch/arm/mach-ux500/board-snowball.c b/arch/arm/mach-ux500/board-snowball.c
index ab152ee..ec6ec9f 100644
--- a/arch/arm/mach-ux500/board-snowball.c
+++ b/arch/arm/mach-ux500/board-snowball.c
@@ -342,6 +342,7 @@ static void __init mop500_init_machine(void)
 	snowball_pins_init();
 
 	mop500_i2c_init();
+	mop500_sdi_init();
 	mop500_spi_init();
 	mop500_uart_init();
 
-- 
1.7.1
