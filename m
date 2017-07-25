From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jul 2017 14:25:51 +0100
Subject: [PATCH V2 4/4] arm64: disable irq between breakpoint and step
 exception
In-Reply-To: <8f9c3073792c107e3d928e413499572ec75c5175.1499416107.git.panand@redhat.com>
References: <cover.1499416107.git.panand@redhat.com>
 <8f9c3073792c107e3d928e413499572ec75c5175.1499416107.git.panand@redhat.com>
Message-ID: <20170725132551.GB28815@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 05:34:00PM +0530, Pratyush Anand wrote:
> If an interrupt is generated between breakpoint and step handler then
> step handler can not get correct step address. This situation can easily
> be invoked by samples/hw_breakpoint/data_breakpoint.c. It can also be
> reproduced if we insert any printk() statement or dump_stack() in perf
> overflow_handler. So, it seems that perf is working fine just luckily.
> If the CPU which is handling perf breakpoint handler receives any
> interrupt then, perf step handler will not execute sanely.
> 
> This patch improves do_debug_exception() handling, which enforces now,
> that exception handler function:
> - should return 0 for any software breakpoint and hw
> breakpoint/watchpoint handler if it does not expect a single step stage
> - should return 1 if it expects single step.
> - A single step handler should always return 0.
> - All handler should return a -ve error in any other case.
> 
> Now, we can know in do_debug_exception() that whether a step exception
> will be followed or not. If there will a step exception then disable
> irq. Re-enable it after single step handling.

AFAICT, this is only a problem for kernel-mode breakpoints where we end up
stepping into the interrupt handler when trying to step over a breakpoint.

We'd probably be better off getting all users of kernel step (kprobes, kgdb
and perf) to run the step with irqs disabled, but I still have reservations
about that:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/508066.html
  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/510814.html

Wouldn't it be better to follow kprobes/kgdb and have perf run the step with
irqs disabled?

Will
