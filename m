From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Dec 2017 11:25:40 +0000
Subject: [PATCH 02/10] arm64: limit PA size to supported range
In-Reply-To: <1513184845-8711-3-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-3-git-send-email-kristina.martsenko@arm.com>
Message-ID: <d4014afb-a54c-14d0-adca-fb7d7d58febf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/17 17:07, Kristina Martsenko wrote:
> We currently copy the physical address size from
> ID_AA64MMFR0_EL1.PARange directly into TCR.(I)PS. This will not work for
> 4k and 16k granule kernels on systems that support 52-bit physical
> addresses, since 52-bit addresses are only permitted with the 64k
> granule.
> 
> To fix this, fall back to 48 bits when configuring the PA size when the
> kernel does not support 52-bit PAs. When it does, fall back to 52, to
> avoid similar problems in the future if the PA size is ever increased
> above 52.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>   arch/arm64/include/asm/assembler.h | 13 +++++++++++++
>   arch/arm64/include/asm/sysreg.h    |  8 ++++++++
>   arch/arm64/kvm/hyp-init.S          |  6 ++----
>   arch/arm64/kvm/hyp/s2-setup.c      |  2 ++
>   arch/arm64/mm/proc.S               |  6 ++----
>   5 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index aef72d886677..6cddf12a0250 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -351,6 +351,19 @@ alternative_endif
>   	.endm
>   
>   /*
> + * tcr_set_pa_size - set TCR.(I)PS to the highest supported
> + * ID_AA64MMFR0_EL1.PARange value
> + */
> +	.macro	tcr_set_pa_size, tcr, pos, tmp0, tmp1
> +	mrs	\tmp0, ID_AA64MMFR0_EL1
> +	ubfx	\tmp0, \tmp0, #ID_AA64MMFR0_PARANGE_SHIFT, #3
> +	mov	\tmp1, #ID_AA64MMFR0_PARANGE_MAX
> +	cmp	\tmp0, \tmp1
> +	csel	\tmp0, \tmp1, \tmp0, hi
> +	bfi	\tcr, \tmp0, \pos, #3
> +	.endm
> +
> +/*
>    * Macro to perform a data cache maintenance for the interval
>    * [kaddr, kaddr + size)
>    *
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 08cc88574659..ec144f480b39 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -471,6 +471,14 @@
>   #define ID_AA64MMFR0_TGRAN64_SUPPORTED	0x0
>   #define ID_AA64MMFR0_TGRAN16_NI		0x0
>   #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
> +#define ID_AA64MMFR0_PARANGE_48		0x5
> +#define ID_AA64MMFR0_PARANGE_52		0x6
> +
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +#define ID_AA64MMFR0_PARANGE_MAX	ID_AA64MMFR0_PARANGE_52
> +#else
> +#define ID_AA64MMFR0_PARANGE_MAX	ID_AA64MMFR0_PARANGE_48
> +#endif
>   
>   /* id_aa64mmfr1 */
>   #define ID_AA64MMFR1_PAN_SHIFT		20
> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index 3f9615582377..f731a48bd9f1 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -90,11 +90,9 @@ __do_hyp_init:
>   	bfi	x4, x5, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
>   #endif
>   	/*
> -	 * Read the PARange bits from ID_AA64MMFR0_EL1 and set the PS bits in
> -	 * TCR_EL2.
> +	 * Set the PS bits in TCR_EL2.
>   	 */
> -	mrs	x5, ID_AA64MMFR0_EL1
> -	bfi	x4, x5, #16, #3
> +	tcr_set_pa_size x4, #16, x5, x6
>   
>   	msr	tcr_el2, x4
>   
> diff --git a/arch/arm64/kvm/hyp/s2-setup.c b/arch/arm64/kvm/hyp/s2-setup.c
> index a81f5e10fc8c..603e1ee83e89 100644
> --- a/arch/arm64/kvm/hyp/s2-setup.c
> +++ b/arch/arm64/kvm/hyp/s2-setup.c
> @@ -32,6 +32,8 @@ u32 __hyp_text __init_stage2_translation(void)
>   	 * PS is only 3. Fortunately, bit 19 is RES0 in VTCR_EL2...
>   	 */
>   	parange = read_sysreg(id_aa64mmfr0_el1) & 7;
> +	if (parange > ID_AA64MMFR0_PARANGE_MAX)
> +		parange = ID_AA64MMFR0_PARANGE_MAX;
>   	val |= parange << 16;
>   
>   	/* Compute the actual PARange... */
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 95233dfc4c39..c10c6c180961 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -228,11 +228,9 @@ ENTRY(__cpu_setup)
>   	tcr_set_idmap_t0sz	x10, x9
>   
>   	/*
> -	 * Read the PARange bits from ID_AA64MMFR0_EL1 and set the IPS bits in
> -	 * TCR_EL1.
> +	 * Set the IPS bits in TCR_EL1.
>   	 */
> -	mrs	x9, ID_AA64MMFR0_EL1
> -	bfi	x10, x9, #32, #3
> +	tcr_set_pa_size x10, #32, x5, x6

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
