From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 7 Feb 2013 17:27:37 +0100
Subject: [PATCH] pinctrl/abx500: adjust offset for get_mode()
Message-ID: <1360254457-17024-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The set_mode() and get_mode() functions in the abx500 were
not mirrored, leading to the wrong GPIO control bits being
read out.

Cc: Lee Jones <lee.jones@linaro.org>
Reported-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-abx500.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index 17508b5..0b3aa1c 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -401,6 +401,8 @@ static u8 abx500_get_mode(struct pinctrl_dev *pctldev, struct gpio_chip *chip,
 	bool alt_bit2;
 	struct abx500_pinctrl *pct = pinctrl_dev_get_drvdata(pctldev);
 	struct alternate_functions af = pct->soc->alternate_functions[gpio];
+	/* on ABx5xx, there is no GPIO0, so adjust the offset */
+	unsigned offset = gpio - 1;
 
 	/*
 	 * if gpiosel_bit is set to unused,
@@ -410,7 +412,7 @@ static u8 abx500_get_mode(struct pinctrl_dev *pctldev, struct gpio_chip *chip,
 		return ABX500_DEFAULT;
 
 	/* read GpioSelx register */
-	abx500_gpio_get_bit(chip, AB8500_GPIO_SEL1_REG + (gpio / 8),
+	abx500_gpio_get_bit(chip, AB8500_GPIO_SEL1_REG + (offset / 8),
 			af.gpiosel_bit, &bit_mode);
 	mode = bit_mode;
 
-- 
1.7.11.3
