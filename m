From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jul 2015 09:52:20 +0900
Subject: [PATCHv4] ARM: dts: add exynos5422-cpus.dtsi to correct cpu order
In-Reply-To: <1436106556-19134-1-git-send-email-chanho61.park@samsung.com>
References: <1436106556-19134-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <5599D144.7040001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.07.2015 23:29, Chanho Park wrote:
> The odroid-xu3 board which is based on exynos5422 not exynos5800 is
> booted from cortex-a7 core unlike exynos5800. The odroid-xu3's cpu order
> is quite strange. cpu0 and cpu5-7 are cortex-a7 cores and cpu1-4 are
> cortex-a15 cores. To correct this mis-odering, I added exynos5422.dtsi
> and reversing cpu orders from exynos5420. Now, cpu0-3 are cortex-a7 and
> cpu4-7 are cortex-a15.
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
> Changes from v3:
>  - include this exynos5422-cpus.dtsi in the exynos5422-odroidxu3-common.dtsi
> 
> Changes from v2:
>  - drop inclusion of exynos5420.dtsi from exynos5422-cpus.dtsi
>  - drop compatibles from exynos5422-cpus.dtsi
> 
> Changes from v1:
>  - rename exynos5422.dtsi to exynos5422-cpus.dtsi
>  - include the dtsi file top of the exynos5422-odroidxu3.dts
> 
> Secondary cpu booting problem[1] is not resolved yet. Below temporal patch is
> required to see 8 cores booting.
> 
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -124,6 +124,7 @@ void exynos_cpu_power_up(int cpu)
>         if (soc_is_exynos3250())
>                 core_conf |= S5P_CORE_AUTOWAKEUP_EN;
> 
> +       pmu_raw_writel(1, S5P_PMU_SPARE2);
>         pmu_raw_writel(core_conf,
>                         EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>  }
> 
> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg45525.html

$ git am ...
Applying: ARM: dts: add exynos5422-cpus.dtsi to correct cpu order
error: patch failed: arch/arm/mach-exynos/platsmp.c:124
error: arch/arm/mach-exynos/platsmp.c: patch does not apply

The diff above confuses 'git am'.

Best regards,
Krzysztof
