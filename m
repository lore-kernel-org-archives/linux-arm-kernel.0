From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 25 Oct 2017 19:11:01 +0200
Subject: [PATCH v2 5/9] irqchip: stm32: fix initial values
In-Reply-To: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
References: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1508951465-17152-6-git-send-email-ludovic.Barre@st.com>
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
index d872dea..9715d57 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -260,7 +260,16 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
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
