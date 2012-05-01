From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:53:20 +0530
Subject: [PATCH v4 33/39] ARM: OMAP2+: board omap4pcm049: gpmc driver
 adaptation
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Message-ID: <5defad2fdc7a94ccb4275b544a8396c18aa46093.1335874494.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap4pcm049.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index 81de7d5..b4ead86 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -130,6 +130,12 @@ static struct omap2_hsmmc_info mmc[] = {
 	}, {}	/* Terminator */
 };
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
@@ -147,7 +153,11 @@ static inline void __init pcm049_init_smsc911x(void)
 {
 	omap_mux_init_gpio(OMAP4_PCM049_ETH_GPIO_IRQ, OMAP_PIN_INPUT);
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-	gpmc_smsc911x_init(&board_smsc911x_data);
+	*gpmc_device_data = gpmc_smsc911x_init(&board_smsc911x_data);
+	if (*gpmc_device_data)
+		gpmc_data.num_device++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 #else
 static inline void __init pcm049_init_smsc911x(void) { return; }
@@ -562,6 +572,7 @@ static void __init pcm049_init(void)
 	pm_power_off = pcm049_power_off;
 	omap4_mux_init(board_mux, NULL, OMAP_PACKAGE_CBS);
 	pcm049_init_smsc911x();
+	omap_init_gpmc(&gpmc_data);
 	pcm049_i2c_init();
 	platform_add_devices(pcm049_devices, ARRAY_SIZE(pcm049_devices));
 	board_serial_init();
-- 
1.7.10
