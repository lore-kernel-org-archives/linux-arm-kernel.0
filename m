From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Thu, 8 Jul 2010 10:52:42 +0200
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100707072938.GQ25358@esdhcp04058.research.nokia.com>
References: <20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
	<4C31E6C4.8030200@stericsson.com>
	<20100705141926.GA23860@n2100.arm.linux.org.uk>
	<4C31FC27.4010102@stericsson.com>
	<20100705181421.GA27771@n2100.arm.linux.org.uk>
	<4C32E9BD.4090001@stericsson.com>
	<20100707072938.GQ25358@esdhcp04058.research.nokia.com>
Message-ID: <4C3591DA.8030902@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2010 09:29 AM, Mika Westerberg wrote:
> On Tue, Jul 06, 2010 at 10:30:53AM +0200, ext Per Fransson wrote:
>>
>> Can't we set up the identity mapping for only the entry containing
>> relocate_new_kernel() and then add enough NOPs at the start of that routine to
>> cover all implementations? That way only one entry in the L1 table is
>> over-written while keeping the MMU handling code in the different
>> arch/arm/mm/proc-<cpu_or_arch>.S?
>
> Did you mean something like the patch at the end of this mail? It doesn't turn
> off the MMU but sets up the identity mapping for the control page only. I
> quickly tested it on our platform and it seems to work:
>
> crash>  bt
...
> So we can at least access the user stack.
>

Yes, that's what I had in mind. A delay will have to be introduced at 
the start of relocate_new_kernel as well. And we have to make sure that 
it's not possible for this code to straddle two L1 page table entries, 
which might be the case already, I don't know. Finally, the overwritten 
entry needs to be stored somewhere before cleaning the caches.

> However, I'm not sure what is happening with these kdump patches. If they are
> going in at some point maybe we can do this stuff later on as separate patches
> or should post a new version of the patches?
>

I'm also interested in knowing whether there's a chance of these patches 
going in soon.

Is the solution for saving the user-space MMU mapping we've sketched 
here good enough? If yes, we might as well try to do it all in one go, 
as far as I'm concerned. Maybe a new version of the patches is needed 
anyway to fix the inconsistencies between CPUs with regards to the MMU? 
On the other hand, if there's a chance of getting these patches in 
quicker as they stand, it would be nice to seize the opportunity for 
kdump/ARM to get a footing in mainline.

>> Also, couldn't the L1 page table entry in question be saved for
>> posterity in a variable inside the kernel before the table is modified,
>> together with another variable to hold information on the index in the
>> table the entry came from.
>
> Yeah, I think that we want to have full user-space mappings for post-mortem
> analysis.
>
> Regards,
> MW
>
>> From: Mika Westerberg<ext-mika.1.westerberg@nokia.com>
> Subject: [PATCH] ARM: kexec: make identity mapping for control page only
>
> With current implementation we setup 1:1 mapping for all user-space pages in
> order to softboot to a new kernel. This has a drawback that we cannot access
> those pages later on during post-mortem analysis.
>
> This patch changes kexec to setup identity mapping for only the control page
> (this takes 2 PMD entries) and leaves rest of the mappings intact.
>
