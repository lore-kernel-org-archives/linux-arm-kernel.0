From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Sep 2014 01:08:12 +0900
Subject: [PATCH] ARM: cacheflush: Fix exynos build breakage on ARMv6 by
 using macros for ISB/DSB
In-Reply-To: <1410871979-12470-1-git-send-email-k.kozlowski@samsung.com>
References: <1410871979-12470-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54219AEC.2060204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/14 21:52, Krzysztof Kozlowski wrote:
> This fixes build breakage of platsmp.c if ARMv6 was chosen for compile
> time options (e.g. by building allmodconfig):
>
> $ make allmodconfig
> $ make
>    CC      arch/arm/mach-exynos/platsmp.o
> /tmp/ccdQM0Eg.s: Assembler messages:
> /tmp/ccdQM0Eg.s:432: Error: selected processor does not support ARM mode `isb '
> /tmp/ccdQM0Eg.s:437: Error: selected processor does not support ARM mode `isb '
> /tmp/ccdQM0Eg.s:438: Error: selected processor does not support ARM mode `dsb '
> make[1]: *** [arch/arm/mach-exynos/platsmp.o] Error 1
>
> The error was introduced in commit "ARM: EXYNOS: Move code from
> hotplug.c to platsmp.c".  Previously code using
> v7_exit_coherency_flush() macro was built with '-march=armv7-a' flag but
> this flag dissapeared during the movement.
>
> Use isb() and dsb() macros in v7_exit_coherency_flush() so the proper
> code will be generated for ARMv6.
>
> Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
> Reported-by: Mark Brown<broonie@kernel.org>
> Link: http://www.spinics.net/lists/linux-samsung-soc/msg36790.html
> ---
>   arch/arm/include/asm/cacheflush.h | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 79ecb4f34ffb..b74eeec971c0 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -464,22 +464,27 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
>    *   CONFIG_FRAME_POINTER=y.  ip is saved as well if ever r12-clobbering
>    *   trampoline are inserted by the linker and to keep sp 64-bit aligned.
>    */
> -#define v7_exit_coherency_flush(level) \
> +#define v7_exit_coherency_flush(level) do { \
>   	asm volatile( \
>   	"stmfd	sp!, {fp, ip} \n\t" \
>   	"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR \n\t" \
>   	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
>   	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR \n\t" \
> -	"isb	\n\t" \
> +	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
> +	      "r9","r10","lr","memory" ); \
> +	isb(); \
> +	asm volatile( \
>   	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
>   	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR \n\t" \
>   	"bic	r0, r0, #(1<<  6)	@ disable local coherency \n\t" \
>   	"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR \n\t" \
> -	"isb	\n\t" \
> -	"dsb	\n\t" \
> -	"ldmfd	sp!, {fp, ip}" \
>   	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
> -	      "r9","r10","lr","memory" )
> +	      "r9","r10","lr","memory" ); \
> +	isb(); \
> +	dsb(); \
> +	asm volatile( \
> +	"ldmfd	sp!, {fp, ip}" ); \
> +	} while (0)
>
>   int set_memory_ro(unsigned long addr, int numpages);
>   int set_memory_rw(unsigned long addr, int numpages);

Hi Russell,

Can you please check this patch? Unfortunately I'm not sure about this, 
this should resolve the build error though...

- Kukjin
