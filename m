From: rshitrit@marvell.com (Ronen Shitrit)
Date: Mon, 17 May 2010 09:29:35 +0300
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in	theARMv6
	DMA cache ops
In-Reply-To: <20100516150117.GC23961@n2100.arm.linux.org.uk>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<20100516150117.GC23961@n2100.arm.linux.org.uk>
Message-ID: <309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Got it, thanks.

This is my patch over Catalin original patch for v6_dma_inv_range

--- cache-v6.S	2010-05-17 08:12:18.000000000 +0300
+++ cache-v6.S	2010-05-17 08:16:16.000000000 +0300
@@ -210,9 +210,15 @@
 #else
 	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
 #endif
-1:
 #ifdef CONFIG_SMP
-	str	r0, [r0]			@ write for ownership
+	mrs	r2, cpsr
+	orr	r3, r2, #PSR_F_BIT | PSR_I_BIT
+	msr	cpsr_c, r3                      @ Disable interrupts
+1:
+	ldr	r2, [r0]                        @ read for ownership
+	str	r2, [r0]                        @ write for ownership
+#else
+1:
 #endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line
@@ -222,6 +228,9 @@
 	add	r0, r0, #D_CACHE_LINE_SIZE
 	cmp	r0, r1
 	blo	1b
+#ifdef CONFIG_SMP
+	msr	cpsr_c, r2                      @ Restore interrupts
+#endif
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr



-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Sunday, May 16, 2010 6:01 PM
To: Ronen Shitrit
Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6 DMA cache ops

On Sun, May 16, 2010 at 09:29:47AM +0300, Ronen Shitrit wrote:
> Our ARMv6 do speculative rd for both I and D cache...

That means doing this read-write for ownership trick can lead to
corrupted data on your CPU, since the CPU may prefetch data from
the DMA buffer before the unmap has happened.

This means Catalin's patch is unsafe for your situation.
