From: dianders@chromium.org (Doug Anderson)
Date: Tue, 28 Oct 2014 13:57:15 -0700
Subject: [RFC PATCH 2/2] pinctrl: rockchip: Implement PIN_CONFIG_OUTPUT_DISABLE
In-Reply-To: <1414529835-16207-1-git-send-email-dianders@chromium.org>
References: <1414529835-16207-1-git-send-email-dianders@chromium.org>
Message-ID: <1414529835-16207-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If someone requests us to disable output for a pin, we'll configure it
as an input.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 40970c3..c1ac14c 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -971,6 +971,12 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			if (rc)
 				return rc;
 			break;
+		case PIN_CONFIG_OUTPUT_DISABLE:
+			rc = _rockchip_pmx_gpio_set_direction(&bank->gpio_chip,
+					  pin - bank->pin_base, true);
+			if (rc)
+				return rc;
+			break;
 		case PIN_CONFIG_OUTPUT:
 			rockchip_gpio_set(&bank->gpio_chip,
 					  pin - bank->pin_base, arg);
-- 
2.1.0.rc2.206.gedb03e5
