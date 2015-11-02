From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 2 Nov 2015 09:03:16 +0100
Subject: [PATCH 5/7] clocksource/drivers/pxa_timer: Move the Kconfig rule
In-Reply-To: <CAHLCerPX+bmNMNDFEW24GWXhmrCspfY=UYkhM54ORfoiB5Xfvw@mail.gmail.com>
References: <CAHLCerPX+bmNMNDFEW24GWXhmrCspfY=UYkhM54ORfoiB5Xfvw@mail.gmail.com>
Message-ID: <563718C4.5050503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Amit,

On 11/02/2015 08:44 AM, Amit Kucheria wrote:
> On Fri, Oct 30, 2015 at 4:22 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> Instead of having the clocksource's Kconfig depending on the arch, let the
>> arch to select the timer it needs.
>
> Is this the prescribed way to do things nowadays? It leads to more
> options showing up in 'make menuconfig'. Why do I need to see
> CLKSRC_PXA if I'm not even compiling for ARCH_PXA (and not interesting
> in COMPILE_TEST)?

That won't happen.

As the 'bool' has no string after, it won't show up in the menuconfig.

Actually, with the next patch, only COMPILE_TEST will show it up in the

Device Drivers->Clocksource drivers.

>> The CLKSRC_OF dependency is removed because already selected by the ARCH_PXA,
>> and it is added for SA1100.
>
> This bit makes sense.
>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/Kconfig            | 3 +++
>>   drivers/clocksource/Kconfig | 3 +--
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 72ad724..aa32286 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -609,6 +609,7 @@ config ARCH_PXA
>>          select AUTO_ZRELADDR
>>          select COMMON_CLK
>>          select CLKDEV_LOOKUP
>> +       select CLKSRC_PXA
>>          select CLKSRC_MMIO
>>          select CLKSRC_OF
>>          select GENERIC_CLOCKEVENTS
>> @@ -669,6 +670,8 @@ config ARCH_SA1100
>>          select ARCH_SPARSEMEM_ENABLE
>>          select CLKDEV_LOOKUP
>>          select CLKSRC_MMIO
>> +       select CLKSRC_PXA
>> +       select CLKSRC_OF if OF
>>          select CPU_FREQ
>>          select CPU_SA1100
>>          select GENERIC_CLOCKEVENTS
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 5cd000c..425abbd 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -289,8 +289,7 @@ config CLKSRC_TANGO_XTAL
>>          select CLKSRC_OF
>>
>>   config CLKSRC_PXA
>> -       def_bool y if ARCH_PXA || ARCH_SA1100
>> -       select CLKSRC_OF if OF
>> +       bool


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
