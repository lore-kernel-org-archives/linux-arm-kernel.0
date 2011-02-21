From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Feb 2011 15:28:13 +0000
Subject: [PATCH 2/5] ARM: omap: update GPIO chained IRQ handler to use EOI in
	parent chip
In-Reply-To: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
Message-ID: <1298302096-21275-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP4, gpio_irq_handler can be chained to a physical interrupt using
the GIC as the primary IRQ chip. Now that the GIC uses the fasteoi flow
model, the chained handler must invoke ->irq_eoi once handling is
complete.

This patch adds a conditional call to ->irq_eoi in the GPIO IRQ handler
for OMAP platforms. For OMAP implementations using other primary
interrupt controllers, the ->irq_ack call remains and is also made
conditional on the support offered by the controller.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Colin Cross <ccross@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-omap/gpio.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 971d186..1d2d1c7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1144,7 +1144,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 retrigger = 0;
 	int unmasked = 0;
 
-	desc->irq_data.chip->irq_ack(&desc->irq_data);
+	if (desc->irq_data.chip->irq_ack)
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = get_irq_data(irq);
 #ifdef CONFIG_ARCH_OMAP1
@@ -1238,6 +1239,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 exit:
 	if (!unmasked)
 		desc->irq_data.chip->irq_unmask(&desc->irq_data);
+	if (desc->irq_data.chip->irq_eoi)
+		desc->irq_data.chip->irq_eoi(&desc->irq_data);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
-- 
1.7.0.4
