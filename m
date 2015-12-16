From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Dec 2015 15:05:56 +0000
Subject: [PATCH v9 3/4] irqchip:create irq domain for each mbigen device
In-Reply-To: <56717BC8.60509@huawei.com>
References: <1448248513-39760-1-git-send-email-majun258@huawei.com>
 <1448248513-39760-4-git-send-email-majun258@huawei.com>
 <20151211154236.GF20666@leverpostej> <56717BC8.60509@huawei.com>
Message-ID: <56717DD4.4080105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/15 14:57, majun wrote:
> Hi Marc and Mark:
> 
> On 2015/12/11 10:42, Mark Rutland wrote:
>> On Mon, Nov 23, 2015 at 11:15:12AM +0800, MaJun wrote:
>>> From: Ma Jun <majun258@huawei.com>
>>>
>>> For peripheral devices which connect to mbigen,mbigen is a interrupt
>>> controller. So, we create irq domain for each mbigen device and add
>>> mbigen irq domain into irq hierarchy structure.
>>>
>>> Signed-off-by: Ma Jun <majun258@huawei.com>
>>> ---
>>>  drivers/irqchip/irq-mbigen.c |  119 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 119 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>>> index 9f036c2..81ae61f 100644
>>> --- a/drivers/irqchip/irq-mbigen.c
>>> +++ b/drivers/irqchip/irq-mbigen.c
>>> @@ -16,13 +16,36 @@
>>>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>   */
>>>  
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irqchip.h>
>>>  #include <linux/module.h>
>>> +#include <linux/msi.h>
>>>  #include <linux/of_address.h>
>>>  #include <linux/of_irq.h>
>>>  #include <linux/of_platform.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/slab.h>
>>>  
>>> +/* Interrupt numbers per mbigen node supported */
>>> +#define IRQS_PER_MBIGEN_NODE		128
>>> +
>>> +/* 64 irqs (Pin0-pin63) are reserved for each mbigen chip */
>>> +#define RESERVED_IRQ_PER_MBIGEN_CHIP	64
>>> +
>>> +/**
>>> + * In mbigen vector register
>>> + * bit[21:12]:	event id value
>>> + * bit[11:0]:	device id
>>> + */
>>> +#define IRQ_EVENT_ID_SHIFT		12
>>> +#define IRQ_EVENT_ID_MASK		0x3ff
>>> +
>>> +/* register range of each mbigen node */
>>> +#define MBIGEN_NODE_OFFSET		0x1000
>>> +
>>> +/* offset of vector register in mbigen node */
>>> +#define REG_MBIGEN_VEC_OFFSET		0x200
>>> +
>>>  /**
>>>   * struct mbigen_device - holds the information of mbigen device.
>>>   *
>>> @@ -34,10 +57,94 @@ struct mbigen_device {
>>>  	void __iomem		*base;
>>>  };
>>>  
>>> +static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>>> +{
>>> +	unsigned int nid, pin;
>>> +
>>> +	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
>>> +	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>>> +	pin = hwirq % IRQS_PER_MBIGEN_NODE;
>>> +
>>> +	return pin * 4 + nid * MBIGEN_NODE_OFFSET
>>> +			+ REG_MBIGEN_VEC_OFFSET;
>>> +}
>>
>> Ok. So your "global" pin id is "global" per mbigen chip.
> 
> right.
> 
>>
>> I think it may make more sense to have separate nid and pin fields in
>> your interrupt-specifier, e.g. interrupt = <1 3 x> for nid 1, pin 3.
>>
>> That's easier for someone to check against a datasheet that describes
>> the nid and pin rather than the global number space you've come up with,
>> and also makes it impossible to describe the reserved IRQs.
> 
> There are no nid and pin fields in our new datasheet now.
> All we can see is hardware pin number.
> So adding nid and pin fields makes the people more confused about using
> mbigen.
> 
> Further more, "pin" is not a good variable name. I should name it as
> "pin_offset" or just"offset" to present the interrupt pin offset to mbigen node.
> 
>>
>>> +
>>> +static struct irq_chip mbigen_irq_chip = {
>>> +	.name =			"mbigen-v2",
>>> +};
>>> +
>>> +static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>>> +{
>>> +	struct irq_data *d = irq_get_irq_data(desc->irq);
>>> +	void __iomem *base = d->chip_data;
>>> +	u32 val;
>>> +
>>> +	base += get_mbigen_vec_reg(d->hwirq);
>>> +	val = readl_relaxed(base);
>>> +
>>> +	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
>>> +	val |= (msg->data << IRQ_EVENT_ID_SHIFT);
>>> +
>>> +	writel_relaxed(val, base);
>>> +}
>>> +
>>> +static int mbigen_domain_translate(struct irq_domain *d,
>>> +				    struct irq_fwspec *fwspec,
>>> +				    unsigned long *hwirq,
>>> +				    unsigned int *type)
>>> +{
>>> +	if (is_of_node(fwspec->fwnode)) {
>>> +		if (fwspec->param_count != 2)
>>> +			return -EINVAL;
>>> +
>>> +		*hwirq = fwspec->param[0];
>>
>> You should validate the hwirq here. For instance, we never expect a
>> hwirq < RESERVED_IRQ_PER_MBIGEN_CHIP here.
> 
> Yes, I also think I need to check the hwirq input value.
> The hwirq should be:
> hwirq > RESERVED_IRQ_PER_MBIGEN_CHIP && hwirq < MAXIMUM_INTERRUPT_NUMBER
> 
>>
>>> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>
>> Don't mask out bits you don't expect to be set. Validate that they
>> aren't set and complain if they are.
>>
> 
> I referred Marc's dummy driver when coding this function.
> 
> Marc, do you have any different comment about these two parts.

My dummy driver was exactly that: a dummy. It was not meant to be
followed to the letter, but just an example showing how to use a new
API. And given that it didn't handle any interrupt, it really didn't
matter what it did in the translate function.

Here, I think Mark is right, and you should follow his recommendation.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
