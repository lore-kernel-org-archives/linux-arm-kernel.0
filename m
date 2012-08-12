From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 11 Aug 2012 23:39:06 -0400 (EDT)
Subject: [PATCH v2 05/22] ARM: LPAE: support 64-bit virt_to_phys patching
In-Reply-To: <1344648306-15619-6-git-send-email-cyril@ti.com>
References: <1344648306-15619-1-git-send-email-cyril@ti.com>
 <1344648306-15619-6-git-send-email-cyril@ti.com>
Message-ID: <alpine.LFD.2.02.1208112316560.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Aug 2012, Cyril Chemparathy wrote:

> This patch adds support for 64-bit physical addresses in virt_to_phys()
> patching.  This does not do real 64-bit add/sub, but instead patches in the
> upper 32-bits of the phys_offset directly into the output of virt_to_phys.
> 
> There is no corresponding change on the phys_to_virt() side, because
> computations on the upper 32-bits would be discarded anyway.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---
>  arch/arm/include/asm/memory.h |   22 ++++++++++++++++++----
>  arch/arm/kernel/head.S        |    4 ++++
>  arch/arm/kernel/setup.c       |    2 +-
>  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 81e1714..dc5fbf3 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -154,14 +154,28 @@
>  #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
>  
>  extern unsigned long	__pv_offset;
> -extern unsigned long	__pv_phys_offset;
> +extern phys_addr_t	__pv_phys_offset;
>  #define PHYS_OFFSET	__virt_to_phys(PAGE_OFFSET)
>  
>  static inline phys_addr_t __virt_to_phys(unsigned long x)
>  {
> -	unsigned long t;
> -	early_patch_imm8("add", t, x, __pv_offset, 0);
> -	return t;
> +	unsigned long tlo, thi;
> +
> +	early_patch_imm8("add", tlo, x, __pv_offset, 0);
> +
> +#ifdef CONFIG_ARM_LPAE
> +	/*
> +	 * On LPAE, we do not _need_ to do 64-bit arithmetic because the high
> +	 * order 32 bits are never changed by the phys-virt offset.  We simply
> +	 * patch in the high order physical address bits instead.
> +	 */
> +#ifdef __ARMEB__
> +	early_patch_imm8_mov("mov", thi, __pv_phys_offset, 0);
> +#else
> +	early_patch_imm8_mov("mov", thi, __pv_phys_offset, 4);
> +#endif
> +#endif
> +	return (u64)tlo | (u64)thi << 32;
>  }

Hmmm...  I'm afraid this is going to be suboptimal when LPAE is not 
selected.

First of all, you do not need to cast tlo to a u64 in the return value.

Then, I'm not sure if the compiler is smart enough to see that the 
returned value is a phys_addr_t which can be a u32, and in this case the 
(u64)thi << 32 is going to be truncated right away, and therefore there 
is no point in emiting the corresponding instructions.

Furthermore, if LPAE is not defined, then thi never gets initialized and 
should produce a warning. Did you test compilation of the code with LPAE 
turned off?

I'd prefer something like this where more stuff is validated by the 
compiler:

static inline phys_addr_t __virt_to_phys(unsigned long x)
{
	unsigned long tlo, thi;
	phys_addr_t ret;

	early_patch_imm8("add", tlo, x, __pv_offset, 0);
	ret = tlo;

	if (sizeof(phys_addr_t) > 4) {
#ifdef __ARMEB__
		early_patch_imm8_mov("mov", thi, __pv_phys_offset, 0);
#else
		early_patch_imm8_mov("mov", thi, __pv_phys_offset, 4);
#endif
		ret |= ((u64)thi) << 32;
	}

	return ret);
}

This should let the compiler optimize things whether LPAE is enabledor 
not while validating both cases.


Nicolas
