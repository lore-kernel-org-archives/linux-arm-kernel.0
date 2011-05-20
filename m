From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 15:31:42 +0100
Subject: [PATCH v3 1/2] arm: Convert v7 proc infos into a common macro
In-Reply-To: <1305898769-10462-1-git-send-email-pawel.moll@arm.com>
References: <1305892312.17656.72.camel@hornet.cambridge.arm.com>
	<1305898769-10462-1-git-send-email-pawel.moll@arm.com>
Message-ID: <002101cc16fa$a3bc6650$eb3532f0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pawel,

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index babfba0..e5087aa 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -436,33 +436,36 @@ cpu_elf_name:
> 
>  	.section ".proc.info.init", #alloc, #execinstr
> 
> -	.type   __v7_ca9mp_proc_info, #object
> -__v7_ca9mp_proc_info:
> -	.long	0x410fc090		@ Required ID value
> -	.long	0xff0ffff0		@ Mask for ID
> -	ALT_SMP(.long \
> -		PMD_TYPE_SECT | \
> -		PMD_SECT_AP_WRITE | \
> -		PMD_SECT_AP_READ | \
> -		PMD_FLAGS_SMP)
> -	ALT_UP(.long \
> -		PMD_TYPE_SECT | \
> -		PMD_SECT_AP_WRITE | \
> -		PMD_SECT_AP_READ | \
> -		PMD_FLAGS_UP)
> -	.long   PMD_TYPE_SECT | \
> -		PMD_SECT_XN | \
> -		PMD_SECT_AP_WRITE | \
> -		PMD_SECT_AP_READ
> -	W(b)	__v7_ca9mp_setup
> +	/*
> +	 * Standard v7 proc info content
> +	 */
> +.macro __v7_proc initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0
> +	ALT_SMP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
> +			PMD_FLAGS_SMP | \mm_mmuflags)
> +	ALT_UP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
> +			PMD_FLAGS_UP | \mm_mmuflags)

My only minor gripe is the reformatting of the PMD_* here.
Functionally, it looks fine.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
