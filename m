From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 15 Apr 2011 15:17:32 -0700
Subject: [RFC PATCH] genirq: implement read_irq_line for interrupt lines
In-Reply-To: <4DA899E3.30409@caviumnetworks.com>
References: <1302892952-7090-1-git-send-email-adharmap@codeaurora.org>
	<4DA899E3.30409@caviumnetworks.com>
Message-ID: <4DA8C3FC.5010102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Daney wrote:
> On 04/15/2011 11:42 AM, Abhijeet Dharmapurikar wrote:
> [...]
>>
>> +/**
>> + *    irq_read_line - read the value on an irq line
>> + *    @irq: Interrupt number representing a hardware line
>> + *
>> + *    This function may be called from IRQ context only when
>> + *    desc->chip->bus_lock and desc->chip->bus_sync_unlock are NULL !
> 
> What does it return?  I can see that -EINVAL is returned if it isn't 
> applicable to this irq.  But what if chip->irq_read_line is implemented?

It returns the logical state of that line (0 when it is low or 1 when it 
is high). Will add the return type in the comment.

> 
> 
> 
> 
>> + */
>> +int irq_read_line(unsigned int irq)
>> +{
>> +    struct irq_desc *desc = irq_to_desc(irq);
>> +    unsigned long flags;
>> +    int val;
>> +
>> +    if (!desc || !desc->irq_data.chip->irq_read_line)
>> +        return -EINVAL;

It returns -EINVAL is irq_read_line is not implemented.

>> +
>> +    chip_bus_lock(desc);
>> +    raw_spin_lock_irqsave(&desc->lock, flags);



--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
