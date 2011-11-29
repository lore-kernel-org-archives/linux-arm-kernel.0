From: robherring2@gmail.com (Rob Herring)
Date: Tue, 29 Nov 2011 13:52:27 -0600
Subject: [PATCH V2] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <4ED51AC4.50303@ti.com>
References: <1322528052-6516-1-git-send-email-swarren@nvidia.com>
 <4ED4D78A.6000400@ti.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAFADC@HQMAIL01.nvidia.com>
 <4ED51AC4.50303@ti.com>
Message-ID: <4ED537FB.1010307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/29/2011 11:47 AM, Cousson, Benoit wrote:
> On 11/29/2011 6:13 PM, Stephen Warren wrote:
>> Cousson, Benoit wrote at Tuesday, November 29, 2011 6:01 AM:
>>> Hi Stephen&  Peter,
>>>
>>> On 11/29/2011 1:54 AM, Stephen Warren wrote:
>>>> From: pdeschrijver at nvidia.com<pdeschrijver@nvidia.com>
>>>
>>> [...]
>>>
>>>> @@ -125,6 +131,14 @@ void __init tegra_init_irq(void)
>>>>        gic_arch_extn.irq_unmask = tegra_unmask;
>>>>        gic_arch_extn.irq_retrigger = tegra_retrigger;
>>>>
>>>> -    gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
>>>> -         IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
>>>> +#ifdef CONFIG_OF
>>>> +    /* Check if there is a devicetree present as of_irq_init doesn't
>>>> +     * indicate if an interrupt controller node was found.
>>>> +     */
>>>> +    if (of_find_node_by_path("/"))
>>>> +        of_irq_init(tegra_irq_match);
>>>> +    else
>>>> +#endif
>>>
>>> For the same kind of need, I found the following API:
>>>
>>> of_have_populated_dt()
>>>
>>> Moreover, it returns false if !CONFIG_OF, so it will avoid the #ifdef.
>>
>> That sounds like a great idea. Unfortunately, of_irq_init() is a DT-only
>> function. Exynos has the following in mainline to solve this:
>>
>>          if (!of_have_populated_dt())
>>                  gic_init_bases(...);
>> #ifdef CONFIG_OF
>>          else
>>                  of_irq_init(exynos4_dt_irq_match);
>> #endif
>>
>> Perhaps we should add a dummy of_irq_init() too, so that we can remove
>> this ifdef.
> 
> Yes, indeed, I think that's much better. Most of_XXX APIs do have a
> dummy version, but for some reason some of them do not.
> That one clearly deserve a dummy version.

I had an empty version originally and removed it based on Grant's review...

The original intent was this call should be in a DT board file and
therefore always enabled. Perhaps you can split tegra_init_irq into 2
functions with one having all but gic_init and then call that function
from board-dt.c along with of_irq_init.

Rob
