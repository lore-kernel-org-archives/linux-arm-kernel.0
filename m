From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Tue, 14 Jul 2015 13:48:25 +0200
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <55A4952A.3090309@wwwdotorg.org>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <55822C71.2040409@wwwdotorg.org> <5582C87C.20008@tronnes.org>
 <55A09710.3030509@wwwdotorg.org> <55A135B4.1060309@tronnes.org>
 <55A4952A.3090309@wwwdotorg.org>
Message-ID: <55A4F709.1000501@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Den 14.07.2015 06:50, skrev Stephen Warren:
> On 07/11/2015 09:26 AM, Noralf Tr?nnes wrote:
>> Den 11.07.2015 06:09, skrev Stephen Warren:
>>> (Sorry for the slow reply; I was on vacation)
>>>
>>> On 06/18/2015 07:32 AM, Noralf Tr?nnes wrote:
>>>> Den 18.06.2015 04:26, skrev Stephen Warren:
>>>>> On 06/12/2015 11:26 AM, Noralf Tr?nnes wrote:
>>>>>> Add a duplicate irq range with an offset on the hwirq's so the
>>>>>> driver can detect that enable_fiq() is used.
>>>>>> Tested with downstream dwc_otg USB controller driver.
>>>>> This basically looks OK, but a few comments/thoughts:
>>>>> b) Doesn't the driver need to refuse some operation (handler
>>>>> registration, IRQ setup, IRQ enable, ...?) for more than 1 IRQ in the
>>>>> FIQ range, since the FIQ control register only allows routing 1 IRQ to
>>>>> FIQ.
>>>> claim_fiq() protects the FIQ. See d) answer below.
>>> That assumes the IRQ is "accessed" via the fiq-specific APIs. Since this
>>> patch changes the IRQ domain from having n IRQs to having 2*n IRQs, and
>>> doesn't do anything special to prevent clients from using IRQs n..2n-1
>>> via the existing IRQ APIs, it's quite possible the a buggy client would.
>> Yes, but doesn't this apply to all irq use, using the wrong one doesn't
>> work.
>> If FIQ's where in more common use, we might have seen a FIQ IRQ flag
>> instead
>> of special FIQ irqs.
>>
>>> (From another email):
>>>>>> c) The DT binding needs updating to describe the extra IRQs:
>>>>>>
>>>>>>> Documentation/devicetree/bindings/interrupt-controller/brcm,bcm28armctrl-ic.txt
>>>>>>>
>>>>> Ok.
>>>> I have seconds thoughts on this:
>>>> This patch does not change the DT bindings so I don't see what update
>>>> I should make. This patch only adds support for the Linux way of
>>>> handling FIQ's through enable_fiq(). It doesn't change how interrupts
>>>> are described in the DT.
>>> The intention of the patch may not be to expand the set of IRQs
>>> available via DT, but it does in practice. I think you need to add a
>>> custom of_xlate for the IRQ domain to ensure that only IRQs 0..n-1 can
>>> be translated from DT, and not IRQs n..2n-1. If you do that, then I
>>> agree that no DT binding update should be required.
>> armctrl_xlate() maps to the same hwirqs as before. This patch adds a
>> new range of hwirqs at the end of the "real" hwirq range.
>> It's not possible to get to these FIQ shadow hwirqs through DT.
> What prevents a DT from (incorrectly) referencing the extra hwirqs?

armctrl_xlate() has these limits:

if (WARN_ON(intspec[0] >= NR_BANKS))
if (WARN_ON(intspec[1] >= IRQS_PER_BANK))
if (WARN_ON(intspec[0] == 0 && intspec[1] >= NR_IRQS_BANK0))

Thus the maximum values allowed are:
intspec[0]: (NR_BANKS - 1) = 2
intspec[1]: (IRQS_PER_BANK - 1) = 31

This gives a maximum hwirq:
*out_hwirq = MAKE_HWIRQ(intspec[0], intspec[1]);
*out_hwirq = (2 << 5) | 31 = 95

The FIQ shadow hwirq range starts@96:
irq = irq_create_mapping(intc.domain, MAKE_HWIRQ(b, i) + NUMBER_IRQS);

NUMBER_IRQS = MAKE_HWIRQ(NR_BANKS, 0) = 96
