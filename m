From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Mar 2011 17:13:23 +0000
Subject: [PATCH 5/7] ARM: msm: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
References: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
Message-ID: <1299604405-12960-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the MSM gpio chained IRQ handler to use the chained
IRQ enter/exit functions in order to function correctly on primary
controllers with different methods of flow control.

Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-msm/gpio-v2.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
index 0de19ec..62be63b 100644
--- a/arch/arm/mach-msm/gpio-v2.c
+++ b/arch/arm/mach-msm/gpio-v2.c
@@ -310,6 +310,9 @@ static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
 static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned long i;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+
+	chained_irq_enter(chip, desc);
 
 	for (i = find_first_bit(msm_gpio.enabled_irqs, NR_GPIO_IRQS);
 	     i < NR_GPIO_IRQS;
@@ -318,7 +321,8 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 			generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
 							   i));
 	}
-	desc->chip->ack(irq);
+
+	chained_irq_exit(chip, desc);
 }
 
 static int msm_gpio_irq_set_wake(unsigned int irq, unsigned int on)
-- 
1.7.0.4
