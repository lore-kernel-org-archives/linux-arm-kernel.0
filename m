From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 30 Jul 2015 10:02:46 +0100
Subject: [PATCH] irqchip: gic: Add a cpu map for each GIC instance
In-Reply-To: <55B9DB74.8030100@nvidia.com>
References: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>	<alpine.DEB.2.11.1507291810040.3825@nanos>
 <20150730081934.02a6aa99@why.wild-wind.fr.eu.org>
 <55B9DB74.8030100@nvidia.com>
Message-ID: <55B9E836.6090004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/15 09:08, Jon Hunter wrote:
> 
> On 30/07/15 08:19, Marc Zyngier wrote:
>> On Wed, 29 Jul 2015 17:10:45 +0100
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>> On Wed, 29 Jul 2015, Jon Hunter wrote:
>>>
>>> Cc'ing Marc ...
>>
>> Thanks for looping me in.
>>
>>>
>>>> The gic_init_bases() function initialises an array that stores the mapping
>>>> between the GIC and CPUs. This array is a global array that is
>>>> unconditionally initialised on every call to gic_init_bases(). Although,
>>>> it is not common for there to be more than one GIC instance, there are
>>>> some devices that do support nested GIC controllers and gic_init_bases()
>>>> can be called more than once.
>>>>
>>>> A 2nd call to gic_init_bases() will clear the previous CPU mapping and
>>>> will only setup the mapping again for CPU0. This is because for child GIC
>>>> controllers there is most likely only one recipient of the interrupt.
>>>>
>>>> Fix this by moving the CPU mapping array to the GIC chip data structure
>>>> so that it is initialised for each GIC instance separately. It is assumed
>>>> that the bL switcher code is only interested in the root or primary GIC
>>>> instance.
>>
>> This feels very odd. If you have a secondary GIC, it is cascaded into
>> the primary one, and I don't see why you would need to manage the
>> affinity of the interrupt for the secondary GIC. The only thing that
>> matters is the affinity of interrupts in the primary one, and this is
>> what the bl switcher is dealing with.
>>
>> To me, it looks like the bug is to even try to compute an affinity for
>> a GIC that is not the primary one, and keeping it around doesn't
>> seem to make much sense. 
>>
>> Or am I overlooking something?
> 
> I mentioned to Russell (sorry you were not copied), that I am looking at
> a use-case where the secondary GIC is actually a router that can route
> interrupts to the main CPU cluster (via the primary GIC) or to another
> CPU. So it turns out that I do see a use for being able to configure the
> cpu map for the secondary as well. In this case the set_affinity would
> be use to direct the interrupt to either the main cluster or the other CPU.

I'm afraid that's not exactly the same thing. This data structure maps
Linux view of the CPU number to the number of the CPU interface. What
you're describing is being able to route the interrupts to an entity
that is not under the kernel's control. I don't think you should
shoehorn the two concept together.

> Please note that this patch does not address configuring the map for the
> secondary GIC. I am trying to think about the best way to handle this. I
> guess it could done via device-tree or we could have a API,
> gic_set_cpu_map(), that would allow you to set it.

This is starting to look a lot like the Freescale Vybrid stuff, where
they share devices between two unrelated ARM CPUs, each running their
own OS.

You should sync up with these guys.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
