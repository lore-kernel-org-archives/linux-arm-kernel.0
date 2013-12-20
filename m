From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 20 Dec 2013 23:23:11 +0100
Subject: [PATCH] ARM: EXYNOS: Kill exynos_pm_late_initcall()
In-Reply-To: <52B4B861.2050506@samsung.com>
References: <1387574758-28489-1-git-send-email-s.nawrocki@samsung.com>
 <52B4B861.2050506@samsung.com>
Message-ID: <52B4C34F.10207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2013 10:36 PM, Kukjin Kim wrote:
> On 12/21/13 06:25, Sylwester Nawrocki wrote:
>> The only thing exynos_pm_late_initcall() does is calling
>> pm_genpd_poweroff_unused(), which is already stubbed when
>> CONFIG_PM_GENERIC_DOMAINS is not enabled. So replace
>> exynos_pm_late_initcall() with a direct call to
>> pm_genpd_poweroff_unused().
>>
>> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> ---
>> arch/arm/mach-exynos/common.c | 3 ++-
>> arch/arm/mach-exynos/common.h | 6 ------
>> arch/arm/mach-exynos/pm_domains.c | 6 ------
>> 3 files changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/common.c
>> b/arch/arm/mach-exynos/common.c
>> index 8ae4797..09e6898 100644
>> --- a/arch/arm/mach-exynos/common.c
>> +++ b/arch/arm/mach-exynos/common.c
>> @@ -23,6 +23,7 @@
>> #include<linux/of.h>
>> #include<linux/of_fdt.h>
>> #include<linux/of_irq.h>
>> +#include<linux/pm_domain.h>
>> #include<linux/export.h>
>> #include<linux/irqdomain.h>
>> #include<linux/of_address.h>
>> @@ -324,7 +325,7 @@ void __init exynos_init_late(void)
>> /* to be supported later */
>> return;
>>
>> - exynos_pm_late_initcall();
>> + pm_genpd_poweroff_unused();
>> }
>>
>> static int __init exynos_fdt_map_chipid(unsigned long node, const char
>> *uname,
>> diff --git a/arch/arm/mach-exynos/common.h
>> b/arch/arm/mach-exynos/common.h
>> index ff9b6a9..0c31b34 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -26,12 +26,6 @@ void exynos_init_late(void);
>>
>> void exynos_firmware_init(void);
>>
>> -#ifdef CONFIG_PM_GENERIC_DOMAINS
>> -int exynos_pm_late_initcall(void);
>> -#else
>> -static inline int exynos_pm_late_initcall(void) { return 0; }
>> -#endif
>> -
>> extern struct smp_operations exynos_smp_ops;
>>
>> extern void exynos_cpu_die(unsigned int cpu);
>> diff --git a/arch/arm/mach-exynos/pm_domains.c
>> b/arch/arm/mach-exynos/pm_domains.c
>> index ff50836..8fd2488 100644
>> --- a/arch/arm/mach-exynos/pm_domains.c
>> +++ b/arch/arm/mach-exynos/pm_domains.c
>> @@ -184,9 +184,3 @@ static __init int exynos4_pm_init_power_domain(void)
>> return 0;
>> }
>> arch_initcall(exynos4_pm_init_power_domain);
>> -
>> -int __init exynos_pm_late_initcall(void)
>> -{
>> - pm_genpd_poweroff_unused();
>> - return 0;
>> -}
>
> Yes, right. Applied BTW, how about same thing in mach-s3c64xx? ;-)

Good point, unfortunately I don't have time for it neither possibility to
test.  Hopefully someone else can handle that.

> Thanks and Merry Christmas.

Thank you for quick response.  Merry Christmas and Happy New Year.
