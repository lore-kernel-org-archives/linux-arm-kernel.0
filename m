From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 14 Nov 2016 10:59:26 -0500
Subject: [PATCH V7 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <CAG2=9p_SKF4TAbbqF6L4u=y9-_m73vZJ3tOAbRKHCT0MOsLwGQ@mail.gmail.com>
References: <1476778140-10319-1-git-send-email-zhang.chunyan@linaro.org>
 <1476778140-10319-2-git-send-email-zhang.chunyan@linaro.org>
 <20161018114418.3445c390@gandalf.local.home>
 <CAG2=9p_SKF4TAbbqF6L4u=y9-_m73vZJ3tOAbRKHCT0MOsLwGQ@mail.gmail.com>
Message-ID: <20161114105926.7bc7844b@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016 20:13:13 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:

> On 18 October 2016 at 23:44, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 18 Oct 2016 16:08:58 +0800
> > Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> >  
> >> Currently Function traces can be only exported to ring buffer, this
> >> patch added trace_export concept which can process traces and export
> >> them to a registered destination as an addition to the current only
> >> one output of Ftrace - i.e. ring buffer.
> >>
> >> In this way, if we want Function traces to be sent to other destination
> >> rather than ring buffer only, we just need to register a new trace_export
> >> and implement its own .write() function for writing traces to storage.
> >>
> >> With this patch, only Function trace (trace type is TRACE_FN)
> >> is supported.  
> >
> > This is getting better, but I still have some nits.
> >  
> 
> Thanks.
> 
> >>
> >> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> >> ---
> >>  include/linux/trace.h |  28 +++++++++++
> >>  kernel/trace/trace.c  | 132 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 159 insertions(+), 1 deletion(-)
> >>  create mode 100644 include/linux/trace.h
> >>
> >> diff --git a/include/linux/trace.h b/include/linux/trace.h
> >> new file mode 100644
> >> index 0000000..eb1c5b8
> >> --- /dev/null
> >> +++ b/include/linux/trace.h
> >> @@ -0,0 +1,28 @@
> >> +#ifndef _LINUX_TRACE_H
> >> +#define _LINUX_TRACE_H
> >> +
> >> +#ifdef CONFIG_TRACING
> >> +/*
> >> + * The trace export - an export of Ftrace output. The trace_export
> >> + * can process traces and export them to a registered destination as
> >> + * an addition to the current only output of Ftrace - i.e. ring buffer.
> >> + *
> >> + * If you want traces to be sent to some other place rather than ring
> >> + * buffer only, just need to register a new trace_export and implement
> >> + * its own .write() function for writing traces to the storage.
> >> + *
> >> + * next              - pointer to the next trace_export
> >> + * write     - copy traces which have been delt with ->commit() to
> >> + *             the destination
> >> + */
> >> +struct trace_export {
> >> +     struct trace_export __rcu       *next;
> >> +     void (*write)(const char *, unsigned int);  
> >
> > Why const char*? Why not const void *? This will never be a string.
> >  
> 
> Will revise this.
> 
> >  
> >> +};
> >> +
> >> +int register_ftrace_export(struct trace_export *export);
> >> +int unregister_ftrace_export(struct trace_export *export);
> >> +
> >> +#endif       /* CONFIG_TRACING */
> >> +
> >> +#endif       /* _LINUX_TRACE_H */
> >> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> >> index 8696ce6..db94ec1 100644
> >> --- a/kernel/trace/trace.c
> >> +++ b/kernel/trace/trace.c
> >> @@ -40,6 +40,7 @@
> >>  #include <linux/poll.h>
> >>  #include <linux/nmi.h>
> >>  #include <linux/fs.h>
> >> +#include <linux/trace.h>
> >>  #include <linux/sched/rt.h>
> >>
> >>  #include "trace.h"
> >> @@ -2128,6 +2129,132 @@ void trace_buffer_unlock_commit_regs(struct trace_array *tr,
> >>       ftrace_trace_userstack(buffer, flags, pc);
> >>  }
> >>
> >> +static void
> >> +trace_process_export(struct trace_export *export,
> >> +            struct ring_buffer_event *event)
> >> +{
> >> +     struct trace_entry *entry;
> >> +     unsigned int size = 0;
> >> +
> >> +     entry = ring_buffer_event_data(event);
> >> +
> >> +     size = ring_buffer_event_length(event);
> >> +
> >> +     if (export->write)
> >> +             export->write((char *)entry, size);  
> >
> > Is there ever going to be a time where export->write wont be set?  
> 
> There hasn't been since only one trace_export (i.e. stm_ftrace) was
> added in this patch-set , I just wanted to make sure the write() has
> been set before registering trace_export like what I added in 2/3 of
> this series.
> 
> >
> > And if there is, this can be racy. As in
> >
> >
> >         CPU 0:                  CPU 1:
> >         ------                  ------
> >         if (export->write)
> >
> >                                 export->write = NULL;  
> 
> Is there going to be this kind of use case? Why some one needs to
> change export->write() rather than register a new trace_export?

Then why have a

	if (export->write)


Is there every going to be a case where export will not have a write
function?

-- Steve

> 
> I probably haven't understood your point thoroughly, please correct me
> if my guess was wrong.
> 
> 
> Thanks for the review,
> Chunyan
> 
> >
> >         export->write(entry, size);
> >
> >         BOOM!
> >
> >
> > -- Steve
