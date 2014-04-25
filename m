From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 26 Apr 2014 00:47:51 +0200
Subject: [PATCH 2/4] ARM: EXYNOS: Fix core ID used by platsmp and hotplug
 code
In-Reply-To: <CANuQgHF9up5=8+cWgC+9cm-8Bf7sGcRBcg1DyXm-pbmK=EMgmg@mail.gmail.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>	<1397832181-5153-3-git-send-email-t.figa@samsung.com>
 <CANuQgHF9up5=8+cWgC+9cm-8Bf7sGcRBcg1DyXm-pbmK=EMgmg@mail.gmail.com>
Message-ID: <535AE617.9050202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

On 20.04.2014 09:23, Chander Kashyap wrote:
> Hi Tomasz,
>
>
> On 18 April 2014 20:12, Tomasz Figa <t.figa@samsung.com> wrote:
>> When CPU topology is specified in device tree, cpu_logical_map() does
>> not return core ID anymore, but rather full MPIDR value. This breaks
>> existing calculation of PMU register offsets on Exynos SoCs.
>>
>> This patch fixes the problem by adjusting the code to use only core ID
>> bits of the value returned by cpu_logical_map() to allow CPU topology to
>> be specified in device tree on Exynos SoCs.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>   arch/arm/mach-exynos/hotplug.c | 10 ++++++----
>>   arch/arm/mach-exynos/platsmp.c | 31 ++++++++++++++++++-------------
>>   2 files changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
>> index 7e0f31a..8a5f07d 100644
>> --- a/arch/arm/mach-exynos/hotplug.c
>> +++ b/arch/arm/mach-exynos/hotplug.c
>> @@ -92,11 +92,13 @@ static inline void cpu_leave_lowpower(void)
>>
>>   static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>>   {
>> +       u32 mpidr = cpu_logical_map(cpu);
>> +       u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +
>>          for (;;) {
>>
>> -               /* make cpu1 to be turned off at next WFI command */
>> -               if (cpu == 1)
>> -                       __raw_writel(0, S5P_ARM_CORE_CONFIGURATION(1));
>
> I think this macro is not yet in ML code.

What do you mean? The S5P_ARM_CORE_CONFIGURATION() macro is being added 
by patch 1/4.

Best regards,
Tomasz
