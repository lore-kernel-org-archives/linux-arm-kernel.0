From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Aug 2016 13:48:32 +0100
Subject: [PATCH 3/4] arm64: kprobes: WARN if attempting to step with
 PSTATE.D=1
In-Reply-To: <CAHB_Guonf6qc-yCr2oKDZgX+5q7qXJpSpLU3qafChrBkBqk7FA@mail.gmail.com>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
 <1468937260-23988-3-git-send-email-will.deacon@arm.com>
 <CAHB_Guonf6qc-yCr2oKDZgX+5q7qXJpSpLU3qafChrBkBqk7FA@mail.gmail.com>
Message-ID: <20160809124832.GI27508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 05:52:55PM +0530, Pratyush Anand wrote:
> Hi Will,
> 
> Its already in torvalds/linux.git: master now. I have some related
> queries, so thought to discuss it here.
> 
> On Tue, Jul 19, 2016 at 7:37 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Stepping with PSTATE.D=1 is bad news. The step won't generate a debug
> > exception and we'll likely walk off into random data structures. This
> > should never happen, but when it does, it's a PITA to debug. Add a
> 
> But it happens in many know scenarios, like:
> 
> 1) We are executing a WARN_ON(), which will call `BRK  BUG_BRK_IMM`.
> It prints warning messages through breakpoint handler. Now, suppose we
> have a kprobe instrumented at a print function branch, say
> print_worker_info(), we will land into
> kprobe_handler()->setup_singlestep() with D-bit set. In this case if
> we do not clear it, then we receive undefined exception before we
> could get single step exception.
> 
> 2) Similarly, if we instrument kprobe at uprobe_breakpoint_handler()
> (code not yet in upstream),  we land into similar situation which
> leads to infinite "Unexpected kernel single-step exception at EL1".
> 
> So, why can't we clear PSR_D_BIT in setup_singlestep unconditionally?
> I found that both of the above issue is resolved by doing that.

I think that will work, but the advantage of the WARN_ON is that it can
highlight cases where kprobes have been placed on the debug exception
path, which is generally a Bad Idea as it can result in infinite recursion
loops.

I know that __kprobes is supposed to deal with this, but in reality that's
all a best guess and looks to be incomplete. If we can do a better job
of annotating the debug exception path, I'd be up for unconditional
clearing of PSR_D_BIT in the target when returning.

Will
