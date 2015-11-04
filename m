From: slash.tmp@free.fr (Mason)
Date: Wed, 4 Nov 2015 16:59:05 +0100
Subject: [RESEND][PATCH] ARM: debug: add support for Palmchip 16550-like
 UART
In-Reply-To: <yw1x1tc59375.fsf@unicorn.mansr.com>
References: <1445950678-16097-1-git-send-email-mans@mansr.com>
 <563A26B8.9080405@free.fr> <yw1x1tc59375.fsf@unicorn.mansr.com>
Message-ID: <563A2B49.3080804@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2015 16:47, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> On 27/10/2015 13:57, Mans Rullgard wrote:
>>
>>> Some SoCs have a Palmchip UART with a non-standard register layout.
>>> This allows the debug console to work with these.
>>>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>> ---
>>>  arch/arm/Kconfig.debug        |  8 ++++++++
>>>  arch/arm/include/debug/8250.S | 12 ++++++++++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>>> index 0cfd7f9..9039fff 100644
>>> --- a/arch/arm/Kconfig.debug
>>> +++ b/arch/arm/Kconfig.debug
>>> @@ -1597,6 +1597,14 @@ config DEBUG_UART_8250_WORD
>>>  		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
>>>  		DEBUG_BRCMSTB_UART
>>>  
>>> +config DEBUG_UART_8250_PALMCHIP
>>> +	bool "8250 UART is Palmchip variant"
>>> +	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
>>
>> I am 100% clueless about the UART sequence in Linux.
>>
>> There's earlyprintk, the boot console (polled?), the "full-blown"
>> console (with IRQs)...
>>
>> If I want earlyprintk, I have to enable DEBUG_LL (?) so I'll have
>> DEBUG_LL_UART_8250, right? There's no way to pick DEBUG_UART_8250
>> in menuconfig, is there?
>>
>> So I picked the following options:
>>
>> CONFIG_DEBUG_LL=y
>> # CONFIG_DEBUG_ICEDCC is not set
>> # CONFIG_DEBUG_SEMIHOSTING is not set
>> CONFIG_DEBUG_LL_UART_8250=y
>> # CONFIG_DEBUG_LL_UART_PL01X is not set
>> CONFIG_DEBUG_LL_INCLUDE="debug/8250.S"
>> # CONFIG_DEBUG_UART_8250 is not set
>> # CONFIG_DEBUG_UART_BCM63XX is not set
>> CONFIG_DEBUG_UART_PHYS=0x10700
>> CONFIG_DEBUG_UART_VIRT=0xf0010700
>> CONFIG_DEBUG_UART_8250_SHIFT=2
>> CONFIG_DEBUG_UART_8250_WORD=y
>> CONFIG_DEBUG_UART_8250_PALMCHIP=y
>> # CONFIG_DEBUG_UART_8250_FLOW_CONTROL is not set
>> CONFIG_DEBUG_UNCOMPRESS=y
>> CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
>> CONFIG_EARLY_PRINTK=y
> 
> Those are the settings I use.
> 
>> I suppose I have to provide DEBUG_UART_PHYS because it needs
>> the address before it can parse the DT? But how am I supposed
>> to know the virtual address? Isn't that from iomap(UART_PHYS)?
> 
> The decompression code and early setup don't have that luxury.

But how am I supposed to compute the virtual address?
Can I set DEBUG_UART_VIRT to 0xdeadbeef? :-)

Also is it expected that setting DEBUG_LL forces make to recompile
every source file in the source tree?

Regards.
