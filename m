From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Fri, 15 Jun 2012 18:32:29 +0200
Subject: How to use linear mapping without DT?
In-Reply-To: <20120615160155.GN31565@S2101-09.ap.freescale.net>
References: <4FD9B4DC.80706@atmel.com>
 <20120615160155.GN31565@S2101-09.ap.freescale.net>
Message-ID: <4FDB639D.4060103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 06/15/2012 06:01 PM, Shawn Guo a ?crit :
> On Thu, Jun 14, 2012 at 11:54:36AM +0200, ludovic.desroches wrote:
>> Hello,
>>
>> In fact, my question depends on sparse irq, irq domain and non DT.
>>
>> I have enabled sparse_irq use for at91 sub architecture. I don't
>> know if it is the good solution... I won't like to use n_irqs in my
>> machine descriptor. I think the goal of sparse irq is to allocate
>> the irq descriptor only when the irq is used. It's better than
>> allocating the range that can be managed by the controller which
>> should be indicated by nr_irqs.
>>
>> In this case using the legacy irq domain is not the right solution
>> since I will have to allocate the range of irq managed by the
>> controller. Moving to linear irq domain should be better. Moreover,
>> I have seen that Grant may want to remove it.
>>
>> So, how to move to linear irq domain? In DT case, all the interrupts
>> into the DT are mapped so the irq descriptor is allocated and my
>> device will have the right virq number. In non DT case, my device
>> has an irq number corresponding to a fixed value (which is in fact
>> the hwirq number) but probably not to any existing virq.
>>
>> So how to get a valid virq? Do I have to call irq_create_mapping
>> from my driver? It's probably not the right way... Should I keep
>> legacy domain and set nr_irqs?
>>
> Short answer - Don't use linear but legacy domain for non-DT.
>

Ok it's much more easier for me to not move to linear domain.

> I was getting punched on the head for thinking about using legacy
> domain for non-DT.[1]  Also Documentation/IRQ-domain.txt suggests
> that as below.
>
> | The Legacy mapping is a special case for drivers that already have a
> | range of irq_descs allocated for the hwirqs.  It is used when the
> | driver cannot be immediately converted to use the linear mapping.  For
> | example, many embedded system board support files use a set of #defines
> | for IRQ numbers that are passed to struct device registrations.  In that
> | case the Linux IRQ numbers cannot be dynamically assigned and the legacy
> | mapping should be used.
>
> So as long as you need to support non-DT users, you will need to use
> legacy domain.  But that does not necessarily mean you need to set
> .nr_irqs in mach_desc for enabling spare-irq.  If you have all your
> irqchips call irq_alloc_descs to allocate their irqdescs, you can enable
> spare-irq without the need of setting .nr_irq.  I posted the series
> "[PATCH 00/16] Enable SPARSE_IRQ support for imx" yesterday doing that
> for imx.
>

I've seen your patch series and I am wondering what is the difference 
between these two solutions:
- not using nr_irqs: you will have NR_IRQS_LEGACY irqdescs allocated and 
you will allocate the irqdescs for your controller just after by calling 
irq_alloc_descs so you will have to manage the NR_IRQS_LEGACY offset.
- using nr_irqs: you will have all your irqdescs allocated and won't 
have to manage the NR_IRQS_LEGACY offset.

Regards

Ludovic


> Regards,
> Shawn
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/151860/focus=152072
>
>
>
