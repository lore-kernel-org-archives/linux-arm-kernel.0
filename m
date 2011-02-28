From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Feb 2011 13:33:41 +0000
Subject: [PATCH 5/6] ARM: msm: update GPIO chained IRQ handler to use EOI in
	parent chip
In-Reply-To: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
Message-ID: <1298900022-21516-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chained GPIO IRQ handler on MSM8x60 calls ->ack on the parent chip
after handling the interrupt.

This patch updates the code to use ->irq_eoi now that the GIC has moved
to using the fasteoi flow model.

Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-msm/gpio-v2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
index 0de19ec..90a968f 100644
--- a/arch/arm/mach-msm/gpio-v2.c
+++ b/arch/arm/mach-msm/gpio-v2.c
@@ -310,6 +310,7 @@ static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
 static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned long i;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 
 	for (i = find_first_bit(msm_gpio.enabled_irqs, NR_GPIO_IRQS);
 	     i < NR_GPIO_IRQS;
@@ -318,7 +319,7 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 			generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
 							   i));
 	}
-	desc->chip->ack(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static int msm_gpio_irq_set_wake(unsigned int irq, unsigned int on)
-- 
1.7.0.4
