From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Aug 2015 17:54:41 +0100
Subject: [PATCH v2 3/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <20150813161741.GO1820@rric.localhost>
References: <1439477277-6157-1-git-send-email-rric@kernel.org>
 <1439477277-6157-4-git-send-email-rric@kernel.org> <55CCB393.1040909@arm.com>
 <20150813161741.GO1820@rric.localhost>
Message-ID: <55CCCBD1.2090304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/15 17:17, Robert Richter wrote:
> Marc,
> 
> thanks for your quick review.
> 
> On 13.08.15 16:11:15, Marc Zyngier wrote:
>> On 13/08/15 15:47, Robert Richter wrote:
>>> From: Robert Richter <rrichter@cavium.com>
> 
>>>  static const struct gic_capabilities gicv3_errata[] = {
>>>  	{
>>> +		.desc		= "GIC: Cavium erratum 23154",
>>> +		.iidr		= 0xa100034c,	/* ThunderX pass 1.x */
>>> +		.iidr_mask	= 0xffff0fff,
>>> +		.init		= gicv3_enable_cavium_thunderx,
>>> +	},
>>
>> I'm even more puzzled. You're working around a CPU bug based on the ITS
>> ID registers? Or have you swapped the detection methods for the two errata?
> 
> :/ Right, I mixed this up... Must have starred on this for too long.
> Will fix that.
> 
> Wrt midr: Originally this was written to support iidr. I wanted to
> keep the version check in the driver of the hw, an implementation
> outside of drivers/irqchip looked not appropriate here as it would
> rely then on arch arm64 only. This is the main reason. Apart from
> that, I think an implmentation based on struct arm64_cpu_capabilities,
> etc. would require much rework compared to my current easy
> implementation, e.g:
> 
>  * binding flags to callbacks and actually run them,
> 
>  * handing over private driver data (base addr for iidr detection) to
>    a capabilty's match function.
> 
> Overall this looked bloated. Now, that the MIDR also needs to be
> checked, it looked better to me to keep the gic hw detection at a
> single location in the driver. This also allows us to check a
> combination of midr and iidr values.
> 
> I hope this sounds reasonable?

+Will.

The point I was trying to make is that a CPU interface bug is a CPU bug,
and that it feels quite weird weird to have the detection in the GIC.
Will, what do you think?

Also, I don't really buy the combined MIDR/GITS_IIDR detection. These
are two *very* distinct pieces of HW that are not even directly
connected (the redistributors are in between).

I wouldn't mind having something like:

struct gic_capabilities {
	const char *desc;
	void (*init)(void *data);
	u32 iidr;
	u32 iidr_mask;
	int feature;
};

where "feature" is a one of things declared in cpufeature.h, and that
would condition the capability (I love the name!) if that really
happens. I don't think we're there yet.

As for the complexity of implementation, testing a flag in the probe
function and tingling a static key is not really a big deal.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
