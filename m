From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 27 Nov 2018 14:50:44 -0500
Subject: [RFC][PATCH 03/14] arm64: function_graph: Remove use of
 FTRACE_NOTRACE_DEPTH
In-Reply-To: <20181127193149.GJ5641@arm.com>
References: <20181122012708.491151844@goodmis.org>
 <20181122012803.040221352@goodmis.org>
 <20181127193149.GJ5641@arm.com>
Message-ID: <20181127145044.53ddb58a@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2018 19:31:50 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Steve,
> 
> On Wed, Nov 21, 2018 at 08:27:11PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The curr_ret_stack is no longer set to -1 when not tracing a function. It is
> > now done differently, and the FTRACE_NOTRACE_DEPTH value is no longer used.
> > Remove the reference to it.  
> 
> Do you have a pointer to the commit that changed that behaviour? I just want
> to make sure we're not missing something in our unwind_frame() code.

The commit log is slightly wrong. The -1 goes away in patch 11 of this
series (and this is patch 3). But the FTRACE_NOTRACE_DEPTH is going
away, which is why we need this patch.

> 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/stacktrace.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 4989f7ea1e59..7723dadf25be 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -61,9 +61,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
> >  			(frame->pc == (unsigned long)return_to_handler)) {
> >  		if (WARN_ON_ONCE(frame->graph == -1))
> >  			return -EINVAL;  
> 
> Hmm, so is this code redundant too ^^ ?

Actually, it is fine before patch 11 (which I'm only going to take the
first 10 patches for the next merge window, after they are cleaned up).


> 
> > -		if (frame->graph < -1)
> > -			frame->graph += FTRACE_NOTRACE_DEPTH;
> > -  
> 
> Do we still need to initialise frame->graph in __save_stack_trace()?

You are fine till patch 11, which will probably break all this (another
reason why I'm not going to push that in the next merge window).

Ideally, we need to get rid of all users of curr_ret_stack outside of
the function graph logic. As it's going to change drastically. We need
this in order to combine function graph and kretprobes.

I'm working on a v2 that's going to be aimed at the next merge window,
that will only contain patches 1-10 of this series (and some other
updates). I'll Cc you on that entire set.

-- Steve
