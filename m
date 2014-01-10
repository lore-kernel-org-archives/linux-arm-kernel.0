From: ta.omasab@gmail.com (Thomas Abraham)
Date: Fri, 10 Jan 2014 17:29:34 +0530
Subject: [PATCH 0/6] cpufreq: use cpufreq-cpu0 driver for exynos4210 based
 platforms
In-Reply-To: <20140110113240.797381e6@amdc2363>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <20140110113240.797381e6@amdc2363>
Message-ID: <CAJuA9ahCc7b=209Tmh-O_cx2aEhPY+s_TjHHnjGk1x3duE-P1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Fri, Jan 10, 2014 at 4:02 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Thomas,
>
> I've investigated the topic for a while, so if you don't mind I will
> share my thoughts :-)

Sure. Thanks for having a look at this patch series.

>
>> The patch series removes the use of Exynos4210 specific cpufreq driver
>> and enables to use the cpufreq-cpu0 driver for Exynos4210 based
>> platforms. This is being done for few reasons.
>>
>> (a) The Exynos4210 cpufreq driver reads/writes clock controller
>> registers bypassing the Exynos4 CCF driver which is sort of
>> problematic.
>
> Also other, already supported devices suffer from it. Namely -
> Exynos4x12 and Exynos5250.
>

Right, I did check the cpufreq driver of these SoCs.

> That's why the solution shall be as generic as possible to also work
> with those two SoCs.

The approach taken here is to encapsulate the source of the CPU domain
clock in a single logical clock. The implementation of this logical
clock can vary for different Exynos SoCs but the interface to register
and use this clock is common for all Exynos SoCs. If the changes in
the cpufreq-cpu0 driver are accepted, the combination of cpufreq-cpu0
and the logical clock representing the CPU clock is sufficient to
provide a generic solution for Exynos4x12 and Exynos5250 SoCs.

Thanks,
Thomas.

>
>> (b) Removes the need for having clock controller
>> register definitions in the cpufreq driver and also removes the need
>> for statically io-remapping clock controller address space (helps in
>> moving towards multiplatform kernel).
>>
>> In order to use cpufreq-cpu0 driver and provide fast cpu clock
>> switching during dvfs operations, the following apporach has been
>> used.
>>
>> (a) A new CPU clock provider type has been introduced in Samsung's CCF
>>     support. This clock provider type can be a compostion of multiple
>>     clock blocks such as mux, dividers and gates. Typically, in Exynos
>>     platforms, there are multiple clock blocks in between the output
>>     of the APLL and the CPU clock domain output. Representing these
>>     mutiple clock blocks within a opaque CPU clock provider type helps
>>     in reducing the time taken to perform a CPU clock frequency change
>>     operation, which is generally required during DVFS operations.
>>     This approach was suggested by Arnd Bergmann <arnd@arndb.de>
>> during LCE-2013.
>>
>> (b) A new optional safe operating point property has been introduced
>>     in the cpufreq-cpu0 driver binding. On some platforms such as the
>>     Samsung Exynos, a change in CPU frequency requires a change in the
>>     PLL output that drives the CPU clock. A change in PLL output
>>     requires the PLL output be turned off, which implies that the CPU
>>     (and other components in the CPU clock domain) be supplied with
>>     an alternate clock source during the time the PLL output is
>> changed.
>>
>>     The clock speed of this alternate clock source could be higher
>>     than the clock speed of the PLL at the time of switching over to
>>     the alternate clock source. This temporary increase in clock speed
>>     of the CPU clock domain implies that the blocks within the CPU
>>     clock domain should also be supplied with an appropriate voltage
>>     supply level as required to drive the CPU clock domain components
>>     at the speed of the alternative clock source. This temporary
>>     voltage level required during switching of CPU clock speed is
>>     called safe voltage level. And the cpufreq-cpu0 driver has been
>>     modified to setup the safe voltage levels during the changes
>>     in CPU clock speed.
>>
>> (c) The CPU clock supply as been restructured as
>>     [ Output of APLL -> Opaque CPU clock provider -> CPU clock output
>> ] And with the changes in (a) and (b) above, the cpufreq-cpu0 driver
>>     can now be used and can remove the use of Exynos4210 specific
>>     cpufreq driver.
>>
>> This approach is currently tried on Exynos4210 only. The same approach
>> can be adopted for other Exynos SoCs as well. This patch series is
>> based on linux-next master branch.
>>
>> Thomas Abraham (6):
>>   cpufreq: cpufreq-cpu0: allow optional safe voltage during frequency
>> transitions clk: samsung: add infrastructure to register CPU clocks
>>   clk: samsung: register cpu clock provider for exynos4210 SoC
>>   cpufreq: exynos: remove Exynos4210 specific cpufreq driver support
>>   arm: exynos4-dt: statically add platform device for cpufreq-cpu0
>> platform driver arm: dts: add cpu nodes for Exynos4210 SoC
>>
>>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    5 +
>>  arch/arm/boot/dts/exynos4210-origen.dts            |    6 +
>>  arch/arm/boot/dts/exynos4210-trats.dts             |    6 +
>>  arch/arm/boot/dts/exynos4210-universal_c210.dts    |    6 +
>>  arch/arm/boot/dts/exynos4210.dtsi                  |   22 +++
>>  arch/arm/mach-exynos/mach-exynos4-dt.c             |    6 +
>>  drivers/clk/samsung/clk-exynos4.c                  |   96
>> ++++++++++++- drivers/clk/samsung/clk.c                          |
>> 71 +++++++++ drivers/clk/samsung/clk.h                          |
>> 37 +++++- drivers/cpufreq/Kconfig.arm                        |   11 --
>>  drivers/cpufreq/Makefile                           |    1 -
>>  drivers/cpufreq/cpufreq-cpu0.c                     |   49 ++++++-
>>  drivers/cpufreq/exynos-cpufreq.c                   |    4 +-
>>  drivers/cpufreq/exynos-cpufreq.h                   |    8 -
>>  drivers/cpufreq/exynos4210-cpufreq.c               |  157
>> -------------------- 15 files changed, 301 insertions(+), 184
>> deletions(-) delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
