From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Dec 2017 11:48:13 +0000
Subject: [PATCH v2 06/18] arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
In-Reply-To: <1512059986-21325-7-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-7-git-send-email-will.deacon@arm.com>
Message-ID: <20171201114813.lgqtdadjs6r3xiwg@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:39:34PM +0000, Will Deacon wrote:
> With the ASID now installed in TTBR1, we can re-enable ARM64_SW_TTBR0_PAN
> by ensuring that we switch to a reserved ASID of zero when disabling
> user access and restore the active user ASID on the uaccess enable path.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

[...]

> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index b3da6c886835..21b8cf304028 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -16,11 +16,20 @@
>  	add	\tmp1, \tmp1, #SWAPPER_DIR_SIZE	// reserved_ttbr0 at the end of swapper_pg_dir
>  	msr	ttbr0_el1, \tmp1		// set reserved TTBR0_EL1
>  	isb
> +	sub	\tmp1, \tmp1, #SWAPPER_DIR_SIZE
> +	bic	\tmp1, \tmp1, #(0xffff << 48)
> +	msr	ttbr1_el1, \tmp1		// set reserved ASID
> +	isb
>  	.endm
>  
> -	.macro	__uaccess_ttbr0_enable, tmp1
> +	.macro	__uaccess_ttbr0_enable, tmp1, tmp2
>  	get_thread_info \tmp1
>  	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
> +	mrs	\tmp2, ttbr1_el1
> +	extr    \tmp2, \tmp2, \tmp1, #48
> +	ror     \tmp2, \tmp2, #16

It took me a while to figure out what was going on here, as I confused
EXTR with BFX.

I also didn't realise that thread_info::ttbr0 still had the ASID
orred-in. I guess it doesn't matter if we write that into TTBR0_EL1, as
it should be ignored by HW.

> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index fc0f9eb66039..750a3b76a01c 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -107,15 +107,19 @@ static inline void __uaccess_ttbr0_disable(void)
>  {
>  	unsigned long ttbr;
>  
> +	ttbr = read_sysreg(ttbr1_el1);
>  	/* reserved_ttbr0 placed at the end of swapper_pg_dir */
> -	ttbr = read_sysreg(ttbr1_el1) + SWAPPER_DIR_SIZE;
> -	write_sysreg(ttbr, ttbr0_el1);
> +	write_sysreg(ttbr + SWAPPER_DIR_SIZE, ttbr0_el1);
> +	isb();
> +	/* Set reserved ASID */
> +	ttbr &= ~(0xffffUL << 48);

Given we have this constant open-coded in a few places, maybe we should
have something like:

#define TTBR_ASID_MASK	(UL(0xffff) << 48)

... in a header somewhere.

Otherwise, looks good to me.

Thanks,
Mark.
