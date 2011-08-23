From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Aug 2011 17:32:47 +0100
Subject: v6 software reset fails on 1176
Message-ID: <20110823163247.GM2796@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I'm trying to use the cpu_v6_reset that you added in "ARM: proc: add 
definition of cpu_reset for ARMv6 and ARMv7 cores", but I've found that 
on my 1176 platform, it never gets to the branch to the reset vector.  

Removing the ISB allows the branch instruction to be in the pipeline by 
the time the MMU is disabled, but I'm not sure if this is the correct 
fix.  Having said that, I don't see how this can work with an ISB in 
there.

Jamie

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 219138d..3b6737a 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -59,8 +59,6 @@ ENTRY(cpu_v6_reset)
 	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
 	bic	r1, r1, #0x1			@ ...............m
 	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
-	mov	r1, #0
-	mcr	p15, 0, r1, c7, c5, 4		@ ISB
 	mov	pc, r0
 
 /*
