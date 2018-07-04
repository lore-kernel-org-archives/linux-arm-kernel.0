From: james.morse@arm.com (James Morse)
Date: Wed, 4 Jul 2018 13:47:11 +0100
Subject: panic kexec broken on ARM64?
In-Reply-To: <20180704084123.GC28220@linaro.org>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
 <2865150f-ebca-4c6b-fc4b-93bfab5f0e91@arm.com>
 <86lgbm96dq.wl-marc.zyngier@arm.com> <20180703070106.GV23681@linaro.org>
 <86601wzn3h.wl-marc.zyngier@arm.com> <20180704084123.GC28220@linaro.org>
Message-ID: <3df2d32d-867b-2237-d2a0-9fd6d7302eb3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 04/07/18 09:41, takahiro.akashi at linaro.org wrote:
> On Tue, Jul 03, 2018 at 09:58:44AM +0100, Marc Zyngier wrote:
>> On 03/07/18 08:01, takahiro.akashi at linaro.org wrote:
>>> On Sun, Jun 10, 2018 at 01:24:17PM +0100, Marc Zyngier wrote:
>>>> On Wed, 06 Jun 2018 12:37:02 +0100 James Morse wrote:,
>>>>> Bingo: its the lan78xx driver that is sleeping from the irqchip
>>>>> callbacks; The smsc95xx driver doesn't have a struct irq_chip, which
>>>>> is why the RPi-3-B doesn't do this.
>>>>>
>>>>> It may be valid for kdump to only teardown the 'root irqdomain' (if
>>>>> that even means anything). I assume these secondary irqchip's would
>>>>> have a summary-interrupt that goes to another irqchip. But I can't
>>>>> see a way to tell them apart..,

>>>> Overall, I can't think of an easy fix. We have a few options, but none
>>>> of them involve a centralised change:
>>>>
>>>> 1) We provide a reset infrastructure for irqchips, with an opt-in
>>>>    mechanism. This involves changing the way we teardown irqs at
>>>>    crash-time, and we'd then need some notion of reset ordering (think
>>>>    of the layered ITS and GICv3, for example).
>>>
>>> Does this mean that all the irqchips have to be implemented with reset?
>>
>> No. Only those that want to be reset at kexec time.
> 
> I don't get the point yet.

(this stuff is new to me, below terminology is probably wrong:)

It seems there is actually a tree of irqchips, which feed interrupts through the
tree via some summary-interrupt.
The problem is one of these later-irqchips is on the other end of the USB bus,
and requires a fair amount of sleeping in order to reset it.

The trick is everything comes through the root irqchip. So we can reset that to
disable all the other interrupts in this tree.

This only works until the new kernel re-enables the summary-interrupt, it needs
to reset the irqchip that the summary-interrupt leads to first.

(I assume shared summary-interrupts are somehow forbidden).


> Who should have reset interface?
> What is the criteria?

(reset-interface -> be reset at kdump time)

Just the root irchip that all interrupts have to come through.


Thanks,

James
