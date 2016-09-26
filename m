From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 26 Sep 2016 09:21:28 +0200
Subject: [PATCH] ARM: pxa: pxa_cplds: honor probe deferral
Message-ID: <1474874488-26533-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method to acquire the input interrupt was working in a platform data
based board, but was failing in a device-tree one when the gpio
controller was probed after pxa_cplds.

Use platform_get_irq() to benefit from the probe deferral
mechanism. Moreover, as seen in dm9000.c development, platform_get_irq()
doesn't honor the irq type IO resource (ie. edge rising for example),
and it must be passed again at irq request in a not device-tree build,
hence the irq_get_trigger_type() call.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa_cplds_irqs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index e362f865fcd2..941508585e34 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -120,13 +120,9 @@ static int cplds_probe(struct platform_device *pdev)
 	if (!fpga)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res) {
-		fpga->irq = (unsigned int)res->start;
-		irqflags = res->flags;
-	}
-	if (!fpga->irq)
-		return -ENODEV;
+	fpga->irq = platform_get_irq(pdev, 0);
+	if (fpga->irq <= 0)
+		return fpga->irq;
 
 	base_irq = platform_get_irq(pdev, 1);
 	if (base_irq < 0)
@@ -142,6 +138,7 @@ static int cplds_probe(struct platform_device *pdev)
 	writel(fpga->irq_mask, fpga->base + FPGA_IRQ_MASK_EN);
 	writel(0, fpga->base + FPGA_IRQ_SET_CLR);
 
+	irqflags = irq_get_trigger_type(fpga->irq);
 	ret = devm_request_irq(&pdev->dev, fpga->irq, cplds_irq_handler,
 			       irqflags, dev_name(&pdev->dev), fpga);
 	if (ret == -ENOSYS)
-- 
2.1.4
