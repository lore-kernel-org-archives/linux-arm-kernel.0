From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 May 2017 11:52:10 +0100
Subject: [CFT] Always enable SMP mode on MP capable CPUs
Message-ID: <20170518105209.GN22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a result of a recent bug report, it has been found that certain CPUs
must always have SMP mode enabled in order for the caches to work.

Remove the conditional on setting the SMP bit(s).

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
This needs to be tested on:

- Cortex A5MP
- Cortex A9MP
- Cortex R7MP
- Cortex A7MP
- Cortex A12MP
- Cortex A15MP
- Cortex A17MP
- Brahma B15

and any other CPU that mis-identifies itself with a MP-capable CPUID
signature that might match one of those CPUs.  I'm aware of a Cortex
A9 CPU out there that does mis-identify itself as SMP capable but
isn't:

        @ Core indicates it is SMP. Check for Aegis SOC where a single
        @ Cortex-A9 CPU is present but SMP operations fault.

This will also need testing.

 arch/arm/mm/proc-v7.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 01d64c0b2563..4d48a4cf563b 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -286,14 +286,10 @@ ENDPROC(cpu_pj4b_do_resume)
 	stmia	r12, {r1-r6, lr}		@ v7_invalidate_l1 touches r0-r6
 	bl      v7_invalidate_l1
 	ldmia	r12, {r1-r6, lr}
-#ifdef CONFIG_SMP
+	mrc	p15, 0, r0, c1, c0, 1
 	orr	r10, r10, #(1 << 6)		@ Enable SMP/nAMP mode
-	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
-	ALT_UP(mov	r0, r10)		@ fake it for UP
 	orr	r10, r10, r0			@ Set required bits
-	teq	r10, r0				@ Were they already set?
-	mcrne	p15, 0, r10, c1, c0, 1		@ No, update register
-#endif
+	mcr	p15, 0, r10, c1, c0, 1		@ No, update register
 	b	__v7_setup_cont
 
 /*

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
