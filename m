From: john@metanate.com (John Keeping)
Date: Mon, 13 Mar 2017 18:38:12 +0000
Subject: [RFC PATCH 3/4] pinctrl: rockchip: split out verification of mux
 settings
In-Reply-To: <20170313183813.3582-1-john@metanate.com>
References: <20170313183813.3582-1-john@metanate.com>
Message-ID: <20170313183813.3582-4-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to avoid calling regmap functions from irq handlers, so the next
commit is going to move the call to rockchip_set_mux() into an
irq_bus_sync_unlock handler.  But we can't return an error from there so
we still need to check the settings from rockchip_irq_set_type() and we
will use this new rockchip_verify_mux() function from there.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 46 +++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 2f963aea64b2..52e70c4aef7c 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -629,6 +629,31 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	return ((val >> bit) & mask);
 }
 
+static int rockchip_verify_mux(struct rockchip_pin_bank *bank,
+			       int pin, int mux)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	int iomux_num = (pin / 8);
+
+	if (iomux_num > 3)
+		return -EINVAL;
+
+	if (bank->iomux[iomux_num].type & IOMUX_UNROUTED) {
+		dev_err(info->dev, "pin %d is unrouted\n", pin);
+		return -EINVAL;
+	}
+
+	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY) {
+		if (mux != RK_FUNC_GPIO) {
+			dev_err(info->dev,
+				"pin %d only supports a gpio mux\n", pin);
+			return -ENOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Set a new mux function for a pin.
  *
@@ -652,23 +677,12 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	u8 bit;
 	u32 data, rmask;
 
-	if (iomux_num > 3)
-		return -EINVAL;
-
-	if (bank->iomux[iomux_num].type & IOMUX_UNROUTED) {
-		dev_err(info->dev, "pin %d is unrouted\n", pin);
-		return -EINVAL;
-	}
+	ret = rockchip_verify_mux(bank, pin, mux);
+	if (ret < 0)
+		return ret;
 
-	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY) {
-		if (mux != RK_FUNC_GPIO) {
-			dev_err(info->dev,
-				"pin %d only supports a gpio mux\n", pin);
-			return -ENOTSUPP;
-		} else {
-			return 0;
-		}
-	}
+	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
+		return 0;
 
 	dev_dbg(info->dev, "setting mux of GPIO%d-%d to %d\n",
 						bank->bank_num, pin, mux);
-- 
2.12.0.377.gf910686b23.dirty
