From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 19 Apr 2014 10:42:02 +0200
Subject: [PATCH 1/4] ARM: EXYNOS: Fix definitions of S5P_ARM_CORE_*
 registers
In-Reply-To: <CAGTfZH1Lg=2thqGSgyTehzM_UO1meyOcdXcn-b0AJnrm9dgwXQ@mail.gmail.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>	<1397832181-5153-2-git-send-email-t.figa@samsung.com>
 <CAGTfZH1Lg=2thqGSgyTehzM_UO1meyOcdXcn-b0AJnrm9dgwXQ@mail.gmail.com>
Message-ID: <535236DA.1030806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 19.04.2014 09:47, Chanwoo Choi wrote:
> Hi Tomasz,
>
> On Fri, Apr 18, 2014 at 11:42 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> On SoCs with more than 2 cores there are more than 2 S5P_ARM_CORE_*
>> registers that can be addressed with fixed stride of 0x80. This patch
>> renames the definitions of S5P_ARM_CORE1_* registers to be S5P_ARM_CORE_*
>> and make them take physical core ID as argument to calculate register
>> address.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>   arch/arm/mach-exynos/hotplug.c  | 2 +-
>>   arch/arm/mach-exynos/platsmp.c  | 6 +++---
>>   arch/arm/mach-exynos/regs-pmu.h | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
>> index 5eead53..7e0f31a 100644
>> --- a/arch/arm/mach-exynos/hotplug.c
>> +++ b/arch/arm/mach-exynos/hotplug.c
>> @@ -96,7 +96,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>>
>>                  /* make cpu1 to be turned off at next WFI command */
>>                  if (cpu == 1)
>> -                       __raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
>> +                       __raw_writel(0, S5P_ARM_CORE_CONFIGURATION(1));
>
> Exynos4412 has quad cores. If turn off third/fourth core, this patch
> could not turn off third/fourth cores.
>
> Why didn't you use cpu number for argument of
> S5P_ARM_CORE_CONFIGURATION() as following?
> - __raw_writel(0, S5P_ARM_CORE_CONFIGURATION(cpu));
>
>>
>>                  /*
>>                   * here's the WFI
>> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
>> index 03e5e9f..7b7de4b 100644
>> --- a/arch/arm/mach-exynos/platsmp.c
>> +++ b/arch/arm/mach-exynos/platsmp.c
>> @@ -107,14 +107,14 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>           */
>>          write_pen_release(phys_cpu);
>>
>> -       if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
>> +       if (!(__raw_readl(S5P_ARM_CORE_STATUS(1)) & S5P_CORE_LOCAL_PWR_EN)) {
>>                  __raw_writel(S5P_CORE_LOCAL_PWR_EN,
>> -                            S5P_ARM_CORE1_CONFIGURATION);
>> +                            S5P_ARM_CORE_CONFIGURATION(1));
>
> ditto.
>
>>
>>                  timeout = 10;
>>
>>                  /* wait max 10 ms until cpu1 is on */
>> -               while ((__raw_readl(S5P_ARM_CORE1_STATUS)
>> +               while ((__raw_readl(S5P_ARM_CORE_STATUS(1))
>
> ditto.

You are absolutely correct, this needs to be fixed, but this series just 
keeps current behavior for now to just make CPU topology in DT not break 
things that are working.

I have further patches that clean up platsmp and hotplug code and they 
will add proper support for arbitrary number of cores.

Best regards,
Tomasz
