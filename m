From: james.morse@arm.com (James Morse)
Date: Fri, 02 Oct 2015 17:23:59 +0100
Subject: [PATCH v3] arm64: Introduce IRQ stack
In-Reply-To: <1442923918-11289-1-git-send-email-jungseoklee85@gmail.com>
References: <1442923918-11289-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <560EAF9F.6090604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/09/15 13:11, Jungseok Lee wrote:
> Currently, kernel context and interrupts are handled using a single
> kernel stack navigated by sp_el1. This forces a system to use 16KB
> stack, not 8KB one. This restriction makes low memory platforms suffer
> from memory pressure accompanied by performance degradation.
> 
> This patch addresses the issue as introducing a separate percpu IRQ
> stack to handle both hard and soft interrupts with two ground rules:
> 
>   - Utilize sp_el0 in EL1 context, which is not used currently
>   - Do not complicate current_thread_info calculation
> 
> It is a core concept to directly retrieve struct thread_info from
> sp_el0. This approach helps to prevent text section size from being
> increased largely as removing masking operation using THREAD_SIZE
> in tons of places.

One observed change in behaviour:
Any stack-unwinding now stops at el1_irq(), which is the bottom of the irq
stack. This shows up with perf (using incantation [0]), and with any calls
to dump_stack() (which actually stops the frame before el1_irq()).

I don't know if this will break something, (perf still seems to work) - but
it makes the panic() output less useful, as all the 'other' cpus print:

> CPU3: stopping
> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.3.0-rc3+ #223
> Hardware name: ARM Juno development board (r1) (DT)
> Call trace:
> [<ffff800000089878>] dump_backtrace+0x0/0x164
> [<ffff8000000899f8>] show_stack+0x1c/0x28
> [<ffff8000003134d0>] dump_stack+0x88/0xc8
> [<ffff80000008edcc>] handle_IPI+0x258/0x268
> [<ffff8000000824b8>] gic_handle_irq+0x88/0xa4
> Exception stack(0xffff8009769e3fc0 to 0xffff8009769e40e0)
> <...values from stack ...>
> CPU4: stopping
> CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.3.0-rc3+ #223
> Hardware name: ARM Juno development board (r1) (DT)
> Call trace:

So we don't get to see what they were doing, as the IPI-irq and subsequent
switch to the irq_stack hide the state.

I was trying to fix this with the other version, (see the changes to
kernel/stacktrace.c), but as Akashi Takahiro pointed out, I wasn't quite
right...

I will try to produce a fragment to tidy this up next week.


Thanks,

James

[0] perf record -e mem:<address of __do_softirq()>:x -ag -- sleep 10;
    perf report --call-graph --stdio
