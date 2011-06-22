From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 13:35:14 +0200
Subject: [PATCH 3/6] mach-ux500: Add SDI support for snowball board
Message-ID: <1308742514-24514-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

With SDI support for the Snowball we can boot from the
SD card.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Robert Marklund <robert.marklund@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   19 ++++++++++++++-----
 arch/arm/mach-ux500/board-mop500.c     |    3 +--
 arch/arm/mach-ux500/board-mop500.h     |    5 +++++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 5fbd6bc..d0cb9e5 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -216,15 +216,24 @@ void __init mop500_sdi_init(void)
 	/* PoP:ed eMMC on top of DB8500 v1.0 has problems with high speed */
 	if (!cpu_is_u8500v10())
 		mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-	db8500_add_sdi2(&mop500_sdi2_data, periphid);
+	/* sdi2 on snowball is in ATL_B mode for FSMC (LAN) */
+	if (!machine_is_snowball())
+		db8500_add_sdi2(&mop500_sdi2_data, periphid);
 
 	/* On-board eMMC */
 	db8500_add_sdi4(&mop500_sdi4_data, periphid);
 
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
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index e3bbb55..4eead1a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -573,8 +573,7 @@ static void __init mop500_init_machine(void)
 					ARRAY_SIZE(mop500_platform_devs));
 
 	mop500_i2c_init();
-	if (!machine_is_snowball())
-		mop500_sdi_init();
+	mop500_sdi_init();
 	mop500_spi_init();
 	mop500_uart_init();
 
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 03a31cc..ee77a89 100644
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
-- 
1.7.3.2
