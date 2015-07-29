From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 29 Jul 2015 20:27:53 +0100
Subject: [PATCH] irqchip: gic: Add a cpu map for each GIC instance
In-Reply-To: <20150729183321.GP7557@n2100.arm.linux.org.uk>
References: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
 <20150729183321.GP7557@n2100.arm.linux.org.uk>
Message-ID: <55B92939.5040101@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29/07/15 19:33, Russell King - ARM Linux wrote:
> On Wed, Jul 29, 2015 at 03:43:04PM +0100, Jon Hunter wrote:
>> The gic_init_bases() function initialises an array that stores the mapping
>> between the GIC and CPUs. This array is a global array that is
>> unconditionally initialised on every call to gic_init_bases(). Although,
>> it is not common for there to be more than one GIC instance, there are
>> some devices that do support nested GIC controllers and gic_init_bases()
>> can be called more than once.
>>
>> A 2nd call to gic_init_bases() will clear the previous CPU mapping and
>> will only setup the mapping again for CPU0. This is because for child GIC
>> controllers there is most likely only one recipient of the interrupt.
>>
>> Fix this by moving the CPU mapping array to the GIC chip data structure
>> so that it is initialised for each GIC instance separately. It is assumed
>> that the bL switcher code is only interested in the root or primary GIC
>> instance.
> 
> Does it make sense to expose the per-CPU-ness of the non-primary GIC?
> If they are chained off a primary GIC SPI interrupt, then all IRQs on
> the secondary GIC are routed to the same CPU that the SPI on the primary
> GIC is routed to.

I am looking at a use-case where there is a secondary GIC and the secondary
GIC is used as a interrupt router between the main CPU cluster and another
CPU. So in this case the mapping of a secondary is still of interest. This
patch does not address setting up the secondary mapping, but avoids a
secondary GIC overwriting the primary map (which we don't want).
 
> Other features like the PPIs and SGIs in the secondary CPU should also
> be ignored - they probably aren't used anyway.

Yes, agree.
 
> I have to say though... are the 1020 IRQs that the primary GIC provides
> really not enough?  What insane hardware needs more than 1020 IRQs?

Ha. I guess some realview boards for a start ...

# grep -r "gic_init(1" arch/arm/
arch/arm/mach-realview/realview_pb1176.c:	gic_init(1, IRQ_PB1176_GIC_START,
arch/arm/mach-realview/realview_eb.c:		gic_init(1, 96, __io_address(REALVIEW_EB_GIC_DIST_BASE),
arch/arm/mach-realview/realview_pb11mp.c:	gic_init(1, IRQ_PB11MP_GIC_START,

Jon
