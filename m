From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 7 Jul 2017 09:26:29 +0200
Subject: [PATCH 6/8] irqchip: stm32: move the wakeup on interrupt mask
In-Reply-To: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
References: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1499412391-25480-7-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

move irq_set_wake on interrupt mask, needed to out of
low power mode (wakeup source)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 3c7077d..f92c103 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -142,16 +142,16 @@ static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
 	struct stm32_exti_bank *stm32_bank = gc->private;
 	int pin = data->hwirq % BITS_PER_LONG;
-	u32 emr;
+	u32 imr;
 
 	irq_gc_lock(gc);
 
-	emr = irq_reg_readl(gc, stm32_bank->emr_ofst);
+	imr = irq_reg_readl(gc, stm32_bank->imr_ofst);
 	if (on)
-		emr |= BIT(pin);
+		imr |= BIT(pin);
 	else
-		emr &= ~BIT(pin);
-	irq_reg_writel(gc, emr, stm32_bank->emr_ofst);
+		imr &= ~BIT(pin);
+	irq_reg_writel(gc, imr, stm32_bank->imr_ofst);
 
 	irq_gc_unlock(gc);
 
-- 
2.7.4
