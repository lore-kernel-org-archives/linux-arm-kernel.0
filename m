From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 20 Aug 2017 13:26:54 +0100
Subject: [PATCH] arm64: kaslr: ignore modulo offset when validating
 virtual displacement
In-Reply-To: <20170818174230.30435-1-ard.biesheuvel@linaro.org>
References: <20170818174230.30435-1-ard.biesheuvel@linaro.org>
Message-ID: <20170820122653.vicqcqqdgqai6ywz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 06:42:30PM +0100, Ard Biesheuvel wrote:
> In the KASLR setup routine, we ensure that the early virtual mapping
> of the kernel image does not cover more than a single table entry at
> the level above the swapper block level, so that the assembler routines
> involved in setting up this mapping can remain simple.
> 
> In this calculation we add the proposed KASLR offset to the values of
> the _text and _end markers, and reject it if they would end up falling
> in different swapper table sized windows.
> 
> However, when taking the addresses of _text and _end, the modulo offset
> (the physical displacement modulo 2 MB) is already accounted for, and
> so adding it again results in incorrect results. So disregard the modulo
> offset from the calculation.
> 
> Fixes: 08cdac619c81 ("arm64: relocatable: deal with physically misaligned ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This still leaves the 16K pages issue, but I think this solves the problem
> encountered by Mark.

Thanks. It indeed seems to solve this aspect, at least in my tests but
I'll let Mark confirm with his known to fail seeds. For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>

For the 16K pages, we still need my patch on top of yours, slightly
changed to drop module_offset (see below). With both these patches, my
continuous reboot seems to be fine but I'll let it running overnight.

------8<-----------------------
>From fead5f2937b3af7e1054c1de74b7e5fe5964ac02 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 18 Aug 2017 15:39:24 +0100
Subject: [PATCH] arm64: kaslr: Adjust the offset to avoid Image across
 alignment boundary

With 16KB pages and a kernel Image larger than 16MB, the current
kaslr_early_init() logic for avoiding mappings across swapper table
boundaries fails since increasing the offset by kimg_sz just moves the
problem to the next boundary.

This patch decreases the offset by the boundary overflow amount, with
slight risk of reduced entropy as the kernel is more likely to be found
at kimg_sz below a swapper table boundary.

Fixes: afd0e5a87670 ("arm64: kaslr: Fix up the kernel image alignment")
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/kaslr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 1d95c204186b..b5fceb7efff5 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -131,8 +131,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/*
 	 * The kernel Image should not extend across a 1GB/32MB/512MB alignment
 	 * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
-	 * happens, increase the KASLR offset by the size of the kernel image
-	 * rounded up by SWAPPER_BLOCK_SIZE.
+	 * happens, decrease the KASLR offset by the boundary overflow rounded
+	 * up to SWAPPER_BLOCK_SIZE.
 	 *
 	 * NOTE: The references to _text and _end below will already take the
 	 *       modulo offset (the physical displacement modulo 2 MB) into
@@ -142,8 +142,9 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 */
 	if ((((u64)_text + offset) >> SWAPPER_TABLE_SHIFT) !=
 	    (((u64)_end + offset) >> SWAPPER_TABLE_SHIFT)) {
-		u64 kimg_sz = _end - _text;
-		offset = (offset + round_up(kimg_sz, SWAPPER_BLOCK_SIZE))
+		u64 adjust = ((u64)_end + offset) &
+			((1 << SWAPPER_TABLE_SHIFT) - 1);
+		offset = (offset - round_up(adjust, SWAPPER_BLOCK_SIZE))
 				& mask;
 	}
 
