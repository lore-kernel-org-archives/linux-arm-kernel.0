From: al@alarsen.net (Anders Larsen)
Date: Wed, 3 Mar 2010 22:33:29 +0100
Subject: [PATCH 1/2] AT91 slow-clock suspend: don't wait when turning PLLs off
Message-ID: <20100303213329.GA500@alarsen.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Langer <julien.langer@gmail.com>

AT91: when turning off the PLLs during suspend, don't wait for the lock flag
to be set. Previously the code would always run into the loop limitation
of 1000 iterations because the flag is never set when turning the PLLs off.

Signed-off-by: Julien Langer <julien.langer@gmail.com>
Signed-off-by: Anders Larsen <al@alarsen.net>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-at91/pm_slowclock.S |    4 ----
 1 file changed, 4 deletions(-)

Index: b/arch/arm/mach-at91/pm_slowclock.S
===================================================================
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -175,8 +175,6 @@ ENTRY(at91_slow_clock)
 	orr	r3, r3, #(1 << 29)		/* bit 29 always set */
 	str	r3, [r1, #(AT91_CKGR_PLLAR - AT91_PMC)]
 
-	wait_pllalock
-
 	/* Save PLLB setting and disable it */
 	ldr	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
 	str	r3, .saved_pllbr
@@ -184,8 +182,6 @@ ENTRY(at91_slow_clock)
 	mov	r3, #AT91_PMC_PLLCOUNT
 	str	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
 
-	wait_pllblock
-
 	/* Turn off the main oscillator */
 	ldr	r3, [r1, #(AT91_CKGR_MOR - AT91_PMC)]
 	bic	r3, r3, #AT91_PMC_MOSCEN
