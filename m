From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Wed, 02 Oct 2013 19:31:20 +1300
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <524B7E90.30000@wwwdotorg.org>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <52410949.8070403@wwwdotorg.org> <5241489D.4000709@yahoo.com.au>
 <524B7E90.30000@wwwdotorg.org>
Message-ID: <524BBDB8.70301@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:01 PM, Stephen Warren wrote:
>>>> +static struct irq_chip bmc2835_chip = {
>>>> +    .name = "bmc2835-level",
>>>> +    .irq_mask = bmc2835_mask_irq,
>>>> +    .irq_unmask = bmc2835_unmask_irq,
>>>> +    .irq_ack =  bmc2835_mask_irq,
>>>> +};
>>>
>>> Why should an IRQ be masked by the ack operation?
>>
>> To be honest, I don't know for sure.  I took my cue from
>> Documentation/arm/Interrupts.
>>
>> ack    - required.  May be the same function as mask for IRQs
>>           handled by do_level_IRQ.
>>
>> Some other irq_chips are set up the same way and I can't see any other
>> way of implementing an acknowledgement function.  And my experience with
>> a never ending flow of interrupts while writing the mailbox driver made
>> me think it might be good idea for the BMC2835 as well.
>
> OK, it makes sense to implement that.
>

Possibly not.  I've dug a little deeper and followed the call chain 
through handle_level_irq() to mask_ack_irq().

static inline void mask_ack_irq(struct irq_desc *desc)
{
	if (desc->irq_data.chip->irq_mask_ack)
		desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
	else {
		desc->irq_data.chip->irq_mask(&desc->irq_data);
		if (desc->irq_data.chip->irq_ack)
			desc->irq_data.chip->irq_ack(&desc->irq_data);
	}
	irq_state_set_masked(desc);
}

I've not looked further to find out why code and documentation are 
different, but it looks like the .irq_ack is unnecessary, but harmless 
beyond an unneeded function call.  I plan to drop it.

Cheers,
Craig.
