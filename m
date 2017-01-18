From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 18 Jan 2017 12:27:37 +0800
Subject: [PATCH v19 06/15] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
In-Reply-To: <20170116175025.GJ5908@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-7-fu.wei@linaro.org>
 <20170116175025.GJ5908@leverpostej>
Message-ID: <CADyBb7tMaOJ9D-AYnaNP1OX8kkst7DCkVT0giB2HqdrjSpgX3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 17 January 2017 at 01:50, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Dec 21, 2016 at 02:45:54PM +0800, fu.wei at linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> Currently, the counter frequency detection call(arch_timer_detect_rate)
>> combines all the ways to get counter frequency: device-tree property,
>> system coprocessor register, MMIO timer. But in the most of use cases,
>> we don't need all the ways to try:
>> For example, reading device-tree property will be needed only when
>> system boot with device-tree, getting frequency from MMIO timer register
>> will beneeded only when we init MMIO timer.
>>
>> This patch separates paths to determine frequency:
>> Separate out device-tree code, keep them in device-tree init function.
>
> Splitting these out makes sense to me.

OK , will do

>
>> Separate out the MMIO frequency and the sysreg frequency detection call,
>> and use the appropriate one for the counter.
>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 49 +++++++++++++++++++++++-------------
>>  1 file changed, 31 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index c7b4482..9a1f138 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -488,27 +488,31 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>>       return 0;
>>  }
>>
>> -static void
>> -arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>> +static void arch_timer_detect_rate(void)
>>  {
>> -     /* Who has more than one independent system counter? */
>> -     if (arch_timer_rate)
>> -             return;
>> +     /*
>> +      * Try to get the timer frequency from
>> +      * cntfrq_el0(system coprocessor register).
>> +      */
>> +     if (!arch_timer_rate)
>> +             arch_timer_rate = arch_timer_get_cntfrq();
>> +
>> +     /* Check the timer frequency. */
>> +     if (!arch_timer_rate)
>> +             pr_warn("frequency not available\n");
>> +}
>>
>> +static void arch_timer_mem_detect_rate(void __iomem *cntbase)
>> +{
>>       /*
>> -      * Try to determine the frequency from the device tree or CNTFRQ,
>> -      * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
>> +      * Try to determine the frequency from
>> +      * CNTFRQ in memory-mapped timer.
>>        */
>> -     if (!acpi_disabled ||
>> -         of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
>> -             if (cntbase)
>> -                     arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
>> -             else
>> -                     arch_timer_rate = arch_timer_get_cntfrq();
>> -     }
>> +     if (!arch_timer_rate)
>> +             arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
>>
>>       /* Check the timer frequency. */
>> -     if (arch_timer_rate == 0)
>> +     if (!arch_timer_rate)

I think you mean this one, this is for keeping consistency with
arch_timer_detect_rate.

>>               pr_warn("frequency not available\n");
>>  }
>
> There's a subtle change in behaviour here. Previously for ACPI we'd only
> ever use the sysreg CNTFRQ value for arch_timer_rate, whereas now we
> might use the MMIO timer rate. Maybe that's not a big deal, but I will
> need to think.
>
> Generally, the logic to determine the rate is fairly gnarly regardless.
>
> It would be nice if we could split the MMIO and sysreg rates entirely,

Yes, I am doing this way,

For sysreg rates,
static void arch_timer_detect_rate(void)
{
/*
* Try to get the timer frequency from
* cntfrq_el0(system coprocessor register).
*/
if (!arch_timer_rate)
arch_timer_rate = arch_timer_get_cntfrq();

/* Check the timer frequency. */
if (!arch_timer_rate)
pr_warn("frequency not available\n");
}

For MMIO timer,
static void arch_timer_mem_detect_rate(void __iomem *cntbase)
{
/*
* Try to determine the frequency from
* CNTFRQ in memory-mapped timer.
*/
if (!arch_timer_rate)
arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);

/* Check the timer frequency. */
if (!arch_timer_rate)
pr_warn("frequency not available\n");
}

in arch_time_*_init, only call  arch_timer_detect_rate,
in arch_timer_mem_init, only call arch_timer_mem_detect_rate.

But you are right, this is fairly gnarly regardless.

> and kill the implicit relationship between the two, or at least make one
> canonical and warn if the two differ.

So I think maybe we can do this:

static void __arch_timer_determine_rate(u32 rate)
{
/* Check the timer frequency. */
if (!arch_timer_rate)
if (rate)
arch_timer_rate = rate;
else
pr_warn("frequency not available\n");
else if (arch_timer_rate != rate)
pr_warn("got different frequency, keep original.\n");
}

static void arch_timer_detect_rate(void)
{
/*
* Try to get the timer frequency from
* cntfrq_el0(system coprocessor register).
*/
__arch_timer_determine_rate(arch_timer_get_cntfrq());
}

static void arch_timer_mem_detect_rate(void __iomem *cntbase)
{
/*
* Try to get the timer frequency from
* CNTFRQ in the MMIO timer.
*/
__arch_timer_determine_rate(readl_relaxed(cntbase + CNTFRQ));
}

any thought?

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
