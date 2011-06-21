From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 21 Jun 2011 23:11:17 +0200
Subject: [PATCH] arm: mach-vt8500: add forgotten irq_data conversion
Message-ID: <1308690677-19874-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform has not been converted when the big pile was done and thus
fails to compile. Tested on a JayPC-Tablet.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Lennert Buytenhek <buytenh@secretlab.ca>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
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
