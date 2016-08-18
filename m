From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Thu, 18 Aug 2016 17:22:11 +0800
Subject: [PATCH V4 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <20160817101119.0432655e@gandalf.local.home>
References: <1471261803-1186-1-git-send-email-zhang.chunyan@linaro.org>
 <1471261803-1186-2-git-send-email-zhang.chunyan@linaro.org>
 <20160815102826.667318b6@gandalf.local.home>
 <CAG2=9p8qLfftFApsqDPeN9--0c8na7jwpjzrjcbYw4xv2PUcbw@mail.gmail.com>
 <20160817101119.0432655e@gandalf.local.home>
Message-ID: <CAG2=9p9G+74k_rnY72LK=YVp0pLvOHBNxLDmYaQtGQUC4QRB4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

Please correct me if I'm misunderstanding something.

On 17 August 2016 at 22:11, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 17 Aug 2016 20:48:07 +0800
> Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>
>
>> Ok, will do.
>>
>> But I guess 'ftrace_ops_list' in ftrace.c [1] also should be annotated as rcu?
>>
>> [1] http://lxr.free-electrons.com/source/kernel/trace/ftrace.c#L460
>
> Hmm, perhaps it should. I wonder if sparse complains about this?
>

Yes, there are many this kind of errors in kernel/trace/ftrace.c and
kernel/trace/trace_events_filter.c
I can submit a patch to fix them.

>
>> >
>> >> +
>> >> +     mutex_lock(&trace_export_lock);
>> >> +
>> >> +     export->tr = trace_exports_list->tr;
>> >
>> > I don't see where tr is ever assigned.
>> >
>> >> +     export->commit = trace_generic_commit;
>> >
>> > Shouldn't the caller pass in the commit function too?
>>
>> The trace_export::write() callback is for caller, commit function
>> mainly deal with traces, is it better to keep 'trace_generic_commit'
>> in trace.c, i.e don't expose it to callers?
>
> It's fine to be external if it's only declared in kernel/trace/trace.h.

But we cannot assume that the trace_exports all are under
kernel/trace/, for example in this patchset 2/2, 'stm_ftrace' as a
trace_export was registered in stm subsystem but during its
initialization it cannot access 'trace_generic_commit' which is under
kernel/trace.

> I would think anything using a different "write" would require a
> different "commit".

Ok, I should make it more feasible rather than pointing to
'trace_generic_commit' directly when registering trace_export, that's
say, if the trace_export doesn't have its own commit function, point
directly to 'trace_generic_commit'.

>
> But maybe I'm misunderstanding your objective. See below.
>
>>
>> >
>> >> +
>> >> +     add_trace_export(&trace_exports_list, export);
>> >> +
>> >> +     mutex_unlock(&trace_export_lock);
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +EXPORT_SYMBOL_GPL(register_trace_export);
>> >> +
>> >> +int unregister_trace_export(struct trace_export *export)
>> >> +{
>> >> +     int ret;
>> >> +
>> >> +     mutex_lock(&trace_export_lock);
>> >> +
>> >> +     ret = rm_trace_export(&trace_exports_list, export);
>> >> +
>> >> +     mutex_unlock(&trace_export_lock);
>> >> +
>> >> +     return ret;
>> >> +}
>> >> +EXPORT_SYMBOL_GPL(unregister_trace_export);
>> >> +
>> >>  void
>> >>  trace_function(struct trace_array *tr,
>> >>              unsigned long ip, unsigned long parent_ip, unsigned long flags,
>> >> @@ -2147,7 +2269,7 @@ trace_function(struct trace_array *tr,
>> >>       entry->parent_ip                = parent_ip;
>> >>
>> >>       if (!call_filter_check_discard(call, entry, buffer, event))
>> >
>> > How do you handle the discard? If the entry doesn't match the filter,
>> > it will try to discard the event. I don't see how the "trace_exports"
>> > handle that.
>>
>> I directly used the entries which had already been filtered.
>> Humm.. sorry, actually you lost me here.
>
> I'm assuming this entire patch is to have the events written to
> something other than the ftrace ring buffer, correct?
>
> Or is this just trying to hook into the tracing that is happening? That
> is, this isn't replacing writing into the ftrace ring buffer, but it is
> just adding a way to write to someplace in addition to the ftrace ring
> buffer. Where you still write to the ftrace ring buffer, but then you
> can add a hook to copy someplace else as well.

Yes, this is what this patch is trying to implement.

>
> I was looking at this as a way that you are adding a replacement, not
> only an addition to. If that's the case, I think there may be a easier
> way to do this.

I want to know how it would be in the easier way you mentioned here.

I was trying to add a ftrace_ops before, but with that way, I have to
deal with a lot of trace or ring buffer stuff including the sort of
discard things like you mentioned, which the existed ftrace code does.
And if I choose to implement a new ftrace_ops, I'm only able to get
the function trace support for STM and have to do many things which
would be overlap with the current ftrace subsystem.

So in order to reuse the existed code and architecture, I chose to add
a trace_export interface for Ftrace subsytem, and in this way I'm
using in this patch, I will get all supports of traces which are dealt
with trace_function();

Another benefit of adding a trace_export is, if there will be other
subsystem would like to use the processed traces, it only needs to
register a trace_export and provides a .write() function call back or
together with a commit function, although from what I can see now
.write() is enough since my purpose was the processed traces I don't
need 'ring_buffer_event' so long as I had trace entries.


Thanks for your comments,
Chunyan

>
> -- Steve
