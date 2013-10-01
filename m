From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:37:03 +0900
Subject: [PATCH 03/12] ARM: shmobile: ape6evm: update MMC0,
 SDHI0 and SDHI1 with correct regulators
In-Reply-To: <cover.1380530519.git.horms+renesas@verge.net.au>
References: <cover.1380530519.git.horms+renesas@verge.net.au>
Message-ID: <8b98126d2ce701c7367deee60739904e17864523.1380530519.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Currently a dummy fixed always-on regulator is used for all 3 SD/MMC
interfaces on ape6evm. This patch updates the board to use correct supplies
for MMC0, SDHI0 and SDHI1 VDD. SDHI0 VccQ supply regulator should be
implemented in a separate patch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 54 +++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 24b87eea..02be420 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -113,16 +113,49 @@ static const struct smsc911x_platform_config lan9220_data __initconst = {
 };
 
 /*
- * On APE6EVM power is supplied to MMCIF by a tps80032 regulator. For now we
- * model a VDD supply to MMCIF, using a fixed 3.3V regulator. Also use the
- * static power supply for SDHI0 and SDHI1, whereas SDHI0's VccQ is also
- * supplied by the same tps80032 regulator and thus can also be adjusted
- * dynamically.
+ * MMC0 power supplies:
+ * Both Vcc and VccQ to eMMC on APE6EVM are supplied by a tps80032 voltage
+ * regulator. Until support for it is added to this file we simulate the
+ * Vcc supply by a fixed always-on regulator
  */
-static struct regulator_consumer_supply fixed3v3_power_consumers[] =
+static struct regulator_consumer_supply vcc_mmc0_consumers[] =
 {
 	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+};
+
+/*
+ * SDHI0 power supplies:
+ * Vcc to SDHI0 on APE6EVM is supplied by a GPIO-switchable regulator. VccQ is
+ * provided by the same tps80032 regulator as both MMC0 voltages - see comment
+ * above
+ */
+static struct regulator_consumer_supply vcc_sdhi0_consumers[] =
+{
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+};
+
+static struct regulator_init_data vcc_sdhi0_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(vcc_sdhi0_consumers),
+	.consumer_supplies      = vcc_sdhi0_consumers,
+};
+
+static const struct fixed_voltage_config vcc_sdhi0_info __initconst = {
+	.supply_name = "SDHI0 Vcc",
+	.microvolts = 3300000,
+	.gpio = 76,
+	.enable_high = 1,
+	.init_data = &vcc_sdhi0_init_data,
+};
+
+/*
+ * SDHI1 power supplies:
+ * Vcc and VccQ to SDHI1 on APE6EVM are both fixed at 3.3V
+ */
+static struct regulator_consumer_supply vcc_sdhi1_consumers[] =
+{
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
 };
 
@@ -215,14 +248,19 @@ static void __init ape6evm_add_standard_devices(void)
 	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
 					  lan9220_res, ARRAY_SIZE(lan9220_res),
 					  &lan9220_data, sizeof(lan9220_data));
-	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
-				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+
+	regulator_register_always_on(1, "MMC0 Vcc", vcc_mmc0_consumers,
+				     ARRAY_SIZE(vcc_mmc0_consumers), 2800000);
 	platform_device_register_resndata(&platform_bus, "sh_mmcif", 0,
 					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
 					  &mmcif0_pdata, sizeof(mmcif0_pdata));
+	platform_device_register_data(&platform_bus, "reg-fixed-voltage", 2,
+				      &vcc_sdhi0_info, sizeof(vcc_sdhi0_info));
 	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 0,
 					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
 					  &sdhi0_pdata, sizeof(sdhi0_pdata));
+	regulator_register_always_on(3, "SDHI1 Vcc", vcc_sdhi1_consumers,
+				     ARRAY_SIZE(vcc_sdhi1_consumers), 3300000);
 	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 1,
 					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
 					  &sdhi1_pdata, sizeof(sdhi1_pdata));
-- 
1.8.4
