From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 01:03:30 -0800
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <CALAqxLU7ehHfvQa58HpdzojRU-2zhNpEgkr9KEJ3cf550WcnWw@mail.gmail.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <5302B306.8090503@samsung.com>
 <CAOesGMhnUDcUL7hREV=EYEGr5YG-ZLL6v9NiGcrBr6477WfdyQ@mail.gmail.com>
 <6032891.ndY8FikAMY@wuerfel>
 <CALAqxLX6STNqUeVO2G18bm_HKabpoRxZTa3uK6i-JP97zEYVZg@mail.gmail.com>
 <CAOesGMjLR3PGXeyJPAvGwam4yK97+vnDfq5MVutJz75aKPX8gw@mail.gmail.com>
 <CALAqxLU7ehHfvQa58HpdzojRU-2zhNpEgkr9KEJ3cf550WcnWw@mail.gmail.com>
Message-ID: <CAOesGMjSjzZ4iX3NVA6eS4LHJF2MQQ=KJpNgKWikJb6YkQxNpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 12:06 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Tue, Feb 18, 2014 at 12:00 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Tue, Feb 18, 2014 at 11:52 AM, John Stultz <john.stultz@linaro.org> wrote:
>>> On Tue, Feb 18, 2014 at 10:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Tuesday 18 February 2014 08:16:13 Olof Johansson wrote:
>>>>> On Mon, Feb 17, 2014 at 5:10 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>>>> > On 02/15/14 02:06, Arnd Bergmann wrote:
>>>>> >> My feeling is that we don't need to use the levels for Kconfig, although
>>>>> >> we might want to use them DT compatible strings, even if it ends up
>>>>> >> looking
>>>>> >> a little funny when you do
>>>>> >>
>>>>> >>         compatible = "arm,sbsa-l3", "arm,sbsa-l2", "arm,sbsa-l1";
>>>>> >>
>>>>> >>> What kind of features are you expecting though? More IP
>>>>> >>> blocks/devices? Those are just kernel config options to enable,
>>>>> >>> ideally as modules.
>>>>> >>
>>>>> >>
>>>>> >> Right, I think we can just put them into defconfig. No need to
>>>>> >> "select" them from Kconfig since the extra options wouldn't be
>>>>> >> required for booting or using the system.
>>>>> >>
>>>>> > As I commented above, how about MCT? Samsung has a plan to use MCT on ARMv8,
>>>>> > it is not for used for GH7 though...
>>>>>
>>>>> It looks like the clocksource drivers are all based around being
>>>>> enabled based on platforms instead of individually selectable. That
>>>>> causes a problem here. I think we should change the clocksource
>>>>> Kconfig instead. Then it's just a matter of making sure your defconfig
>>>>> has the needed driver enabled.
>>>>>
>>>>> (Adding Daniel and Thomas in case they have objections to that approach)
>>>>
>>>> +John Stultz
>>>>
>>>> IIRC it was John who insisted on doing it the current way, although
>>>> I can't remember his reasoning.
>>>
>>> Are we really expecting there to be SoC specific clocksources here? I
>>> thought we were getting away from that sort of stuff with the
>>> architecture timer?
>>
>> Unfortunately vendors can do crazy stuff if they want to. But we also
>> have an option to choose to enable it. Maybe the answer here is to say
>> no to MCT on 64-bit, they get to use the arch timers like everybody
>> else. Or at least motivate why they're not good enough.
>>
>>> I'm fine with clocksources being selected by other functionality
>>> options (ie: on x86 ACPI PM timer clocksource doesn't have a prompt,
>>> but depends on the ACPI option). I just don't want to force users to
>>> have to navigate through tons of deep menus to select clocksource
>>> options that logically duplicate other selections already made.
>>>
>>> But again, I handed this maintainership over to Daniel, so I can be
>>> considered just a crank yelling from the sidelines :)
>>
>> I think you have a good point. Until we hear why MCT is needed this is
>> mostly speculation, so let's see what Kukjin says about that.
>
> Yea. And on x86 (well, i386 actually) there are system specific
> clocksources as well, such as the cyclone timer used by "summit" based
> x440 and similar NUMA systems, but those systems had more general
> config options that had to be enabled which the cyclone clocksource
> depended on.

So, after giving this some more thought (and getting my hands dirty in
some of this code), I think I'm going to change my mind on this. For
mobile platforms I think it might make sense to bring over the
toplevel platform Kconfig from arch/arm, to simplify dependencies
without tearing up the driver subtree with churn like this.

This, of course, only holds true for v8 mobile platforms. Samsung
isn't saying if GH7 is a server platform and not, and they don't have
to tell us. But I think we should consider only enabling and bringing
over the mobile ones (and ideally try to avoid even that, but it might
make sense to do some of them at least initially -- it does provide
some convenient ways to enable larger subsets of default drivers per
platform/vendor family).

I.e. I'd be OK with an
ARCH_EXYNOS/ARCH_TEGRA/ARCH_IMX/ARCH_<whatever>, but I don't think we
should add more finegrained options than that globally on ARM64, at
least not until truly proven to be needed. We're trying to push back
against new per-SoC Kconfig entries on 32-bit as well right now.


-Olof
