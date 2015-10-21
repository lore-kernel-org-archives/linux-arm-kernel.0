From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Oct 2015 09:48:22 +0100
Subject: [PATCHv4 08/24] arm64: Keep track of CPU feature registers
In-Reply-To: <1445261101-22344-9-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
 <1445261101-22344-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151021084821.GE4801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:24:45PM +0100, Suzuki K. Poulose wrote:
> This patch adds an infrastructure to keep track of the CPU feature
> registers on the system. For each register, the infrastructure keeps
> track of the system wide safe value of the feature bits. Also, tracks
> the which fields of a register should be matched strictly across all
> the CPUs on the system for the SANITY check infrastructure.

[...]

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 85507fe..af0c187 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -35,6 +35,37 @@
>  
>  #include <linux/kernel.h>
>  
> +/* CPU feature register tracking */
> +enum ftr_type {
> +	FTR_EXACT,	/* Use a predefined safe value */
> +	FTR_LOWER_SAFE,	/* Smaller value is safe */
> +	FTR_HIGHER_SAFE,/* Bigger value is safe */
> +};
> +
> +#define FTR_STRICT	true	/* SANITY check strict matching required */
> +#define FTR_NONSTRICT	false	/* SANITY check ignored */
> +
> +struct arm64_ftr_bits {
> +	bool		strict;	  /* CPU Sanity check: strict matching required ? */
> +	enum ftr_type	type;
> +	u8		shift;
> +	u8		width;
> +	s64		safe_val; /* safe value for discrete features */
> +};
> +
> +/*
> + * @arm64_ftr_reg - Feature register
> + * @strict_mask 	Bits which should match across all CPUs for sanity.

nit: ^ whitespace, no need to fix unless respinning the series

> + * @sys_val		Safe value across the CPUs (system view)
> + */
> +struct arm64_ftr_reg {

[...]

Cheers
---Dave
