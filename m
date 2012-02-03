From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:32:49 +0000
Subject: [PATCH 05/17] ARM: sa11x0: neponset: fix interrupt setup
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOsL-0001Bp-C2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARM was converted to genirq, the neponset IRQ implementation has
gradually broken as a result of various subtle changes being introduced
into genirq.

It used to be that simple IRQs did not need an IRQ chip.  This is no
longer the case, and genirq barfs in irq_set_handler().  Fix this by
introducing a dummy no-op chip, and registering it along with the flow
handler.

Neponset IRQs really don't have any masking ability - all we have is a
status register to allow us to decode the source, and a three input OR
gate inside a CPLD.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index abbe859..6a14d37 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -138,6 +138,20 @@ static struct sa1100_port_fns neponset_port_fns __devinitdata = {
 	.get_mctrl	= neponset_get_mctrl,
 };
 
+/*
+ * Yes, we really do not have any kind of masking or unmasking
+ */
+static void nochip_noop(struct irq_data *irq)
+{
+}
+
+static struct irq_chip nochip = {
+	.name = "neponset",
+	.irq_ack = nochip_noop,
+	.irq_mask = nochip_noop,
+	.irq_unmask = nochip_noop,
+};
+
 static int __devinit neponset_probe(struct platform_device *dev)
 {
 	sa1100_register_uart_fns(&neponset_port_fns);
@@ -161,10 +175,13 @@ static int __devinit neponset_probe(struct platform_device *dev)
 	 * Setup other Neponset IRQs.  SA1111 will be done by the
 	 * generic SA1111 code.
 	 */
-	irq_set_handler(IRQ_NEPONSET_SMC9196, handle_simple_irq);
+	irq_set_chip_and_handler(IRQ_NEPONSET_SMC9196, &nochip,
+		handle_simple_irq);
 	set_irq_flags(IRQ_NEPONSET_SMC9196, IRQF_VALID | IRQF_PROBE);
-	irq_set_handler(IRQ_NEPONSET_USAR, handle_simple_irq);
+	irq_set_chip_and_handler(IRQ_NEPONSET_USAR, &nochip,
+		handle_simple_irq);
 	set_irq_flags(IRQ_NEPONSET_USAR, IRQF_VALID | IRQF_PROBE);
+	irq_set_chip(IRQ_NEPONSET_SA1111, &nochip);
 
 	/*
 	 * Disable GPIO 0/1 drivers so the buttons work on the module.
-- 
1.7.4.4
