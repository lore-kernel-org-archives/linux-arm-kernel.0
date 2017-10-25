From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 25 Oct 2017 19:11:02 +0200
Subject: [PATCH v2 6/9] irqchip: stm32: move the wakeup on interrupt mask
In-Reply-To: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
References: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1508951465-17152-7-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

Move irq_set_wake on interrupt mask, needed to wake up from
low power mode as the event mask is not able to do so.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 9715d57..3e4ee25 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -156,16 +156,16 @@ static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
 	const struct stm32_exti_bank *stm32_bank = gc->private;
 	int pin = data->hwirq % IRQS_PER_BANK;
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
