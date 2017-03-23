From: john@metanate.com (John Keeping)
Date: Thu, 23 Mar 2017 10:59:30 +0000
Subject: [PATCH v4 3/4] pinctrl: rockchip: split out verification of mux
 settings
In-Reply-To: <20170323105931.10455-1-john@metanate.com>
References: <20170323105931.10455-1-john@metanate.com>
Message-ID: <20170323105931.10455-4-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to avoid calling regmap functions from irq handlers, so the next
commit is going to move the call to rockchip_set_mux() into an
irq_bus_sync_unlock handler.  But we can't return an error from there so
we still need to check the settings from rockchip_irq_set_type() and we
will use this new rockchip_verify_mux() function from there.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
v3: unchanged
v2: unchanged
---
 drivers/pinctrl/pinctrl-rockchip.c | 46 +++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 5d5a9c4c522d..9dd981ddbb17 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -632,6 +632,31 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
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
@@ -655,23 +680,12 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
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
