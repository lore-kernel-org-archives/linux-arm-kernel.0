From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 4 Nov 2011 13:45:03 +0900
Subject: [PATCH] ARM: EXYNOS4: Enable write full line for zeros mode
In-Reply-To: <1320373056-11718-1-git-send-email-boojin.kim@samsung.com>
References: <1320373056-11718-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <CAH9JG2XWPrrWWvnwmbbqixsN72P=Y87KBw3Skgsp_aiYx66XCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/4/11, Boojin Kim <boojin.kim@samsung.com> wrote:
> This patch enables the 'write full line for zeros mode' feature of
> cortex-A9.
> The performance of memset() with zero is increased about 10% with this
> patch.

It seems CA9 common parts, does other SoC require same feature?
>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> ---
>  arch/arm/mach-exynos4/platsmp.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/platsmp.c
> b/arch/arm/mach-exynos4/platsmp.c
> index d5f0f29..edf7054 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -90,6 +90,16 @@ static void __cpuinit exynos4_gic_secondary_init(void)
>  	__raw_writel(1, cpu_base + GIC_CPU_CTRL);
>  }
>
> +static void enable_foz(void)
> +{
> +	u32 val;
> +	asm volatile(
> +	"mrc   p15, 0, %0, c1, c0, 1\n"
> +	"orr   %0, %0, #(1 << 3)\n"
> +	"mcr   p15, 0, %0, c1, c0, 1"
> +	: "=r" (val));
> +}
> +
>  void __cpuinit platform_secondary_init(unsigned int cpu)
>  {
>  	/*
> @@ -106,6 +116,14 @@ void __cpuinit platform_secondary_init(unsigned int
> cpu)
>  	write_pen_release(-1);
>
>  	/*
> +	* Enable write full line for zeros mode
> +	*/
> +	if (soc_is_exynos4210() | soc_is_exynos4212() | soc_is_exynos4412()) {
Now CA15 is not ready so this if statement is meaningless.
> +		enable_foz();
> +		smp_call_function((void (*)(void *))enable_foz, NULL, 0);
> +	}
> +
> +	/*
>  	 * Synchronise with the boot thread.
>  	 */
>  	spin_lock(&boot_lock);
Thank you,
Kyungmin Park
