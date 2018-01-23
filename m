From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 23 Jan 2018 18:04:55 +0100
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00=2F41=5D_ARM=3A_davinci=3A_convert_to_common?=
 =?UTF-8?Q?_clock_framework=E2=80=8B?=
In-Reply-To: <e5f4af7d-971c-5694-2da5-0cba9083ee5c@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <CAMRc=MexJTMiD=URw1bv-qfGaTntZRXgfsSb_beYGkvO+LrpgQ@mail.gmail.com>
 <d819e18f-7d74-d8c4-8056-bfc545f4d4e9@lechnology.com>
 <CAMRc=McVNJqsO4+j=XkyNWuKqF-S-hQAw9XxHx6GC47UudgMYw@mail.gmail.com>
 <e5f4af7d-971c-5694-2da5-0cba9083ee5c@lechnology.com>
Message-ID: <CAMRc=Mfwo-2FUu-zsL0xOLBR8pFcT-vF36HeoUCBVM4jiH1Edg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-23 17:03 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/23/2018 08:54 AM, Bartosz Golaszewski wrote:
>>
>> 2018-01-22 18:30 GMT+01:00 David Lechner <david@lechnology.com>:
>>>
>>> On 01/22/2018 05:14 AM, Bartosz Golaszewski wrote:
>>>>
>>>>
>>>> 2018-01-20 18:13 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>>
>>>>>
>>>>> This series converts mach-davinci to use the common clock framework.
>>>>>
>>>>> The series works like this, the first 19 patches create new clock
>>>>> drivers
>>>>> using the common clock framework. There are basically 3 groups of
>>>>> clocks
>>>>> -
>>>>> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each
>>>>> have
>>>>> unique init data, which is the reason for so many patches.
>>>>>
>>>>> Then, starting with "ARM: da830: add new clock init using common
>>>>> clock",
>>>>> we get the mach code ready for the switch by adding the code needed for
>>>>> the new clock drivers and adding #ifndef CONFIG_COMMON_CLK around the
>>>>> legacy clocks so that we can switch easily between the old and the new.
>>>>>
>>>>> "ARM: davinci: switch to common clock framework" actually flips the
>>>>> switch
>>>>> to start using the new clock drivers. Then the next 8 patches remove
>>>>> all
>>>>> of the old clock code.
>>>>>
>>>>> The final three patches add device tree clock support to the one SoC
>>>>> that
>>>>> supports it.
>>>>>
>>>>> v6 changes (also see individual patches for details):
>>>>> - All of the device tree bindings are changed
>>>>> - All of the clock drivers are changed significantly
>>>>> - Fixed issues brought up during review of v5
>>>>> - "ARM: davinci: move davinci_clk_init() to init_time" is removed from
>>>>> this
>>>>>     series and submitted separately
>>>>>
>>>>> v5 changes:
>>>>> - Basically, this is an entirely new series
>>>>> - Patches are broken up into bite-sized pieces
>>>>> - Converted PSC clock driver to use regmap
>>>>> - Restored "force" flag for certain DA850 clocks
>>>>> - Added device tree bindings
>>>>> - Moved more of the clock init to drivers/clk
>>>>> - Fixed frequency scaling (maybe*)
>>>>>
>>>>> * I have frequency scaling using cpufreq-dt, so I know the clocks are
>>>>> doing
>>>>>     what they need to do to make this work, but I haven't figured out
>>>>> how
>>>>> to
>>>>>     test davinci-cpufreq driver yet. (Patches to make cpufreq-dt work
>>>>> will
>>>>> be
>>>>>     sent separately after this series has landed.)
>>>>>
>>>>> Dependencies:
>>>>>
>>>>> This series applies on top of linux-davinci/master plus the following
>>>>> patches:
>>>>> - [1] "clk: fix reentrancy of clk_enable() on UP systems" (in clk-next)
>>>>> - [2] "clk: add helper functions for managing clk_onecell_data"
>>>>> - [3] "clk: divider: read-only divider can propagate rate change"
>>>>> - [4],[5],[6],[7],[8],[9] series "ARM: davinci: common clock prep work"
>>>>>
>>>>
>>>> Hi David,
>>>>
>>>> I'm getting a splat[1] when trying to mount the rootfs over nfs on a
>>>> da850-lcdk.
>>>>
>>>> I'll try to figure out what's happening.
>>>>
>>>> Best regards,
>>>> Bartosz Golaszewski
>>>>
>>>> [1] https://pastebin.com/D94z8SAe
>>>>
>>>
>>> Could it have something to do with the "rmii" clock? I don't think I
>>> added
>>> that
>>> in the device tree.
>>>
>>
>> I'm looking at it now. There are problems with emac & mdio both in
>> legacy and in DT mode.
>
>
> Adam, is networking working for you on the DA850 EVM?
>
>>
>> The davinci_mdio driver seems to not get an actual functional clock
>> (phy is reported as down). I'm seeing that in old legacy code,
>> mdio_clk has emac_clk as parent, while after your changes they share
>> pll0_sysclk4 as parent, although I'm not sure if that has anything to
>> do with it.
>
>
> The two clocks prior to these changes was a hack to work around a
> limitation of the old lock code (because of the way it used a linked list
> each clock could only be used once) so, yes, that should not have anything
> to do with it.
>

And it was I who did the change in commit ef37427ac567 ("ARM: davinci:
da850: don't add emac clock to lookup table twice") :) Already forgot
that.

> I see that there is no clk_prepare_enable() in the mdio driver or the emac
> driver. I suppose it expects pm_runtime to take care of this maybe?
>
> You can see if the clock is enabled by running:
>
>     cat /sys/kernel/debug/clk/clk_summary
>
>>
>> I'll see about the rmii clock too.
>
> FWIW, the rmii clock is in the clock init for non-DT da850.
>

2018-01-23 17:06 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/23/2018 10:03 AM, David Lechner wrote:
>>
>> You can see if the clock is enabled by running:
>>
>>      cat /sys/kernel/debug/clk/clk_summary
>>
>
> I just realized if you can't boot, you can't do this. :-/

I can always boot from SD or just printk it.

Thanks,
Bartosz
