From: david@lechnology.com (David Lechner)
Date: Mon, 22 Jan 2018 11:11:01 -0600
Subject: =?UTF-8?Q?Re:_[PATCH_v6_00/41]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
In-Reply-To: <CAMRc=MesQTvkVtPLOGr2G7-KSR=k35y24SsO4s8rDbCv=2-G7A@mail.gmail.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <CAMRc=MesQTvkVtPLOGr2G7-KSR=k35y24SsO4s8rDbCv=2-G7A@mail.gmail.com>
Message-ID: <38b081e9-fe00-cf18-2d72-5ad1937c3800@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2018 07:29 AM, Bartosz Golaszewski wrote:
> 2018-01-20 18:13 GMT+01:00 David Lechner <david@lechnology.com>:
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 19 patches create new clock drivers
>> using the common clock framework. There are basically 3 groups of clocks -
>> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
>> unique init data, which is the reason for so many patches.
>>
>> Then, starting with "ARM: da830: add new clock init using common clock",
>> we get the mach code ready for the switch by adding the code needed for
>> the new clock drivers and adding #ifndef CONFIG_COMMON_CLK around the
>> legacy clocks so that we can switch easily between the old and the new.
>>
>> "ARM: davinci: switch to common clock framework" actually flips the switch
>> to start using the new clock drivers. Then the next 8 patches remove all
>> of the old clock code.
>>
>> The final three patches add device tree clock support to the one SoC that
>> supports it.
>>
>> v6 changes (also see individual patches for details):
>> - All of the device tree bindings are changed
>> - All of the clock drivers are changed significantly
>> - Fixed issues brought up during review of v5
>> - "ARM: davinci: move davinci_clk_init() to init_time" is removed from this
>>    series and submitted separately
>>
>> v5 changes:
>> - Basically, this is an entirely new series
>> - Patches are broken up into bite-sized pieces
>> - Converted PSC clock driver to use regmap
>> - Restored "force" flag for certain DA850 clocks
>> - Added device tree bindings
>> - Moved more of the clock init to drivers/clk
>> - Fixed frequency scaling (maybe*)
>>
>> * I have frequency scaling using cpufreq-dt, so I know the clocks are doing
>>    what they need to do to make this work, but I haven't figured out how to
>>    test davinci-cpufreq driver yet. (Patches to make cpufreq-dt work will be
>>    sent separately after this series has landed.)
>>
> 
> This driver doesn't have DT support - I suppose it would be useful to
> add it and also add the corresponding DT node to da850.dtsi. If you're
> ok with it, I can start working on it. I also have a patch for the i2c
> cpufreq issue and it would be nice to test it with it.
> 

Why not just use cpufreq-dt for the DT case? It seems to be working.

I have preliminary patches on GitHub [1][2].

[1]: https://github.com/dlech/ev3dev-kernel/commit/e38897148a949b736ab135983887f9c81375f108
[2]: https://github.com/dlech/ev3dev-kernel/commit/bab85f9e45450a36a7ea6f4407f89a75edb63761
