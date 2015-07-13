From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:12 -0000
Subject: [patch 09/11] ARM/pxa: Prepare *_irq_handler for irq argument removal
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.677065400@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

Search and update was done with coccinelle and the invaluable help of
Julia Lawall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org

---
 arch/arm/mach-pxa/cm-x2xx-pci.c      |    3 ++-
 arch/arm/mach-pxa/lpd270.c           |    3 ++-
 arch/arm/mach-pxa/pcm990-baseboard.c |    3 ++-
 arch/arm/mach-pxa/viper.c            |    3 ++-
 arch/arm/mach-pxa/zeus.c             |    3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

Index: tip/arch/arm/mach-pxa/cm-x2xx-pci.c
===================================================================
--- tip.orig/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ tip/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -29,8 +29,9 @@
 void __iomem *it8152_base_address;
 static int cmx2xx_it8152_irq_gpio;
 
-static void cmx2xx_it8152_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void cmx2xx_it8152_irq_demux(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	/* clear our parent irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
Index: tip/arch/arm/mach-pxa/lpd270.c
===================================================================
--- tip.orig/arch/arm/mach-pxa/lpd270.c
+++ tip/arch/arm/mach-pxa/lpd270.c
@@ -120,8 +120,9 @@ static struct irq_chip lpd270_irq_chip =
 	.irq_unmask	= lpd270_unmask_irq,
 };
 
-static void lpd270_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void lpd270_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq;
 	unsigned long pending;
 
 	pending = __raw_readw(LPD270_INT_STATUS) & lpd270_irq_enabled;
Index: tip/arch/arm/mach-pxa/pcm990-baseboard.c
===================================================================
--- tip.orig/arch/arm/mach-pxa/pcm990-baseboard.c
+++ tip/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -284,8 +284,9 @@ static struct irq_chip pcm990_irq_chip =
 	.irq_unmask	= pcm990_unmask_irq,
 };
 
-static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void pcm990_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq;
 	unsigned long pending;
 
 	pending = ~pcm990_cpld_readb(PCM990_CTRL_INTSETCLR);
Index: tip/arch/arm/mach-pxa/viper.c
===================================================================
--- tip.orig/arch/arm/mach-pxa/viper.c
+++ tip/arch/arm/mach-pxa/viper.c
@@ -276,8 +276,9 @@ static inline unsigned long viper_irq_pe
 			viper_irq_enabled_mask;
 }
 
-static void viper_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void viper_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq;
 	unsigned long pending;
 
 	pending = viper_irq_pending();
Index: tip/arch/arm/mach-pxa/zeus.c
===================================================================
--- tip.orig/arch/arm/mach-pxa/zeus.c
+++ tip/arch/arm/mach-pxa/zeus.c
@@ -105,8 +105,9 @@ static inline unsigned long zeus_irq_pen
 	return __raw_readw(ZEUS_CPLD_ISA_IRQ) & zeus_irq_enabled_mask;
 }
 
-static void zeus_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void zeus_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq;
 	unsigned long pending;
 
 	pending = zeus_irq_pending();
