From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 26 Sep 2014 16:25:12 +1000
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20140926162512.07ef4957@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in
arch/arm/mach-omap2/irq.c between commit 8598066cddd1 ("arm: omap: irq:
move irq.c to drivers/irqchip/") from the arm-soc tree and commit
f978999f6096 ("Use the new handle_domain_irq method to handle
interrupts") from the tip tree.

I fixed it up (I applied the latter patch to the moved file - see
below) and can carry the fix as necessary (no action is required).

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index f3814e79192d..28718d3e8281 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -334,8 +334,7 @@ out:
 		irqnr &= ACTIVEIRQ_MASK;
 
 		if (irqnr) {
-			irqnr = irq_find_mapping(domain, irqnr);
-			handle_IRQ(irqnr, regs);
+			handle_domain_irq(domain, irqnr, regs);
 			handled_irq = 1;
 		}
 	} while (irqnr);

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/b76d145a/attachment.sig>
