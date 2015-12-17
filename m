From: pmladek@suse.com (Petr Mladek)
Date: Thu, 17 Dec 2015 13:36:50 +0100
Subject: [RFC PATCH 0/3] livepatch: arm64: add support for livepatch on
 arm64
In-Reply-To: <5670FEF1.1040104@huawei.com>
References: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
 <20151215154356.GF3729@pathway.suse.cz>
 <5670FEF1.1040104@huawei.com>
Message-ID: <20151217123650.GB31777@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2015-12-16 14:04:33, Li Bin wrote:
> 
> 
> on 2015/12/15 23:43, Petr Mladek wrote:
> > On Mon 2015-12-14 20:49:35, Li Bin wrote:
> >> This patchset depends on the on-going gcc feature "-fprolog-pad=N",
> >> which will generate a pad of N nops at the beginning of each function.
> >>
> >> Livepatch on arm64 can using the feature (that always placing one nop
> >> at the beginning of the function). And when enable/disable func patching,
> >> just modify the pad code to nop or branch. And that NOP and B instruction
> >> are both safe instructions on arm64 which called "concurrent modification
> >> and execution of instructions", that can be executed by one thread of
> >> execution as they are being modified by another thread of execution without
> >> requiring explicit synchronization.
> >>
> >> And this method will improve performance significantly compared with the
> >> method based on ftrace, especially for the critical function being frequently
> >> called.
> > It sounds like a great feature for ftrace. If the new prologue is usable
> > for LivePatching, it should be usable to call the ftrace handler as
> > well. If you teach ftrace to use the new prologue, you will not need
> > all these crazy arch-specific hacks for LivePatching. Then both ftrace
> > and livepatch will benefit from the feature.
> >
> > I suggest to read the ftrace documentation in Documentation/trace/,
> > especially ftrace-design.txt. I have never ported ftrace to a new
> > architecture. I guess that you need to teach scripts/recordmcount.c
> >  to find the new location. Also you might need to update
> > arch/arm/kernel/ftrace.c. Also please make sure that ftrace
> > supports DYNAMIC_FTRACE_WITH_REGS on Arm.
> 
> Hi Petr,
> I had posted one method for livepatch implementaion on arm64 based on ftrace with
> DYNAMIC_FTRACE_WITH_REGS.
> https://lwn.net/Articles/646317/

I see. What are the plans with this patchset, please?


> This requires GCC changes to support it, and I propose a method that implement -mfentry
> feature which following some other arch such as x86/mips/s390 etc. This method is
> architecture-specific, and Maxim Kuvyrkov propose a new method for gcc that implement
> a target-independent option -fprolog-pad=N, which will generate a pad of N nops at the
> beginning of each function.
> https://gcc.gnu.org/ml/gcc/2015-05/msg00267.html
>
> And based on this, DYNAMIC_FTRACE_WITH_REGS feature can be implemented as
> mentioned in:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386815.html

What will happen if DYNAMIC_FTRACE_WITH_REGS is implemented using
-fprolog-pad=N, please? Will ftrace and livepatch try to modify the same
location? Or do you plan to revert all these changes then?


> And in this patchset, I only concern the performance for livepatch on arm64, and I
> hope this also can be resolved by improving ftrace, and thanks to Steve that he pointed
> that he is working on a way to make ftrace a bit better for livepatch.

What is the exact performance optimization? Is it that you call the
new functiion (from the patch) dirrectly instead of using the generic
ftrace handler? This will break once ftrace start using this location.
Also this will get more problematic once we have the consistency
mode as pointed out by Josh.

Please, note that there are currently three features that need to
modify the function entry code: Ftrace, Kprobes, and LivePatch.
They need to be coordinated. This is why also Kprobes are called via
Ftrace when available.

Your patch set looks like a temporary hack to me. I suggest you to
concentrace on implemention DYNAMIC_FTRACE_WITH_REGS on Arm. If you
are not happy with the ftrace performance, you might work on improving
it. All three features: Ftrace, Kprobes, and LivePatch will benefit
from it. Modyfying the code directly from LivePatch looks like a way
to a maintenance hell.

Best Regards,
Petr
