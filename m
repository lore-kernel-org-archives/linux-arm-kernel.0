From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 31 May 2017 08:14:56 +0200
Subject: [PATCH v2 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
In-Reply-To: <20170531061457.23744-1-o.rempel@pengutronix.de>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
Message-ID: <20170531061457.23744-6-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some boards the SoC can use one pin "PMIC_STBY_REQ" to notify th PMIC
about state changes. In this case internal state of PMIC must be
preconfigured for upcomming state change.
It works fine with the current regulator framework, except with the
power-off case.

This patch is providing an optional pm_power_off_prepare handler
which will configure the PMIC_StandBy state to disable all power lines.

In my power consumption test on RIoTBoard, I got the following results:
poweroff without this patch:	320 mA
poweroff with this patch:	2   mA
suspend to ram:			40  mA

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-kernel at vger.kernel.org
---
 drivers/regulator/pfuze100-regulator.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 63922a2167e5..505852dd38f5 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/pfuze100.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
+#include <linux/kallsyms.h>
 #include <linux/regmap.h>
 
 #define PFUZE_NUMREGS		128
@@ -42,11 +43,17 @@
 
 #define PFUZE100_COINVOL	0x1a
 #define PFUZE100_SW1ABVOL	0x20
+#define PFUZE100_SW1ABMODE	0x23
 #define PFUZE100_SW1CVOL	0x2e
+#define PFUZE100_SW1CMODE	0x31
 #define PFUZE100_SW2VOL		0x35
+#define PFUZE100_SW2MODE	0x38
 #define PFUZE100_SW3AVOL	0x3c
+#define PFUZE100_SW3AMODE	0x3f
 #define PFUZE100_SW3BVOL	0x43
+#define PFUZE100_SW3BMODE	0x46
 #define PFUZE100_SW4VOL		0x4a
+#define PFUZE100_SW4MODE	0x4d
 #define PFUZE100_SWBSTCON1	0x66
 #define PFUZE100_VREFDDRCON	0x6a
 #define PFUZE100_VSNVSVOL	0x6b
@@ -57,6 +64,13 @@
 #define PFUZE100_VGEN5VOL	0x70
 #define PFUZE100_VGEN6VOL	0x71
 
+#define PFUZE100_SWxMODE_MASK	0xf
+#define PFUZE100_SWxMODE_APS_APS	0x8
+#define PFUZE100_SWxMODE_APS_OFF	0x4
+
+#define PFUZE100_VGENxLPWR	BIT(6)
+#define PFUZE100_VGENxSTBY	BIT(5)
+
 enum chips { PFUZE100, PFUZE200, PFUZE3000 = 3 };
 
 struct pfuze_regulator {
@@ -489,6 +503,64 @@ static inline struct device_node *match_of_node(int index)
 }
 #endif
 
+static struct pfuze_chip *syspm_pfuze_chip;
+
+static void pfuze_poweroff_pre(void)
+{
+	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for poweroff");
+
+	/* Switch from default mode: APS/APS to APS/Off */
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW1ABMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW1CMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW2MODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW3AMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW3BMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW4MODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN1VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN2VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN3VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN4VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN5VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN6VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+}
+
+static int pfuze_poweroff_pre_init(struct pfuze_chip *pfuze_chip)
+{
+	if (pfuze_chip->chip_id != PFUZE100) {
+		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supoorted chip\n");
+		return -ENODEV;
+	}
+
+	if (pm_power_off_prepare) {
+		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registred.\n");
+		return -EBUSY;
+	}
+
+	syspm_pfuze_chip = pfuze_chip;
+	pm_power_off_prepare = pfuze_poweroff_pre;
+
+	return 0;
+}
+
 static int pfuze_identify(struct pfuze_chip *pfuze_chip)
 {
 	unsigned int value;
@@ -659,6 +731,10 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 		}
 	}
 
+	if (of_property_read_bool(client->dev.of_node,
+				  "fsl,pmic_stby_poweroff"))
+		return pfuze_poweroff_pre_init(pfuze_chip);
+
 	return 0;
 }
 
-- 
2.11.0
