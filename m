From: wg@grandegger.com (Wolfgang Grandegger)
Date: Thu, 06 Dec 2012 08:28:02 +0100
Subject: [PATCH 3/6 v9] gpio: Add userland device interface to block GPIO
In-Reply-To: <50BFC8C9.5070504@antcom.de>
References: <1354653588-4018-1-git-send-email-stigge@antcom.de>
 <1354653588-4018-4-git-send-email-stigge@antcom.de>
 <50BF99F3.4060207@grandegger.com> <50BFC8C9.5070504@antcom.de>
Message-ID: <50C04902.7010505@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2012 11:20 PM, Roland Stigge wrote:
> Hi Wolfgang,
> 
> On 05/12/12 20:01, Wolfgang Grandegger wrote:
>>> +	for (i = 0; i < block->ngpio; i++) {
>>> +		status = gpio_request(block->gpio[i], "gpioblock dev");
>>
>> You could use the name of the GPIO block.
> 
> OK.
> 
>>> +		if (status)
>>> +			goto err1;
>>> +
>>> +		irq = gpio_to_irq(block->gpio[i]);
>>> +		if (irq >= 0 &&
>>> +		    !test_bit(FLAG_IS_OUT, &gpio_desc[block->gpio[i]].flags) &&
>>> +		    !gpio_block_is_irq_duplicate(block, i)) {
>>> +			status = request_irq(irq, gpio_block_irq_handler,
>>> +					     IRQF_TRIGGER_FALLING,
>>> +					     block->name, block);
>>> +			if (status)
>>> +				goto err2;
>>> +
>>> +			block->irq_controlled = true;
>>> +		}
>>> +	}
>>
>> There is no need to request IRQs if "O_NONBLOCK" is specified.
> 
> Sure? Regarding this, I found: "The poll() function shall not be
> affected by the O_NONBLOCK flag." [1]

Ah, didn't know that.

>> I observed that the read returns once immediately (without blocking)
>> after reboot. I did not look into that yet.
> 
> Didn't happen to me. Can you tell how this can be reproduced?

I think there is an interrupt pending for some reason. It might not be
the case with your setup.

Feel free to add my:

"Tested by: Wolfgang Grandegger <wg@grandegger.com>".

Will do some more tests when time permits, especially with mixed GPIO
input and output.

Wolfgang.
