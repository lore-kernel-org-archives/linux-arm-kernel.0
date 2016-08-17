From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 17 Aug 2016 10:11:19 -0400
Subject: [PATCH V4 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <CAG2=9p8qLfftFApsqDPeN9--0c8na7jwpjzrjcbYw4xv2PUcbw@mail.gmail.com>
References: <1471261803-1186-1-git-send-email-zhang.chunyan@linaro.org>
 <1471261803-1186-2-git-send-email-zhang.chunyan@linaro.org>
 <20160815102826.667318b6@gandalf.local.home>
 <CAG2=9p8qLfftFApsqDPeN9--0c8na7jwpjzrjcbYw4xv2PUcbw@mail.gmail.com>
Message-ID: <20160817101119.0432655e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Aug 2016 20:48:07 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:


> Ok, will do.
> 
> But I guess 'ftrace_ops_list' in ftrace.c [1] also should be annotated as rcu?
> 
> [1] http://lxr.free-electrons.com/source/kernel/trace/ftrace.c#L460

Hmm, perhaps it should. I wonder if sparse complains about this?




> >  
> >> +
> >> +     mutex_lock(&trace_export_lock);
> >> +
> >> +     export->tr = trace_exports_list->tr;  
> >
> > I don't see where tr is ever assigned.
> >  
> >> +     export->commit = trace_generic_commit;  
> >
> > Shouldn't the caller pass in the commit function too?  
> 
> The trace_export::write() callback is for caller, commit function
> mainly deal with traces, is it better to keep 'trace_generic_commit'
> in trace.c, i.e don't expose it to callers?

It's fine to be external if it's only declared in kernel/trace/trace.h.
I would think anything using a different "write" would require a
different "commit".

But maybe I'm misunderstanding your objective. See below.

> 
> >  
> >> +
> >> +     add_trace_export(&trace_exports_list, export);
> >> +
> >> +     mutex_unlock(&trace_export_lock);
> >> +
> >> +     return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(register_trace_export);
> >> +
> >> +int unregister_trace_export(struct trace_export *export)
> >> +{
> >> +     int ret;
> >> +
> >> +     mutex_lock(&trace_export_lock);
> >> +
> >> +     ret = rm_trace_export(&trace_exports_list, export);
> >> +
> >> +     mutex_unlock(&trace_export_lock);
> >> +
> >> +     return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(unregister_trace_export);
> >> +
> >>  void
> >>  trace_function(struct trace_array *tr,
> >>              unsigned long ip, unsigned long parent_ip, unsigned long flags,
> >> @@ -2147,7 +2269,7 @@ trace_function(struct trace_array *tr,
> >>       entry->parent_ip                = parent_ip;
> >>
> >>       if (!call_filter_check_discard(call, entry, buffer, event))  
> >
> > How do you handle the discard? If the entry doesn't match the filter,
> > it will try to discard the event. I don't see how the "trace_exports"
> > handle that.  
> 
> I directly used the entries which had already been filtered.
> Humm.. sorry, actually you lost me here.

I'm assuming this entire patch is to have the events written to
something other than the ftrace ring buffer, correct?

Or is this just trying to hook into the tracing that is happening? That
is, this isn't replacing writing into the ftrace ring buffer, but it is
just adding a way to write to someplace in addition to the ftrace ring
buffer. Where you still write to the ftrace ring buffer, but then you
can add a hook to copy someplace else as well.

I was looking at this as a way that you are adding a replacement, not
only an addition to. If that's the case, I think there may be a easier
way to do this.

-- Steve
