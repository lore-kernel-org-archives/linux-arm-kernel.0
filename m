From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sun, 5 Feb 2017 11:00:41 +0100 (CET)
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
In-Reply-To: <20170128204839.18330-2-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1702051054240.26313@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

while debugging my boot issues on my NAS 4220, I saw this warning

irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller at 48000000!

We need to use the use the use the PCI IRQ from gemini as root for the irq 
domain, not the next one in DT.

diff --git a/drivers/pci/host/pci-gemini.c b/drivers/pci/host/pci-gemini.c
index 7051dd992114..bb564a8e6379 100644
--- a/drivers/pci/host/pci-gemini.c
+++ b/drivers/pci/host/pci-gemini.c
@@ -217,7 +217,6 @@ static const struct irq_domain_ops gemini_pci_irqdomain_ops = {
 
 static int gemini_pci_setup_irq(struct gemini_pci *p, int irq)
 {
-	struct device_node *intc = of_get_next_child(p->dev->of_node, NULL);
 	int i;
 
 	if (!intc) {
@@ -225,7 +224,7 @@ static int gemini_pci_setup_irq(struct gemini_pci *p, int irq)
 		return -EINVAL;
 	}
 
-	p->irqdomain = irq_domain_add_linear(intc, 4,
+	p->irqdomain = irq_domain_add_linear(p->dev->of_node, 4,
 					     &gemini_pci_irqdomain_ops,
 					     p);
 	if (!p->irqdomain) {
-- 
2.11.0
