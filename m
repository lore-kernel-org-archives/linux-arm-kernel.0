From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Apr 2012 01:21:32 +0200
Subject: [PATCH 2/3] plat-versatile: modernize FPGA IRQ controller
In-Reply-To: <20120411230319.GE24211@n2100.arm.linux.org.uk>
References: <1334184240-18898-1-git-send-email-linus.walleij@linaro.org>
 <20120411230319.GE24211@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZkNHodkpGZ9q+yNDqphgx7Bfa5veaCP9kub=FMqqmKOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 1:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 12, 2012 at 12:44:00AM +0200, Linus Walleij wrote:
>> @@ -12,10 +15,14 @@
>> ?#define IRQ_ENABLE_SET ? ? ? ? ? ? ? 0x08
>> ?#define IRQ_ENABLE_CLEAR ? ? 0x0c
>>
>> +/* we cannot allocate memory when VICs are initially registered */
>
> They aren't VICs. ?A VIC is a totally different interrupt controller.

OK copy/paste error...

>> + ? ? u32 mask = (1 << d->hwirq);
>
> 1 << d->hwirq will do, no need for excessive parens here.

OK

>> +static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
>> ?{
>> + ? ? int handled = 0;
>> + ? ? int irq;
>> + ? ? u32 status = readl(f->base + IRQ_STATUS);
>> +
>> + ? ? while (status) {
>> + ? ? ? ? ? ? irq = ffs(status) - 1;
>> + ? ? ? ? ? ? handle_IRQ(irq_find_mapping(f->domain, irq), regs);
>> + ? ? ? ? ? ? status &= ~(1 << irq);
>> + ? ? ? ? ? ? handled = 1;
>> + ? ? }
>> +
>> + ? ? return handled;
>
> Buggy. ?See what happens when you cache the status register, and
> handle_IRQ enables interrupts after processing the first IRQ to do
> soft IRQ processing.

Hm the code is exactly the same as in arch/arm/common/vic.c
I guess once we figure this loop out we may need to go back and
fix that driver also so good that we bring it up.

Anyway, IIRC the VIC was written that way since it will traverse
all IRQs once, if there are remaining IRQs after that these are
treated from this outer loop in the per-instance handler:

asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
{
	int i, handled;

	do {
		for (i = 0, handled = 0; i < fpga_irq_id; ++i)
			handled |= handle_one_fpga(&fpga_irq_devices[i], regs);
	} while (handled);
}

This will traverse all flags on all controllers until all flags are low so all
handlers get chance to run. (i.e. IRQ0 on controller 0 cannot lock others
out.)

It always looked sane to me, but what am I not getting here...

Thanks,
Linus Walleij
