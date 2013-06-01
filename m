From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 01 Jun 2013 14:27:12 +0200
Subject: [PATCH v2] arch: arm: plat-samsung: dependency, S5P_SLEEP depends
 on ARM_CPU_SUSPEND
In-Reply-To: <51A33C1F.3000804@asianux.com>
References: <5199E4AF.7040607@asianux.com> <51A32FD4.4000001@asianux.com>
 <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
 <51A33A53.1050502@asianux.com> <51A33C1F.3000804@asianux.com>
Message-ID: <51A9E8A0.3050906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2013 12:57 PM, Chen Gang wrote:
>
> When randconfig with MMU for arm s5pv210 (and select all cpu type),
> need let S5P_SLEEP depend on ARM_CPU_SUSPEND, or will cause issue below:
>
>    arch/arm/plat-samsung/built-in.o: In function `s3c_cpu_resume':
>    arch/arm/plat-samsung/s5p-sleep.S:83: undefined reference to `cpu_resume'
>
>
> Signed-off-by: Chen Gang<gang.chen@asianux.com>
> ---
>   arch/arm/plat-samsung/Kconfig |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index f8ed2de..b388d93 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -483,6 +483,7 @@ config S5P_PM
>
>   config S5P_SLEEP
>   	bool
> +	select ARM_CPU_SUSPEND if PM
>   	help
>   	  Internal config node to apply common S5P sleep management code.
>   	  Can be selected by S5P and newer SoCs with similar sleep procedure.

We have discussed this about two months ago [1] and the conclusion was 
to also
remove "select ARM_CPU_SUSPEND if PM" line from 
arch/arm/mach-exynos/Kconfig.
It is still unresolved then, I'm getting similar linker errors with
s3c2410_defconfig...

   LD      init/built-in.o
arch/arm/mach-s3c24xx/built-in.o: In function `s3c_cpu_resume':
/home/snawrocki/linux/media_tree/arch/arm/mach-s3c24xx/sleep.S:83: 
undefined reference to `cpu_resume'
arch/arm/plat-samsung/built-in.o: In function `s3c_pm_enter':
/home/snawrocki/linux/media_tree/arch/arm/plat-samsung/pm.c:305: 
undefined reference to `cpu_suspend'
make: *** [vmlinux] Error 1


[1] https://patchwork.kernel.org/patch/2406351

Thanks,
Sylwester
