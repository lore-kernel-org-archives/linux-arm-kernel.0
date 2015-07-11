From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 10 Jul 2015 22:09:52 -0600
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <5582C87C.20008@tronnes.org>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <55822C71.2040409@wwwdotorg.org> <5582C87C.20008@tronnes.org>
Message-ID: <55A09710.3030509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Sorry for the slow reply; I was on vacation)

On 06/18/2015 07:32 AM, Noralf Tr?nnes wrote:
> Den 18.06.2015 04:26, skrev Stephen Warren:
>> On 06/12/2015 11:26 AM, Noralf Tr?nnes wrote:
>>> Add a duplicate irq range with an offset on the hwirq's so the
>>> driver can detect that enable_fiq() is used.
>>> Tested with downstream dwc_otg USB controller driver.
>> This basically looks OK, but a few comments/thoughts:

>> b) Doesn't the driver need to refuse some operation (handler
>> registration, IRQ setup, IRQ enable, ...?) for more than 1 IRQ in the
>> FIQ range, since the FIQ control register only allows routing 1 IRQ to
>> FIQ.
> 
> claim_fiq() protects the FIQ. See d) answer below.

That assumes the IRQ is "accessed" via the fiq-specific APIs. Since this
patch changes the IRQ domain from having n IRQs to having 2*n IRQs, and
doesn't do anything special to prevent clients from using IRQs n..2n-1
via the existing IRQ APIs, it's quite possible the a buggy client would.

(From another email):
>>> c) The DT binding needs updating to describe the extra IRQs:
>>>
>>>> Documentation/devicetree/bindings/interrupt-controller/brcm,bcm28armctrl-ic.txt
>>
>> Ok.
> 
> I have seconds thoughts on this:
> This patch does not change the DT bindings so I don't see what update
> I should make. This patch only adds support for the Linux way of
> handling FIQ's through enable_fiq(). It doesn't change how interrupts
> are described in the DT.

The intention of the patch may not be to expand the set of IRQs
available via DT, but it does in practice. I think you need to add a
custom of_xlate for the IRQ domain to ensure that only IRQs 0..n-1 can
be translated from DT, and not IRQs n..2n-1. If you do that, then I
agree that no DT binding update should be required.

Even with a custom of_xlate function, some code could hard-code an IRQ
number and hence end up registering a FIQ handler that way. However, I
guess that's a bug that the driver doesn't need to solve. We can just
fix that bug in the kernel code in that case. The same argument doesn't
apply to bad DTs; we need to more aggressively protect against that case.

>> d) I wonder how the FIQ handler actually gets routed to this controller
>> and hooked to its handler etc. I assume there's a separate patch for
>> that coming?
> 
> set_fiq_handler() sets the handler and enable_fiq() enables it:
> 
>     if (claim_fiq(&fh))
>         ERROR;
>     set_fiq_handler(...)
>     set_fiq_regs(&regs);
>     enable_fiq(irq);
>     local_fiq_enable();
