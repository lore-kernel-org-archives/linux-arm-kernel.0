From: stigge@antcom.de (Roland Stigge)
Date: Sat, 25 Feb 2012 16:35:16 +0100
Subject: [PATCH v2 4/6] ARM: LPC32xx: irq.c: Clear latched event
In-Reply-To: <1330184118-10270-1-git-send-email-stigge@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
Message-ID: <1330184118-10270-5-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the wakeup disable function by clearing latched events.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/irq.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c
@@ -309,9 +309,18 @@ static int lpc32xx_irq_wake(struct irq_d
 
 		if (state)
 			eventreg |= lpc32xx_events[d->irq].mask;
-		else
+		else {
 			eventreg &= ~lpc32xx_events[d->irq].mask;
 
+			/*
+			 * When disabling the wakeup, clear the latched
+			 * event
+			 */
+			__raw_writel(lpc32xx_events[d->irq].mask,
+				lpc32xx_events[d->irq].
+				event_group->rawstat_reg);
+		}
+
 		__raw_writel(eventreg,
 			lpc32xx_events[d->irq].event_group->enab_reg);
 
