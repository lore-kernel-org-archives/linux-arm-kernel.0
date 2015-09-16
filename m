From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Sep 2015 18:16:50 +0100
Subject: Regression by 01f779f4862b ("irqchip/GIC: Don't deactivate
 interrupts forwarded to a guest")
In-Reply-To: <20150917011021.0460792d@xhacker>
References: <20150917003202.498ff83c@xhacker>	<alpine.DEB.2.11.1509161851330.3951@nanos>	<20150917005908.111c00ca@xhacker>
 <20150917011021.0460792d@xhacker>
Message-ID: <55F9A402.1060408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/15 18:10, Jisheng Zhang wrote:
> Dear Thomas,
> 
> On Thu, 17 Sep 2015 00:59:08 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
>> On Wed, 16 Sep 2015 18:52:41 +0200
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>> On Thu, 17 Sep 2015, Jisheng Zhang wrote:
>>>
>>>> Hi Marc,
>>>>
>>>> Commit 01f779f4862b ("irqchip/GIC: Don't deactivate interrupts forwarded to a
>>>> guest") causes a regression on Marvell BG4CT SoC. In this SoC, there's only one
>>>> GIC, the secondary irq controller is Synopsys DW iCtl:
>>>> drivers/irqchip/irq-dw-apb-ictl.c
>>>>
>>>> So cascading_gic_irq() should return true on Marvell BG4CT SoC, but it returns
>>>> false. The logic in cascading_gic_irq() doesn't take cascaded irq controller
>>>> which is provided by non-gic controllers.
>>>
>>> I have a fix pending for this in
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.irq
>>>
>>> 714665351cc7: irqchip/gic: Use IRQD_FORWARDED_TO_VCPU flag
>>>
>>> Can you please give that a try?
>>
>> Sure, Will try and get back to you
> 
> Good news! The regression is fixed, cascaded irq works again!
> 
> Feel free to add
> 
> Tested-by: Jisheng Zhang <jszhang@marvell.com>

Ah, excellent. Probably a case of handler_data being reused... Thanks a
lot for testing this!

	M.
-- 
Jazz is not dead. It just smells funny...
