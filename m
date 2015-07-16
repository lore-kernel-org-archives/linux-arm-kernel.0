From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jul 2015 18:09:01 +0100
Subject: [PATCH 4/5] irqchip: gic-v3: Add gic_get_irq_domain() to get
 the irqdomain of the GIC.
In-Reply-To: <55A7E0C2.8020704@caviumnetworks.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-5-git-send-email-ddaney.cavm@gmail.com>
 <55A6947F.8070903@arm.com> <55A6AD1F.902@caviumnetworks.com>
 <55A75F8B.3080009@arm.com> <55A7E0C2.8020704@caviumnetworks.com>
Message-ID: <55A7E52D.9080201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/15 17:50, David Daney wrote:
> On 07/16/2015 12:38 AM, Marc Zyngier wrote:
>> On 15/07/15 19:57, David Daney wrote:
>>> On 07/15/2015 10:12 AM, Marc Zyngier wrote:
>>>> On 15/07/15 17:54, David Daney wrote:
>>>>> From: David Daney <david.daney@cavium.com>
>>>>>
>>>>> Needed to map SPI interrupt sources.
>>>>>
>>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>>> ---
>>>>>    drivers/irqchip/irq-gic-v3.c       | 5 +++++
>>>>>    include/linux/irqchip/arm-gic-v3.h | 1 +
>>>>>    2 files changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>>>> index c52f7ba..0019fed 100644
>>>>> --- a/drivers/irqchip/irq-gic-v3.c
>>>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>>>> @@ -58,6 +58,11 @@ static struct gic_chip_data gic_data __read_mostly;
>>>>>    /* Our default, arbitrary priority value. Linux only uses one anyway. */
>>>>>    #define DEFAULT_PMR_VALUE	0xf0
>>>>>
>>>>> +struct irq_domain *gic_get_irq_domain(void)
>>>>> +{
>>>>> +	return gic_data.domain;
>>>>> +}
>>>>> +
>>>>>    static inline unsigned int gic_irq(struct irq_data *d)
>>>>>    {
>>>>>    	return d->hwirq;
>>>>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>>>>> index 18e3757..5992224 100644
>>>>> --- a/include/linux/irqchip/arm-gic-v3.h
>>>>> +++ b/include/linux/irqchip/arm-gic-v3.h
>>>>> @@ -391,6 +391,7 @@ int its_init(struct device_node *node, struct rdists *rdists,
>>>>>
>>>>>    typedef u32 (*its_pci_requester_id_t)(struct pci_dev *, u16);
>>>>>    void set_its_pci_requester_id(its_pci_requester_id_t fn);
>>>>> +struct irq_domain *gic_get_irq_domain(void);
>>>>>    #endif
> [...]
>>
>>> We need a way to be able to map these.
>>
>> However you're going to map them, it will not be by just blindly
>> exporting random irqdomains from an unsuspecting interrupt controller.
> 
> There is nothing random about it.  The ARM architects specified that 
> there is exactly One True GIC in a system.  If we need to do something 
> with the GIC, it is not a "random ... unsuspecting interrupt 
> controller", it is *The* GIC.

Indeed. And The One True GIC Driver will not be butchered just because
you can, thank you very much.

>>
>> Patch 5 has established that you're using "virtual wire" SPIs, so we
>> need to work on exposing that with the normal kernel abstraction, and
>> not by messing with the internals of the GIC.
>>
> 
> Agreed.
> 
> The MSI system has pci_enable_msix()/pci_disable_msix().
> 
> I would propose something like:
> 
> struct gic_spi_entry {
> 	int spi   /* SPI number */
> 	int irq;  /* kernel irq number mapped to the spi*/
> 	u32 msg;  /* message to be written */
> 	u64 assert_addr;
> 	u64 deassert_addr;
> };
> 
> /* Fill in the SPI processing information */
> int gic_map_spi(int spi, struct gic_spi_entry *data);

Neither.

The way to do it is to make this a *separate* IRQ domain stacked onto
the SPI domain. No funky hook on the side. If it doesn't go through the
normal kernel API, it doesn't reach the GIC.

	M.
-- 
Jazz is not dead. It just smells funny...
