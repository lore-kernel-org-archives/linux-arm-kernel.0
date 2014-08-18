From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Aug 2014 15:23:35 +0200
Subject: [PATCH v3 1/2] ARM: EXYNOS: Move Disabling of JPEG USE_RETENTION
 for exynos5250 to pmu.c
In-Reply-To: <CAGm_ybiKm7sZB0zPoQ99b2+jZ8h=+48zjv24QvaC5GcccAPORg@mail.gmail.com>
References: <1407412789-1919-1-git-send-email-vikas.sajjan@samsung.com>	<1407412789-1919-2-git-send-email-vikas.sajjan@samsung.com>	<53F1EDB4.8040906@gmail.com>
 <CAGm_ybiKm7sZB0zPoQ99b2+jZ8h=+48zjv24QvaC5GcccAPORg@mail.gmail.com>
Message-ID: <53F1FE57.80209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.08.2014 15:21, Vikas Sajjan wrote:
> Hi Tomasz,
> 
> On Mon, Aug 18, 2014 at 5:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Vikas,
>>
>> On 07.08.2014 13:59, Vikas Sajjan wrote:
>>> Move the Disabling of JPEG USE_RETENTION for exynos5250 to pmu.c to make way for
>>> refactoring of pm.c and to create common functions across exynos4 and
>>> exynos5250.
>>>
>>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>>> ---
>>>  arch/arm/mach-exynos/pm.c  |    7 +------
>>>  arch/arm/mach-exynos/pmu.c |    6 ++++++
>>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>>> index c4c6d98..fdd68c2 100644
>>> --- a/arch/arm/mach-exynos/pm.c
>>> +++ b/arch/arm/mach-exynos/pm.c
>>> @@ -265,13 +265,8 @@ static void exynos_pm_prepare(void)
>>>
>>>       s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>>>
>>> -     if (soc_is_exynos5250()) {
>>> +     if (soc_is_exynos5250())
>>>               s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
>>> -             /* Disable USE_RETENTION of JPEG_MEM_OPTION */
>>> -             tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
>>> -             tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
>>> -             pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
>>> -     }
>>>
>>>       /* Set value of power down register for sleep mode */
>>>
>>> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
>>> index ff9d23f..6021adb 100644
>>> --- a/arch/arm/mach-exynos/pmu.c
>>> +++ b/arch/arm/mach-exynos/pmu.c
>>> @@ -389,6 +389,7 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>>>  static int __init exynos_pmu_init(void)
>>>  {
>>>       unsigned int value;
>>> +     unsigned int tmp;
>>>
>>>       exynos_pmu_config = exynos4210_pmu_config;
>>>
>>> @@ -411,6 +412,11 @@ static int __init exynos_pmu_init(void)
>>>               value &= ~EXYNOS5_SYS_WDTRESET;
>>>               pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
>>>
>>> +             /* Disable USE_RETENTION of JPEG_MEM_OPTION */
>>> +             tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
>>> +             tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
>>> +             pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
>>> +
>>
>> Note that this code is executed once at system bootup. Is this register
>> preserved across a suspend/resume cycle?
>>
>> Anyway, what I suggested in my comment to previous revision of this
>> series was stuffing this thing into the PMU configuration array. As you
>> can see in the arrays for Exynos4 SoCs, they just hardcode the
>> MEM_OPTION registers to constant values, because I believe the only
>> field from those registers with non-zero value in practice is
>> EXYNOS5_OPTION_USE_RETENTION (or 0x10 used directly in PMU arrays for
>> Exynos4 SoCs). This would also cover my comment above, because the
>> arrays are written to the PMU every time a low power state is being entered.
>>
> 
> Is this what you meant,
> 
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index 6021adb..67b70fd 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -264,6 +264,7 @@ static const struct exynos_pmu_conf
> exynos5250_pmu_config[] = {
>         { EXYNOS5_INTRAM_MEM_SYS_PWR_REG,               { 0x3, 0x0, 0x0} },
>         { EXYNOS5_INTROM_MEM_SYS_PWR_REG,               { 0x3, 0x0, 0x0} },
>         { EXYNOS5_JPEG_MEM_SYS_PWR_REG,                 { 0x3, 0x0, 0x0} },
> +       { EXYNOS5_JPEG_MEM_OPTION,                      { 0x10, 0x10, 0x0} },
>         { EXYNOS5_HSI_MEM_SYS_PWR_REG,                  { 0x3, 0x0, 0x0} },
>         { EXYNOS5_MCUIOP_MEM_SYS_PWR_REG,               { 0x3, 0x0, 0x0} },
>         { EXYNOS5_SATA_MEM_SYS_PWR_REG,                 { 0x3, 0x0, 0x0} },
> @@ -412,11 +413,6 @@ static int __init exynos_pmu_init(void)
>                 value &= ~EXYNOS5_SYS_WDTRESET;
>                 pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
> 
> -               /* Disable USE_RETENTION of JPEG_MEM_OPTION */
> -               tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
> -               tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
> -               pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
> -
>                 exynos_pmu_config = exynos5250_pmu_config;
>                 pr_info("EXYNOS5250 PMU Initialize\n");
>         } else {
> 
> for AFTR and LPA mode, i still maintain 0x10 like any other
> XXX_XXX_MEM_OPTION register,
> but for sleep mode, I am disabling USE_RETENTION of JPEG_MEM_OPTION as required.
> 
> 
> Hope this is fine.
> 
> I tested with the above change on snow, S2R works well.

Yes, looks good, thanks.

Best regards,
Tomasz
