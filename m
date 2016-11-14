From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Nov 2016 14:55:40 +0530
Subject: [PATCH] ARM: davinci: enable PM for DT boot
In-Reply-To: <m2mvh6km8d.fsf@baylibre.com>
References: <20161025214738.27744-1-khilman@baylibre.com>
 <c3a69359-bcec-40fe-e25c-048b97bab726@ti.com> <m2shr16dr7.fsf@baylibre.com>
 <6c73eab0-dadd-f8a0-f822-84296d319443@ti.com> <m2mvh6km8d.fsf@baylibre.com>
Message-ID: <57c0823b-125e-00f0-140a-5431f0247e7e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 November 2016 10:06 PM, Kevin Hilman wrote:
> Sekhar Nori <nsekhar@ti.com> writes:
> 
>> On Tuesday 08 November 2016 11:43 PM, Kevin Hilman wrote:
>>> Hi Sekhar,
>>>
>>> Sekhar Nori <nsekhar@ti.com> writes:
>>>
>>>> On Wednesday 26 October 2016 03:17 AM, Kevin Hilman wrote:
>>>>> Currently system PM is only enabled for legacy (non-DT) boot.  Enable
>>>>> for DT boot also.
>>>>>
>>>>> Tested on da850-lcdk using "rtcwake -m mem -s5 -d rtc0".
>>>>>
>>>>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>>>>> ---
>>>>>  arch/arm/mach-davinci/da8xx-dt.c | 18 ++++++++++++++++++
>>>>>  1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
>>>>> index c9f7e9274aa8..a8089fa40d86 100644
>>>>> --- a/arch/arm/mach-davinci/da8xx-dt.c
>>>>> +++ b/arch/arm/mach-davinci/da8xx-dt.c
>>>>> @@ -43,8 +43,26 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>>>>>  
>>>>>  #ifdef CONFIG_ARCH_DAVINCI_DA850
>>>>>  
>>>>> +static struct davinci_pm_config da850_pm_pdata = {
>>>>> +	.sleepcount = 128,
>>>>> +};
>>>>> +
>>>>> +static struct platform_device da850_pm_device = {
>>>>> +	.name           = "pm-davinci",
>>>>> +	.dev = {
>>>>> +		.platform_data	= &da850_pm_pdata,
>>>>> +	},
>>>>> +	.id             = -1,
>>>>> +};
>>>>> +
>>>>>  static void __init da850_init_machine(void)
>>>>>  {
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = da850_register_pm(&da850_pm_device);
>>>>
>>>> I am not sure if it makes sense to keep the "pm device" around anymore.
>>>> I think for both DT and non-DT boot, we can get rid of the fake PM
>>>> device and combine da850_register_pm() and davinci_pm_probe() into a
>>>> single davinci_init_suspend() function which can then be called both for
>>>> DT and non-DT boot.
>>>
>>> Looking closer at this, where do you propose the pdata comes from for
>>> the non-DT boot?
>>>
>>> It seems to me that we can't currently remove the pdata dependency
>>> without breaking the non-DT platforms, so the approach proposed here is
>>> the least invasive.
>>
>> There is a single value of sleep count that is used today (128). So I
>> was thinking we can hardcode that in pm.c. We are not going to add more
>> board files anyway so there is no risk here.
>>
>> For future, if a different sleepcount value is needed, it will need to
>> be a new DT property.
> 
> Right, but getting rid of the pdata is more than just hard-coding the
> sleep count. There are a bunch of other fields in the pdata, which are
> filled out to some standard defaults in da850.c.  Are you proposing to
> hard-code those in pm.c also?

Yeah. When I wrote the code for pm.c, I wrote it hoping that it can be
used on other davinci devices too. But since then, no other DaVinci
device has gained PM support. DM365 could support PM, but its not
supported even on TI's internal releases.

Even if in future PM does get supported on DM365, platform data will not
be used for sure. And besides, the sequence in sleep.S has only ever
been tested on DA850 and pretty sure will need some tweaks for running
on DM365.

> 
> An intermediate step might be to start by removing the
> platform_device/pdata from the board files, but keep it in da850.c for
> now.  Then, a follow-up cleanup could be done to either move all of that
> into pm.c, or use DT.

I think keeping it in pm.c is fine. We could have called pm.c da850-pm.c
but thats not really required I guess since thats the only device in
mach-davinci which supports suspend-to-RAM anyway.

Thanks,
Sekhar
