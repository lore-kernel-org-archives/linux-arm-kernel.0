From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 01 Dec 2011 23:05:15 +0100
Subject: [PATCH 2/2] gpio/tegra: Dynamically allocate IRQ base, and support
 DT
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174FDB02BF@HQMAIL01.nvidia.com>
References: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
 <1322700336-26866-2-git-send-email-swarren@nvidia.com>
 <4ED78461.40006@gmail.com> <20111201141112.GG4556@totoro>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDB01DD@HQMAIL01.nvidia.com>
 <20111201165518.GH4556@totoro>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDB02BF@HQMAIL01.nvidia.com>
Message-ID: <4ED7FA1B.1080109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2011 09:57 PM, Stephen Warren :
> Jamie Iles wrote at Thursday, December 01, 2011 9:55 AM:
>> On Thu, Dec 01, 2011 at 08:52:49AM -0800, Stephen Warren wrote:
>>> Jamie Iles wrote at Thursday, December 01, 2011 7:11 AM:
>>>> On Thu, Dec 01, 2011 at 07:42:57AM -0600, Rob Herring wrote:
>>>>> On 11/30/2011 06:45 PM, Stephen Warren wrote:
> ...
>>>>>> +	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
>>>>>> +	if (irq_domain.irq_base<  0) {
>>>>>> +		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
>>>>>> +		return -ENODEV;
>>>>>> +	}
>>>>>> +	irq_domain.nr_irq = TEGRA_NR_GPIOS;
>>>>>> +	irq_domain.ops =&irq_domain_ops;
>>>>>
>>>>> Why don't you just use irq_domain_simple_ops?
>>>>
>>>> This would need the patch I posted earlier
>>>> (https://lkml.org/lkml/2011/12/1/109) so they can work for the
>>>> !CONFIG_OF case ;-)
>>>
>>> Part of my reasoning was that simple_ops appeared to be intended for
>>> DT-based controllers; is it safe to use those ops for a controller that
>>> wasn't instantiated from DT? I know that right now, the only op in that
>>> structure is dt_translate, and that won't ever be called for the non-DT
>>> case, but is there a guarantee that more functions won't be added to
>>> the simple ops, and that they won't assume DT is in use, and fail if
>>> not?
>>>
>>> If these are safe to use in the non-DT case, then yet I could build off
>>> Jamie's patch, although managing the dependencies might be awkward.
>>
>> Yes, it's absolutely fine to use it just that irq_simple_ops isn't
>> currently exported unless you have CONFIG_OF_IRQ set so you'd get an
>> undefined reference for !CONFIG_OF at the moment.
>
> OK, sounds good.
>
> So, I think we have a few options:
> 1) Merge my change as-is, and simplify it later once your patch is in.
> 2) Put your change in a branch, and merge it into both its usual place,
> and the Tegra/ARM branches, so I can rebase my patch on top of it.
> 3) Have the usual maintainer ack it (I see Rob already did, but I think
> Thomas is the maintainer here right?) and just put both patches into the
> Tegra/ARM tree. This of course means non-Tegra branches have to wait for
> it rather than the other way around.
>
> (1) seems simplest, but (2) is probably doable. Thomas?

I jump into the discussion to say that I am also interested by Jamie's 
patch. I am following the same path as Stephen at the moment with Atmel 
AT91... A chance I can read all your comments that are so valuable for 
me as well :-)

So, for me (2) will ease things...

Best regards,
-- 
Nicolas Ferre
