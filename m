From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 23:47:09 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <op.u3j8zxsd2s3iss@richese> (Imre Kaloz's message of "Tue, 17 Nov
	2009 23:34:35 +0100")
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
	<op.u3gddjdi2s3iss@ecaz> <m3y6m7qylr.fsf@intrepid.localdomain>
	<op.u3j6cak02s3iss@richese> <m3ws1o4y3h.fsf@intrepid.localdomain>
	<op.u3j7xuh92s3iss@richese> <m3skcc4wrm.fsf@intrepid.localdomain>
	<op.u3j8zxsd2s3iss@richese>
Message-ID: <m3ocn04vma.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Imre Kaloz" <kaloz@openwrt.org> writes:

> Yeah, you get rid of the external .h files for dropping all that bloat
> into the setup
> files. Honestly, do however you please, but this hardly makes sense
> IMHO when you have
> the chance to get rid of all this mess.

What I'm thinking about is (cut & paste):

--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -27,49 +27,40 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
-#define AVILA_PCI_MAX_DEV      4
-#define LOFT_PCI_MAX_DEV       6
-#define AVILA_PCI_IRQ_LINES    4
+#define AVILA_MAX_DEV  4
+#define LOFT_MAX_DEV   6
+#define IRQ_LINES      4
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define AVILA_PCI_INTA_PIN     11
-#define AVILA_PCI_INTB_PIN     10
-#define AVILA_PCI_INTC_PIN     9
-#define AVILA_PCI_INTD_PIN     8
-
-#define IRQ_AVILA_PCI_INTA     IRQ_IXP4XX_GPIO11
-#define IRQ_AVILA_PCI_INTB     IRQ_IXP4XX_GPIO10
-#define IRQ_AVILA_PCI_INTC     IRQ_IXP4XX_GPIO9
-#define IRQ_AVILA_PCI_INTD     IRQ_IXP4XX_GPIO8
+#define INTA           11
+#define INTB           10
+#define INTC           9
+#define INTD           8

You can see the duplicate definitions removed.
BTW: I don't like it much, but using ordinary GPIOx certainly
isn't better.

(Yep, I see at least one bug which the patches should fix, will do).

 void __init avila_pci_preinit(void)
 {
-       set_irq_type(IRQ_AVILA_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
-       set_irq_type(IRQ_AVILA_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
-       set_irq_type(IRQ_AVILA_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
-       set_irq_type(IRQ_AVILA_PCI_INTD, IRQ_TYPE_LEVEL_LOW);
-
+       set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+       set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+       set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
+       set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
        ixp4xx_pci_preinit();
 }
-- 
Krzysztof Halasa
