From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 15:40:34 +0100
Subject: [RFC][PATCH 6/8] sched,idle: Avoid spurious wakeup IPIs
In-Reply-To: <20140509141520.GV2844@laptop.programming.kicks-ass.net>
References: <20140411134243.160989490@infradead.org>
 <20140411135218.478299389@infradead.org>
 <CAAG0J9_q1KsUx10-XAb7AJnxv2ehctg6q1KME7ahsk1OZV8vZQ@mail.gmail.com>
 <20140509141520.GV2844@laptop.programming.kicks-ass.net>
Message-ID: <20140509144034.GF7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, May 09, 2014 at 03:15:20PM +0100, Peter Zijlstra wrote:
> On Fri, May 09, 2014 at 02:37:27PM +0100, James Hogan wrote:
> > On 11 April 2014 14:42, Peter Zijlstra <peterz@infradead.org> wrote:
> > > +       return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
> > 
> > This breaks the build on metag, and I suspect arm64 too:
> 
> Yep, I just got a patch for arm64.

[...]

> Any SMP arch that has a polling idle function of any kind (including the
> default cpu_idle_poll()).
> 
> That said, even if that's true, not having TIF_POLLING_NRFLAG isn't
> fatal, just sub-optimal in that we'll send an unconditional IPI to wake
> the CPU even though its polling TIF_NEED_RESCHED and doesn't need
> anything other than that write to wake up.
> 
> Most archs have (x86) hlt or (arm) wfi like idle instructions, and if
> that is your only possible idle function, you'll require the interrupt
> to wake up and there's really no point to having the POLLING bit.

I wonder why we still need TIF_POLLING_NRFLAG for arm64. It was on arm
until commit 16a8016372c42c7628eb (sanitize tsk_is_polling()). On arm64
we use wfi for idle or a firmware call but in both cases the assumption
is that we need an interrupt for waking up.

So I think we should remove this macro for arm64.

-- 
Catalin
