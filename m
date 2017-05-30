From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 30 May 2017 16:43:04 +0200
Subject: [PATCH] pinctrl: stm32: Fix bad function call
Message-ID: <1496155384-30711-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In stm32_pconf_parse_conf function, stm32_pmx_gpio_set_direction is
called with wrong parameter value. Indeed, using NULL value for range
will raise an oops.

Fixes: aceb16dc2da5 ("pinctrl: Add STM32 MCUs support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index d3c5f5d..222b668 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -798,7 +798,7 @@ static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		break;
 	case PIN_CONFIG_OUTPUT:
 		__stm32_gpio_set(bank, offset, arg);
-		ret = stm32_pmx_gpio_set_direction(pctldev, NULL, pin, false);
+		ret = stm32_pmx_gpio_set_direction(pctldev, range, pin, false);
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.9.1
