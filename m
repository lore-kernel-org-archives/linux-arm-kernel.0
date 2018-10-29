From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 29 Oct 2018 09:28:12 +0000
Subject: [PATCH v4 3/3] arm64: reliable stacktraces
In-Reply-To: <20181026153704.7g34j3gtlklepyvb@treble>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142157.B8FAA68C97@newverein.lst.de>
 <20181026153704.7g34j3gtlklepyvb@treble>
Message-ID: <20181029092812.j7q5gfwxc3qq4vye@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

I also have a few concerns here, as it is not clear to me precisely what is
required from arch code. Is there any documentation I should look at?

On Fri, Oct 26, 2018 at 10:37:04AM -0500, Josh Poimboeuf wrote:
> On Fri, Oct 26, 2018 at 04:21:57PM +0200, Torsten Duwe wrote:
> > Enhance the stack unwinder so that it reports whether it had to stop
> > normally or due to an error condition; unwind_frame() will report
> > continue/error/normal ending and walk_stackframe() will pass that
> > info. __save_stack_trace() is used to check the validity of a stack;
> > save_stack_trace_tsk_reliable() can now trivially be implemented.
> > Modify arch/arm64/kernel/time.c as the only external caller so far
> > to recognise the new semantics.

There are a number of error conditions not currently handled by the unwinder
(mostly in the face of stack corruption), for which there have been prior
discussions on list.

Do we care about those cases, or do we consider things best-effort in the face
of stack corruption?

> > I had to introduce a marker symbol kthread_return_to_user to tell
> > the normal origin of a kernel thread.
> > 
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> I haven't looked at the code, but the commit log doesn't inspire much
> confidence.  It's missing everything I previously asked for in the
> powerpc version.
> 
> There's zero mention of objtool.  What analysis was done to indicate
> that we can rely on frame pointers?
> 
> Such a frame pointer analysis should be included in the commit log.  It
> should describe *at least* the following:
> 
> - whether inline asm statements with call/branch instructions will
>   confuse GCC into skipping the frame pointer setup if it considers the
>   function to be a leaf function;

There's a reasonable chance that the out-of-line LL/SC atomics could confuse
GCC into thinking callers are leaf functions. That's the only inline asm that
I'm aware of with BL instructions (how calls are made on arm64).

> - whether hand-coded non-leaf assembly functions can accidentally omit
>   the frame pointer prologue setup;

Most of our assembly doesn't setup stackframes, and some of these are non-leaf,
e.g. __cpu_suspend_enter.

Also, I suspect our entry assembly may violate/confuse assumptions here. I've
been working to move more of that to C, but that isn't yet complete.

> - whether GCC can generally be relied upon to get arm64 frame pointers
>   right, in both normal operation and edge cases.
> 
> The commit log should also describe whether the unwinder itself can be
> considered reliable for all edge cases:
> 
> - detection and reporting of preemption and page faults;
> 
> - detection and recovery from function graph tracing;
> 
> - detection and reporting of other unexpected conditions,
>   including when the unwinder doesn't reach the end of the stack.

We may also have NMIs (with SDEI).

Thanks,
Mark.
