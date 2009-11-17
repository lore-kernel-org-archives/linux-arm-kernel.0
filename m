From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 18 Nov 2009 00:39:01 +0100
Subject: [PATCH] IXP4xx: GTWX5715 platform only has two PCI IRQ lines,
	not four.
Message-ID: <1258501141-5359-1-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/gtwx5715-pci.c |   32 +++++++++++---------------------
 1 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index 276c614..25d2c33 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -31,15 +31,9 @@
 #include <asm/mach/pci.h>
 
 #define SLOT0_DEVID	0
-#define SLOT0_INTA	10
-#define SLOT0_INTB	11
-
 #define SLOT1_DEVID	1
-#define SLOT1_INTA	11
-#define SLOT1_INTB	10
-
-#define SLOT_COUNT	2
-#define INT_PIN_COUNT	2
+#define INTA		10 /* slot 1 has INTA and INTB crossed */
+#define INTB		11
 
 /*
  * Slot 0 isn't actually populated with a card connector but
@@ -49,26 +43,22 @@
  */
 void __init gtwx5715_pci_preinit(void)
 {
-	set_irq_type(IXP4XX_GPIO_IRQ(SLOT0_INTA), IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IXP4XX_GPIO_IRQ(SLOT0_INTB), IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IXP4XX_GPIO_IRQ(SLOT1_INTA), IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IXP4XX_GPIO_IRQ(SLOT1_INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 
 static int __init gtwx5715_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	int rc;
-	static int gtwx5715_irqmap[SLOT_COUNT][INT_PIN_COUNT] = {
-		{IXP4XX_GPIO_IRQ(SLOT0_INTA), IXP4XX_GPIO_IRQ(SLOT0_INTB)},
-		{IXP4XX_GPIO_IRQ(SLOT1_INTA), IXP4XX_GPIO_IRQ(SLOT1_INTB)},
-	};
+	int rc = -1;
 
-	if (slot >= SLOT_COUNT || pin >= INT_PIN_COUNT)
-		rc = -1;
-	else
-		rc = gtwx5715_irqmap[slot][pin - 1];
+	if ((slot == SLOT0_DEVID && pin == 1) ||
+	    (slot == SLOT1_DEVID && pin == 2))
+		rc = IXP4XX_GPIO_IRQ(INTA);
+	else if ((slot == SLOT0_DEVID && pin == 2) ||
+		 (slot == SLOT1_DEVID && pin == 1))
+		rc = IXP4XX_GPIO_IRQ(INTB);
 
 	printk(KERN_INFO "%s: Mapped slot %d pin %d to IRQ %d\n",
 	       __func__, slot, pin, rc);
-- 
1.6.5.2
