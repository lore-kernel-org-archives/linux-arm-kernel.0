From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Apr 2013 12:43:07 +0100
Subject: [PATCH v2] arm64: Fix task tracing
In-Reply-To: <20130415105840.GB29528@arm.com>
References: <20130408153132.GQ17476@mudshark.cambridge.arm.com>
 <1365510814-21343-1-git-send-email-cov@codeaurora.org>
 <20130415101159.GA25095@localhost.cambridge.arm.com>
 <20130415104542.GE9827@mudshark.cambridge.arm.com>
 <20130415105840.GB29528@arm.com>
Message-ID: <20130415114307.GC29528@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 11:58:40AM +0100, Catalin Marinas wrote:
> On Mon, Apr 15, 2013 at 11:45:42AM +0100, Will Deacon wrote:
> > On Mon, Apr 15, 2013 at 11:11:59AM +0100, Catalin Marinas wrote:
> > > On Tue, Apr 09, 2013 at 01:33:34PM +0100, Christopher Covington wrote:
> > > > For accurate accounting pass contextidr_thread_switch the prev
> > > > task pointer, since cpu_switch_to has at that point changed the
> > > > the stack pointer.
> > > > 
> > > > Signed-off-by: Christopher Covington <cov@codeaurora.org>
> > > > ---
> > > >  arch/arm64/kernel/process.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > > index 0337cdb..a49b25a 100644
> > > > --- a/arch/arm64/kernel/process.c
> > > > +++ b/arch/arm64/kernel/process.c
> > > > @@ -315,7 +315,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
> > > >  	/* the actual thread switch */
> > > >  	last = cpu_switch_to(prev, next);
> > > >  
> > > > -	contextidr_thread_switch(next);
> > > > +	contextidr_thread_switch(prev);
> > > 
> > > The original code was indeed wrong but using prev isn't any better. For
> > > a newly created thread, prev is probably 0 (if it's in a register,
> > > cpu_context has been zeroed by copy_thread()) or some random stack
> > > value.
> > 
> > Really? If prev is NULL in context_switch(...), the scheduler will implode,
> > and I can't see where else switch_to is called from.
> > 
> > Which code path are you thinking of?
> 
> copy_thread() zeros cpu_context which is used by cpu_switch_to() to load
> the next saved registers. The switch_to() function sets prev to last as
> returned by __switch_to(), so this is valid but in __switch_to() we
> don't have a valid prev (nor next) after cpu_switch_to() for newly
> created threads.

Correction - newly created threads return to ret_from_fork rather than
__switch_to(), which means that we miss the first
contextidr_thread_switch() call for a new thread. I would vote for
Christopher's original patch moving the call before cpu_switch_to(). The
alternative is to define finish_arch_switch() and add the call there. If
you are primarily tracing user space, it doesn't really matter whether
the stack was switched or not when we set the contextidr. For kernel
tracking, it could be a problem as we have the next task with the old
stack. But the same could be said about the prev task with the new
stack.

-- 
Catalin
