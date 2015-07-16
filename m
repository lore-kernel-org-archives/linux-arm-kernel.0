From: majun258@huawei.com (majun (F))
Date: Thu, 16 Jul 2015 16:35:33 +0800
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <559D422D.1000307@arm.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
 <559D422D.1000307@arm.com>
Message-ID: <55A76CD5.1050301@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/7/8 23:30, Marc Zyngier ??:
> Hi,
> 
> Aside from all the comments Thomas had, the following aspect is worrying
> me a bit:
> 
> On 06/07/15 08:09, Ma Jun wrote:
>> This patch contains the mbigen interrupt controller driver.
> 
> [...]
> 
>> +static int mbigen_set_type(struct irq_data *d, unsigned int type)
>> +{
>> +       struct mbigen_chip *chip = d->domain->host_data;
>> +       u32 ofst, mask;
>> +       u32 val, nid, hwirq;
>> +       void __iomem *addr;
>> +
>> +       if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
>> +               return -EINVAL;
> 
> You seem to be supporting both edge and level triggered interrupts.
> 
> Given that the ITS is edge triggered only, I must assume you have some
> code to regenerate an edge if the wired interrupt is level triggered,
> and that the line level is still high when you perform the EOI...
> 
For each interrupt, there is state machine in mbigen chip.
inactive-->pending--> active(pending & active)

The level triggered interrupt process flow list as below:
device---->mbigen---->ITS---->GIC--->CPU

[1]: device triggered interrupt A and line level changes to high
[2]: Mbigen receive interrupt A and changes the status of A to pending in mbigen(mbigen.state = pending)
[3]: Mbigen send interrupt A to ITS , the A status in mbigen will be changed to pending
	& active (mbigen.state = pending & active)
[4]: ITS receive the interrupt A and send A to gic (A status in gic is pending. gic.state=pending)
[5]: CPU ack the interrupt A ( gic.state = active)
[6]: Enter interrupt handler. The interrupt line level is cleared in device irq handler.
[7]: When detects the low level on interrupt A line, mbigen change the interrupt A status
	from pending & active to inactive (mbigen.state = inactive).
[8]: Send EOI . a): write register to clear the status in mbigen .
	b):clear the status in gic. (gic.state = inactive)

[....]
>> +static void mbigen_irq_eoi(struct irq_data *d)
>> +{
>> +       irq_chip_eoi_parent(d);
> 
> ... but this function doesn't have any code dealing with injecting an
> edge on detecting a level high.
> 

Yes, before irq_chip_eoi_parent is called, some code should be added to
clear the interrupt status in mbigen.

> So how does it work? Either you're missing some logic here, or you don't
> really support level interrupts.
> 
> Thanks,
> 
> 	M.
> 
