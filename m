From: geoff@infradead.org (Geoff Levand)
Date: Thu, 18 Aug 2016 10:57:50 -0700
Subject: [PATCH 6/8] arm64: Introduce raw_{d,i}cache_line_size
In-Reply-To: <1471525832-21209-7-git-send-email-suzuki.poulose@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1471543070.20164.14.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-08-18 at 14:10 +0100, Suzuki K Poulose wrote:
> On systems with mismatched i/d cache min line sizes, we need to use
> the smallest size possible across all CPUs. This will be done by fetching
> the system wide safe value from CPU feature infrastructure.
> However the some special users(e.g kexec, hibernate) would need the line
> size on the CPU (rather than the system wide), when the system wide
> feature may not be accessible. Provide another helper which will fetch
> cache line size on the current CPU.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Geoff Levand <geoff@infradead.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> ?arch/arm64/include/asm/assembler.h??| 24 ++++++++++++++++++++----
> ?arch/arm64/kernel/hibernate-asm.S???|??2 +-
> ?arch/arm64/kernel/relocate_kernel.S |??2 +-
> ?3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index d5025c6..a4bb3f5 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -218,9 +218,10 @@ lr	.req	x30		// link register
> ?	.endm
> ?
> ?/*
> - * dcache_line_size - get the minimum D-cache line size from the CTR register.
> + * raw_dcache_line_size - get the minimum D-cache line size on this CPU
> + * from the CTR register.
> ? */
> -	.macro	dcache_line_size, reg, tmp
> +	.macro	raw_dcache_line_size, reg, tmp
> ?	mrs	\tmp, ctr_el0			// read CTR
> ?	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
> ?	mov	\reg, #4			// bytes per word
> @@ -228,9 +229,17 @@ lr	.req	x30		// link register
> ?	.endm

...

> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -34,7 +34,7 @@ ENTRY(arm64_relocate_new_kernel)
> ?	/* Setup the list loop variables. */
> ?	mov	x17, x1				/* x17 = kimage_start */
> ?	mov	x16, x0				/* x16 = kimage_head */
> -	dcache_line_size x15, x0		/* x15 = dcache line size */
> +	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
> ?	mov	x14, xzr			/* x14 = entry ptr */
> ?	mov	x13, xzr			/* x13 = copy dest */

Since this is just renaming dcache_line_size to raw_dcache_line_size,
and for kexec's relocate_kernel we need to know about the CPU we are
running on, this part of the change looks good.

Reviewed by: Geoff Levand <geoff@infradead.org>
