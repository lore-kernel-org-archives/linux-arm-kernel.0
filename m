From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Sep 2011 16:00:34 +0100
Subject: [RFC PATCH 1/3] genirq: add support for per-cpu dev_id interrupts
In-Reply-To: <4E770B3E.9040401@arm.com>
References: <1316105551-17505-1-git-send-email-marc.zyngier@arm.com>
	<1316105551-17505-2-git-send-email-marc.zyngier@arm.com>
	<4E767CD6.6090208@codeaurora.org> <4E770B3E.9040401@arm.com>
Message-ID: <4E775912.3060502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/11 10:28, Marc Zyngier wrote:
> On 19/09/11 00:20, Abhijeet Dharmapurikar wrote:
>>  > + *  @devname: An ascii name for the claiming device
>>  > + *  @dev_id: A percpu cookie passed back to the handler function
>>  > + *
>>  > + *  This call allocates interrupt resources, but doesn't
>>  > + *  automatically enable the interrupt. It has to be done on each
>>  > + *  CPU using enable_percpu_irq().
>>  > + *
>>  > + *  Dev_id must be globally unique. It is a per-cpu variable, and
>>  > + *  the handler gets called with the interrupted CPU's instance of
>>  > + *  that variable.
>>  > + */
>>  > +int request_percpu_irq(unsigned int irq, irq_handler_t handler,
>>  > +                   const char *devname, void __percpu *dev_id)
>>
>> Can we add irqflags argument. I think it will be useful to pass flags,
>> at least the IRQF_TRIGGER_MASK since it ends up calling __setup_irq().
>> The chip could use a set_type callback for ppi's too.
> 
> We're entering dangerous territory here. While this would work with the
> GIC (the interrupt type is at the distributor level), you could easily
> imagine an interrupt controller with the PPI configuration at the CPU
> interface level... In that case, calling set_type from __setup_irq()
> would end up doing the wrong thing, and I'd hate the API to give the
> idea it can do things it may not do in the end...
> 
> Furthermore, do we actually have a GIC implementation where PPI
> configuration isn't read-only? I only know about the ARM implementation,
> and the Qualcomm may well be different (the spec says it's
> implementation defined).

Replying to myself after a quick investigation... Looks like the Qualcomm
implementation does exactly what is mentioned above:

arch/arm/mach-msm/platsmp.c:
void __cpuinit platform_secondary_init(unsigned int cpu)
{
	/* Configure edge-triggered PPIs */
	writel(GIC_PPI_EDGE_MASK, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
	[...]

The way I understand it, this "MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4"
is a banked register (otherwise we would not do it in platform_secondary_init(),
right?) So doing a set_type() from __setup_irq() would be just wrong. It really
needs to be done on a per-CPU basis.

Do you agree?

	M.
-- 
Jazz is not dead. It just smells funny...
