From: stefan@agner.ch (Stefan Agner)
Date: Sat, 31 Jan 2015 00:53:46 +0100
Subject: [PATCH] ARM: extend SMP_ON_UP detection for A5 MPCore devices with 1
 CPU
Message-ID: <1422662026-12968-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the non-SMP Cortex-A5 Vybrid SoC detection of SMP_ON_UP fails.
Some variants of this SoC have a secondary Cortex-M4 CPU, which
might be the reason the MPIDR register reporting a multiprocessor
system.

The code introduced in bc41b8724f ("ARM: 7846/1: Update SMP_ON_UP
code to detect A9MPCore with 1 CPU devices") proved applicable
for Vybrid too: The SCU register number of CPUs reports b00
indicating only one A5 MPCore being present in the system. This
patch lets Cortex-A5 CPU's use the SCU check too.

On the Vybrid platform this did not lead to CPU faults (so far),
but is_smp checks evaluate to true which is not optimal
performance wise.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
A boot log of the Vybrid SoC with this patch applied is available at:
http://www.agner.ch/vybrid-vf610-3.19-rc6-smp-fixup.txt

 arch/arm/kernel/head.S | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 664eee8..35982af 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -492,19 +492,24 @@ __fixup_smp:
 	mrc	p15, 0, r0, c0, c0, 5	@ read MPIDR
 	and	r0, r0, #0xc0000000	@ multiprocessing extensions and
 	teq	r0, #0x80000000		@ not part of a uniprocessor system?
-	bne    __fixup_smp_on_up	@ no, assume UP
+	bne	__fixup_smp_on_up	@ no, assume UP
 
-	@ Core indicates it is SMP. Check for Aegis SOC where a single
-	@ Cortex-A9 CPU is present but SMP operations fault.
+	@ Core indicates it is SMP. Check for Vybrid/Aegis SoC where a single
+	@ Cortex-A5/A9 CPU is present
 	mov	r4, #0x41000000
 	orr	r4, r4, #0x0000c000
-	orr	r4, r4, #0x00000090
-	teq	r3, r4			@ Check for ARM Cortex-A9
-	retne	lr			@ Not ARM Cortex-A9,
-
+	orr	r0, r4, #0x00000090
+	teq	r3, r0			@ Check for ARM Cortex-A9
+	beq	__fixup_smp_by_scu
+	orr	r0, r4, #0x00000050
+	teq	r3, r0			@ Check for ARM Cortex-A5
+	beq	__fixup_smp_by_scu
+	ret	lr			@ Not ARM Cortex-A5 or A9, assume SMP
+
+__fixup_smp_by_scu:
 	@ If a future SoC *does* use 0x0 as the PERIPH_BASE, then the
 	@ below address check will need to be #ifdef'd or equivalent
-	@ for the Aegis platform.
+	@ for the Vybrid and Aegis platform.
 	mrc	p15, 4, r0, c15, c0	@ get SCU base address
 	teq	r0, #0x0		@ '0' on actual UP A9 hardware
 	beq	__fixup_smp_on_up	@ So its an A9 UP
-- 
2.2.2
