From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Mar 2012 10:10:52 -0400 (EDT)
Subject: [PATCH] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
Message-ID: <alpine.LFD.2.02.1203191002350.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Mar 2012, Boojin Kim wrote:

> This patch uses LDRD/STRD that loads and stores data as DWORD unit
> for the copy of 8-words data.
> It brings better performance than LDRM/STRM that was used originally.
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Firstly, you're breaking those CPUs without ldrd/strd support.

Secondly, you're breaking to_user/from_user copies when processor 
domains are not disabled.

Then, my question is why didn't you simply provide an alternative 
implementation of ldr8w/str8w using ldrd/strd instead of interleaving 
them?  Certainly that would have allowed you to benefit from SDRAM burst 
transfers which are typically aligned to d-cache lines, as well as 
locating the subs into the unavoidable result delay slot.

> ---
>  arch/arm/lib/copy_from_user.S |   14 +++++++++-----
>  arch/arm/lib/copy_template.S  |   10 ++++++----
>  arch/arm/lib/copy_to_user.S   |   13 +++++++++----
>  arch/arm/lib/memcpy.S         |   13 +++++++++----
>  4 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 66a477a..15d1e1c 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -51,11 +51,6 @@
>  	ldr1w \ptr, \reg4, \abort
>  	.endm
> 
> -	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> -	ldr4w \ptr, \reg1, \reg2, \reg3, \reg4, \abort
> -	ldr4w \ptr, \reg5, \reg6, \reg7, \reg8, \abort
> -	.endm
> -
>  	.macro ldr1b ptr reg cond=al abort
>  	ldrusr	\reg, \ptr, 1, \cond, abort=\abort
>  	.endm
> @@ -68,6 +63,15 @@
>  	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
>  	.endm
> 
> +	.macro cpy8w dst src reg1 reg2 abort
> +	.irp offset, #0, #8, #16, #24
> +	ldr1w \src, \reg1, \abort
> +	ldr1w \src, \reg2, \abort
> +	strd \reg1, \reg2, [\dst, \offset]
> +	.endr
> +	add \dst, \dst, #32
> +	.endm
> +
>  	.macro str1b ptr reg cond=al abort
>  	str\cond\()b \reg, [\ptr], #1
>  	.endm
> diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
> index 805e3f8..72640aa 100644
> --- a/arch/arm/lib/copy_template.S
> +++ b/arch/arm/lib/copy_template.S
> @@ -28,9 +28,8 @@
>   *	'ptr' to the next word. The 'abort' argument is used for fixup tables.
>   *
>   * ldr4w ptr reg1 reg2 reg3 reg4 abort
> - * ldr8w ptr, reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
>   *
> - *	This loads four or eight words starting from 'ptr', stores them
> + *	This loads eight words starting from 'ptr', stores them
>   *	in provided registers and increments 'ptr' past those words.
>   *	The'abort' argument is used for fixup tables.
>   *
> @@ -47,6 +46,10 @@
>   *	Same as their ldr* counterparts, but data is stored to 'ptr' location
>   *	rather than being loaded.
>   *
> + * cpy8w src dst reg1 reg2 abort
> + *	This loads eight words starting from 'src' and stores them to 'dst'.
> + *	The 'abort' argument is used for fixup tables.
> + *
>   * enter reg1 reg2
>   *
>   *	Preserve the provided registers on the stack plus any additional
> @@ -97,9 +100,8 @@
>  	PLD(	pld	[r1, #92]		)
> 
>  3:	PLD(	pld	[r1, #124]		)
> -4:		ldr8w	r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> +4:		cpy8w   r0, r1, r4, r5, abort=20f
>  		subs	r2, r2, #32
> -		str8w	r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
>  		bge	3b
>  	PLD(	cmn	r2, #96			)
>  	PLD(	bge	4b			)
> diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> index d066df6..9402a08 100644
> --- a/arch/arm/lib/copy_to_user.S
> +++ b/arch/arm/lib/copy_to_user.S
> @@ -48,10 +48,6 @@
>  	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4}
>  	.endm
> 
> -	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> -	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
> -	.endm
> -
>  	.macro ldr1b ptr reg cond=al abort
>  	ldr\cond\()b \reg, [\ptr], #1
>  	.endm
> @@ -71,6 +67,15 @@
>  	str1w \ptr, \reg8, \abort
>  	.endm
> 
> +	.macro cpy8w dst src reg1 reg2 abort
> +	.irp offset, #0, #8, #16, #24
> +	ldrd \reg1, \reg2, [\src, \offset]
> +	str1w \dst, \reg1, \abort
> +	str1w \dst, \reg2, \abort
> +	.endr
> +	add \src, \src, #32
> +	.endm
> +
>  	.macro str1b ptr reg cond=al abort
>  	strusr	\reg, \ptr, 1, \cond, abort=\abort
>  	.endm
> diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
> index a9b9e22..25320c9 100644
> --- a/arch/arm/lib/memcpy.S
> +++ b/arch/arm/lib/memcpy.S
> @@ -24,10 +24,6 @@
>  	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4}
>  	.endm
> 
> -	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> -	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
> -	.endm
> -
>  	.macro ldr1b ptr reg cond=al abort
>  	ldr\cond\()b \reg, [\ptr], #1
>  	.endm
> @@ -40,6 +36,15 @@
>  	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
>  	.endm
> 
> +	.macro cpy8w dst src reg1 reg2 abort
> +	.irp offset, #0, #8, #16, #24
> +	ldrd \reg1, \reg2, [\src, \offset]
> +	strd \reg1, \reg2, [\dst, \offset]
> +	.endr
> +	add \src, \src, #32
> +	add \dst, \dst, #32
> +	.endm
> +
>  	.macro str1b ptr reg cond=al abort
>  	str\cond\()b \reg, [\ptr], #1
>  	.endm
> --
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
