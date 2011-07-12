From: toddpoynor@google.com (Todd Poynor)
Date: Tue, 12 Jul 2011 15:36:40 -0700
Subject: [PATCH 2/4] ARM: orion: Check NULL return from irq_alloc_generic_chip
Message-ID: <1310510200-4417-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/plat-orion/gpio.c |    7 +++++++
 arch/arm/plat-orion/irq.c  |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 5b4fffa..ddc20d3 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -419,6 +419,13 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 
 	gc = irq_alloc_generic_chip("orion_gpio_irq", 2, secondary_irq_base,
 				    ochip->base, handle_level_irq);
+
+	if (!gc) {
+		pr_err("%s: irq_alloc_generic_chip for IRQ %d failed\n",
+		       __func__, secondary_irq_base);
+		return;
+	}
+
 	gc->private = ochip;
 
 	ct = gc->chip_types;
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 2d5b9c1..41e6e82 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -26,6 +26,13 @@ void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 
 	gc = irq_alloc_generic_chip("orion_irq", 1, irq_start, maskaddr,
 				    handle_level_irq);
+
+	if (!gc) {
+		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
+		       __func__, irq_start);
+		return;
+	}
+
 	ct = gc->chip_types;
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
-- 
1.7.3.1
