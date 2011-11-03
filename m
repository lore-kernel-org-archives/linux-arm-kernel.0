From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Nov 2011 13:29:08 +0100
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20111102140811.GA22491@totoro>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
	<20111102134024.GE19187@n2100.arm.linux.org.uk>
	<20111102140811.GA22491@totoro>
Message-ID: <CACRpkdY+EBkHfupO5T4SYKPxzX2L2kr8fLVMJK=JctNeYAzn2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 2, 2011 at 3:08 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> On Wed, Nov 02, 2011 at 01:40:24PM +0000, Russell King - ARM Linux wrote:
>>
>> And if we receive another interrupt after the read of the register, we'll
>> have to exit all the way back (possibly to userspace) before re-entering
>> the IRQ handling paths back to this point to process it.
>
> OK, so how about something like this instead:
>
> static int vic_single_handle_irq(struct vic_device *vic,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct pt_regs *regs)

Is it single really? This handles all active IRQs on the VIC instance.
Can it be renamed vic_handle_irq()?

> {
> ? ? ? ?u32 stat, irq;
> ? ? ? ?int handled = 0;
>
> ? ? ? ?stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> ? ? ? ?while (stat) {
> ? ? ? ? ? ? ? ?irq = ffs(stat) - 1;
> ? ? ? ? ? ? ? ?handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> ? ? ? ? ? ? ? ?stat &= ~(1 << irq);
> ? ? ? ? ? ? ? ?handled = 1;
> ? ? ? ?}
>
> ? ? ? ?return handled;
> }

No, if we receive another IRQ *after* the read of the register was the
question, right?

Just replace

stat &= ~(1 << irq);

with a second

stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);

It'll work just fine, the IRQ line should be low when you read
it the second time, else it is probably fully proper to call
the IRQ handler again anyway.

Just my ?0.01..
Linus Walleij
