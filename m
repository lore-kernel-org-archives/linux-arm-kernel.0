From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Apr 2011 15:50:39 +0100
Subject: [PATCH 4/6] ARM: msm: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
Message-ID: <1301669441-13744-5-git-send-email-will.deacon@arm.com>
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
index 56a964e..483f007 100644
--- a/arch/arm/mach-msm/gpio-v2.c
+++ b/arch/arm/mach-msm/gpio-v2.c
@@ -311,6 +311,9 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	unsigned long i;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+
+	chained_irq_enter(chip, desc);
 
 	for (i = find_first_bit(msm_gpio.enabled_irqs, NR_GPIO_IRQS);
 	     i < NR_GPIO_IRQS;
@@ -319,7 +322,8 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 			generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
 							   i));
 	}
-	data->chip->irq_ack(data);
+
+	chained_irq_exit(chip, desc);
 }
 
 static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
-- 
1.7.0.4
