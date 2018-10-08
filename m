From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 8 Oct 2018 10:36:59 -0400
Subject: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints
 go to pstore
In-Reply-To: <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
 <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
 <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
Message-ID: <20181008103659.5bc14b28@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Oct 2018 19:46:15 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> Hi Joel,
> 
> Sorry for the long delay in updating this thread.
> But I just observed one weird behaviour in ftrace-ramoops when I was 
> trying to use binary record instead of rendering text for event-ramoops.
> 
> Even though we set the ftrace-size in device tree for ramoops, the 
> actual ftrace-ramoops record seems to have more records than specified size.
> Is this expected or some bug?

If ftrace-ramoops is using logic similar to the ftrace ring buffer,
then yes, it will be able to store more events than specified. The
ftrace ring buffer is broken up into pages, and everything is rounded
up to the nearest page (note, the data may be smaller than a page,
because each page also contains a header).

> 
> Below is the ftrace-ramoops size passed in dtsi for db410c and we can 
> see that the ftrace record is more.
> 
> # cat /sys/module/ramoops/parameters/ftrace_size
> 131072

I'm assuming this too is like the ftrace ring buffer, where the size is
per cpu (and why you do a search per cpu below).

> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | wc -c
> 560888
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:0 | wc -c
> 137758
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:1 | wc -c
> 140560
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:2 | wc -c
> 141174
> #
> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:3 | wc -c
> 141396
> #
> 

If you are using binary record, isn't this what you want? The
ftrace_size is the size of how much binary data is stored. When you
translate the binary into human text, the text should be bigger.

> I don't see this in console or dmesg ramoops and also with the 
> event-ramoops which I have posted since we don't use binary record, only 
> ftrace-ramoops uses binary record to store trace data.
> 
> Also regarding the warning on "event_call->event.funcs->trace()" call,
> I see it everytime without spinlock. Also we see output_printk using 
> spinlock when making this call. I could not find a way to pass event 
> buffer size and allocate in pstore. Steven can give some hints with this 
> I guess.
> 
> Steven Rostedt gave some reviews about using raw_spinlocks for this call 
> earlier in this thread. So is it right to not use spinlocks for trace 
> events?

Correct.

> 
> One difference I see in ftrace-ramoops and event-ramoops is that 
> ftrace-ramoops  is not started on boot and event-ramoops logging can be 
> enabled from boot (late initcall however).
> 
> Do let me know if you have any way to avoid this warning which is a race 
> I think without spinlock.

I guess I need to look at that code again too.

-- Steve
