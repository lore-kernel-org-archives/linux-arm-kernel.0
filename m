From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 24 May 2016 13:57:43 +0200
Subject: [PATCH v2] pinctrl: stm32: factorize stm32_pconf_input/output_get()
In-Reply-To: <1464091063-22341-1-git-send-email-patrice.chotard@st.com>
References: <1464091063-22341-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1464091063-22341-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

As these 2 functions code are 95% similar, factorize them.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index ae9fab8..4ae596b 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -638,8 +638,8 @@ static u32 stm32_pconf_get_bias(struct stm32_gpio_bank *bank,
 	return (val >> (offset * 2));
 }
 
-static bool stm32_pconf_input_get(struct stm32_gpio_bank *bank,
-	unsigned int offset)
+static bool stm32_pconf_get(struct stm32_gpio_bank *bank,
+	unsigned int offset, bool dir)
 {
 	unsigned long flags;
 	u32 val;
@@ -647,23 +647,12 @@ static bool stm32_pconf_input_get(struct stm32_gpio_bank *bank,
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
-	val = !!(readl_relaxed(bank->base + STM32_GPIO_IDR) & BIT(offset));
-
-	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
-
-	return val;
-}
-
-static bool stm32_pconf_output_get(struct stm32_gpio_bank *bank,
-	unsigned int offset)
-{
-	unsigned long flags;
-	u32 val;
-
-	clk_enable(bank->clk);
-	spin_lock_irqsave(&bank->lock, flags);
-	val = !!(readl_relaxed(bank->base + STM32_GPIO_ODR) & BIT(offset));
+	if (dir)
+		val = !!(readl_relaxed(bank->base + STM32_GPIO_IDR) &
+			 BIT(offset));
+	else
+		val = !!(readl_relaxed(bank->base + STM32_GPIO_ODR) &
+			 BIT(offset));
 
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
@@ -772,7 +761,7 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 	switch (mode) {
 	/* input */
 	case 0:
-		val = stm32_pconf_input_get(bank, offset);
+		val = stm32_pconf_get(bank, offset, true);
 		seq_printf(s, "- %s - %s",
 			   val ? "high" : "low",
 			   biasing[bias]);
@@ -782,7 +771,7 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 	case 1:
 		drive = stm32_pconf_get_driving(bank, offset);
 		speed = stm32_pconf_get_speed(bank, offset);
-		val = stm32_pconf_output_get(bank, offset);
+		val = stm32_pconf_get(bank, offset, false);
 		seq_printf(s, "- %s - %s - %s - %s %s",
 			   val ? "high" : "low",
 			   drive ? "open drain" : "push pull",
-- 
1.9.1
