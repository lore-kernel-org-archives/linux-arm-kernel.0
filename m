From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 25 Oct 2017 19:11:00 +0200
Subject: [PATCH v2 4/9] irqchip: stm32: add stm32h7 support
In-Reply-To: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
References: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1508951465-17152-5-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

stm32h7 has up to 96 inputs
(3 banks of 32 inputs max).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6b4109b..d872dea 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -38,6 +38,39 @@ static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
 	&stm32f4xx_exti_b1,
 };
 
+static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
+	.imr_ofst	= 0x80,
+	.emr_ofst	= 0x84,
+	.rtsr_ofst	= 0x00,
+	.ftsr_ofst	= 0x04,
+	.swier_ofst	= 0x08,
+	.pr_ofst	= 0x88,
+};
+
+static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
+	.imr_ofst	= 0x90,
+	.emr_ofst	= 0x94,
+	.rtsr_ofst	= 0x20,
+	.ftsr_ofst	= 0x24,
+	.swier_ofst	= 0x28,
+	.pr_ofst	= 0x98,
+};
+
+static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
+	.imr_ofst	= 0xA0,
+	.emr_ofst	= 0xA4,
+	.rtsr_ofst	= 0x40,
+	.ftsr_ofst	= 0x44,
+	.swier_ofst	= 0x48,
+	.pr_ofst	= 0xA8,
+};
+
+static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
+	&stm32h7xx_exti_b1,
+	&stm32h7xx_exti_b2,
+	&stm32h7xx_exti_b3,
+};
+
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	const struct stm32_exti_bank *stm32_bank = gc->private;
@@ -258,3 +291,12 @@ static int __init stm32f4_exti_of_init(struct device_node *np,
 }
 
 IRQCHIP_DECLARE(stm32f4_exti, "st,stm32-exti", stm32f4_exti_of_init);
+
+static int __init stm32h7_exti_of_init(struct device_node *np,
+				       struct device_node *parent)
+{
+	return stm32_exti_init(stm32h7xx_exti_banks,
+			ARRAY_SIZE(stm32h7xx_exti_banks), np);
+}
+
+IRQCHIP_DECLARE(stm32h7_exti, "st,stm32h7-exti", stm32h7_exti_of_init);
-- 
2.7.4
