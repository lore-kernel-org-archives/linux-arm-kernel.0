From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Wed, 10 Aug 2016 21:04:01 +0900
Subject: [PATCH 3/4] arm64: kprobes: WARN if attempting to step with
 PSTATE.D=1
In-Reply-To: <20160810080114.GB27500@localhost.localdomain>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
 <1468937260-23988-3-git-send-email-will.deacon@arm.com>
 <CAHB_Guonf6qc-yCr2oKDZgX+5q7qXJpSpLU3qafChrBkBqk7FA@mail.gmail.com>
 <20160809124832.GI27508@arm.com>
 <20160810080114.GB27500@localhost.localdomain>
Message-ID: <20160810210401.e2bb53d1c9def874ba270f16@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2016 13:31:14 +0530
Pratyush Anand <panand@redhat.com> wrote:

> Hi Will,
> 
> Thanks for the reply.
> 
> On 09/08/2016:01:48:32 PM, Will Deacon wrote:
> > On Wed, Aug 03, 2016 at 05:52:55PM +0530, Pratyush Anand wrote:
> > > Hi Will,
> > > 
> > > Its already in torvalds/linux.git: master now. I have some related
> > > queries, so thought to discuss it here.
> > > 
> > > On Tue, Jul 19, 2016 at 7:37 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > > Stepping with PSTATE.D=1 is bad news. The step won't generate a debug
> > > > exception and we'll likely walk off into random data structures. This
> > > > should never happen, but when it does, it's a PITA to debug. Add a
> > > 
> > > But it happens in many know scenarios, like:
> > > 
> > > 1) We are executing a WARN_ON(), which will call `BRK  BUG_BRK_IMM`.
> > > It prints warning messages through breakpoint handler. Now, suppose we
> > > have a kprobe instrumented at a print function branch, say
> > > print_worker_info(), we will land into
> > > kprobe_handler()->setup_singlestep() with D-bit set. In this case if
> > > we do not clear it, then we receive undefined exception before we
> > > could get single step exception.

If the D-bit means debug trap flag for single-stepping, we need to store
the flag in kprobe_ctlblk so that we can restore the previous state
in post_kprobe handler.
And also, if we found the kprobes in such state, we should skip it so that
not involving any other functions, and if possible disable it forcibly if
it is really dangerous.

> > > 
> > > 2) Similarly, if we instrument kprobe at uprobe_breakpoint_handler()
> > > (code not yet in upstream),  we land into similar situation which
> > > leads to infinite "Unexpected kernel single-step exception at EL1".

It should be marked by NOKPROBE_SYMBOL.

> > > 
> > > So, why can't we clear PSR_D_BIT in setup_singlestep unconditionally?
> > > I found that both of the above issue is resolved by doing that.
> > 
> > I think that will work, but the advantage of the WARN_ON is that it can
> > highlight cases where kprobes have been placed on the debug exception
> > path, which is generally a Bad Idea as it can result in infinite recursion
> > loops.
> 
> It might result in infinite recursion if we place kprobe at a function which is
> called from kprobe breakpoint/single step handler.

For those functions we have to mark as blacklist by NOPROBE_SYMBOL() macro.

> However, it should still be
> OK if kprobe is placed in other debug exception path.

It depends on the architecture kprobe implementation, if we can not separate
the debug exception path to the kprobe at very last part of the path, we
can not probe that. So I recommend you to check it is kprobe or not at first.

> Other arches like x86 allows that, so I think we will have to support as well.

Yes, actually on x86, we hook kprobes directly in do_int3.

> > 
> > I know that __kprobes is supposed to deal with this, but in reality that's
> > all a best guess and looks to be incomplete. If we can do a better job
> > of annotating the debug exception path, I'd be up for unconditional
> > clearing of PSR_D_BIT in the target when returning.
> 
> OK, so I will send a patch for review with proper comment logs for debug
> exception path.

Could you also test it by using ftrace kprobe-trace interface and if you find
any place where can cause infinit recursion, please put the function in blacklist.

Thank you,


> 
> ~Pratyush


-- 
Masami Hiramatsu <mhiramat@kernel.org>
