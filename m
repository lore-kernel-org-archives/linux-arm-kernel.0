From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 20 Sep 2009 22:13:24 +0200
Subject: [PATCH] [TRIVIAL] Changes to IRQs.
In-Reply-To: <alpine.LNX.2.00.0909202042300.17028@wotan.suse.de> (Jiri
	Kosina's message of "Sun, 20 Sep 2009 20:43:50 +0200 (CEST)")
References: <m34oqx4s0e.fsf@intrepid.localdomain>
	<alpine.LNX.2.00.0909202042300.17028@wotan.suse.de>
Message-ID: <m3vdjds7bv.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jiri Kosina <jkosina@suse.cz> writes:

> This doesn't really qualify for trivial queue, adding ARM addressess to CC
> (I hope I got them right after the latest flame :P) at least for the ARM
> bits.

(Fixed the arm ml address, and lkml too (my mistake)).

But you noticed, of course, that the only real change is that to the
arch/arm/plat-orion/gpio.c? Just asking to make sure as the patch may
look longer than it is.

>> +++ b/Documentation/DocBook/genericirq.tmpl
>> @@ -417,8 +417,8 @@ desc->chip->end();
>>        </para>
>>        <para>
>>  	To make use of the split implementation, replace the call to
>> -	__do_IRQ by a call to desc->chip->handle_irq() and associate
>> -        the appropriate handler function to desc->chip->handle_irq().
>> +	__do_IRQ by a call to desc->handle_irq() and associate
>> +        the appropriate handler function to desc->handle_irq().

Only the comment fix, the code has been changed long ago.

>> +++ b/arch/arm/include/asm/hw_irq.h
>> @@ -10,14 +10,6 @@ static inline void ack_bad_irq(int irq)
>>  	irq_err_count++;
>>  }
>>  
>> -/*
>> - * Obsolete inline function for calling irq descriptor handlers.
>> - */
>> -static inline void desc_handle_irq(unsigned int irq, struct irq_desc *desc)
>> -{
>> -	desc->handle_irq(irq, desc);
>> -}

IIRC there had been no users of this function for some time, one has
been added recently...

>> +++ b/arch/arm/plat-orion/gpio.c
>> @@ -354,6 +354,6 @@ void orion_gpio_irq_handler(int pinoff)
>>  			polarity ^= 1 << (pin & 31);
>>  			writel(polarity, GPIO_IN_POL(pin));
>>  		}
>> -		desc_handle_irq(irq, desc);
>> +		desc->handle_irq(irq, desc);
>>  	}
>>  }

That's the one. I've little doubt someone did that by mistake.

>> +++ b/include/linux/irq.h
>> @@ -281,7 +281,7 @@ extern irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action);
>>  
>>  /*
>>   * Built-in IRQ handlers for various IRQ types,
>> - * callable via desc->chip->handle_irq()
>> + * callable via desc->handle_irq()

The code has been changed long ago, the patch only fixes comments.

But of course I'm not insisting, just wanted to flush my queue of such
things out.
-- 
Krzysztof Halasa
