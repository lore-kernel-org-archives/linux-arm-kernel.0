From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 12 Aug 2014 22:49:12 +0200
Subject: [PATCH v2 1/3] ARM: EXYNOS: Fix build with PM_SLEEP=n and
 ARM_EXYNOS_CPUIDLE=n
In-Reply-To: <1407856317-2457-2-git-send-email-b.zolnierkie@samsung.com>
References: <1407856317-2457-1-git-send-email-b.zolnierkie@samsung.com>
 <1407856317-2457-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <53EA7DC8.6040801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2014 05:11 PM, Bartlomiej Zolnierkiewicz wrote:
> Fix building of exynos_defconfig with disabled CONFIG_PM_SLEEP by
> adding checking whether Exynos cpuidle support is enabled before
> accessing exynos_enter_aftr.
>
> The build error message:
> arch/arm/mach-exynos/built-in.o:(.data+0x74): undefined reference to `exynos_enter_aftr'
> make: *** [vmlinux] Error 1
 >
> This patch has been tested on Exynos4210 based Origen board.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/mach-exynos/exynos.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 6a24e11..d57f136 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -161,7 +161,9 @@ static void exynos_restart(enum reboot_mode mode, const char *cmd)
>
>   static struct platform_device exynos_cpuidle = {
>   	.name              = "exynos_cpuidle",
> +#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
>   	.dev.platform_data = exynos_enter_aftr,
> +#endif
>   	.id                = -1,
>   };

This patch does not address the real issue of the compilation error. The 
cpuidle driver needs the exynos_enter_aftr function in order to work 
correctly. Hence the Makefile should be fixed in order to compile pm.o 
if cpuidle or pm_sleep are set.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
