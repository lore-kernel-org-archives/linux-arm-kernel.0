From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:53:39 +0530
Subject: [PATCH v4 36/39] ARM: OMAP2+: board rx51: gpmc driver adaptation
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Message-ID: <5841f9504787c7d7cf5066c197ef53dcb6a2b18b.1335874494.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ae957c9..af7909e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -73,6 +73,13 @@ enum {
 static struct wl12xx_platform_data wl1251_pdata;
 static struct tsc2005_platform_data tsc2005_pdata;
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
 static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
 	.cover_comp_gain = 16,
@@ -1039,7 +1046,11 @@ static void __init board_smc91x_init(void)
 	omap_mux_init_gpio(86, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(164, OMAP_PIN_OUTPUT);
 
-	gpmc_smc91x_init(&board_smc91x_data);
+	*gpmc_cur = gpmc_smc91x_init(&board_smc91x_data);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: gpmc smsc911x setup\n");
 }
 
 #else
@@ -1136,8 +1147,10 @@ void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
 	regulator_has_full_constraints();
-	gpmc_onenand_init(board_onenand_data);
+	*gpmc_cur++ = gpmc_onenand_init(board_onenand_data);
+	gpmc_data.num_device++;
 	board_smc91x_init();
+	omap_init_gpmc(&gpmc_data);
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
 	rx51_init_tsc2005();
-- 
1.7.10
