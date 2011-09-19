From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 19 Sep 2011 10:47:53 +0200
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <20110918061526.GE3523@ponder.secretlab.ca>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
	<CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com>
	<20110918061526.GE3523@ponder.secretlab.ca>
Message-ID: <4E7701B9.1040505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/18/2011 8:15 AM, Grant Likely wrote:
> On Thu, Sep 15, 2011 at 12:07:25PM +0200, Cousson, Benoit wrote:
>> Hi Rob,
>>
>> On 9/15/2011 9:55 AM, Thomas Abraham wrote:
>>> Hi Rob,
>>>
>>> On 14 September 2011 22:01, Rob Herring<robherring2@gmail.com>   wrote:
>>>> From: Rob Herring<rob.herring@calxeda.com>
>>>>
>>>> This adds gic initialization using device tree data. The initialization
>>>> functions are intended to be called by a generic OF interrupt
>>>> controller parsing function once the right pieces are in place.
>>>>
>>>> PPIs are handled using 3rd cell of interrupts properties to specify the cpu
>>>> mask the PPI is assigned to.
>>>>
>>>> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/arm/gic.txt |   53 ++++++++++++++++++++++++
>>>>   arch/arm/common/gic.c                         |   55 +++++++++++++++++++++++--
>>>>   arch/arm/include/asm/hardware/gic.h           |   10 +++++
>>>>   3 files changed, 114 insertions(+), 4 deletions(-)
>>>>   create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
>>>
>>> [...]
>>>
>>>
>>>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>>>> index d1ccc72..14de380 100644
>>>> --- a/arch/arm/common/gic.c
>>>> +++ b/arch/arm/common/gic.c
>>>
>>> [...]
>>>
>>>> +void __init gic_of_init(struct device_node *node, struct device_node *parent)
>>>> +{
>>>> +       void __iomem *cpu_base;
>>>> +       void __iomem *dist_base;
>>>> +       int irq;
>>>> +       struct irq_domain *domain =&gic_data[gic_cnt].domain;
>>>> +
>>>> +       if (WARN_ON(!node))
>>>> +               return;
>>>> +
>>>> +       dist_base = of_iomap(node, 0);
>>>> +       WARN(!dist_base, "unable to map gic dist registers\n");
>>>> +
>>>> +       cpu_base = of_iomap(node, 1);
>>>> +       WARN(!cpu_base, "unable to map gic cpu registers\n");
>>>> +
>>>> +       domain->nr_irq = gic_irq_count(dist_base);
>>>> +       domain->irq_base = irq_alloc_descs(-1, 0, domain->nr_irq, numa_node_id());
>>>
>>> For exynos4, all the interrupts originating from GIC are statically
>>> mapped to start from 32 in the linux virq space (GIC SPI interrupts
>>> start from 64). In the above code, since irq_base would be 0 for
>>> exynos4, the interrupt mapping is not working correctly. In your
>>> previous version of the patch, you have given a option to the platform
>>> code to choose the offset. Could that option be added to this series
>>> also. Or a provision to use platform specific translate function
>>> instead of the irq_domain_simple translator.
>>
>> I have another concern on a similar topic.
>>
>> On OMAP4 the SoC interrupts external to the MPU (SPI) have an offset
>> of 32. Only the internal PPI are between 0 and 31.
>>
>> For the moment we add 32 to every SoC interrupts in the irq.h
>> define, but I'm assuming that this offset calculation should be done
>> thanks to a dedicated irq domain for the SPI.
>> The real HW physical number start at 0, and thus this is that value
>> that should be in the irq binding of the device.
>
> Yes.
>
>> So ideally we should have a irq domain for the PPI starting at 0 and
>> another one for the SPI starting at 32. Or 32 and 64 for the exynos4
>> case, but it looks like the PPI/SPI offset is always 32.
>
> Part of the purpose behind irq_domains is to have a translator
> callback that can take care of complex mappings, such as mapping each
> of the GIC irq ranges onto the Linux irq space.  Plus, by being based
> on the DT irq specifiers and dynamically assigning the linux numbers,
> the actual mapping that the kernel chooses to use shouldn't actually
> have any relevance.  So whether or not the driver uses an offset is 32
> becomes an implementation detail.

I do agree, my point was not about the driver usage but about how the 
device node should populate its irq entry. The +32 offset is due to the 
internal implementation of the GIC. That should not be exposed outside 
the MPUSS.

Here are the first IRQs from the OMAP4430 public TRM.

MA_IRQ_0 L2_CACHE_IRQ CORTEXA9 L2 cache controller interrupt
MA_IRQ_1 CTI_IRQ_0 CORTEXA9 Cross-trigger module 0 (CTI0) interrupt
MA_IRQ_2 CTI_IRQ_1 CORTEXA9 Cross-trigger module 1 (CTI1) interrupt
MA_IRQ_3 Reserved Reserved Reserved
MA_IRQ_4 ELM_IRQ ELM Error location process completion
MA_IRQ_5 Reserved Reserved Reserved
MA_IRQ_6 Reserved Reserved Reserved
MA_IRQ_7 sys_nirq1 External External interrupt 1 (active low)
MA_IRQ_8 Reserved Reserved Reserved
MA_IRQ_9 L3_DBG_IRQ L3 L3 interconnect debug error
MA_IRQ_10 L3_APP_IRQ L3 L3 interconnect application error
MA_IRQ_11 PRCM_MPU_IRQ PRCM PRCM interrupt
...

It is a 0 based index, and thus this is the value I'm expecting to enter 
in the irq attribute of the DT node.

Regards,
Benoit
