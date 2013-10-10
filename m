From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 16:54:34 +0200
Subject: [PATCH] ARM: integrator: use devm_ioremap() to remap CM
Message-ID: <1381416874-4858-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the PCIv3 driver, use devm_ioremap() instead of just ioremap()
when remapping the system controller in the PCIv3 driver, so
the mapping will be automatically released on probe failure.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/pci_v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index ce8d0ca..c9c5a33 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -842,7 +842,7 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 	int irq, ret;
 
 	/* Remap the Integrator system controller */
-	ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);
+	ap_syscon_base = devm_ioremap(&pdev->dev, INTEGRATOR_SC_BASE, 0x100);
 	if (!ap_syscon_base) {
 		dev_err(&pdev->dev, "unable to remap the AP syscon for PCIv3\n");
 		return -ENODEV;
-- 
1.8.3.1
