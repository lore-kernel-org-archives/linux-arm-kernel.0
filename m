From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 15:42:10 +0530
Subject: [PATCH v5 1/5] ARM: EXYNOS: Add generic cpu power control
 functions for all exynos based SoCs
In-Reply-To: <019b01cf6e52$75e1a710$61a4f530$@samsung.com>
References: <1399307221-8659-1-git-send-email-a.kesavan@samsung.com>
 <1399307221-8659-2-git-send-email-a.kesavan@samsung.com>
 <019b01cf6e52$75e1a710$61a4f530$@samsung.com>
Message-ID: <CAM4voamSNYZ_hsjF3eZhqZ=FF__39tFgi5FeXRcUhRbYYzu0LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tue, May 13, 2014 at 7:54 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Abhilash Kesavan wrote:
>>
> + Jonghwan Choi, Seungkon Hwang
>
>> From: Leela Krishna Amudala <leela.krishna@linaro.org>
>>
>> Add generic cpu power control functions for exynos based SoCS
>> for cpu power up/down and to know the cpu status.
>>
>> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
>
> In this case, Abhilash's signed-off-by should be added here.
Will add.
>
>> ---
>>  arch/arm/mach-exynos/common.h   |    3 +++
>>  arch/arm/mach-exynos/pm.c       |   36
> ++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-exynos/regs-pmu.h |    6 ++++++
>>  3 files changed, 45 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index 47cbab0..a7dbb5f 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -63,5 +63,8 @@ struct exynos_pmu_conf {
>>  };
>>
>>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
>> +extern void exynos_cpu_powerdown(int cpu);
>
> IMO, using 'xxx_power_down' would be better.
Will change.
>
>> +extern void exynos_cpu_powerup(int cpu);
>> +extern int  exynos_cpu_power_state(int cpu);
>
> Hmm...is it really 'cpu' related? Or 'core' related? As I know, when the
> function is called, ARM core and L1 cache will be power_up/down except L2
> cache...But I have no strong objection to use 'cpu' here
OK, I am keeping cpu as it is then.
>
>>
>>  #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index 15af0ce..6651028 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -100,6 +100,42 @@ static int exynos_irq_set_wake(struct irq_data *data,
>> unsigned int state)
>>       return -ENOENT;
>>  }
>>
>> +/**
>> + * exynos_cpu_powerdown : power down the specified cpu
>> + * @cpu : the cpu to power down
>> + *
>> + * Power downs the specified cpu. The sequence must be finished by a
>> + * call to cpu_do_idle()
>> + *
>> + */
>> +void exynos_cpu_powerdown(int cpu)
>> +{
>> +     __raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>> +}
>> +
>> +/**
>> + * exynos_cpu_powerup : power up the specified cpu
>> + * @cpu : the cpu to power up
>> + *
>> + * Power up the specified cpu
>> + */
>> +void exynos_cpu_powerup(int cpu)
>> +{
>> +     __raw_writel(S5P_CORE_LOCAL_PWR_EN,
>> +                  EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>> +}
>> +
>> +/**
>> + * exynos_cpu_power_state : returns the power state of the cpu
>> + * @cpu : the cpu to retrieve the power state from
>> + *
>> + */
>> +int exynos_cpu_power_state(int cpu)
>> +{
>> +     return (__raw_readl(EXYNOS_ARM_CORE_STATUS(cpu)) &
>> +                     S5P_CORE_LOCAL_PWR_EN);
>> +}
>> +
>>  /* For Cortex-A9 Diagnostic and Power control register */
>>  static unsigned int save_arm_register[2];
>>
>> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-
>> pmu.h
>> index 4f6a256..0bdfcbc 100644
>> --- a/arch/arm/mach-exynos/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/regs-pmu.h
>> @@ -121,6 +121,12 @@
>>
>>  #define S5P_CHECK_SLEEP                              0x00000BAD
>>
>> +#define EXYNOS_ARM_CORE0_CONFIGURATION               S5P_PMUREG(0x2000)
>
> This can be put in order of address.
OK, will fix.
>
>> +#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)   \
>> +                     (EXYNOS_ARM_CORE0_CONFIGURATION + (0x80 * (_nr)))
>> +#define EXYNOS_ARM_CORE_STATUS(_nr)          \
>> +                     (EXYNOS_ARM_CORE_CONFIGURATION(_nr) + 0x4)
>
> Can you please cleanup codes following definitions are used with using above
> definitions?
>
> S5P_ARM_CORE1_CONFIGURATION and S5P_ARM_CORE1_STATUS in hotplug.c and
> platsmp.c
Will remove these.

Regards,
Abhilash
>
>> +
>>  /* Only for EXYNOS4210 */
>>  #define S5P_CMU_CLKSTOP_LCD1_LOWPWR  S5P_PMUREG(0x1154)
>>  #define S5P_CMU_RESET_LCD1_LOWPWR    S5P_PMUREG(0x1174)
>> --
>> 1.7.9.5
>
