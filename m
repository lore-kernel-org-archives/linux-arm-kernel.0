From: robherring2@gmail.com (Rob Herring)
Date: Thu, 11 Oct 2012 07:43:22 -0500
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
Message-ID: <1349959402-24164-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With recent compilers and move to generic unaligned.h in commit d25c881
(ARM: 7493/1: use generic unaligned.h), unaligned accesses will be used
by the LZO decompressor on v7 cores. So we need to make sure unaligned
accesses are allowed by clearing the SCTLR A bit.

While v6 can support unaligned accesses, it is optional and current
compilers won't emit unaligned accesses. So we don't clear the A bit for
v6.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---

The contents of this were already reviewed on this thread, so I sent this
to the patch system and this was Russell's reply:

> NAK for two reasons.
> 
> 1. It hasn't been on the list (I can't find a match for "clear SCTLR.A"
> in my mailbox)
> 
> 2. The behaviour of unaligned accesses vary depending on CPU.  Some
> fix-up the access, others load the word and then rotate it.  If we have
> decompressors which perform unaligned accesses, we need to fix this
> properly to avoid the CPU specific behaviour, rather than tweaking
> control bits to hide the problem.

I'm simply matching the behavior of the kernel itself. The A bit is cleared
for v7 kernels and compilers only generate unaligned accesses for v7.
Without this the initial state of the A bit is undefined as a bootloader
could have cleared it already. We should document the required state or set
it to what we want.

Rob

 arch/arm/boot/compressed/head.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index bc67cbf..b2e30b8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -654,6 +654,7 @@ __armv7_mmu_cache_on:
 #endif
 		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
 		bic	r0, r0, #1 << 28	@ clear SCTLR.TRE
+		bic	r0, r0, #1 << 1		@ clear SCTLR.A
 		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
 		orr	r0, r0, #0x003c		@ write buffer
 #ifdef CONFIG_MMU
-- 
1.7.9.5
