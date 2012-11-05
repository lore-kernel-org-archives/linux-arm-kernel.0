From: robherring2@gmail.com (Rob Herring)
Date: Mon, 05 Nov 2012 11:44:52 -0600
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121105172624.GE2005@linaro.org>
References: <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net> <20121105104839.GA2005@linaro.org>
 <20121105111346.GF28327@n2100.arm.linux.org.uk>
 <20121105130255.GD2005@linaro.org>
 <20121105153917.GG28327@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1211051111150.21033@xanadu.home>
 <20121105172624.GE2005@linaro.org>
Message-ID: <5097FB14.20404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 11:26 AM, Dave Martin wrote:
> On Mon, Nov 05, 2012 at 11:13:51AM -0500, Nicolas Pitre wrote:
>> On Mon, 5 Nov 2012, Russell King - ARM Linux wrote:
>>
>>> On Mon, Nov 05, 2012 at 01:02:55PM +0000, Dave Martin wrote:
>>>> Why not allow unaligned accesses in the decompressor, though, both
>>>> for v6 and v7?
>>>
>>> EXACTLY.
>>
>> I have no objections to that.  In fact, I made a remark to this effect 
>> in my initial review of this patch.  Whether or not gcc does take 
>> advantage of this hardware ability in the end is orthogonal.
> 
> For the sake of argument, here's how it might look.
> 
> Currently, I make no attempt to restore the original state of the U bit.
> The A bit if forced later by the kernel during boot, after a short window
> during which we should only run low-level arch code and therefore where
> no unaligned accesses should happen.
> 
> Does anyone think these issues are likely to be important?
> 

And here is my updated version that does v6 somewhat differently:

8<------------------------------------------------------------------
>From 76c2b7685397f13aa53f426822128430fc24b8a0 Mon Sep 17 00:00:00 2001
From: Rob Herring <rob.herring@calxeda.com>
Date: Mon, 5 Nov 2012 11:39:48 -0600
Subject: [PATCH v2] ARM: decompressor: clear SCTLR.A bit for v6 and v7 cores

With recent compilers and move to generic unaligned.h in commit d25c881
(ARM: 7493/1: use generic unaligned.h), unaligned accesses will be used
by the LZO decompressor on v7 cores. So we need to make sure unaligned
accesses are allowed by clearing the SCTLR A bit.

While v6 can support unaligned accesses, it is optional and current
compilers won't emit unaligned accesses. In case this changes and to align
with the kernel behavior, we clear the A bit and set the U bit.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/compressed/head.S |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index bc67cbf..f14d7ec 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -629,6 +629,11 @@ __armv4_mmu_cache_on:
 		mcr	p15, 0, r0, c7, c10, 4	@ drain write buffer
 		mcr	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
 		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
+		mrc	p15, 0, r11, c0, c0	@ get processor ID
+		and	r11, r11, #0xf0000
+		tst	r11, #0x70000		@ ARMv6
+		orreq	r0, r0, #1 << 22	@ set SCTLR.U
+		biceq	r0, r0, #1 << 1		@ clear SCTLR.A
 		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
 		orr	r0, r0, #0x0030
 #ifdef CONFIG_CPU_ENDIAN_BE8
@@ -654,6 +659,7 @@ __armv7_mmu_cache_on:
 #endif
 		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
 		bic	r0, r0, #1 << 28	@ clear SCTLR.TRE
+		bic	r0, r0, #1 << 1		@ clear SCTLR.A
 		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
 		orr	r0, r0, #0x003c		@ write buffer
 #ifdef CONFIG_MMU
-- 
1.7.10.4
