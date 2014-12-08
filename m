From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 08 Dec 2014 11:18:12 +0000
Subject: [PATCH 09/16] ARM: imx6: convert wakeupgen to stacked domains
In-Reply-To: <67e8ccd2cb9fbcc3598904a441c8a2d0@agner.ch>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
 <1417539497-20101-10-git-send-email-marc.zyngier@arm.com>
 <67e8ccd2cb9fbcc3598904a441c8a2d0@agner.ch>
Message-ID: <548588F4.6060309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephan,

On 06/12/14 16:08, Stefan Agner wrote:
> On 2014-12-02 17:58, Marc Zyngier wrote:
>> IMX6 has been (ab)using the gic_arch_extn to provide
>> wakeup from suspend, and it makes a lot of sense to convert
>> this code to use stacked domains instead.
>>
>> This patch does just this, updating the DT files to actually
>> reflect what the HW provides.
>>
>> BIG FAT WARNING: because the DTs were so far lying by not
>> exposing the fact that the GPC block is actually the first
>> interrupt controller in the chain, kernels with this patch
>> applied wont have any suspend-resume facility when booted
>> with old DTs, and old kernels with updated DTs won't even boot.
>>
> 
> Not sure this is entirely true. I don't think that GPC block is really
> in the chain of the interrupts for normal interrupt delivery. This is
> tested to be _not_ true for Vybird (which has also a GPC block and seems
> to be quite similar). I can mask an interrupt in GPC_IMR2 for instance
> and it still gets delivered to the GIC. However, the registers need to
> be unmasked to deliver wake-up events.

Well, if it has an influence on the delivery of interrupts in the
wake-up case, we need to take care of it.

> In the GPC_IMRx register description of Vybrid this sentence actually
> states what I observe: "This register is used to mask certain interrupts
> if they are not desired to be a source of
> wake up during STOP mode.". However, this sentence is not there in the
> i.MX6 RM. But the drawing in Chapter 27.1 (GPC, Overview) suggests to
> me, that it is implemented like I see it in Vybrid. So I'm not
> completely sure about this, and I don't have hardware handy to test
> this...

My copy of the TRM has the following wording: "GPC determines wake-up
irq for exiting STOP mode", and the diagram just below has some
indication of the interrupts being used to generate a wake-up signal.

> I'm aware that the code did something different before. Not sure whether
> this refactoring would look differently if my suspicion holds true. I
> guess even if it is only wake-up capabilities, we would use stacked IRQ
> domain and just implement the wake-up part...?

Very much so. My (limited) understanding of the HW:
- GPC is placed before the GIC, and derives a wake-up signal based on a
mask and an enable signal (most probably the STOP state).
- It always forwards interrupts to the GIC.
- When STOP is asserted, the GIC is offline

So we can see this as either
- two parallel interrupt controllers
- two cascaded interrupt controllers

The first case cannot be represented in DT (an interrupt can only have a
single interrupt parent). so we're left with the second option, which is
a good enough approximation IMHO. Better than not describing it, anyway.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
