From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 12 Nov 2012 22:07:16 +0530
Subject: [PATCH 12/14] ARM: SPEAr3xx: shirq: simplify and move the shared
 irq multiplexor to DT
In-Reply-To: <201211121509.45176.arnd@arndb.de>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <71bbb1faf3cd048953dcf24ef9ce6d9dd37fe8e1.1352608333.git.viresh.kumar@linaro.org>
 <201211121509.45176.arnd@arndb.de>
Message-ID: <CAOh2x=nJXVVjFmDFnTN_02PSG9hcDuXToRUzRMi5jwJqUFtgfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 8:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 11 November 2012, Viresh Kumar wrote:

>>  .../devicetree/bindings/arm/spear/shirq.txt        |  48 ++++
>>  arch/arm/mach-spear3xx/include/mach/irqs.h         |  10 +-
>>  arch/arm/mach-spear3xx/spear300.c                  | 103 -------
>>  arch/arm/mach-spear3xx/spear310.c                  | 202 --------------
>>  arch/arm/mach-spear3xx/spear320.c                  | 204 --------------
>>  arch/arm/mach-spear3xx/spear3xx.c                  |   4 +
>>  arch/arm/plat-spear/include/plat/shirq.h           |  35 +--
>>  arch/arm/plat-spear/shirq.c                        | 305 +++++++++++++++++----
>
> I guess it would be nice to move this to drivers/irqchip/st-shirq.c now
> that we have introduced that directory.

I was sure that i will get this one :)
I wanted to, but was just trying the basic patch first :)

I would add another patch in this series as the last patch to move stuff
out of plat :)

>>  static const char * const spear320_dt_board_compat[] = {
>> diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
>> index 98144ba..781aec9 100644
>> --- a/arch/arm/mach-spear3xx/spear3xx.c
>> +++ b/arch/arm/mach-spear3xx/spear3xx.c
>> @@ -121,6 +122,9 @@ struct sys_timer spear3xx_timer = {
>>
>>  static const struct of_device_id vic_of_match[] __initconst = {
>>       { .compatible = "arm,pl190-vic", .data = vic_of_init, },
>> +     { .compatible = "st,spear300-shirq", .data = spear3xx_shirq_of_init, },
>> +     { .compatible = "st,spear310-shirq", .data = spear3xx_shirq_of_init, },
>> +     { .compatible = "st,spear320-shirq", .data = spear3xx_shirq_of_init, },
>>       { /* Sentinel */ }
>>  };
>
> You list three "compatible" values here with the same init function, and then
>
>> +int __init spear3xx_shirq_of_init(struct device_node *np,
>> +             struct device_node *parent)
>> +{
>> +}
>
> In that multiplex between thre three again. I think it would be cleaner to have
> three separate functions and move the call to of_iomap into shirq_init.

I reworked a bit on this patch after picking the initial patch from
Shiraz. And i
am disappointed that i missed this basic thing.

--
viresh
