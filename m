From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 18 Sep 2015 03:19:04 +0200
Subject: [PATCH v3 20/26] ARM: pxa: magician: Add support for MAX1587A Vcore
 regulator
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FB6688.3010505@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HTC Magician contains a MAX1587A voltage regulator for a Vcore supply.
The Vcore regulation is required for a CPU speed switching. This patch adds
declaration for the max1586 driver.

Notice:

- MAX1587A version does not support the V6 (USIM) output.
- A boost resistor was directly measured for a board_id 0x3a.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index d844b9c..490d79f 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -52,6 +52,8 @@
 #include <linux/platform_data/camera-pxa.h>
 #include <media/soc_camera.h>
 
+#include <linux/regulator/max1586.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -787,6 +789,52 @@ static struct platform_device vads7846_device = {
 };
 
 /*
+ * Vcore regulator MAX1587A
+ */
+
+static struct regulator_consumer_supply magician_max1587a_consumers[] = {
+	REGULATOR_SUPPLY("vcc_core", NULL),
+};
+
+static struct regulator_init_data magician_max1587a_v3_info = {
+	.constraints = {
+		.name		= "vcc_core range",
+		.min_uV		= 700000,
+		.max_uV		= 1500000,
+		.always_on	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.consumer_supplies	= magician_max1587a_consumers,
+	.num_consumer_supplies	= ARRAY_SIZE(magician_max1587a_consumers),
+};
+
+static struct max1586_subdev_data magician_max1587a_subdevs[] = {
+	{
+		.name		= "vcc_core",
+		.id		= MAX1586_V3,
+		.platform_data	= &magician_max1587a_v3_info,
+	}
+};
+
+static struct max1586_platform_data magician_max1587a_info = {
+	.subdevs     = magician_max1587a_subdevs,
+	.num_subdevs = ARRAY_SIZE(magician_max1587a_subdevs),
+	/*
+	 * NOTICE measured directly on the PCB (board_id == 0x3a), but
+	 * if R24 is present, it will boost the voltage
+	 * (write 1.475V, get 1.645V and smoke)
+	 */
+	.v3_gain     = MAX1586_GAIN_NO_R24,
+};
+
+static struct i2c_board_info magician_pwr_i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("max1586", 0x14),
+		.platform_data	= &magician_max1587a_info,
+	},
+};
+
+/*
  * MMC/SD
  */
 
@@ -1066,6 +1114,10 @@ static void __init magician_init(void)
 	pxa_set_ficp_info(&magician_ficp_info);
 	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
+
+	i2c_register_board_info(1,
+		ARRAY_AND_SIZE(magician_pwr_i2c_board_info));
+
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
 
-- 
1.7.12.1
