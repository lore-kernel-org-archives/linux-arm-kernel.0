From: john@metanate.com (John Keeping)
Date: Wed, 15 Mar 2017 17:46:51 +0000
Subject: [PATCH v2 1/4] pinctrl: rockchip: remove unnecessary locking
In-Reply-To: <20170315174654.15128-1-john@metanate.com>
References: <20170315174654.15128-1-john@metanate.com>
Message-ID: <20170315174654.15128-2-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_update_bits does its own locking and everything else accessed
here is a local variable so there is no need to lock around it.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
v2:
- Also remove locking in rockchip_set_schmitt()
---
 drivers/pinctrl/pinctrl-rockchip.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 1e276dfe1763..128c383ea7ba 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -652,7 +652,6 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	int iomux_num = (pin / 8);
 	struct regmap *regmap;
 	int reg, ret, mask, mux_type;
-	unsigned long flags;
 	u8 bit;
 	u32 data, rmask;
 
@@ -701,15 +700,11 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	if (ctrl->iomux_recalc && (mux_type & IOMUX_RECALCED))
 		ctrl->iomux_recalc(bank->bank_num, pin, &reg, &bit, &mask);
 
-	spin_lock_irqsave(&bank->slock, flags);
-
 	data = (mask << (bit + 16));
 	rmask = data | (data >> 16);
 	data |= (mux & mask) << bit;
 	ret = regmap_update_bits(regmap, reg, rmask, data);
 
-	spin_unlock_irqrestore(&bank->slock, flags);
-
 	return ret;
 }
 
@@ -1135,7 +1130,6 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 	struct rockchip_pinctrl *info = bank->drvdata;
 	struct rockchip_pin_ctrl *ctrl = info->ctrl;
 	struct regmap *regmap;
-	unsigned long flags;
 	int reg, ret, i;
 	u32 data, rmask, rmask_bits, temp;
 	u8 bit;
@@ -1163,8 +1157,6 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 		return ret;
 	}
 
-	spin_lock_irqsave(&bank->slock, flags);
-
 	switch (drv_type) {
 	case DRV_TYPE_IO_1V8_3V0_AUTO:
 	case DRV_TYPE_IO_3V3_ONLY:
@@ -1185,17 +1177,14 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 			rmask = BIT(15) | BIT(31);
 			data |= BIT(31);
 			ret = regmap_update_bits(regmap, reg, rmask, data);
-			if (ret) {
-				spin_unlock_irqrestore(&bank->slock, flags);
+			if (ret)
 				return ret;
-			}
 
 			rmask = 0x3 | (0x3 << 16);
 			temp |= (0x3 << 16);
 			reg += 0x4;
 			ret = regmap_update_bits(regmap, reg, rmask, temp);
 
-			spin_unlock_irqrestore(&bank->slock, flags);
 			return ret;
 		case 18 ... 21:
 			/* setting fully enclosed in the second register */
@@ -1203,7 +1192,6 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 			bit -= 16;
 			break;
 		default:
-			spin_unlock_irqrestore(&bank->slock, flags);
 			dev_err(info->dev, "unsupported bit: %d for pinctrl drive type: %d\n",
 				bit, drv_type);
 			return -EINVAL;
@@ -1215,7 +1203,6 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 		rmask_bits = RK3288_DRV_BITS_PER_PIN;
 		break;
 	default:
-		spin_unlock_irqrestore(&bank->slock, flags);
 		dev_err(info->dev, "unsupported pinctrl drive type: %d\n",
 			drv_type);
 		return -EINVAL;
@@ -1227,7 +1214,6 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 	data |= (ret << bit);
 
 	ret = regmap_update_bits(regmap, reg, rmask, data);
-	spin_unlock_irqrestore(&bank->slock, flags);
 
 	return ret;
 }
@@ -1339,16 +1325,12 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 			return ret;
 		}
 
-		spin_lock_irqsave(&bank->slock, flags);
-
 		/* enable the write to the equivalent lower bits */
 		data = ((1 << RK3188_PULL_BITS_PER_PIN) - 1) << (bit + 16);
 		rmask = data | (data >> 16);
 		data |= (ret << bit);
 
 		ret = regmap_update_bits(regmap, reg, rmask, data);
-
-		spin_unlock_irqrestore(&bank->slock, flags);
 		break;
 	default:
 		dev_err(info->dev, "unsupported pinctrl type\n");
@@ -1408,7 +1390,6 @@ static int rockchip_set_schmitt(struct rockchip_pin_bank *bank,
 	struct rockchip_pin_ctrl *ctrl = info->ctrl;
 	struct regmap *regmap;
 	int reg, ret;
-	unsigned long flags;
 	u8 bit;
 	u32 data, rmask;
 
@@ -1419,16 +1400,11 @@ static int rockchip_set_schmitt(struct rockchip_pin_bank *bank,
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&bank->slock, flags);
-
 	/* enable the write to the equivalent lower bits */
 	data = BIT(bit + 16) | (enable << bit);
 	rmask = BIT(bit + 16) | BIT(bit);
 
-	ret = regmap_update_bits(regmap, reg, rmask, data);
-	spin_unlock_irqrestore(&bank->slock, flags);
-
-	return ret;
+	return regmap_update_bits(regmap, reg, rmask, data);
 }
 
 /*
-- 
2.12.0.377.gf910686b23.dirty
