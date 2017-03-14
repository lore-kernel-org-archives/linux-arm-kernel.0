From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 10:02:36 +0200
Subject: [2/3] soc: samsung: Do not build ARMv7 PMU drivers on ARMv8
In-Reply-To: <2da8c346-dae9-6754-8349-df0946c89ae2@samsung.com>
References: <CGME20170314075427epcas5p19d137fbcc390e937172a17ae99f11a0c@epcas5p1.samsung.com>
 <20170311213856.21701-3-krzk@kernel.org>
 <2da8c346-dae9-6754-8349-df0946c89ae2@samsung.com>
Message-ID: <CAJKOXPd=K8rbBxV21ibubjgU8BV3g4AqDrXX0f6-N_VPkR=puQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 9:51 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> Hi Krzysztof,
>
> On 03/12/2017 03:08 AM, Krzysztof Kozlowski wrote:
>> The Exynos Power Management Unit (PMU) drivers contain quite large
>> static arrays of register values necessary for given Exynos SoC to enter
>> low power mode.  All this data is useless for ARMv8 SoC like
>> Exynos5433, because the image will not be shared between ARMv7 and
>> ARMv8.
>>
>> Add additional Kconfig symbol for selecting the SoC-specific driver
>> addons thus skipping the useless data in the final image (this is
>> similar approach to chosen for Exynos clock controller drivers):
>>  - exynos-pmu driver will be compiled on both architectures ARMv7
>>    and ARMv8,
>>  - additional driver_data for ARMv7 SoCs will not be built on ARMv8
>>    and a macro will return NULL for them in of_device_id - this should
>>    be safe as these compatibles cannot match on ARMv7 and driver
>>    anyway handles NULL driver_data,
>>  - on ARMv8 compile only exynos-pmu driver which exposes the
>>    syscon-regmap for PMU address space.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  drivers/soc/samsung/Kconfig      |  8 +++++++-
>>  drivers/soc/samsung/Makefile     |  4 +++-
>>  drivers/soc/samsung/exynos-pmu.c | 22 ++++++++++++++++------
>>  drivers/soc/samsung/exynos-pmu.h |  3 +++
>>  4 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>> index 245533907d1b..8b25bd55e648 100644
>> --- a/drivers/soc/samsung/Kconfig
>> +++ b/drivers/soc/samsung/Kconfig
>> @@ -8,7 +8,13 @@ if SOC_SAMSUNG
>>
>>  config EXYNOS_PMU
>>       bool "Exynos PMU controller driver" if COMPILE_TEST
>> -     depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
>> +     depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
>> +     select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
>> +
>
> In general this patch look ok, but I was think we should make these
> configs configurable via _menuconfig_. Currently these are visible only
> if COMPILE_TEST is enabled.
> Recently I was working on adding PMU support for Exynos7 and I face
> issues when I want to disable this option and re-enable it for testing
> purpose.

These drivers are not available in menuconfig on purpose - these are
essential parts of SoC. Without them usually something will not work
so user should not be able to disable them. For all of such drivers,
we use the SELECT from mach approach.

>> +# There is no need to enable these drivers for ARMv8
>> +config EXYNOS_PMU_ARM_DRIVERS
>> +     bool "Exynos PMU ARMv7-specific driver extensions" if COMPILE_TEST
>> +     depends on EXYNOS_PMU
>>
>>  config EXYNOS_PM_DOMAINS
>>       bool "Exynos PM domains" if COMPILE_TEST
>> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
>> index 3619f2ecddaa..4d7694a4e7a4 100644
>> --- a/drivers/soc/samsung/Makefile
>> +++ b/drivers/soc/samsung/Makefile
>> @@ -1,3 +1,5 @@
>> -obj-$(CONFIG_EXYNOS_PMU)     += exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
>> +obj-$(CONFIG_EXYNOS_PMU)     += exynos-pmu.o
>> +
>> +obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS) += exynos3250-pmu.o exynos4-pmu.o \
>>                                       exynos5250-pmu.o exynos5420-pmu.o
>>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
>> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
>> index 56d9244ff981..bd4a76f27bc2 100644
>> --- a/drivers/soc/samsung/exynos-pmu.c
>> +++ b/drivers/soc/samsung/exynos-pmu.c
>> @@ -69,27 +69,37 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>>  }
>>
>>  /*
>> + * Split the data between ARM architectures because it is relatively big
>> + * and useless on other arch.
>> + */
>> +#ifdef CONFIG_EXYNOS_PMU_ARM_DRIVERS
>> +#define exynos_pmu_data_arm_ptr(data)        (&data)
>> +#else
>> +#define exynos_pmu_data_arm_ptr(data)        NULL
>> +#endif
>> +
>> +/*
>>   * PMU platform driver and devicetree bindings.
>>   */
>>  static const struct of_device_id exynos_pmu_of_device_ids[] = {
>>       {
>>               .compatible = "samsung,exynos3250-pmu",
>> -             .data = &exynos3250_pmu_data,
>> +             .data = exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
>>       }, {
>>               .compatible = "samsung,exynos4210-pmu",
>> -             .data = &exynos4210_pmu_data,
>> +             .data = exynos_pmu_data_arm_ptr(exynos4210_pmu_data),
>>       }, {
>>               .compatible = "samsung,exynos4212-pmu",
>> -             .data = &exynos4212_pmu_data,
>> +             .data = exynos_pmu_data_arm_ptr(exynos4212_pmu_data),
>>       }, {
>>               .compatible = "samsung,exynos4412-pmu",
>> -             .data = &exynos4412_pmu_data,
>> +             .data = exynos_pmu_data_arm_ptr(exynos4412_pmu_data),
>>       }, {
>>               .compatible = "samsung,exynos5250-pmu",
>> -             .data = &exynos5250_pmu_data,
>> +             .data = exynos_pmu_data_arm_ptr(exynos5250_pmu_data),
>>       }, {
>>               .compatible = "samsung,exynos5420-pmu",
>> -             .data = &exynos5420_pmu_data,
>> +             .data = exynos_pmu_data_arm_ptr(exynos5420_pmu_data),
>>       }, {
>>               .compatible = "samsung,exynos5433-pmu",
> So, as I understand, the idea here to use something like
>         .data = &exynos5433_pmu_data or so in case ARMv8?

In the future, yes. Now there is no low power mode support for
Exynos5433 so the data is left empty.

Best regards,
Krzysztof
