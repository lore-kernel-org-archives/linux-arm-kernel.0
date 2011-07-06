From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed,  6 Jul 2011 21:07:07 +0200
Subject: [PATCH RESEND 2] arm: mach-vt8500: add forgotten irq_data conversion
Message-ID: <1309979227-24578-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform has not been converted to 'struct irq_data' when the big
pile was done. It fails to compile nowadays, because the compatibility
code has gone.

  CC      arch/arm/mach-vt8500/irq.o
arch/arm/mach-vt8500/irq.c:118:2: error: unknown field 'ack' specified in initializer
arch/arm/mach-vt8500/irq.c:118:2: warning: initialization from incompatible pointer type
arch/arm/mach-vt8500/irq.c:119:2: error: unknown field 'mask' specified in initializer
arch/arm/mach-vt8500/irq.c:119:2: warning: initialization from incompatible pointer type
arch/arm/mach-vt8500/irq.c:120:2: error: unknown field 'unmask' specified in initializer
arch/arm/mach-vt8500/irq.c:120:2: warning: initialization from incompatible pointer type
arch/arm/mach-vt8500/irq.c:121:2: error: unknown field 'set_type' specified in initializer
arch/arm/mach-vt8500/irq.c:121:2: warning: initialization from incompatible pointer type
make[1]: *** [arch/arm/mach-vt8500/irq.o] Error 1

Add the missing conversion. Tested on a JayPC-Tablet.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Alexey Charkov <alchark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

This fixes a build failure and is acked by the platform maintainer. As
there might be no -rc7 and the release might be soon, I'll try adding
two more people to CC to increase chances to have that issue sorted out
in 3.0

 arch/arm/mach-vt8500/irq.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-vt8500/irq.c b/arch/arm/mach-vt8500/irq.c
index 245140c..642de04 100644
--- a/arch/arm/mach-vt8500/irq.c
+++ b/arch/arm/mach-vt8500/irq.c
@@ -39,9 +39,10 @@
 static void __iomem *ic_regbase;
 static void __iomem *sic_regbase;
 
-static void vt8500_irq_mask(unsigned int irq)
+static void vt8500_irq_mask(struct irq_data *d)
 {
 	void __iomem *base = ic_regbase;
+	unsigned irq = d->irq;
 	u8 edge;
 
 	if (irq >= 64) {
@@ -64,9 +65,10 @@ static void vt8500_irq_mask(unsigned int irq)
 	}
 }
 
-static void vt8500_irq_unmask(unsigned int irq)
+static void vt8500_irq_unmask(struct irq_data *d)
 {
 	void __iomem *base = ic_regbase;
+	unsigned irq = d->irq;
 	u8 dctr;
 
 	if (irq >= 64) {
@@ -78,10 +80,11 @@ static void vt8500_irq_unmask(unsigned int irq)
 	writeb(dctr, base + VT8500_IC_DCTR + irq);
 }
 
-static int vt8500_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int vt8500_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	void __iomem *base = ic_regbase;
-	unsigned int orig_irq = irq;
+	unsigned irq = d->irq;
+	unsigned orig_irq = irq;
 	u8 dctr;
 
 	if (irq >= 64) {
@@ -114,11 +117,11 @@ static int vt8500_irq_set_type(unsigned int irq, unsigned int flow_type)
 }
 
 static struct irq_chip vt8500_irq_chip = {
-	.name      = "vt8500",
-	.ack       = vt8500_irq_mask,
-	.mask      = vt8500_irq_mask,
-	.unmask    = vt8500_irq_unmask,
-	.set_type  = vt8500_irq_set_type,
+	.name = "vt8500",
+	.irq_ack = vt8500_irq_mask,
+	.irq_mask = vt8500_irq_mask,
+	.irq_unmask = vt8500_irq_unmask,
+	.irq_set_type = vt8500_irq_set_type,
 };
 
 void __init vt8500_init_irq(void)
-- 
1.7.2.5
