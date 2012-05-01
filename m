From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:39:39 +0530
Subject: [PATCH 30/39] ARM: OMAP2+: board omap3logic: gpmc driver adaptation
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Message-ID: <e040c11706547d01fb2744246d83c0cba30003ef.1335873032.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3logic.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 9b3c141..9867fc8 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -55,6 +55,12 @@
 #define OMAP3_TORPEDO_MMC_GPIO_CD		127
 #define OMAP3_TORPEDO_SMSC911X_GPIO_IRQ		129
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static struct regulator_consumer_supply omap3logic_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -180,7 +186,11 @@ static inline void __init board_smsc911x_init(void)
 		return;
 	}
 
-	gpmc_smsc911x_init(&board_smsc911x_data);
+	*gpmc_device_data = gpmc_smsc911x_init(&board_smsc911x_data);
+	if (*gpmc_device_data)
+		gpmc_data.num_device++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #ifdef CONFIG_OMAP_MUX
@@ -204,6 +214,7 @@ static void __init omap3logic_init(void)
 	omap_sdrc_init(NULL, NULL);
 	board_mmc_init();
 	board_smsc911x_init();
+	omap_init_gpmc(&gpmc_data);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.10
