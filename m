From: robherring2@gmail.com (Rob Herring)
Date: Tue, 29 Nov 2011 16:24:59 -0600
Subject: [PATCH V2] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174FDAFBEA@HQMAIL01.nvidia.com>
References: <1322528052-6516-1-git-send-email-swarren@nvidia.com>
 <4ED4D78A.6000400@ti.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAFADC@HQMAIL01.nvidia.com>
 <4ED51AC4.50303@ti.com> <4ED537FB.1010307@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAFBEA@HQMAIL01.nvidia.com>
Message-ID: <4ED55BBB.4040805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2011 03:08 PM, Stephen Warren wrote:
> Rob Herring wrote at Tuesday, November 29, 2011 12:52 PM:
>> On 11/29/2011 11:47 AM, Cousson, Benoit wrote:
>>> On 11/29/2011 6:13 PM, Stephen Warren wrote:
>>>> Cousson, Benoit wrote at Tuesday, November 29, 2011 6:01 AM:
>>>>> Hi Stephen&  Peter,
>>>>>
>>>>> On 11/29/2011 1:54 AM, Stephen Warren wrote:
>>>>>> From: pdeschrijver at nvidia.com<pdeschrijver@nvidia.com>
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -125,6 +131,14 @@ void __init tegra_init_irq(void)
>>>>>>        gic_arch_extn.irq_unmask = tegra_unmask;
>>>>>>        gic_arch_extn.irq_retrigger = tegra_retrigger;
>>>>>>
>>>>>> -    gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
>>>>>> -         IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
>>>>>> +#ifdef CONFIG_OF
>>>>>> +    /* Check if there is a devicetree present as of_irq_init doesn't
>>>>>> +     * indicate if an interrupt controller node was found.
>>>>>> +     */
>>>>>> +    if (of_find_node_by_path("/"))
>>>>>> +        of_irq_init(tegra_irq_match);
>>>>>> +    else
>>>>>> +#endif
>>>>>
>>>>> For the same kind of need, I found the following API:
>>>>>
>>>>> of_have_populated_dt()
>>>>>
>>>>> Moreover, it returns false if !CONFIG_OF, so it will avoid the #ifdef.
>>>>
>>>> That sounds like a great idea. Unfortunately, of_irq_init() is a DT-only
>>>> function. Exynos has the following in mainline to solve this:
>>>>
>>>>          if (!of_have_populated_dt())
>>>>                  gic_init_bases(...);
>>>> #ifdef CONFIG_OF
>>>>          else
>>>>                  of_irq_init(exynos4_dt_irq_match);
>>>> #endif
>>>>
>>>> Perhaps we should add a dummy of_irq_init() too, so that we can remove
>>>> this ifdef.
>>>
>>> Yes, indeed, I think that's much better. Most of_XXX APIs do have a
>>> dummy version, but for some reason some of them do not.
>>> That one clearly deserve a dummy version.
>>
>> I had an empty version originally and removed it based on Grant's review...
>>
>> The original intent was this call should be in a DT board file and
>> therefore always enabled. Perhaps you can split tegra_init_irq into 2
>> functions with one having all but gic_init and then call that function
>> from board-dt.c along with of_irq_init.
> 
> Well, that's certainly possible, but it seems a little inconsistent to
> initialize the GIC from tegra_init_irq for non-DT, yet do it somewhere
> else in the DT case. It seems like putting all the GIC stuff into
> tegra_irq_init is the right thing to do. I note that Exynos works this
> way already.
> 
> I couldn't find Grant's email to see his rationale for not wanting an
> empty or_irq_init(); do you have a link?
> 

My brain is rotting... I think it was gic_of_init that I was thinking of
but still can't find the email.

Will your code even link currently with !CONFIG_OF. I would think it
cannot resolve gic_of_init in that case.

I have a lot of concerns that supporting both CONFIG_OF and !CONFIG_OF
is going to be a pain as it's yet another variable to compile against.
In order to actually start reducing reducing the size of the ARM
platform code (that is the goal, right?), platforms need to be always OF
enabled and start removing the !CONFIG_OF code. So why not always turn
on CONFIG_OF for Tegra and not worry about this? Eventually, CONFIG_OF
will always be enabled anyway.

Rob
