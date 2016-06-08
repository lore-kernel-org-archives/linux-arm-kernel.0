From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 8 Jun 2016 09:17:18 +0200
Subject: [PATCH] ARM: at91: debug: use DEBUG_UART_VIRT
In-Reply-To: <20160607162301.GL3363@piout.net>
References: <1465313079-6307-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5756ECC5.6020908@atmel.com> <20160607162301.GL3363@piout.net>
Message-ID: <5757C67E.3000301@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/06/2016 18:23, Alexandre Belloni a ?crit :
> On 07/06/2016 at 17:48:21 +0200, Nicolas Ferre wrote :
>> Le 07/06/2016 17:24, Alexandre Belloni a ?crit :
>>> AT91 still uses an offset (0x0100 0000) from the physical address to map
>>> the debug UART. This is unfortunate as for some platforms (sama5d3 and
>>> earlier), it ends up in the PCI zone and PCI is enabled in multi_v7.
>>> Switch to DEBUG_UART_VIRT to solve that.
>>>
>>> Tested on sama5d3 and 9g20.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>
>> People using their old defconfigs must pay attention to this change...
>> but it's true that it's a debug configuration anyway...
>>
> 
> I really doubt people are letting DEBUG_LL enabled in a production
> kernel...
> 
>>> diff --git a/arch/arm/include/debug/at91.S b/arch/arm/include/debug/at91.S
>>> index d4ae3b8e2426..0098401e5aeb 100644
>>> --- a/arch/arm/include/debug/at91.S
>>> +++ b/arch/arm/include/debug/at91.S
>>> @@ -9,14 +9,6 @@
>>>   *
>>>  */
>>>  
>>> -#ifdef CONFIG_MMU
>>> -#define AT91_IO_P2V(x) ((x) - 0x01000000)
>>> -#else
>>> -#define AT91_IO_P2V(x) (x)
>>> -#endif
>>> -
>>> -#define AT91_DEBUG_UART_VIRT AT91_IO_P2V(CONFIG_DEBUG_UART_PHYS)
>>> -
>>>  #define AT91_DBGU_SR		(0x14)	/* Status Register */
>>>  #define AT91_DBGU_THR		(0x1c)	/* Transmitter Holding Register */
>>>  #define AT91_DBGU_TXRDY		(1 << 1)	/* Transmitter Ready */
>>> @@ -24,7 +16,7 @@
>>>  
>>>  	.macro	addruart, rp, rv, tmp
>>>  	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
>>> -	ldr	\rv, =AT91_DEBUG_UART_VIRT		@ System peripherals (virt address)
>>> +	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
>>
>> Shouldn't we protect the use of this defined value with some
>> #warning "Beware the value CONFIG_DEBUG_UART_VIRT haven't been defined:
>> is it intentional"
>> or even #error?
>>
>> or something like that?
>>
> 
> Well, those that are using this feature are supposed to know what they
> are doing. There is now protection for CONFIG_DEBUG_UART_PHYS anyway.

So, I know that developers are sensible people and know what they're
doing but still... what about having a protection for both anyway...
instead of silently crashing at runtime?

Bye,
-- 
Nicolas Ferre
