From: john.stultz@linaro.org (John Stultz)
Date: Tue, 18 Feb 2014 12:06:45 -0800
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <CAOesGMjLR3PGXeyJPAvGwam4yK97+vnDfq5MVutJz75aKPX8gw@mail.gmail.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <5302B306.8090503@samsung.com>
 <CAOesGMhnUDcUL7hREV=EYEGr5YG-ZLL6v9NiGcrBr6477WfdyQ@mail.gmail.com>
 <6032891.ndY8FikAMY@wuerfel>
 <CALAqxLX6STNqUeVO2G18bm_HKabpoRxZTa3uK6i-JP97zEYVZg@mail.gmail.com>
 <CAOesGMjLR3PGXeyJPAvGwam4yK97+vnDfq5MVutJz75aKPX8gw@mail.gmail.com>
Message-ID: <CALAqxLU7ehHfvQa58HpdzojRU-2zhNpEgkr9KEJ3cf550WcnWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 12:00 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Feb 18, 2014 at 11:52 AM, John Stultz <john.stultz@linaro.org> wrote:
>> On Tue, Feb 18, 2014 at 10:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Tuesday 18 February 2014 08:16:13 Olof Johansson wrote:
>>>> On Mon, Feb 17, 2014 at 5:10 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>>> > On 02/15/14 02:06, Arnd Bergmann wrote:
>>>> >> My feeling is that we don't need to use the levels for Kconfig, although
>>>> >> we might want to use them DT compatible strings, even if it ends up
>>>> >> looking
>>>> >> a little funny when you do
>>>> >>
>>>> >>         compatible = "arm,sbsa-l3", "arm,sbsa-l2", "arm,sbsa-l1";
>>>> >>
>>>> >>> What kind of features are you expecting though? More IP
>>>> >>> blocks/devices? Those are just kernel config options to enable,
>>>> >>> ideally as modules.
>>>> >>
>>>> >>
>>>> >> Right, I think we can just put them into defconfig. No need to
>>>> >> "select" them from Kconfig since the extra options wouldn't be
>>>> >> required for booting or using the system.
>>>> >>
>>>> > As I commented above, how about MCT? Samsung has a plan to use MCT on ARMv8,
>>>> > it is not for used for GH7 though...
>>>>
>>>> It looks like the clocksource drivers are all based around being
>>>> enabled based on platforms instead of individually selectable. That
>>>> causes a problem here. I think we should change the clocksource
>>>> Kconfig instead. Then it's just a matter of making sure your defconfig
>>>> has the needed driver enabled.
>>>>
>>>> (Adding Daniel and Thomas in case they have objections to that approach)
>>>
>>> +John Stultz
>>>
>>> IIRC it was John who insisted on doing it the current way, although
>>> I can't remember his reasoning.
>>
>> Are we really expecting there to be SoC specific clocksources here? I
>> thought we were getting away from that sort of stuff with the
>> architecture timer?
>
> Unfortunately vendors can do crazy stuff if they want to. But we also
> have an option to choose to enable it. Maybe the answer here is to say
> no to MCT on 64-bit, they get to use the arch timers like everybody
> else. Or at least motivate why they're not good enough.
>
>> I'm fine with clocksources being selected by other functionality
>> options (ie: on x86 ACPI PM timer clocksource doesn't have a prompt,
>> but depends on the ACPI option). I just don't want to force users to
>> have to navigate through tons of deep menus to select clocksource
>> options that logically duplicate other selections already made.
>>
>> But again, I handed this maintainership over to Daniel, so I can be
>> considered just a crank yelling from the sidelines :)
>
> I think you have a good point. Until we hear why MCT is needed this is
> mostly speculation, so let's see what Kukjin says about that.

Yea. And on x86 (well, i386 actually) there are system specific
clocksources as well, such as the cyclone timer used by "summit" based
x440 and similar NUMA systems, but those systems had more general
config options that had to be enabled which the cyclone clocksource
depended on.

thanks
-john
