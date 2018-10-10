From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 10 Oct 2018 15:37:12 -0400
Subject: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints
 go to pstore
In-Reply-To: <174a465d-aedd-6561-e4e5-1f97ca4d0b0a@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
 <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
 <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
 <20181008103659.5bc14b28@gandalf.local.home>
 <20181008224056.GA213420@joelaf.mtv.corp.google.com>
 <174a465d-aedd-6561-e4e5-1f97ca4d0b0a@codeaurora.org>
Message-ID: <20181010153712.4e3a16d7@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Oct 2018 23:52:14 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> >>> Also regarding the warning on "event_call->event.funcs->trace()" call,
> >>> I see it everytime without spinlock. Also we see output_printk using
> >>> spinlock when making this call. I could not find a way to pass event
> >>> buffer size and allocate in pstore. Steven can give some hints with this
> >>> I guess.  
> > 
> > The spinlock warning you're talking about is this one correct?
> > 
> > [    1.389382] WARNING: CPU: 2 PID: 2 at kernel/trace/trace_output.c:289 trace_raw_output_prep+0x18/0xa0
> > [    1.389416] Modules linked in:
> > which you reported here:
> > https://lkml.org/lkml/2018/9/22/319
> > 
> > This warning happens I think because you're trying to format the events while
> > the trace events are being generated. You said you got this warning when you
> > didn't use the spinlock. I believe the spinlocking prevents such races, but
> > if you didn't need to format the events into text into text in the first
> > place, then you wouldn't need such locking at all.
> > 
> > I believe ftrace doesn't have such issues because such locking is taken care
> > off when the trace events are formatted from the trace buffer and displayed,
> > but I could be wrong about that.. I'll let Steven provide more inputs about
> > how this warning can occur.  
> Yes Steven would have more insight on this warning.

Correct. Formatting should not be done at the location of recording
(it's way too much overhead). Even trace_printk() doesn't format string
at the execution path, but does so at the presentation path (reading
the buffer, via reads of the trace file, or in trace-cmd post
processing of the trace.dat file).

trace_printk() uses vbin_printf() which doesn't do printf()
conversions, but instead only saves the format string and the raw
values into the buffer. Then in uses bstr_printf() that takes the
format string and raw values to produce the "printf()" output you know
and love.

-- Steve
