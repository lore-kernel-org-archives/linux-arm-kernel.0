From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Fri, 26 Oct 2018 10:37:04 -0500
Subject: [PATCH v4 3/3] arm64: reliable stacktraces
In-Reply-To: <20181026142157.B8FAA68C97@newverein.lst.de>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142157.B8FAA68C97@newverein.lst.de>
Message-ID: <20181026153704.7g34j3gtlklepyvb@treble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 04:21:57PM +0200, Torsten Duwe wrote:
> Enhance the stack unwinder so that it reports whether it had to stop
> normally or due to an error condition; unwind_frame() will report
> continue/error/normal ending and walk_stackframe() will pass that
> info. __save_stack_trace() is used to check the validity of a stack;
> save_stack_trace_tsk_reliable() can now trivially be implemented.
> Modify arch/arm64/kernel/time.c as the only external caller so far
> to recognise the new semantics.
> 
> I had to introduce a marker symbol kthread_return_to_user to tell
> the normal origin of a kernel thread.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

I haven't looked at the code, but the commit log doesn't inspire much
confidence.  It's missing everything I previously asked for in the
powerpc version.

There's zero mention of objtool.  What analysis was done to indicate
that we can rely on frame pointers?

Such a frame pointer analysis should be included in the commit log.  It
should describe *at least* the following:

- whether inline asm statements with call/branch instructions will
  confuse GCC into skipping the frame pointer setup if it considers the
  function to be a leaf function;

- whether hand-coded non-leaf assembly functions can accidentally omit
  the frame pointer prologue setup;

- whether GCC can generally be relied upon to get arm64 frame pointers
  right, in both normal operation and edge cases.


The commit log should also describe whether the unwinder itself can be
considered reliable for all edge cases:

- detection and reporting of preemption and page faults;

- detection and recovery from function graph tracing;

- detection and reporting of other unexpected conditions,
  including when the unwinder doesn't reach the end of the stack.

-- 
Josh
