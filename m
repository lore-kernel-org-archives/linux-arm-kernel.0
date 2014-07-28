From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 28 Jul 2014 14:24:38 +0300
Subject: [PATCH 2/2] ARM: davinci: board-da850-evm: Add needed regulators for
 tlv320aic3106 codec
In-Reply-To: <1406546678-797-1-git-send-email-peter.ujfalusi@ti.com>
References: <1406546678-797-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1406546678-797-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOVDD: tps65070's dcdc2
AVDD and DRVDD: fixed regulator derived from 5V via TPS73701DCQ
DVDD: fixed regulator derived from 5V via TPS73701DCQ

This patch needed to be able to probe the audio codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 77d8968336df..41eb05907f31 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -35,6 +35,7 @@
 #include <linux/platform_data/uio_pruss.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps6507x.h>
+#include <linux/regulator/fixed.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/wl12xx.h>
@@ -841,6 +842,15 @@ static int da850_lcd_hw_init(void)
 
 	return 0;
 }
+/* Fixed regulator support */
+static struct regulator_consumer_supply fixed_supplies[] = {
+	/* Baseboard 3.3V: 5V -> TPS73701DCQ -> 3.3V */
+	REGULATOR_SUPPLY("AVDD", "1-0018"),
+	REGULATOR_SUPPLY("DRVDD", "1-0018"),
+
+	/* Baseboard 1.8V: 5V -> TPS73701DCQ -> 1.8V */
+	REGULATOR_SUPPLY("DVDD", "1-0018"),
+};
 
 /* TPS65070 voltage regulator support */
 
@@ -865,6 +875,7 @@ static struct regulator_consumer_supply tps65070_dcdc2_consumers[] = {
 	{
 		.supply = "dvdd3318_c",
 	},
+	REGULATOR_SUPPLY("IOVDD", "1-0018"),
 };
 
 /* 1.2V */
@@ -1447,6 +1458,8 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
 
+	regulator_register_fixed(0, fixed_supplies, ARRAY_SIZE(fixed_supplies));
+
 	ret = pmic_tps65070_init();
 	if (ret)
 		pr_warn("%s: TPS65070 PMIC init failed: %d\n", __func__, ret);
-- 
2.0.2
