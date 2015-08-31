From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 1 Sep 2015 00:46:22 +0200
Subject: [PATCH] ARM: EXYNOS: reset KFC cores when cpu is up
In-Reply-To: <7hmvx785wx.fsf@deeprootsystems.com>
References: <1441031111-6549-1-git-send-email-parkch98@gmail.com>
 <7hmvx785wx.fsf@deeprootsystems.com>
Message-ID: <55E4D93E.4090307@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[adding Krzysztof Kozlowski to cc list]

Hello Kevin,

On 09/01/2015 12:11 AM, Kevin Hilman wrote:
> Chanho Park <parkch98@gmail.com> writes:
> 
>> The cpu booting of exynos5422 has been still broken since we discussed
>> it in last year[1]. This patch is inspired from odroid xu3
>> code(Actually, it was from samsung exynos vendor kernel)[2]. This weird
>> reset code was founded exynos5420 octa cores series SoCs and only
>> required for the first boot core is the little core(kingfisher core).
>> Some of the exynos5420 boards and all of the exynos5422 boards will be
>> required this code.
>> There is two ways to check the little core is the first cpu. One is
>> checking GPG2CON[1] gpio value and the other is checking the cluster
>> number of the first cpu. I selected the latter because it's more easier
>> than the former.
>>
>> Changes since RFC[3]:
>> - drop checking soc_is_exynos5800 to extend this codes to
>> exynos5420/5422 boards.
>> - kfc cores will be reset only if the cpu0 is kfc core.
>> - Rebase top of the kukjin's for-next branch
>>
>> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350632.html
>> [2]:https://patchwork.kernel.org/patch/6782891/
>> [3]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356610.html
>>
>> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Heesub Shin <heesub.shin@samsung.com>
>> Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
>> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
>> Cc: Przemyslaw Marczak <p.marczak@samsung.com>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Chanho Park <parkch98@gmail.com>
> 
>> ---
>>  arch/arm/mach-exynos/mcpm-exynos.c | 18 +++++++++++++++++-
>>  arch/arm/mach-exynos/regs-pmu.h    |  6 ++++++
>>  2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
>> index 9bdf547..5b69ed2 100644
>> --- a/arch/arm/mach-exynos/mcpm-exynos.c
>> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>> @@ -20,6 +20,7 @@
>>  #include <asm/cputype.h>
>>  #include <asm/cp15.h>
>>  #include <asm/mcpm.h>
>> +#include <asm/smp_plat.h>
>>  
>>  #include "regs-pmu.h"
>>  #include "common.h"
>> @@ -70,7 +71,22 @@ static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>>  		cluster >= EXYNOS5420_NR_CLUSTERS)
>>  		return -EINVAL;
>>  
>> -	exynos_cpu_power_up(cpunr);
>> +	if (!exynos_cpu_power_state(cpunr)) {
>> +		exynos_cpu_power_up(cpunr);
>> +
>> +		/* This assumes the cluster number of the eagle is 0 and the
>> +		 * kfc is 1. When the system was booted from the kfc core,
>> +		 * they should be reset */
> 
> minor: fix multi-line comment style (search for 'multi-line' in
> Documentation/CodingStyle)
> 
> Also minor, but personally, I prefer seeing A15/A7 instead of eagle/KFC
> as those names are fading from my memory and I can't seem to remember
> which one is which. :/
> 
>> +		if (cluster &&
>> +		    cluster == MPIDR_AFFINITY_LEVEL(cpu_logical_map(0), 1)) {
>> +			while (!pmu_raw_readl(S5P_PMU_SPARE2))
>> +				udelay(10);
>> +
>> +			pmu_raw_writel(EXYNOS5420_KFC_CORE_RESET(cpu),
>> +					EXYNOS_SWRESET);
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
> 
> I tested this on top of mainline (v4.2) using exynos_defconfig (with
> BL_SWITCHER disabled) and I now see all 8 CPUs booting.  Nice!
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Also, please note that this does not fix another fundamental problem
> with this board in that the firmware puts CCI into secure mode, so
> linux/MCPM cannot manage it, causing hangs whenever CPUidle is enabled
> (because b.L cpuidle driver tries to use MCPM, which needs to manage
> CCI.)
> 
> In order for this to not hang when using CPUidle, the following patch is
> also needed.
> 
> Kevin
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> index 78e6a502f320..7891bd05bf8e 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -49,3 +49,11 @@
>                 shunt-resistor = <10000>;
>         };
>  };
> +
> +/*
> + * Secure firmware prevents CCI access/usage from linux, so must be
> disabled
> + * to prevent usage by MCPM.
> + */
> +&cci {
> +       status = "disabled";
> +};
> 
>

I posted a similar patch that instead disabling CCI for the XU3 board,
it disables in exynos5422-odroidxu3-common.dtsi since all Exynos5422
Odroid boards have the same broken firmware and so the same issue:

https://lkml.org/lkml/2015/8/29/59

Krzysztof tested it on an Odroid XU3 Lite and reported that disabling
CCI caused some CPUs to fail to boot even with $subject applied:

https://lkml.org/lkml/2015/8/29/65

Did you succeed booting all CPUs with CONFIG_ARM_BIG_LITTLE_CPUIDLE
enabled and CCI disabled in the the Odroid XU3 DTS?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
