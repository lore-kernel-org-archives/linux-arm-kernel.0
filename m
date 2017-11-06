From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 6 Nov 2017 18:03:35 +0100
Subject: [PATCH v3 5/9] irqchip: stm32: fix initial values
In-Reply-To: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
References: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1509987819-29599-6-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

-After cold boot, imr default value depends on hardware configuration.
-After hot reboot the registers must be cleared to avoid residue.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 8f409a9..477d0fa 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -258,7 +258,16 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 		writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
 		irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
 		nr_exti = fls(readl_relaxed(base + stm32_bank->rtsr_ofst));
+
+		/*
+		 * This IP has no reset, so after hot reboot we should
+		 * clear registers to avoid residue
+		 */
+		writel_relaxed(0, base + stm32_bank->imr_ofst);
+		writel_relaxed(0, base + stm32_bank->emr_ofst);
 		writel_relaxed(0, base + stm32_bank->rtsr_ofst);
+		writel_relaxed(0, base + stm32_bank->ftsr_ofst);
+		writel_relaxed(~0UL, base + stm32_bank->pr_ofst);
 
 		pr_info("%s: bank%d, External IRQs available:%#x\n",
 			node->full_name, i, irqs_mask);
-- 
2.7.4
