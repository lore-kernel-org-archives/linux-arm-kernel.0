From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:56:03 +0200
Subject: [RESEND PATCH 05/12] ARM: integrator: grab PCI error IRQ in probe()
Message-ID: <1366466163-15492-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the request of the PCI error interrupt to the probe()
function for the device, uses the devm* managed call and switch
to a dev_err() error print.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/pci_v3.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 2733c6c..f027596 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -495,7 +495,6 @@ static void __init pci_v3_preinit(void)
 {
 	unsigned long flags;
 	unsigned int temp;
-	int ret;
 
 	/* Remap the Integrator system controller */
 	ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);
@@ -579,14 +578,6 @@ static void __init pci_v3_preinit(void)
 	v3_writeb(V3_LB_IMASK, 0x28);
 	__raw_writel(3, ap_syscon_base + INTEGRATOR_SC_PCIENABLE_OFFSET);
 
-	/*
-	 * Grab the PCI error interrupt.
-	 */
-	ret = request_irq(IRQ_AP_V3INT, v3_irq, 0, "V3", NULL);
-	if (ret)
-		printk(KERN_ERR "PCI: unable to grab PCI error "
-		       "interrupt: %d\n", ret);
-
 	raw_spin_unlock_irqrestore(&v3_lock, flags);
 }
 
@@ -684,7 +675,17 @@ static struct hw_pci pci_v3 __initdata = {
 
 static int __init pci_v3_probe(struct platform_device *pdev)
 {
+	int ret;
+
+	ret = devm_request_irq(&pdev->dev, IRQ_AP_V3INT, v3_irq, 0, "V3", NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to grab PCI error interrupt: %d\n",
+			ret);
+		return -ENODEV;
+	}
+
 	pci_common_init(&pci_v3);
+
 	return 0;
 }
 
-- 
1.8.1.4
