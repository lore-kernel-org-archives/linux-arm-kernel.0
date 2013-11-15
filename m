From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 16:59:39 +0000
Subject: Some question about GIC v1 setting
In-Reply-To: <CANudz+sg6MiUZaTELF4G=NMfwj--K9j10JrYh1cm2VAjfvq6MA@mail.gmail.com>
References: <CANudz+sg6MiUZaTELF4G=NMfwj--K9j10JrYh1cm2VAjfvq6MA@mail.gmail.com>
Message-ID: <20131115165939.GO16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 12:55:11AM +0800, loody wrote:
> hi all:
> I use arm cortex A9 smp with GIC v1 system.
> And my kernel is 3.8.13.
> 
> I have some questions:
> 1.  From GIc v1 spec, we can modify irq priority.
>      (ICDIPRn, Interrupt Priority Rigisters)
>      how could we do that in kernel? Did kernel provide any API of Irq
> to reach that goal?

No.  It's pointless.  The kernel doesn't support interrupting one IRQ
while another is already in progress.

> 2. From Gic V1 spec, we can assign 1 irq to multi-core.
>      (ICDIPTRn, Interrupt Processor Targets Registers)
>      Is there similar API in kernel to let 1 irq possibility to be
> handled by multi-cores?

No.  All that does is lead to cores being woken up and racing on locks,
and then causing IRQs to be spuriously marked as false (because there's
nothing for the handlers to do on the cores which lost out).

If you want to redirect IRQs to different cores, run the userspace
irqbalance daemon.
