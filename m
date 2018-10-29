From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 29 Oct 2018 09:49:10 -0400 (EDT)
Subject: [PATCH v4] ARM: Optimise copy_{from/to}_user for !CPU_USE_DOMAINS
In-Reply-To: <20181029080635.28973-1-vincent.whitchurch@axis.com>
References: <20181029080635.28973-1-vincent.whitchurch@axis.com>
Message-ID: <nycvar.YSQ.7.76.1810290948230.1498@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Oct 2018, Vincent Whitchurch wrote:

> ARMv6+ processors do not use CONFIG_CPU_USE_DOMAINS and use privileged
> ldr/str instructions in copy_{from/to}_user.  They are currently
> unnecessarily using single ldr/str instructions and can use ldm/stm
> instructions instead like memcpy does (but with appropriate fixup
> tables).
> 
> This speeds up a "dd if=foo of=bar bs=32k" on a tmpfs filesystem by
> about 4% on my Cortex-A9.
> 
> before:134217728 bytes (128.0MB) copied, 0.543848 seconds, 235.4MB/s
> before:134217728 bytes (128.0MB) copied, 0.538610 seconds, 237.6MB/s
> before:134217728 bytes (128.0MB) copied, 0.544356 seconds, 235.1MB/s
> before:134217728 bytes (128.0MB) copied, 0.544364 seconds, 235.1MB/s
> before:134217728 bytes (128.0MB) copied, 0.537130 seconds, 238.3MB/s
> before:134217728 bytes (128.0MB) copied, 0.533443 seconds, 240.0MB/s
> before:134217728 bytes (128.0MB) copied, 0.545691 seconds, 234.6MB/s
> before:134217728 bytes (128.0MB) copied, 0.534695 seconds, 239.4MB/s
> before:134217728 bytes (128.0MB) copied, 0.540561 seconds, 236.8MB/s
> before:134217728 bytes (128.0MB) copied, 0.541025 seconds, 236.6MB/s
> 
>  after:134217728 bytes (128.0MB) copied, 0.520445 seconds, 245.9MB/s
>  after:134217728 bytes (128.0MB) copied, 0.527846 seconds, 242.5MB/s
>  after:134217728 bytes (128.0MB) copied, 0.519510 seconds, 246.4MB/s
>  after:134217728 bytes (128.0MB) copied, 0.527231 seconds, 242.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.525030 seconds, 243.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.524236 seconds, 244.2MB/s
>  after:134217728 bytes (128.0MB) copied, 0.523659 seconds, 244.4MB/s
>  after:134217728 bytes (128.0MB) copied, 0.525018 seconds, 243.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.519249 seconds, 246.5MB/s
>  after:134217728 bytes (128.0MB) copied, 0.518527 seconds, 246.9MB/s
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Nicolas Pitre <nico@linaro.org>


> ---
> v4: Do not modify str1b/ldr1b
> v3: Explicitly add IT instructions to fix fault handling on Thumb-2
> v2: Group *_SHIFT #defines with respective .macro implementations
> 
>  arch/arm/include/asm/assembler.h |  6 ++++--
>  arch/arm/lib/copy_from_user.S    | 23 ++++++++++++++++++++++-
>  arch/arm/lib/copy_to_user.S      | 27 ++++++++++++++++++++++-----
>  3 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index b17ee03d280b..da16d31c7ef9 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -243,13 +243,15 @@
>  	.endm
>  #endif
>  
> -#define USER(x...)				\
> +#define USERL(l, x...)				\
>  9999:	x;					\
>  	.pushsection __ex_table,"a";		\
>  	.align	3;				\
> -	.long	9999b,9001f;			\
> +	.long	9999b,l;			\
>  	.popsection
>  
> +#define USER(x...)	USERL(9001f, x)
> +
>  #ifdef CONFIG_SMP
>  #define ALT_SMP(instr...)					\
>  9998:	instr
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index a826df3d3814..3f79001830fe 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -34,12 +34,13 @@
>   *	Number of bytes NOT copied.
>   */
>  
> +#ifdef CONFIG_CPU_USE_DOMAINS
> +
>  #ifndef CONFIG_THUMB2_KERNEL
>  #define LDR1W_SHIFT	0
>  #else
>  #define LDR1W_SHIFT	1
>  #endif
> -#define STR1W_SHIFT	0
>  
>  	.macro ldr1w ptr reg abort
>  	ldrusr	\reg, \ptr, 4, abort=\abort
> @@ -57,10 +58,30 @@
>  	ldr4w \ptr, \reg5, \reg6, \reg7, \reg8, \abort
>  	.endm
>  
> +#else
> +
> +#define LDR1W_SHIFT	0
> +
> +	.macro ldr1w ptr reg abort
> +	USERL(\abort, W(ldr) \reg, [\ptr], #4)
> +	.endm
> +
> +	.macro ldr4w ptr reg1 reg2 reg3 reg4 abort
> +	USERL(\abort, ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4})
> +	.endm
> +
> +	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> +	USERL(\abort, ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8})
> +	.endm
> +
> +#endif /* CONFIG_CPU_USE_DOMAINS */
> +
>  	.macro ldr1b ptr reg cond=al abort
>  	ldrusr	\reg, \ptr, 1, \cond, abort=\abort
>  	.endm
>  
> +#define STR1W_SHIFT	0
> +
>  	.macro str1w ptr reg abort
>  	W(str) \reg, [\ptr], #4
>  	.endm
> diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> index caf5019d8161..5cb28f6c7941 100644
> --- a/arch/arm/lib/copy_to_user.S
> +++ b/arch/arm/lib/copy_to_user.S
> @@ -35,11 +35,6 @@
>   */
>  
>  #define LDR1W_SHIFT	0
> -#ifndef CONFIG_THUMB2_KERNEL
> -#define STR1W_SHIFT	0
> -#else
> -#define STR1W_SHIFT	1
> -#endif
>  
>  	.macro ldr1w ptr reg abort
>  	W(ldr) \reg, [\ptr], #4
> @@ -57,6 +52,14 @@
>  	ldr\cond\()b \reg, [\ptr], #1
>  	.endm
>  
> +#ifdef CONFIG_CPU_USE_DOMAINS
> +
> +#ifndef CONFIG_THUMB2_KERNEL
> +#define STR1W_SHIFT	0
> +#else
> +#define STR1W_SHIFT	1
> +#endif
> +
>  	.macro str1w ptr reg abort
>  	strusr	\reg, \ptr, 4, abort=\abort
>  	.endm
> @@ -72,6 +75,20 @@
>  	str1w \ptr, \reg8, \abort
>  	.endm
>  
> +#else
> +
> +#define STR1W_SHIFT	0
> +
> +	.macro str1w ptr reg abort
> +	USERL(\abort, W(str) \reg, [\ptr], #4)
> +	.endm
> +
> +	.macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> +	USERL(\abort, stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8})
> +	.endm
> +
> +#endif /* CONFIG_CPU_USE_DOMAINS */
> +
>  	.macro str1b ptr reg cond=al abort
>  	strusr	\reg, \ptr, 1, \cond, abort=\abort
>  	.endm
> -- 
> 2.11.0
> 
> 
