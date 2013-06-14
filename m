From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Fri, 14 Jun 2013 09:55:51 +0530
Subject: [PATCH V2 1/2] ARM: SAMSUNG: Add SAMSUNG_PM config option to
 select pm
In-Reply-To: <151101ce6833$70efaf20$52cf0d60$%kim@samsung.com>
References: <1371036526-16589-1-git-send-email-amit.daniel@samsung.com>
 <1371036526-16589-2-git-send-email-amit.daniel@samsung.com>
 <151101ce6833$70efaf20$52cf0d60$%kim@samsung.com>
Message-ID: <CADGdYn4KOCAsih6BWnmixBUES_m_fOoXdDuq_YhvdO6OCbarvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for your review comments.

On Thu, Jun 13, 2013 at 6:12 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Amit Daniel wrote:
>>
>> This patch enables the selection of samsung pm related stuffs
>> when SAMSUNG_PM config is enabled and not just when generic PM
>> config is enabled. Power management for s3c64XX and s3c24XX
>> is enabled by default and for other platform depends on S5P_PM.
>> This patch also fixes the following compilation error's when compiling
>> a platform like exynos5440 which does not select pm stuffs.
>>
>> arch/arm/mach-exynos/built-in.o: In function `__virt_to_phys':
>> linux/arch/arm/include/asm/memory.h:175: undefined reference to
>> `s3c_cpu_resume'
>> linux/arch/arm/include/asm/memory.h:175: undefined reference to
>> `s3c_cpu_resume'
>> linux/arch/arm/include/asm/memory.h:175: undefined reference to
>> `s3c_cpu_resume'
>> linux/arch/arm/include/asm/memory.h:175: undefined reference to
>> `s3c_cpu_resume'
>> arch/arm/mach-exynos/built-in.o: In function `exynos5_init_irq':
>> linux/arch/arm/mach-exynos/common.c:492: undefined reference to
>> `s3c_irq_wake'
>> linux/arch/arm/mach-exynos/common.c:492: undefined reference to
>> `s3c_irq_wake'
>> arch/arm/mach-exynos/built-in.o: In function `exynos4_init_irq':
>> linux/arch/arm/mach-exynos/common.c:476: undefined reference to
>> `s3c_irq_wake'
>> linux/arch/arm/mach-exynos/common.c:476: undefined reference to
>> `s3c_irq_wake'
>> arch/arm/plat-samsung/built-in.o: In function `s3c_irqext_wake':
>> linux/arch/arm/plat-samsung/pm.c:144: undefined reference to
>> `s3c_irqwake_eintallow'
>> linux/arch/arm/plat-samsung/pm.c:144: undefined reference to
>> `s3c_irqwake_eintallow'
>> arch/arm/plat-samsung/built-in.o: In function `s3c_pm_enter':
>> linux/arch/arm/plat-samsung/pm.c:263: undefined reference to
>> `s3c_irqwake_intallow'
>> linux/arch/arm/plat-samsung/pm.c:263: undefined reference to
>> `s3c_irqwake_intallow'
>> linux/arch/arm/plat-samsung/pm.c:264: undefined reference to
>> `s3c_irqwake_eintallow'
>> linux/arch/arm/plat-samsung/pm.c:264: undefined reference to
>> `s3c_irqwake_eintallow'
>> linux/arch/arm/plat-samsung/pm.c:275: undefined reference to
>> `s3c_pm_save_core'
>> linux/arch/arm/plat-samsung/pm.c:279: undefined reference to
>> `s3c_pm_configure_extint'
>> linux/arch/arm/plat-samsung/pm.c:310: undefined reference to
>> `s3c_pm_restore_core'
>> make: *** [vmlinux] Error 1
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Makefile           |    2 +-
>>  arch/arm/mach-exynos/common.c           |    2 +-
>>  arch/arm/mach-exynos/common.h           |    1 -
>>  arch/arm/mach-exynos/cpuidle.c          |    1 +
>>  arch/arm/plat-samsung/Kconfig           |    7 +++++++
>>  arch/arm/plat-samsung/Makefile          |    3 +--
>>  arch/arm/plat-samsung/include/plat/pm.h |    8 ++++----
>>  7 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
>> index 9811f87..3fa277a 100644
>> --- a/arch/arm/mach-exynos/Makefile
>> +++ b/arch/arm/mach-exynos/Makefile
>> @@ -14,7 +14,7 @@ obj-                                :=
>>
>>  obj-$(CONFIG_ARCH_EXYNOS)    += common.o
>>
>> -obj-$(CONFIG_PM)             += pm.o
>> +obj-$(CONFIG_S5P_PM)         += pm.o
>>  obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
>>  obj-$(CONFIG_CPU_IDLE)               += cpuidle.o
>>
>> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
>> index 9834357..d2b4f54 100644
>> --- a/arch/arm/mach-exynos/common.c
>> +++ b/arch/arm/mach-exynos/common.c
>> @@ -799,7 +799,7 @@ static struct irq_chip exynos_irq_eint = {
>>       .irq_mask_ack   = exynos_irq_eint_maskack,
>>       .irq_ack        = exynos_irq_eint_ack,
>>       .irq_set_type   = exynos_irq_eint_set_type,
>> -#ifdef CONFIG_PM
>> +#ifdef CONFIG_S5P_PM
>
> The 'S5P_PM' is used for plat-samsung/s5p-pm.c and s5p-irq-pm.c for s5pv210.
>
> So there is no problem to use same name for exynos and s5pv210?...
Basically I looked into arch/arm/mach-exynos/Kconfig and there  select
S5P_PM is done for exynos 5250, 4210, 4212 etc. so I used the same
config macro to enable other PM stuffs inside mach-exynos folder.

Thanks,
Amit Daniel
>
> - Kukjin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
