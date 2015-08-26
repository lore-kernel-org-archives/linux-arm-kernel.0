From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 26 Aug 2015 09:52:16 +0100
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1508252123310.15006@nanos>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <55DC3452.3070205@arm.com>
 <CY1PR0301MB08439B6C5F841AFFD152DFD883610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC738D.8000302@arm.com>
 <CY1PR0301MB0843AE566996617D855CC00683610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC7FA4.7040902@arm.com>
 <CY1PR0301MB08433A2659C75028821F0AE783610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC96BA.2020905@arm.com> <alpine.DEB.2.11.1508252123310.15006@nanos>
Message-ID: <55DD7E40.1040009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 25/08/15 20:26, Thomas Gleixner wrote:
> On Tue, 25 Aug 2015, Sudeep Holla wrote:
>> On 25/08/15 15:54, Shenwei Wang wrote:
>>> You don't really understand what happens after a driver calls
>>> enable_irq_wake. In suspend state, even the interrupt
>>> controller itself is powered off. How can you get the system up
>>> again  by just using a SKIP_SET_WAKE.
>>
>> Sorry for that, let me try to understand aloud. So you have
>> irq_{un,}mask function that are called when interrupts are enabled and
>> disabled. So suppose you have 3 irqs that are enabled and only one of
>> then is set as wakeup source.
>>
>> Now you call enable_irq_wake, you save that in wakeup_sources, fine.
>> Later when you enter suspend, you save all the 3 active irqs in
>> saved_irq_mask and over-write cpu2wakeup with wakeup_sources, right?
>>
>> All fine, what I am saying is let irq-core know that you want to mask
>> the 2 non-wakeup irqs you have using MASK_ON_SUSPEND. So when
>> suspend_device_irqs is called in suspend path, that's done for you
>> automatically and the cpu2wakeup will have just 1 wakeup enabled which
>> is what you are doing in suspend callback, right ?
>
> I missed that when I reviewed the patch. You are right, it can be
> simplified.
>
>> Now that it's already done for you, you need not do anything extra and
>> hence just set SKIP_SET_WAKE to do nothing.

Thanks for confirming this.

>
> He still needs the set_wake function to capture the wake enabled
> interrupts as they are handed over to the low level asm code via
> imx_gpcv2_get_wakeup_source(). Though they could be read back from the
> hw registers as well.
>

Correct, I have no objection on how it's saved/restored but was against
having 2 different masks and with the approach taken in this patch the
non-wakeup interrupts are enabled until syscore_suspend which is wrong.

There's whole lot of drivers blindly copy pasting this as theme which I
am going through and trying to clean up. I wanted to ensure no more such
additions happen meanwhile, so I am watching such patches closely.

Regards,
Sudeep
