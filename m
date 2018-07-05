From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Jul 2018 11:19:43 +0100
Subject: panic kexec broken on ARM64?
In-Reply-To: <20180705101326.GM28220@linaro.org>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
 <2865150f-ebca-4c6b-fc4b-93bfab5f0e91@arm.com>
 <86lgbm96dq.wl-marc.zyngier@arm.com> <20180703070106.GV23681@linaro.org>
 <86601wzn3h.wl-marc.zyngier@arm.com> <20180704084123.GC28220@linaro.org>
 <23306e9e-fec6-298d-af2d-018f63b06ab1@arm.com>
 <20180705101326.GM28220@linaro.org>
Message-ID: <a95ec854-ff32-c808-befe-b2db112f6c1e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/18 11:13, takahiro.akashi at linaro.org wrote:
> On Wed, Jul 04, 2018 at 10:02:24AM +0100, Marc Zyngier wrote:
>> On 04/07/18 09:41, takahiro.akashi at linaro.org wrote:
>>> On Tue, Jul 03, 2018 at 09:58:44AM +0100, Marc Zyngier wrote:
>>>> On 03/07/18 08:01, takahiro.akashi at linaro.org wrote:
>>>>> Marc, James,
>>>>>
>>>>> I'd like to re-ignite the discussion.
>>>>>
>>>>> On Sun, Jun 10, 2018 at 01:24:17PM +0100, Marc Zyngier wrote:
>>>>>> On Wed, 06 Jun 2018 12:37:02 +0100,
>>>>>> James Morse wrote:
>>>>>>>
>>>>>>> Hi Stefan,
>>>>>>>
>>>>>>> On 06/06/18 08:02, Stefan Wahren wrote:
>>>>>>>> Am 05.06.2018 um 19:46 schrieb James Morse:
>>>>>>>>> On 05/06/18 09:01, Petr Tesarik wrote:
>>>>>>>>>> I attached a hardware debugger and found
>>>>>>>>>> out that all CPU cores were stopped except one which was stuck in the
>>>>>>>>>> idle thread. It seems that irq_set_irqchip_state() may sleep, which is
>>>>>>>>>> definitely not safe after a kernel panic.
>>>>>>>
>>>>>>>>> I don't know much about irqchip stuff, but __irq_get_desc_lock() takes a
>>>>>>>>> raw_spin_lock(), and calls gic_irq_get_irqchip_state() which is just poking
>>>>>>>>> around in mmio registers, this should all be safe unless you re-entered the same
>>>>>>>>> code.
>>>>>>>
>>>>>>>>>> If I'm right, then this is broken in general, but I have only ever seen
>>>>>>>>>> it on RPi 3 Model B+ (even RPi3 Model B works fine), so the issue may
>>>>>>>>>> be more subtle.
>>>>>>>
>>>>>>>>> Is there a hardware difference around the interrupt controller on these?
>>>>>>>
>>>>>>>> No, but the RPi 3 B has a different USB network chip on board (smsc95xx, Fast
>>>>>>>> ethernet) instead of lan78xx (Gigabit ethernet).
>>>>>>>
>>>>>>> Bingo: its the lan78xx driver that is sleeping from the irqchip
>>>>>>> callbacks; The smsc95xx driver doesn't have a struct irq_chip, which
>>>>>>> is why the RPi-3-B doesn't do this.
>>>>>>>
>>>>>>> It may be valid for kdump to only teardown the 'root irqdomain' (if
>>>>>>> that even means anything). I assume these secondary irqchip's would
>>>>>>> have a summary-interrupt that goes to another irqchip. But I can't
>>>>>>> see a way to tell them apart..,
>>>>>>
>>>>>> There is none. A cascaded irqchip is just like a root irqchip, just
>>>>>> that its output line is connected to another irqchip. But we have no
>>>>>> easy way to identify the parent. Also, this particular driver looks
>>>>>> quite creative (it reinvents the wheel for chained interrupts -- see
>>>>>> intr_complete and lan78xx_status), meaning that even if we could have
>>>>>> a magic way of identify a chained irqchip, we'd miss that one. Broken.
>>>>>>
>>>>>>> I think we need to wait until after the merge window for Marc's
>>>>>>> wisdom on this!
>>>>>>
>>>>>> Overall, I can't think of an easy fix. We have a few options, but none
>>>>>> of them involve a centralised change:
>>>>>>
>>>>>> 1) We provide a reset infrastructure for irqchips, with an opt-in
>>>>>>    mechanism. This involves changing the way we teardown irqs at
>>>>>>    crash-time, and we'd then need some notion of reset ordering (think
>>>>>>    of the layered ITS and GICv3, for example).
>>>>>
>>>>> Does this mean that all the irqchips have to be implemented with reset?
>>>>
>>>> No. Only those that want to be reset at kexec time.
>>>
>>> I don't get the point yet. Who should have reset interface?
>>> What is the criteria?
>>
>> The criteria is "this irqchip requires a reset to be safely used in the
>> secondary kernel". This is a judgement call from the person writing the
>> driver.
> 
> This doesn't tell me anything more than "do it if you need it."
> So let me ask you in other words.
> Does gic driver need to provide a reset function?
> Whether yes or no, why do you think so?

Because I know the architecture and I can assess that it needs it. Case
in point: The RDs have memory tables. kexec without disabling LPIs, and
you end-up with memory corruption.

Sorry, but there is no magic bullet. You have to understand what you're
doing.

> 
>>
>>>
>>>>>>
>>>>>> 2) We provide a way to identify interrupts that are ultimately backed
>>>>>>    by a root controller, which implies walking down the hierarchy for
>>>>>
>>>>> To be clear, from bottom to top (or root), right?
>>>>
>>>> I'm not sure I understand your question. The idea is to walk the
>>>> irq_data chain, until we hit a root irqchip. If we do hit one, we
>>>> deactivate/eoi/disable this interrupt. If we don't, we do nothing.
>>>
>>> I thought that we would traverse the (chained irq) hierarchy from
>>> bottom to top and call deactivate or others in that order.
>>> Am I wrong here?
>>
>> You *cannot* traverse a hierarchy through a chained irq. At that stage,
>> irq_data->parent_data is NULL.
> 
> What do you mean by "at that stage?"

At the point you reach a secondary interrupt controller that exposese a
chained IRQ.

> In your patch, "genirq: Add predicate for irq served by root irqchip,"
> irq_irqchip_is_root() dereferences its parent_data.

And? Hierarchies and chained controllers are two orthogonal concepts.
You can have a hierarchy on top of a chained controller, and that
doesn't make it a root controller.

	M.
-- 
Jazz is not dead. It just smells funny...
