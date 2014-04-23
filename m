From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 Apr 2014 14:27:51 +0200
Subject: [PATCH 1/2] pinctrl: rockchip: return a complete config in pinconf_get
Message-ID: <7604038.VoEVFUfvet@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Till now pinconf_get only set the argument value into the config parameter
effectively removing the actual config param value. As other pinctrl drivers
do, it might be nicer to keep the config param intact.
Therefore construct a real pinconfig value from param and arg in pinconf_get

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 96c60d2..ae3dfe7 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -740,13 +740,14 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	struct rockchip_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct rockchip_pin_bank *bank = pin_to_bank(info, pin);
 	enum pin_config_param param = pinconf_to_config_param(*config);
+	u16 arg;
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
 		if (rockchip_get_pull(bank, pin - bank->pin_base) != param)
 			return -EINVAL;
 
-		*config = 0;
+		arg = 0;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
@@ -758,13 +759,15 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 		if (rockchip_get_pull(bank, pin - bank->pin_base) != param)
 			return -EINVAL;
 
-		*config = 1;
+		arg = 1;
 		break;
 	default:
 		return -ENOTSUPP;
 		break;
 	}
 
+	*config = pinconf_to_config_packed(param, arg);
+
 	return 0;
 }
 
-- 
1.9.0
