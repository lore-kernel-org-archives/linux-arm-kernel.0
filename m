From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 15:22:05 +0100
Subject: [PATCH 2/3] ARM: spectre-v1: add array_index_mask_nospec()
 implementation
In-Reply-To: <E1fONfh-00070F-Tw@rmk-PC.armlinux.org.uk>
References: <20180531133047.GS17671@n2100.armlinux.org.uk>
 <E1fONfh-00070F-Tw@rmk-PC.armlinux.org.uk>
Message-ID: <20180531142205.hzqyt46ijd5vkp77@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 02:31:17PM +0100, Russell King wrote:
> Add an implementation of the array_index_mask_nospec() function for
> mitigating Spectre variant 1 throughout the kernel.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/include/asm/barrier.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
> index 3d9c1d4b7e75..a89adcf53b99 100644
> --- a/arch/arm/include/asm/barrier.h
> +++ b/arch/arm/include/asm/barrier.h
> @@ -76,6 +76,24 @@ extern void arm_heavy_mb(void);
>  #define __smp_rmb()	__smp_mb()
>  #define __smp_wmb()	dmb(ishst)
>  
> +#ifdef CONFIG_CPU_SPECTRE
> +static inline unsigned long array_index_mask_nospec(unsigned long idx,
> +						    unsigned long sz)
> +{
> +	unsigned long mask;
> +
> +	asm(	"cmp	%1, %2\n"
> +	"	sbc	%0, %1, %1\n"
> +	CSDB
> +	: "=r" (mask)
> +	: "r" (idx), "Ir" (sz)
> +	: "cc");
> +
> +	return mask;
> +}
> +#define array_index_mask_nospec array_index_mask_nospec
> +#endif

I believe that the asm should be volatile, otherwise there are cases
where the compiler could remove an invocation that's redundant under
architectural execution, but required under speculation [1].

With that made volatile:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180530060546.jnjoltsturoduohh at salmiak
