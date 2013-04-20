From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:56:11 +0200
Subject: [RESEND PATCH 06/12] ARM: integrator: move PCI base address grab to
 probe
Message-ID: <1366466171-15521-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the point where the PCIv3 driver grabs the SC base
address to the probe function.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/pci_v3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index f027596..756a5f2 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -496,13 +496,6 @@ static void __init pci_v3_preinit(void)
 	unsigned long flags;
 	unsigned int temp;
 
-	/* Remap the Integrator system controller */
-	ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);
-	if (!ap_syscon_base) {
-		pr_err("unable to remap the AP syscon for PCIv3\n");
-		return;
-	}
-
 	pcibios_min_mem = 0x00100000;
 
 	/*
@@ -677,6 +670,13 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 {
 	int ret;
 
+	/* Remap the Integrator system controller */
+	ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);
+	if (!ap_syscon_base) {
+		dev_err(&pdev->dev, "unable to remap the AP syscon for PCIv3\n");
+		return -ENODEV;
+	}
+
 	ret = devm_request_irq(&pdev->dev, IRQ_AP_V3INT, v3_irq, 0, "V3", NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to grab PCI error interrupt: %d\n",
-- 
1.8.1.4
