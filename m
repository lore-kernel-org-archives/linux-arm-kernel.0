From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Oct 2011 13:24:45 +0900
Subject: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
Message-ID: <20111020042444.GA20260@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Hi All,

it appears that "ARM: proc: add definition of cpu_reset for
 ARMv6 and ARMv7 cores" (f4daf06fc23b99df5ca5b3e892428b91e148cc52),
which was introduced for 3.1-rc1, causes a regression and that
kexec no longer works on ARM. The board that I am testing
on is a Renesas Mackerel which has an SH7372 (ARMv7) processor.

I have included the patch below for reference.


commit f4daf06fc23b99df5ca5b3e892428b91e148cc52
Author: Will Deacon <will.deacon@arm.com>
Date:   Mon Jun 6 12:27:34 2011 +0100

    ARM: proc: add definition of cpu_reset for ARMv6 and ARMv7 cores
    
    This patch adds simple definitions of cpu_reset for ARMv6 and ARMv7
    cores, which disable the MMU via the SCTLR.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 5ec1543..aedf3c5 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -56,6 +56,11 @@ ENTRY(cpu_v6_proc_fin)
  */
 	.align	5
 ENTRY(cpu_v6_reset)
+	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
+	bic	r1, r1, #0x1			@ ...............m
+	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
+	mov	r1, #0
+	mcr	p15, 0, r1, c7, c5, 4		@ ISB
 	mov	pc, r0
 
 /*
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 5932854..54d1a63 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -58,9 +58,16 @@ ENDPROC(cpu_v7_proc_fin)
  *	to what would be the reset vector.
  *
  *	- loc   - location to jump to for soft reset
+ *
+ *	This code must be executed using a flat identity mapping with
+ *      caches disabled.
  */
 	.align	5
 ENTRY(cpu_v7_reset)
+	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
+	bic	r1, r1, #0x1			@ ...............m
+	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
+	isb
 	mov	pc, r0
 ENDPROC(cpu_v7_reset)
 
