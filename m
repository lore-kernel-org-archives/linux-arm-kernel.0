From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 17:10:08 +0200
Subject: [PATCH 1/4] pinctrl: stm32: set pin to gpio input when used as
 interrupt
In-Reply-To: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1491577811-26989-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ensures that pin is correctly set as gpio input when it is used
as an interrupt.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index abc405b..c8825e5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -207,12 +207,35 @@ static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 	.to_irq			= stm32_gpio_to_irq,
 };
 
+static int stm32_gpio_irq_request_resources(struct irq_data *irq_data)
+{
+	struct stm32_gpio_bank *bank = irq_data->domain->host_data;
+	u32 ret;
+
+	if (!gpiochip_is_requested(&bank->gpio_chip, irq_data->hwirq)) {
+		ret = stm32_gpio_request(&bank->gpio_chip, irq_data->hwirq);
+		if (ret)
+			return ret;
+	}
+
+	return stm32_gpio_direction_input(&bank->gpio_chip, irq_data->hwirq);
+}
+
+static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
+{
+	struct stm32_gpio_bank *bank = irq_data->domain->host_data;
+
+	stm32_gpio_free(&bank->gpio_chip, irq_data->hwirq);
+}
+
 static struct irq_chip stm32_gpio_irq_chip = {
 	.name           = "stm32gpio",
 	.irq_eoi	= irq_chip_eoi_parent,
 	.irq_mask       = irq_chip_mask_parent,
 	.irq_unmask     = irq_chip_unmask_parent,
 	.irq_set_type   = irq_chip_set_type_parent,
+	.irq_request_resources = stm32_gpio_irq_request_resources,
+	.irq_release_resources = stm32_gpio_irq_release_resources,
 };
 
 static int stm32_gpio_domain_translate(struct irq_domain *d,
-- 
1.9.1
