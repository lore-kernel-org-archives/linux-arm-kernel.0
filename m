From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Aug 2014 16:19:12 +0100
Subject: [PATCH] arm: use cpu_online_mask when using forced
 irq_set_affinity
In-Reply-To: <alpine.DEB.2.10.1408251136380.3323@nanos>
References: <1399653640-21559-1-git-send-email-sudeep.holla@arm.com>
 <20140523121032.GV3693@n2100.arm.linux.org.uk> <537F4453.5000709@arm.com>
 <53A43174.503@arm.com> <20140620151638.GS32514@n2100.arm.linux.org.uk>
 <53C79E43.6040009@arm.com> <alpine.DEB.2.10.1408251136380.3323@nanos>
Message-ID: <53FCA570.1090809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thanks for your feedback.

On 25/08/14 10:55, Thomas Gleixner wrote:
> On Thu, 17 Jul 2014, Sudeep Holla wrote:
>>>> Any suggestions on this ? Since commit 01f8fa4f01d8 and ffde1de64012 are
>>>> now in
>>>> stable releases, CPU0 hotplug is broken there now.
>>>
>>> Maybe we should ask Thomas, as he's (a) the maintainer of the irqchip
>>> stuff, and (b) the author of the patch causing the breakage.
>>>
>>>   From what I can see looking at the x86 code, the work-around in
>>> ffde1de64012 is wrong.
>>>
>>
>> Can provide your thoughts on how to solve this issue ?
>
> ffde1de64012 is not about offlining a cpu, it's about onlining where
> we need to make sure that we assign the affinity to a not yet online
> marked cpu.
>
>> Is it expected from all the irqchip implementation to use force flag in
>> irq_set_affinity to ignore cpu_online_mask similar to GIC ?
>
> No, it's only relevant for the cases where we need to route irqs to
> not yet online cpus.
>

Ok. IIUC Russell's main concern was if irqchip implementation uses force
flag differently, then we can't change the core code to false. Also
x86 core code also uses forced irq_set_affinity in arch/x86/kernel/irq.c

Russell, any comments on this or are you fine with changing to false.

Regards,
Sudeep

> Now the wreckage of offlining was definitely not intended and I wonder
> why set_affinity() is called there with force = true. This was
> introduced in commit 1dbfa187dad. I acked it back then, but I have no
> idea why, because the force argument did not have any effect at that
> time.
>
> Changing it to false should solve the issue.
>
> Thanks,
>
> 	tglx
>
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 2c4257604513..5c4d38e32a51 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -175,7 +175,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>   	c = irq_data_get_irq_chip(d);
>   	if (!c->irq_set_affinity)
>   		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
> -	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
> +	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
>   		cpumask_copy(d->affinity, affinity);
>
>   	return ret;
>
