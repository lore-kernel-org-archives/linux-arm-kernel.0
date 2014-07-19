From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 20 Jul 2014 01:49:17 +0200
Subject: [PATCH 2/3] pinctrl: rockchip: add separate type for rk3288
In-Reply-To: <3086962.49c4Dnm508@diego>
References: <3086962.49c4Dnm508@diego>
Message-ID: <12335737.BWge8alrAi@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An upcoming pinctrl function of the rk3288 differs again from everything else,
so we'll need a separate type for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 37339a1..58c4647 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -62,6 +62,7 @@ enum rockchip_pinctrl_type {
 	RK2928,
 	RK3066B,
 	RK3188,
+	RK3288,
 };
 
 /**
@@ -597,7 +598,8 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 		return !(data & BIT(bit))
 				? PIN_CONFIG_BIAS_PULL_PIN_DEFAULT
 				: PIN_CONFIG_BIAS_DISABLE;
 	case RK3188:
+	case RK3288:
 		data >>= bit;
 		data &= (1 << RK3188_PULL_BITS_PER_PIN) - 1;
 
@@ -651,6 +653,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 		spin_unlock_irqrestore(&bank->slock, flags);
 		break;
 	case RK3188:
+	case RK3288:
 		spin_lock_irqsave(&bank->slock, flags);
 
 		/* enable the write to the equivalent lower bits */
@@ -830,6 +833,7 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 	case RK3066B:
 		return pull ? false : true;
 	case RK3188:
+	case RK3288:
 		return (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT);
 	}
 
@@ -1864,7 +1868,7 @@ static struct rockchip_pin_ctrl rk3288_pin_ctrl = {
 		.pin_banks		= rk3288_pin_banks,
 		.nr_banks		= ARRAY_SIZE(rk3288_pin_banks),
 		.label			= "RK3288-GPIO",
-		.type			= RK3188,
+		.type			= RK3288,
 		.grf_mux_offset		= 0x0,
 		.pmu_mux_offset		= 0x84,
 		.pull_calc_reg		= rk3288_calc_pull_reg_and_bit,
-- 
1.9.0
