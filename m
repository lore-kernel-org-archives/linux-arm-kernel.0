From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 30 Dec 2017 16:23:29 +0100
Subject: [PATCH 2/3] mfd: axp20x: Add support for backup battery charging
In-Reply-To: <20171230152330.28946-1-contact@paulk.fr>
References: <20171230152330.28946-1-contact@paulk.fr>
Message-ID: <20171230152330.28946-3-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for backup battery charging for axp20x PMICs, that is
configured through a dedicated device-tree property.

It supports 4 different charging voltages and as many charging currents.
This is especially useful to allow the on-chip RTC (on the SoC side) to
be powered when the rest of the system is off.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 2468b431bb22..7847f5d0b979 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -34,6 +34,16 @@
 #define AXP806_REG_ADDR_EXT_ADDR_MASTER_MODE	0
 #define AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE	BIT(4)
 
+#define AXP20X_CHRG_BAK_CTRL_ENABLE		BIT(7)
+#define AXP20X_CHRG_BAK_VOLTAGE_3100_MV		(0 << 5)
+#define AXP20X_CHRG_BAK_VOLTAGE_3000_MV		(1 << 5)
+#define AXP20X_CHRG_BAK_VOLTAGE_3600_MV		(2 << 5)
+#define AXP20X_CHRG_BAK_VOLTAGE_2500_MV		(3 << 5)
+#define AXP20X_CHRG_BAK_CURRENT_50_UA		(0 << 0)
+#define AXP20X_CHRG_BAK_CURRENT_100_UA		(1 << 0)
+#define AXP20X_CHRG_BAK_CURRENT_200_UA		(2 << 0)
+#define AXP20X_CHRG_BAK_CURRENT_400_UA		(3 << 0)
+
 static const char * const axp20x_model_names[] = {
 	"AXP152",
 	"AXP202",
@@ -894,6 +904,63 @@ static void axp20x_power_off(void)
 	msleep(500);
 }
 
+static void axp20x_backup_setup(struct axp20x_dev *axp20x)
+{
+	u32 backup[2];
+	int reg;
+	int ret;
+
+	ret = of_property_read_u32_array(axp20x->dev->of_node, "backup", backup,
+					 2);
+	if (ret != 0)
+		return;
+
+	switch (axp20x->variant) {
+	case AXP202_ID:
+	case AXP209_ID:
+		reg = AXP20X_CHRG_BAK_CTRL_ENABLE;
+
+		/* Charging voltage. */
+		switch (backup[0]) {
+		case 2500:
+			reg |= AXP20X_CHRG_BAK_VOLTAGE_2500_MV;
+			break;
+		case 3000:
+			reg |= AXP20X_CHRG_BAK_VOLTAGE_3000_MV;
+			break;
+		case 3100:
+			reg |= AXP20X_CHRG_BAK_VOLTAGE_3100_MV;
+			break;
+		case 3600:
+			reg |= AXP20X_CHRG_BAK_VOLTAGE_3600_MV;
+			break;
+		default:
+			return;
+		}
+
+		/* Charging current. */
+		switch (backup[1]) {
+		case 50:
+			reg |= AXP20X_CHRG_BAK_CURRENT_50_UA;
+			break;
+		case 100:
+			reg |= AXP20X_CHRG_BAK_CURRENT_100_UA;
+			break;
+		case 200:
+			reg |= AXP20X_CHRG_BAK_CURRENT_200_UA;
+			break;
+		case 400:
+			reg |= AXP20X_CHRG_BAK_CURRENT_400_UA;
+			break;
+		default:
+			return;
+		}
+
+		regmap_write(axp20x->regmap, AXP20X_CHRG_BAK_CTRL, reg);
+		break;
+	}
+}
+
 int axp20x_match_device(struct axp20x_dev *axp20x)
 {
 	struct device *dev = axp20x->dev;
@@ -1023,6 +1090,9 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 				     AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE);
 	}
 
+	/* Backup RTC battery. */
+	axp20x_backup_setup(axp20x);
+
 	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
 			  IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
 			   -1, axp20x->regmap_irq_chip, &axp20x->regmap_irqc);
-- 
2.15.1
