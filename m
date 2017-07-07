From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 7 Jul 2017 09:26:28 +0200
Subject: [PATCH 5/8] irqchip: stm32: fix initial values
In-Reply-To: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
References: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1499412391-25480-6-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

-after cold boot, imr default value depend of hw configuration
-after hot reboot the registers must be cleared to avoid residue

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 69ae09d..3c7077d 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -246,7 +246,16 @@ static int __init stm32_exti_init(struct stm32_exti_bank **stm32_exti_banks,
 		irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
 		stm32_bank->irqs_mask = irqs_mask;
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
