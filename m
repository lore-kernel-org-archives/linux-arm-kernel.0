From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 15 Oct 2018 18:35:33 -0400 (EDT)
Subject: [PATCH 2/2] ARM: copypage: do not use naked functions
In-Reply-To: <20181015222621.14673-1-stefan@agner.ch>
References: <20181015222621.14673-1-stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2018, Stefan Agner wrote:

> GCC documentation says naked functions should only use basic ASM
> syntax. The extended ASM or mixture of basic ASM and "C" code is
> not guaranteed. Currently it seems to work though.
> 
> Furthermore with Clang using parameters in extended asm in a
> naked function is not supported:
>   arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not
>   allowed in naked functions
>         : "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
>                ^
> 
> Use a regular function to be more portable. Also use volatile asm
> to avoid unsolicited optimizations.
> 
> Tested with qemu versatileab machine and versatile_defconfig and
> qemu mainstone machine using pxa_defconfig compiled with GCC 7.2.1
> and Clang 7.0.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/90
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/mm/copypage-fa.c       | 17 +++++++++++------
>  arch/arm/mm/copypage-feroceon.c | 17 +++++++++++------
>  arch/arm/mm/copypage-v4mc.c     | 14 +++++++++-----
>  arch/arm/mm/copypage-v4wb.c     | 17 +++++++++++------
>  arch/arm/mm/copypage-v4wt.c     | 17 +++++++++++------
>  arch/arm/mm/copypage-xsc3.c     | 17 +++++++++++------
>  arch/arm/mm/copypage-xscale.c   | 13 ++++++++-----
>  7 files changed, 72 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> index ec6501308c60..33ccd396bf99 100644
> --- a/arch/arm/mm/copypage-fa.c
> +++ b/arch/arm/mm/copypage-fa.c
> @@ -17,11 +17,16 @@
>  /*
>   * Faraday optimised copy_user_page
>   */
> -static void __naked
> -fa_copy_user_page(void *kto, const void *kfrom)
> +static void fa_copy_user_page(void *kto, const void *kfrom)
>  {
> -	asm("\
> -	stmfd	sp!, {r4, lr}			@ 2\n\
> +	register void *r0 asm("r0") = kto;
> +	register const void *r1 asm("r1") = kfrom;
> +
> +	asm(
> +	__asmeq("%0", "r0")
> +	__asmeq("%1", "r1")
> +	"\
> +	stmfd	sp!, {r4}			@ 2\n\
>  	mov	r2, %2				@ 1\n\
>  1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
>  	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> @@ -34,9 +39,9 @@ fa_copy_user_page(void *kto, const void *kfrom)
>  	subs	r2, r2, #1			@ 1\n\
>  	bne	1b				@ 1\n\
>  	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
> -	ldmfd	sp!, {r4, pc}			@ 3"
> +	ldmfd	sp!, {r4}			@ 3"
>  	:
> -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
> +	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 32));

This is still wrong as you list r0 and r1 in the input operand list 
where they must remain constant but the code does modify them. You 
should list them in the output operand list with the "&" attribute. Also 
r2 should be listed in the clobbered list.


Nicolas
