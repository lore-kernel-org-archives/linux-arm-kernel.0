From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Apr 2012 00:34:09 +0100
Subject: [PATCH 2/3] plat-versatile: modernize FPGA IRQ controller
In-Reply-To: <CACRpkdZkNHodkpGZ9q+yNDqphgx7Bfa5veaCP9kub=FMqqmKOA@mail.gmail.com>
References: <1334184240-18898-1-git-send-email-linus.walleij@linaro.org>
 <20120411230319.GE24211@n2100.arm.linux.org.uk>
 <CACRpkdZkNHodkpGZ9q+yNDqphgx7Bfa5veaCP9kub=FMqqmKOA@mail.gmail.com>
Message-ID: <20120413233409.GP24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 01:21:32AM +0200, Linus Walleij wrote:
> On Thu, Apr 12, 2012 at 1:03 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Apr 12, 2012 at 12:44:00AM +0200, Linus Walleij wrote:
> >> +static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
> >> ?{
> >> + ? ? int handled = 0;
> >> + ? ? int irq;
> >> + ? ? u32 status = readl(f->base + IRQ_STATUS);
> >> +
> >> + ? ? while (status) {
> >> + ? ? ? ? ? ? irq = ffs(status) - 1;
> >> + ? ? ? ? ? ? handle_IRQ(irq_find_mapping(f->domain, irq), regs);
> >> + ? ? ? ? ? ? status &= ~(1 << irq);
> >> + ? ? ? ? ? ? handled = 1;
> >> + ? ? }
> >> +
> >> + ? ? return handled;
> >
> > Buggy. ?See what happens when you cache the status register, and
> > handle_IRQ enables interrupts after processing the first IRQ to do
> > soft IRQ processing.
> 
> Hm the code is exactly the same as in arch/arm/common/vic.c
> I guess once we figure this loop out we may need to go back and
> fix that driver also so good that we bring it up.
> 
> Anyway, IIRC the VIC was written that way since it will traverse
> all IRQs once, if there are remaining IRQs after that these are
> treated from this outer loop in the per-instance handler:
> 
> asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
> {
> 	int i, handled;
> 
> 	do {
> 		for (i = 0, handled = 0; i < fpga_irq_id; ++i)
> 			handled |= handle_one_fpga(&fpga_irq_devices[i], regs);
> 	} while (handled);
> }
> 
> This will traverse all flags on all controllers until all flags are low so all
> handlers get chance to run. (i.e. IRQ0 on controller 0 cannot lock others
> out.)
> 
> It always looked sane to me, but what am I not getting here...

See http://lists.arm.linux.org.uk/lurker/message/20120402.214614.e7740b12.en.html

and the rest of that thread.
