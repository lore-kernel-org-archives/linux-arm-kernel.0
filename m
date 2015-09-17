From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Sep 2015 17:21:11 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <CFF333D1-E771-4C50-902A-444DAE76C163@gmail.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150917111735.GN25444@e104818-lin.cambridge.arm.com>
 <3C2C78B3-4669-4DBA-98DC-362EB762FD9C@gmail.com>
 <CFF333D1-E771-4C50-902A-444DAE76C163@gmail.com>
Message-ID: <20150917162110.GO25444@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 10:22:26PM +0900, Jungseok Lee wrote:
> On Sep 17, 2015, at 10:17 PM, Jungseok Lee wrote:
> > On Sep 17, 2015, at 8:17 PM, Catalin Marinas wrote:
> >> On Sun, Sep 13, 2015 at 02:42:17PM +0000, Jungseok Lee wrote:
> >>> Currently, kernel context and interrupts are handled using a single
> >>> kernel stack navigated by sp_el1. This forces many systems to use
> >>> 16KB stack, not 8KB one. Low memory platforms naturally suffer from
> >>> memory pressure accompanied by performance degradation.
> >>> 
> >>> This patch addresses the issue as introducing a separate percpu IRQ
> >>> stack to handle both hard and soft interrupts with two ground rules:
> >>> 
> >>> - Utilize sp_el0 in EL1 context, which is not used currently
> >>> - Do not complicate current_thread_info calculation
> >>> 
> >>> It is a core concept to trace struct thread_info using sp_el0 instead
> >>> of sp_el1. This approach helps arm64 align with other architectures
> >>> regarding object_is_on_stack() without additional complexity.
> >> 
> >> I'm still trying to understand how this patch works. I initially thought
> >> that we would set SPSel = 0 while in kernel thread mode to make use of
> >> SP_EL0 but I can't find any such code. Do you still use SP_EL1 all the
> >> time and SP_EL0 just for temporary saving the thread stack?
> > 
> > Exactly.
> > 
> > My first approach was to set SPSel = 0 and implement EL1t Sync and IRQ.
> > This idea originally comes from your comment [1]. A kernel thread could
> > be handled easily and neatly, but it complicated current_thread_info
> > calculation due to a user process.
> > 
> > Let's assume that a kernel thread uses SP_EL0 by default. When an interrupt
> > comes in, a core jumps to EL1t IRQ. In case of a user process, a CPU goes
> > into EL1h IRQ when an interrupt raises. To handle this scenario correctly,
> > SPSel or spsr_el1 should be referenced. This reaches to quite big overhead
> > in current_thread_info function.
> 
> This statement is described incorrectly. In case of user process, a CPU goes
> into EL0 IRQ. Under this context, another interrupt could come in. At this
> time, a core jumps to EL1h IRQ.

I don't I entirely follow you here.

First of all, we don't allow re-entrant IRQs, they are disabled during
handling (there are patches for NMI via IRQ priorities but these would
be a special case on a different code path; for the current code, let's
just assume that IRQs are not re-entrant).

Second, SPSel is automatically set to 1 when taking an exception. So we
are guaranteed that the kernel entry code always switches to SP_EL1
(EL1h mode).

My initial thought was to populate SP_EL1 per CPU as a handler stack and
never change it afterwards. The entry code may continue to use SP_EL1 if
in interrupt or switch to SP_EL0 and SPSel = 0 if in thread context.
What I didn't realise is that SP_EL0 cannot be accessed directly when
SPSel == 0, only as SP. This indeed complicates current_thread_info
slightly.

I did some tests with using SPSel in current_thread_info() to read SP or
SP_EL0 and it doesn't look good, it increased the .text section by 132KB
(I may have been able to optimise it a bit but it is still quite large).
With your approach to always use sp_el0, I get about 4KB larger .text
section.

So, without any better suggestion for current_thread_info(), I'm giving
up the idea of using SPSel == 0 in the kernel. I'll look at your patch
in more detail. BTW, I don't think we need the any count for the irq
stack as we don't re-enter the same IRQ stack.

-- 
Catalin
