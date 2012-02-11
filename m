From: stigge@antcom.de (Roland Stigge)
Date: Sat, 11 Feb 2012 18:18:28 +0100
Subject: [PATCH 6/6] ARM: LPC32xx: irq.c: Clear latched event
In-Reply-To: <1328980708-11749-1-git-send-email-stigge@antcom.de>
References: <1328980708-11749-1-git-send-email-stigge@antcom.de>
Message-ID: <1328980708-11749-7-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the wakeup disable function by clearing latched events.

Signed-off-by: Roland Stigge <stigge@antcom.de>

Index: linux-2.6/arch/arm/mach-lpc32xx/irq.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c	2012-02-11 15:13:33.000000000 +0100
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c	2012-02-11 15:14:53.000000000 +0100
@@ -309,9 +309,18 @@
 
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
 
