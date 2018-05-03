From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Thu, 3 May 2018 06:46:15 +0000
Subject: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <7862f544-cd4f-8c48-ee04-fa8c628354ea@arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69EECF90@G01JPEXMBKW03>
 <ce2c6191-1f74-4cec-9009-0a770d32673a@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69EF9AF9@G01JPEXMBKW03>
 <7862f544-cd4f-8c48-ee04-fa8c628354ea@arm.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A69EFC716@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

> I can probably help you with that, but this assumes that you've
> implemented support for your own bus by providing a glue layer
> equivalent to the one we have for other buses.
Thanks for your comments.
I want to consider implementing a glue layer for our bus. 

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> Marc Zyngier
> Sent: Monday, April 30, 2018 7:20 PM
> To: Zhang, Lei/? ?; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
> 
> Hi Lei,
> 
> On 30/04/18 08:53, Zhang, Lei wrote:
> > Hi Marc
> >
> > thanks for your opinions.
> >
> >> How many is many? Are they PCI? Or something else?
> >
> >> As it is, this patch will break Multi-MSI and some other platforms
> that
> >> do require a higher allocation granule.
> >>
> >> Depending on whether you're using PCI or some other bus, we can probably
> >> come up with a solution that works for everyone. But I need more
> >> information on this.
> >
> > Actually it is our original interconnect device not on PCI but on our
> > original bus. This device has many sub devices around one thousand,
> > and each sub device requires only a few LPIs.
> 
> OK. Have you implemented your own glue layer for this (like we already
> have for PCI, platform and FSL-MC)? Or are you directly using the
> platform MSI infrastructure?
> 
> > As I explained in point1, each Device ID can still allocate enough
> > LPIs more than IRQS_PER_CHUNK by increasing chunks. So I couldn't
> > understand why this patch will break Multi-MSI.
> 
> Unfortunately, Multi-MSI has more requirements than just allocating
> multiple MSIs. The allocated MSIs must be allocated as a contiguous
> range, be a power of two, aligned on the size of the range, with a
> maximum of 32 interrupts. Your approach breaks the alignment requirement.
> 
> > By the way, 32 seems a good default value for IRQS_PER_CHUNK.
> > So, I want to write another patch to make IRQ_PER_CHUNK a variable
> > which can be changed by kernel parameter.
> > What do you think of this idea?
> 
> It is not great, because it prevents two buses with different
> requirements from being used concurrently in the same system. It may not
> be an issue for you right now, but I want the ITS driver to be
> independent of the bus requirements.
> 
> Another, more involved (but also more correct) approach would be to
> teach the various glue layers about the requirements of the bus they
> support, and pass on the allocation requirements to the core ITS driver.
> That way, we would keep the heterogeneous case working.
> 
> I can probably help you with that, but this assumes that you've
> implemented support for your own bus by providing a glue layer
> equivalent to the one we have for other buses.
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
