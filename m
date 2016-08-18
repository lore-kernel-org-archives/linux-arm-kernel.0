From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 18 Aug 2016 12:12:58 -0400
Subject: [PATCH V4 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <CAG2=9p9G+74k_rnY72LK=YVp0pLvOHBNxLDmYaQtGQUC4QRB4w@mail.gmail.com>
References: <1471261803-1186-1-git-send-email-zhang.chunyan@linaro.org>
 <1471261803-1186-2-git-send-email-zhang.chunyan@linaro.org>
 <20160815102826.667318b6@gandalf.local.home>
 <CAG2=9p8qLfftFApsqDPeN9--0c8na7jwpjzrjcbYw4xv2PUcbw@mail.gmail.com>
 <20160817101119.0432655e@gandalf.local.home>
 <CAG2=9p9G+74k_rnY72LK=YVp0pLvOHBNxLDmYaQtGQUC4QRB4w@mail.gmail.com>
Message-ID: <20160818121258.2a62ce66@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Aug 2016 17:22:11 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:


> > Or is this just trying to hook into the tracing that is happening? That
> > is, this isn't replacing writing into the ftrace ring buffer, but it is
> > just adding a way to write to someplace in addition to the ftrace ring
> > buffer. Where you still write to the ftrace ring buffer, but then you
> > can add a hook to copy someplace else as well.  
> 
> Yes, this is what this patch is trying to implement.
> 
> >
> > I was looking at this as a way that you are adding a replacement, not
> > only an addition to. If that's the case, I think there may be a easier
> > way to do this.  
> 
> I want to know how it would be in the easier way you mentioned here.
> 
> I was trying to add a ftrace_ops before, but with that way, I have to
> deal with a lot of trace or ring buffer stuff including the sort of
> discard things like you mentioned, which the existed ftrace code does.
> And if I choose to implement a new ftrace_ops, I'm only able to get
> the function trace support for STM and have to do many things which
> would be overlap with the current ftrace subsystem.

Adding your own ftrace_ops is a way for replacing, not just adding a
hook into.

> 
> So in order to reuse the existed code and architecture, I chose to add
> a trace_export interface for Ftrace subsytem, and in this way I'm
> using in this patch, I will get all supports of traces which are dealt
> with trace_function();

Actually, a trace_export() should only be called if there's been
something added. And that should be done with a static_key_false()
branch (which is dynamically enabled, and does not use a comparison
branch).

That is, something like this instead:

 	if (!call_filter_check_discard(call, entry, buffer, event)) {
		if (static_key_false(&ftrace_trace_exports_enabled))
			ftrace_exports(tr, event);
		__buffer_unlock_commit(buffer, event);
	}

Don't touch the current logic. Just have your code hook into the
ftrace_exports (note I use "ftrace_exports" and not trace_exports()
because it's the function tracer, which has stricter requirements than
events do. If you add a hook for tracepoints later, use trace_exports()
and have a different list for that).

> 
> Another benefit of adding a trace_export is, if there will be other
> subsystem would like to use the processed traces, it only needs to
> register a trace_export and provides a .write() function call back or
> together with a commit function, although from what I can see now
> .write() is enough since my purpose was the processed traces I don't
> need 'ring_buffer_event' so long as I had trace entries.

I'm saying if you don't mind the ring buffer being used along with
your own code (which seems to be what's happening), then just add a
call back to your code. Don't monkey with the current logic.

I think that will simplify things tremendously.

-- Steve
