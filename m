From: balbi@ti.com (Felipe Balbi)
Date: Mon, 20 Jul 2015 15:49:10 -0500
Subject: [PATCH RESEND] irqchip: omap-intc: improve IRQ handler
In-Reply-To: <alpine.DEB.2.11.1507202241550.18576@nanos>
References: <1437410759-4945-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.11.1507202241550.18576@nanos>
Message-ID: <20150720204910.GH5394@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 10:44:08PM +0200, Thomas Gleixner wrote:
> On Mon, 20 Jul 2015, Felipe Balbi wrote:
> > +	irqnr = intc_readl(INTC_SIR);
> > +	irqnr &= ACTIVEIRQ_MASK;
> > +	WARN(!irqnr, "Spurious IRQ ?\n");
> 
> Shouldn't that be WARN_ONCE?

Sure, why not ?

8<--------------------------------------------------------------------

>From a71590d725e54b888db278de6c278d2a106fc76d Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Fri, 2 Jan 2015 16:18:54 -0600
Subject: [PATCH RESEND v2] irqchip: omap-intc: improve IRQ handler

as it turns out the current IRQ number will
*always* be available from SIR register which
renders the reads of PENDING registers as plain
unnecessary overhead.

In order to catch any situation where SIR reads
as zero, we're adding a WARN() to turn it into
a very verbose error and users actually report
it.

With this patch average running time of
omap_intc_handle_irq() reduced from about 28.5us
to 19.8us as measured by the kernel function
profiler.

Tested with BeagleBoneBlack Rev A5C.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes from V1:

 - replace WARN() with WARN_ONCE()

 drivers/irqchip/irq-omap-intc.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index a569c6dbd1d1..e15f10746310 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -331,37 +331,12 @@ static int __init omap_init_irq(u32 base, struct device_node *node)
 static asmlinkage void __exception_irq_entry
 omap_intc_handle_irq(struct pt_regs *regs)
 {
-	u32 irqnr = 0;
-	int handled_irq = 0;
-	int i;
-
-	do {
-		for (i = 0; i < omap_nr_pending; i++) {
-			irqnr = intc_readl(INTC_PENDING_IRQ0 + (0x20 * i));
-			if (irqnr)
-				goto out;
-		}
-
-out:
-		if (!irqnr)
-			break;
-
-		irqnr = intc_readl(INTC_SIR);
-		irqnr &= ACTIVEIRQ_MASK;
+	u32 irqnr;
 
-		if (irqnr) {
-			handle_domain_irq(domain, irqnr, regs);
-			handled_irq = 1;
-		}
-	} while (irqnr);
-
-	/*
-	 * If an irq is masked or deasserted while active, we will
-	 * keep ending up here with no irq handled. So remove it from
-	 * the INTC with an ack.
-	 */
-	if (!handled_irq)
-		omap_ack_irq(NULL);
+	irqnr = intc_readl(INTC_SIR);
+	irqnr &= ACTIVEIRQ_MASK;
+	WARN_ONCE(!irqnr, "Spurious IRQ ?\n");
+	handle_domain_irq(domain, irqnr, regs);
 }
 
 void __init omap3_init_irq(void)
-- 
2.4.4


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/6a9f0eb0/attachment.sig>
