From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 12 Sep 2016 12:17:53 +0100
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
 <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
 <20160909152047.GA3958@e103592.cambridge.arm.com>
 <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
Message-ID: <20160912111749.GB3958@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 07:01:12PM +0200, Florian Weimer wrote:
> On 09/09/2016 05:21 PM, Dave Martin wrote:
> 
> >>Do you add this extra information only if the stack is sufficiently large?
> >>
> >>x86_64 adds the new information even for small stacks set up with
> >>sigaltstack, leading to memory corruption on bleeding-edge hardware:
> >>
> >>  <https://bugzilla.kernel.org/show_bug.cgi?id=153531>
> >
> >Hmmm, not yet.  We already check that the whole frame is writable user
> >memory, but this isn't sufficient to avoid user corruption in the case
> >of alternate signal stacks.  I'll fix this -- thanks for flagging it.
> >
> >If the stack isn't large enough, we'll still have to SEGV the task
> >though.
> 
> You could skip copying the data and not install a pointer to it in the
> existing signal context.

We could, but then we'd corrupt the task state in sigreturn, since
we wouldn't have been able to save/restore part of the state.

> >We can (and should) bump up the SIG{,MIN}STKSZ constants when adding
> >the SVE support proper to the kernel,
> 
> That's a userspace ABI change (libraries use these constants to size struct
> members), and not a good idea.  You might get away with at this stage, but
> you can't do this every time you add some new process state you want to add
> to signal handlers.

For internal interfaces within a single component that's tolerable,
since a single value would be used for each of these constants
throughout the build of that component.

A quick search on sources.debian.org suggests that the total number of
packages that expose {,MIN}SIGSTKSZ dependent definitions in their
public interfaces is small (I couldn't find any after paging through
dozens of pages of results -- so the total is maybe in the range 0-10)
-- hopefully few enough to eyeball.


> >I wonder whether we should make the signal stack size runtime
> >discoverable through sysconf() instead...

I will likely suggest this for the future, but of course it doesn't help
for current binaries.


Note that MINSIGSTKSZ stared life wrong for arm64, and has since gone
through a few ABI breaking changes.  I don't condone this, but we have
form in this area :/

sigaltstack() already fails with ENOMEM for software that passes
ss_size = MINSIGSTKSZ, and is built against glibc<2.22 [1], [2], running
on linux>=4.3 [3], which is an ABI break in case where sigaltstack() is
otherwise guaranteed to succeed.


The bottom line here is that the sigaltstack() API is broken with regard
to extensibility, so we cannot extend the amount of signal state without
breaking something.


The least-wrong thing I can think of to do is:

* deprecate but continue to support the existing sigaltstack API/ABI
with today's {,MIN}SIGSTKSZ definitions

* guarantee (as much as possible) that software using this ABI continues
to work (by saving/restoring only data that _must_ be saved/restored at
each signal, which may be small enough to fit)

* providing a clean failure mode (fatal signal) when this proves
impossible at signal delivery/return time;

* define a new interface for runtime-querying the required signal stack
size;

* define a new syscall or new stack_t.ss_flags flags (say, SS_STRICT)
that permits the kernel to enforce a runtime-determined minimum greater
than MINSIGSTKSZ when calling sigaltstack().


Another option would be:

* define a new interface for runtime-querying the required signal stack
size, and

* support the current API/ABI, but make a call to sigaltstack() SEGV or
SIGILL the caller if it specifies ss_stack >= MINSIGSTKSZ but smaller
than the actual runtime minimum.

(this would cause old software to break immediately in an obvious way on
new systems, forcing people to fix their software -- which they might or
might not actually bother to do).


Thoughts?

Cheers
---Dave


[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=b763f6ae859ecea70a5dacb8ad45c71d5f667e2e

[2] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/sigstack.h;h=e143034ce24dc383016b4882b89cfebc7a6a62d7;hb=b8079dd0d360648e4e8de48656c5c38972621072

[3] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c9692657c0321fec7bcb3ca8c6db56c08c640ace
