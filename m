From: al@alarsen.net (Anders Larsen)
Date: Wed, 3 Mar 2010 22:33:41 +0100
Subject: [PATCH 2/2] AT91 slow-clock resume: don't restore the PLL settings
	when the PLL was off
Message-ID: <20100303213341.GA654@alarsen.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Langer <julien.langer@gmail.com>

AT91: Don't try to restore the PLL settings on resume when the PLLs were turned
off before suspending.

We run into this problem with the PLLB on the at91: ohci-at91 disables the PLLB
when going to suspend. The slowclock code however tries to do the same: It
saves the PLLB register value and when restoring the value during resume it
waits for the PLLB to lock again. However the PLL will never lock and the loop
would run into its timeout because the slowclock code just stored and restored
an empty register.
Fix the problem by only restoring PLLA/PLLB when the registers were != 0.

Signed-off-by: Julien Langer <julien.langer@gmail.com>
Signed-off-by: Anders Larsen <al@alarsen.net>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-at91/pm_slowclock.S |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: b/arch/arm/mach-at91/pm_slowclock.S
===================================================================
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -171,17 +171,25 @@ ENTRY(at91_slow_clock)
 	ldr	r3, [r1, #(AT91_CKGR_PLLAR - AT91_PMC)]
 	str	r3, .saved_pllar
 
+	cmp r3, #0
+	beq 3f
+
 	mov	r3, #AT91_PMC_PLLCOUNT
 	orr	r3, r3, #(1 << 29)		/* bit 29 always set */
 	str	r3, [r1, #(AT91_CKGR_PLLAR - AT91_PMC)]
 
+3:
 	/* Save PLLB setting and disable it */
 	ldr	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
 	str	r3, .saved_pllbr
 
+	cmp r3, #0
+	beq 4f
+
 	mov	r3, #AT91_PMC_PLLCOUNT
 	str	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
 
+4:
 	/* Turn off the main oscillator */
 	ldr	r3, [r1, #(AT91_CKGR_MOR - AT91_PMC)]
 	bic	r3, r3, #AT91_PMC_MOSCEN
@@ -199,16 +207,22 @@ ENTRY(at91_slow_clock)
 
 	/* Restore PLLB setting */
 	ldr	r3, .saved_pllbr
+	cmp r3, #0
+	beq 5f
 	str	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
 
 	wait_pllblock
 
+5:
 	/* Restore PLLA setting */
 	ldr	r3, .saved_pllar
+	cmp r3, #0
+	beq 6f
 	str	r3, [r1, #(AT91_CKGR_PLLAR - AT91_PMC)]
 
 	wait_pllalock
 
+6:
 #ifdef SLOWDOWN_MASTER_CLOCK
 	/*
 	 * First set PRES if it was not 0,
