From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Oct 2018 18:29:49 +0000
Subject: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
In-Reply-To: <1d813bdf-3161-1514-0368-48fbe24f2205@gmail.com>
References: <20181030111103.12110-1-marc.zyngier@arm.com>
 <1d813bdf-3161-1514-0368-48fbe24f2205@gmail.com>
Message-ID: <6b6307bc-dca1-c334-ca6d-9ab6fc8acdf0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/18 17:02, Florian Fainelli wrote:
> On 10/30/18 4:11 AM, Marc Zyngier wrote:
>> The Keystone QMSS driver is pretty damaged, in the sense that it
>> does things like this:
>>
>> 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
>>
>> where cpu_map is a local variable. As we leave the function, this
>> will point to nowhere-land, and things will end-up badly.
>>
>> Instead, let's use a proper cpumask that gets allocated, giving
>> the driver a chance to actually work with things like irqbalance
>> as well as have a hypothetical 64bit future.
> 
> Since this is at least the second patch from you that I can see in this
> area, would it make sense to sprinkle object_is_on_stack() checks
> throughout irq_set_affinity_hint() to help catch offenders?

I think I nuked the only two offenders in the tree. And to be honest,
I'm far more worried about the use of to_cpumask() itself, because this
can be wrong in quite a number of ways.

As much as I dislike checkpatch, I wonder if having a rule checking for
the usage of to_cpumask() would be a good idea...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
