From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 16 Jan 2014 09:54:41 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a
 gpio used as an interrupt source.
In-Reply-To: <20140115180615.GJ9558@ns203013.ovh.net>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <52D3C166.5050908@overkiz.com> <20140115180615.GJ9558@ns203013.ovh.net>
Message-ID: <52D79E51.4030300@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2014 19:06, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:35 Mon 13 Jan     , boris brezillon wrote:
>> On 13/01/2014 11:29, Jean-Jacques Hiblot wrote:
>>> Hello Nicolas, Jean-Christophe,
>>>
>>> As I was trying to enable the touchscreen on the at91sam9261ek with
>>> device-tree support, I ran into an issue. The touchscreen driver needs
>>> to know the state of the pendown gpio and also needs it as an
>>> interrupt source.
>>>
>>> The problem is that when a gpio is used as an interrupt, it's
>>> requested by the pinctrl driver during the xlate stage, marking it
>>> unavaliable for the other driver.
>>> It looks like the at91 pinctrl driver is the only one to use
>>> gpio_request() in the xlate stage. Maybe we should remove this:
>> You should only request it as a GPIO and then use gpio_to_irq to get the
>> related IRQ.
> This here a HUGE issue in the hole kernel
>
> You should NEVER known ti's a gpio in the driver at all gpio_to_irq should never
> exist you need to only see the irq
>
>> Because what is done here, is to solve the case where only the irq
>> is request, and in this specific case we need to request the pin as a
>> GPIO.
> this need to be handled at irq level not drivers

Then propose something (or at least give us a deadline for this new 
interrupt
model to come out), because the ADS7843E touchscreen is not working anymore
(at least on at91 platforms).

What this driver needs is a level IRQ (not an edge IRQ). The code in 
ads7846_hard_irq<http://lxr.free-electrons.com/ident?i=ads7846_hard_irq>
interrupt handler is here to transform an edge IRQ into a level IRQ.

Is there a way to provide a generic framework to transform edge IRQs 
into level IRQs
(because some GPIO controllers do not support level IRQs, and this is 
the case for the
at91sam9261 one) ?


Of cource the gpio_to_irq approach is not perfect, but at least it as 
the benefit to quickly
fix the bug, and we will still be able to improve this later, when we 
have enough tools
(or mechanisms) to do it.

Best Regards,

Boris
> Best Regards,
> J.
