From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Sep 2016 12:39:21 +0100
Subject: [PATCH] arm64:ftrace: add save_stack_trace_regs()
In-Reply-To: <CAHB_Guoec0-Z57VxYf94XcZFF+bx0410=X1mD-7y7zqxQeyypw@mail.gmail.com>
References: <1e8882680fd875de22db27c897727d0466a7e2e0.1438333085.git.panand@redhat.com>
 <CAHB_Guoec0-Z57VxYf94XcZFF+bx0410=X1mD-7y7zqxQeyypw@mail.gmail.com>
Message-ID: <20160901113920.GD6721@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 04:57:30PM +0530, Pratyush Anand wrote:
> On Fri, Jul 31, 2015 at 2:51 PM, Pratyush Anand <panand@redhat.com> wrote:
> > Implement save_stack_trace_regs, so that stacktrace of a kprobe events can be
> > obtained.
> >
> > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > ---
> > Function will be useful only after having ARM64 kprobes upstreamed.
> > However, since there is no dependency in applying the patch, so it may be
> > upstreamed independently (if there is no other review comment).
> 
> 
> Since kprobe is already in mainline now. So any comment for this patch?
> It still applies cleanly to the latest upstream.

It would be nice if David or Akashi could review/test it.

Will

> > I see following stack trace for kfree with this patch in one of the case.
> >
> > echo stacktrace > /sys/kernel/debug/tracing/trace_options
> > echo "p kfree" >> /sys/kernel/debug/tracing/kprobe_events
> > echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> > more /sys/kernel/debug/tracing/trace
> >             bash-3868  [001] d...  2863.068271: p_kfree_0: (kfree+0x0/0x194)
> >             bash-3868  [001] d...  2863.068276: <stack trace>
> >  => kfree
> >  => syscall_trace_exit
> >  => __sys_trace_return_skipped
> >
> >  arch/arm64/kernel/stacktrace.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 407991bf79f5..c7fa0431ef3e 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -97,6 +97,24 @@ static int save_trace(struct stackframe *frame, void *d)
> >         return trace->nr_entries >= trace->max_entries;
> >  }
> >
> > +void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
> > +{
> > +       struct stack_trace_data data;
> > +       struct stackframe frame;
> > +
> > +       data.trace = trace;
> > +       data.skip = trace->skip;
> > +       data.no_sched_functions = 0;
> > +
> > +       frame.fp = regs->regs[29];
> > +       frame.sp = regs->sp;
> > +       frame.pc = regs->pc;
> > +
> > +       walk_stackframe(&frame, save_trace, &data);
> > +       if (trace->nr_entries < trace->max_entries)
> > +               trace->entries[trace->nr_entries++] = ULONG_MAX;
> > +}
> > +
> >  void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> >  {
> >         struct stack_trace_data data;
> > --
> > 2.4.3
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
