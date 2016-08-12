From: panand@redhat.com (Pratyush Anand)
Date: Fri, 12 Aug 2016 18:16:56 +0530
Subject: [PATCH 3/4] arm64: kprobes: WARN if attempting to step with
 PSTATE.D=1
In-Reply-To: <20160810210401.e2bb53d1c9def874ba270f16@kernel.org>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
 <1468937260-23988-3-git-send-email-will.deacon@arm.com>
 <CAHB_Guonf6qc-yCr2oKDZgX+5q7qXJpSpLU3qafChrBkBqk7FA@mail.gmail.com>
 <20160809124832.GI27508@arm.com>
 <20160810080114.GB27500@localhost.localdomain>
 <20160810210401.e2bb53d1c9def874ba270f16@kernel.org>
Message-ID: <20160812124656.GA23836@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2016:09:04:01 PM, Masami Hiramatsu wrote:
> On Wed, 10 Aug 2016 13:31:14 +0530
> Pratyush Anand <panand@redhat.com> wrote:
> 
> > Hi Will,
> > 
> > Thanks for the reply.
> > 
> > On 09/08/2016:01:48:32 PM, Will Deacon wrote:
> > > On Wed, Aug 03, 2016 at 05:52:55PM +0530, Pratyush Anand wrote:
> > > > Hi Will,
> > > > 
> > > > Its already in torvalds/linux.git: master now. I have some related
> > > > queries, so thought to discuss it here.
> > > > 
> > > > On Tue, Jul 19, 2016 at 7:37 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > > > Stepping with PSTATE.D=1 is bad news. The step won't generate a debug
> > > > > exception and we'll likely walk off into random data structures. This
> > > > > should never happen, but when it does, it's a PITA to debug. Add a
> > > > 
> > > > But it happens in many know scenarios, like:
> > > > 
> > > > 1) We are executing a WARN_ON(), which will call `BRK  BUG_BRK_IMM`.
> > > > It prints warning messages through breakpoint handler. Now, suppose we
> > > > have a kprobe instrumented at a print function branch, say
> > > > print_worker_info(), we will land into
> > > > kprobe_handler()->setup_singlestep() with D-bit set. In this case if
> > > > we do not clear it, then we receive undefined exception before we
> > > > could get single step exception.
> 
> If the D-bit means debug trap flag for single-stepping,

Well, this is what my understanding is about D-bit. Will/Catalin can correct if
something is wrong.

PSTATE.D is debug exception mask bit. It is set whenever we enter into an
exception mode. When it is set then Watchpoint, Breakpoint, and Software Step
exceptions are masked. However, software Breakpoint Instruction exceptions can
never be masked. Therefore, if we ever execute a BRK instruction, irrespective
of D-bit setting, we will be receiving a corresponding  breakpoint exception.
For example:
- We are executing kprobe pre/post handler, and kprobe has been inserted in one
  of the instruction of a function called by handler. So, it executes BRK
  instruction and we land into the case of KPROBE_REENTER. (This case is already
  handled by current code)
- We are executing uprobe handler or any other BRK handler such as in WARN_ON,
  and we trace that path using kprobe.So, we enter into kprobe breakpoint
  handler,from another BRK handler.(This case is not being handled currently)

In all such cases kprobe breakpoint exception will be raised when we were
already in debug exception mode.
SPSR's D bit (bit 9) shows the value of PSTATE.D immediately before the
exception was taken.So, in above example cases we would find it set in kprobe
breakpoint handler.
Single step exception will always be followed by a kprobe breakpoint exception.
However, it will only be raised gracefully if we clear D bit while returning
from breakpoint exception. If D bit is set then, it results into undefined
exception and when it's handler enables dbg then single step exception is
generated, however it will never be handled(because address does not match and
therefore treated as unexpected).

> we need to store
> the flag in kprobe_ctlblk so that we can restore the previous state
> in post_kprobe handler.

I do not think that we need to save it, because irrespective of whether we clear
it in breakpoint handler, it will be found set again in kprobe single step
handler. So, while returning from kprobe single step handler, regs->pstate.D bit
will always be set.

> And also, if we found the kprobes in such state, we should skip it so that
> not involving any other functions, and if possible disable it forcibly if
> it is really dangerous.
> 
> > > > 
> > > > 2) Similarly, if we instrument kprobe at uprobe_breakpoint_handler()
> > > > (code not yet in upstream),  we land into similar situation which
> > > > leads to infinite "Unexpected kernel single-step exception at EL1".
> 
> It should be marked by NOKPROBE_SYMBOL.

I think, if we clear pstate.D in setup_singlestep unconditionally, then we do
not need to blacklist it. x86 allows to trace uprobe handler, so I think we can
do it for ARM64 as well.

> 
> > > > 
> > > > So, why can't we clear PSR_D_BIT in setup_singlestep unconditionally?
> > > > I found that both of the above issue is resolved by doing that.
> > > 
> > > I think that will work, but the advantage of the WARN_ON is that it can
> > > highlight cases where kprobes have been placed on the debug exception
> > > path, which is generally a Bad Idea as it can result in infinite recursion
> > > loops.
> > 
> > It might result in infinite recursion if we place kprobe at a function which is
> > called from kprobe breakpoint/single step handler.
> 
> For those functions we have to mark as blacklist by NOPROBE_SYMBOL() macro.

Yes, agreed.

> 
> > However, it should still be
> > OK if kprobe is placed in other debug exception path.
> 
> It depends on the architecture kprobe implementation, if we can not separate
> the debug exception path to the kprobe at very last part of the path, we
> can not probe that. So I recommend you to check it is kprobe or not at first.

When we are in setup_singlestep() then we are sure that its a kprobe breakpoint.
> 
> > Other arches like x86 allows that, so I think we will have to support as well.
> 
> Yes, actually on x86, we hook kprobes directly in do_int3.
> 
> > > 
> > > I know that __kprobes is supposed to deal with this, but in reality that's
> > > all a best guess and looks to be incomplete. If we can do a better job
> > > of annotating the debug exception path, I'd be up for unconditional
> > > clearing of PSR_D_BIT in the target when returning.
> > 
> > OK, so I will send a patch for review with proper comment logs for debug
> > exception path.
> 
> Could you also test it by using ftrace kprobe-trace interface and if you find
> any place where can cause infinit recursion, please put the function in blacklist.

OK, Will do.

Thanks for your suggestion and review of the proposal. It was helpful.

~Pratyush
