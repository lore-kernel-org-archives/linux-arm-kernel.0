From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 01 Dec 2014 11:19:41 +0000
Subject: [PATCH] irqchip: gic: Allow interrupt level to be set for PPIs.
In-Reply-To: <20141201110358.GA3836@n2100.arm.linux.org.uk>
References: <1417197340-27298-1-git-send-email-Liviu.Dudau@arm.com>
 <20141201104145.GY3836@n2100.arm.linux.org.uk>
 <20141201104612.GM828@e106497-lin.cambridge.arm.com>
 <20141201110358.GA3836@n2100.arm.linux.org.uk>
Message-ID: <547C4ECD.20802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 01/12/14 11:03, Russell King - ARM Linux wrote:
> On Mon, Dec 01, 2014 at 10:46:13AM +0000, Liviu Dudau wrote:
>> On Mon, Dec 01, 2014 at 10:41:45AM +0000, Russell King - ARM Linux wrote:
>>> On Fri, Nov 28, 2014 at 05:55:40PM +0000, Liviu Dudau wrote:
>>>> +	/*
>>>> +	 * PPIs are optionally configurable, but we cannot distinguish
>>>> +	 * between high and low, nor falling and rising. Change the
>>>> +	 * type so that it passes the next check.
>>>
>>> This comment could do with a /lot/ of improvement.  It sounds like the
>>> only reason this code exists is to bypass the check.  If that's all
>>> that's being done, there's better ways to code it.
>>
>> Hi Russell,
>>
>> You are right, all I want to do is bypass the next check because *if*
>> the PPIs can be configured, then any combination is valid (edge 
>> raising/falling, level low/high). In real systems, PPIs tend to be
>> configured with active level low. That falls the existing check.
> 
>  "fails" :)
> 
> If all you want to do is to bypass the following check, what's wrong
> with actually doing that:
> 
> -	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> +	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
> +	    type != IRQ_TYPE_EDGE_RISING)
> 		return -EINVAL;
> 

I think that will require some additional changes to gic_configure_irq
(in irq-gic-common.c).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
