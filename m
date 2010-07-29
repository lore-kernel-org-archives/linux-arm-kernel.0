From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 29 Jul 2010 09:04:09 -0700
Subject: [PATCH 2/7] ARM: LPC32xx: Remove un-needed wakeup code from IRQ ack
	handler
In-Reply-To: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
References: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280419454-1089-3-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Code was intended for clearing platform wakeup events and just
added extra overhead in the ack handler.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/irq.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index bd0df26..d539d42 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -218,11 +218,6 @@ static void lpc32xx_ack_irq(unsigned int irq)
 	get_controller(irq, &ctrl, &mask);
 
 	__raw_writel(mask, LPC32XX_INTC_RAW_STAT(ctrl));
-
-	/* Also need to clear pending wake event */
-	if (lpc32xx_events[irq].mask != 0)
-		__raw_writel(lpc32xx_events[irq].mask,
-			lpc32xx_events[irq].event_group->rawstat_reg);
 }
 
 static void __lpc32xx_set_irq_type(unsigned int irq, int use_high_level,
-- 
1.7.1.1
