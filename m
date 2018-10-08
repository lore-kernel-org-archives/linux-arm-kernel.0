From: joel@joelfernandes.org (Joel Fernandes)
Date: Mon, 8 Oct 2018 15:40:56 -0700
Subject: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints
 go to pstore
In-Reply-To: <20181008103659.5bc14b28@gandalf.local.home>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
 <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
 <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
 <20181008103659.5bc14b28@gandalf.local.home>
Message-ID: <20181008224056.GA213420@joelaf.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 10:36:59AM -0400, Steven Rostedt wrote:
> On Mon, 8 Oct 2018 19:46:15 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
> > Hi Joel,
> > 
> > Sorry for the long delay in updating this thread.
> > But I just observed one weird behaviour in ftrace-ramoops when I was 
> > trying to use binary record instead of rendering text for event-ramoops.
> > 
> > Even though we set the ftrace-size in device tree for ramoops, the 
> > actual ftrace-ramoops record seems to have more records than specified size.
> > Is this expected or some bug?
> 
> If ftrace-ramoops is using logic similar to the ftrace ring buffer,
> then yes, it will be able to store more events than specified. The
> ftrace ring buffer is broken up into pages, and everything is rounded
> up to the nearest page (note, the data may be smaller than a page,
> because each page also contains a header).

In the pstore code, the pages are contiguous. The platform drivers for that
platform configure 'ftrace-size' which is in bytes. That is further divided
by the number of CPUs. The records from all the buffers are then merged at read time.

Each function trace record is of type:
struct pstore_ftrace_record {
        unsigned long ip;
        unsigned long parent_ip;
        u64 ts;
};

which should be 24 bytes.

But there is an ECC block (with ECC data and ECC header) added to each CPU in
this case of the backing store of the pstore being RAM (pstore backing stores
can be other media types too).

> > Below is the ftrace-ramoops size passed in dtsi for db410c and we can 
> > see that the ftrace record is more.
> > 
> > # cat /sys/module/ramoops/parameters/ftrace_size
> > 131072
> 
> I'm assuming this too is like the ftrace ring buffer, where the size is
> per cpu (and why you do a search per cpu below).
> 
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | wc -c
> > 560888
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:0 | wc -c
> > 137758
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:1 | wc -c
> > 140560
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:2 | wc -c
> > 141174
> > #
> > # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:3 | wc -c
> > 141396
> > #

That could be because you're counting text characters when you're counting.
You need to count the binary size.

> If you are using binary record, isn't this what you want? The
> ftrace_size is the size of how much binary data is stored. When you
> translate the binary into human text, the text should be bigger.
> 
> > I don't see this in console or dmesg ramoops and also with the 
> > event-ramoops which I have posted since we don't use binary record, only 
> > ftrace-ramoops uses binary record to store trace data.
> > 
> > Also regarding the warning on "event_call->event.funcs->trace()" call,
> > I see it everytime without spinlock. Also we see output_printk using 
> > spinlock when making this call. I could not find a way to pass event 
> > buffer size and allocate in pstore. Steven can give some hints with this 
> > I guess.

The spinlock warning you're talking about is this one correct?

[    1.389382] WARNING: CPU: 2 PID: 2 at kernel/trace/trace_output.c:289 trace_raw_output_prep+0x18/0xa0
[    1.389416] Modules linked in:
which you reported here:
https://lkml.org/lkml/2018/9/22/319

This warning happens I think because you're trying to format the events while
the trace events are being generated. You said you got this warning when you
didn't use the spinlock. I believe the spinlocking prevents such races, but
if you didn't need to format the events into text into text in the first
place, then you wouldn't need such locking at all. 

I believe ftrace doesn't have such issues because such locking is taken care
off when the trace events are formatted from the trace buffer and displayed,
but I could be wrong about that.. I'll let Steven provide more inputs about
how this warning can occur.

As a suggestion, please always provide references to the warnings you're
referring to, such as previous LKML posts or atleast the warning message so
folks know which warning you're talking about.

thanks,

 - Joel
