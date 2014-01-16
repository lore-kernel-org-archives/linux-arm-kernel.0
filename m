From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 16 Jan 2014 13:02:28 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a gpio
 used as an interrupt source.
In-Reply-To: <52D7BCAA.30706@atmel.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <52D3C166.5050908@overkiz.com>
 <20140115180615.GJ9558@ns203013.ovh.net>
 <52D79E51.4030300@overkiz.com> <52D7BCAA.30706@atmel.com>
Message-ID: <CACh+v5OOx8LgGVN0GFsa5-f=h1kasJVz4r0CfBXdXhK0F8iQAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/16 Nicolas Ferre <nicolas.ferre@atmel.com>:
> On 16/01/2014 09:54, boris brezillon :
>> On 15/01/2014 19:06, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 11:35 Mon 13 Jan     , boris brezillon wrote:
>>>> On 13/01/2014 11:29, Jean-Jacques Hiblot wrote:
>>>>> Hello Nicolas, Jean-Christophe,
>>>>>
>>>>> As I was trying to enable the touchscreen on the at91sam9261ek with
>>>>> device-tree support, I ran into an issue. The touchscreen driver needs
>>>>> to know the state of the pendown gpio and also needs it as an
>>>>> interrupt source.
>>>>>
>>>>> The problem is that when a gpio is used as an interrupt, it's
>>>>> requested by the pinctrl driver during the xlate stage, marking it
>>>>> unavaliable for the other driver.
>>>>> It looks like the at91 pinctrl driver is the only one to use
>>>>> gpio_request() in the xlate stage. Maybe we should remove this:
>>>> You should only request it as a GPIO and then use gpio_to_irq to get the
>>>> related IRQ.
>>> This here a HUGE issue in the hole kernel
>>>
>>> You should NEVER known ti's a gpio in the driver at all gpio_to_irq should never
>>> exist you need to only see the irq
>>>
>>>> Because what is done here, is to solve the case where only the irq
>>>> is request, and in this specific case we need to request the pin as a
>>>> GPIO.
>>> this need to be handled at irq level not drivers
>>
>> Then propose something (or at least give us a deadline for this new
>> interrupt
>> model to come out), because the ADS7843E touchscreen is not working anymore
>> (at least on at91 platforms).
>>
>> What this driver needs is a level IRQ (not an edge IRQ). The code in
>> ads7846_hard_irq<http://lxr.free-electrons.com/ident?i=ads7846_hard_irq>
>> interrupt handler is here to transform an edge IRQ into a level IRQ.
>>
>> Is there a way to provide a generic framework to transform edge IRQs
>> into level IRQs
>> (because some GPIO controllers do not support level IRQs, and this is
>> the case for the
>> at91sam9261 one) ?
>>
>>
>> Of cource the gpio_to_irq approach is not perfect, but at least it as
>> the benefit to quickly
>> fix the bug, and we will still be able to improve this later, when we
>> have enough tools
>> (or mechanisms) to do it.
>
> Moreover, I do not see the rationale behind the concept of "interrupt
> with an electrical value". An interrupt signals an event and this event
> can be a transition or a state but an electrical value is the
> responsibility of a GPIO line, not the other way around.
>
> I see a code that could give the value of an electrical line related to
> an interrupt as a twisted interpretation of the notion of "interrupt".
> It surprises me that it could be thought as an enhancement that an IRQ
> coming from a GPIO could give a value!
>
> Isn't it why other people are also using this simple distinction to use
> their GPIO/IRQ mechanism? Maybe this is why we are the only ones to
> completely forbid this possibility.
>
> So, let's fix the bug, submit the modification to mainline, make
> platform work and see if somebody can convince me that retrieving an
> electrical line status from a GPIO is a "bad" thing...
>

I share your view on this.

Linus,
 the root of the issue is the fact that a GPIO can't be requested
twice. But IMO it's safe for a single device to request it more than
once and use it for different purposes (irq and electrical signal
value). Maybe we can rework the GPIO request to include this ownership
information. I can post a draft implementation for this if you think
it's worthwhile.

Jean-Jacques

> Bye,
> --
> Nicolas Ferre
