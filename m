From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Sat, 22 Sep 2018 12:18:56 +0530
Subject: [PATCH 2/6] pstore: Add event tracing support
In-Reply-To: <bad69c36-2600-f0b3-5bfd-c865039ae97f@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180917193426.41c99fd5@gandalf.local.home>
 <cb17a8c9-fca1-5492-3255-eab0ea33577c@codeaurora.org>
 <20180918164434.472294f3@gandalf.local.home>
 <bad69c36-2600-f0b3-5bfd-c865039ae97f@codeaurora.org>
Message-ID: <8cb8851c-ab65-98ba-81ca-ba36957dc852@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/19/2018 2:43 AM, Sai Prakash Ranjan wrote:
> On 9/19/2018 2:14 AM, Steven Rostedt wrote:
>> On Tue, 18 Sep 2018 23:22:48 +0530
>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>
>>> On 9/18/2018 5:04 AM, Steven Rostedt wrote:
>>>>
>>>> It looks like pstore_event_call() gets called from a trace event. You
>>>> can't call kmalloc() from one. One thing is that kmalloc has
>>>> tracepoints itself. You trace those you just entered an infinite loop.
>>>>
>>>
>>> Ok will remove it in v2. But any alternative way to do this?
>>
>> I think I describe it below.
>>
> 
> Ok got it, will change and post the 2nd version soon.
> 

Hi Steven,

Instead of dummy iterator, can't we have something like below, there 
won't be any infinite loop if we trace kmalloc in this case. This is 
same as tp_printk.

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 018cbbefb769..271b0573f44a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8644,8 +8644,14 @@ void __init early_trace_init(void)
                         static_key_enable(&tracepoint_printk_key.key);
         }

-       if (tracepoint_pstore)
-               static_key_enable(&tracepoint_pstore_key.key);
+       if (tracepoint_pstore) {
+               tracepoint_pstore_iter =
+                       kmalloc(sizeof(*tracepoint_pstore_iter), 
GFP_KERNEL);
+               if (WARN_ON(!tracepoint_pstore_iter))
+                       tracepoint_pstore = 0;
+               else
+                       static_key_enable(&tracepoint_pstore_key.key);
+       }

         tracer_alloc_buffers();
  }
diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index f5263b6fb96f..0534546aef6d 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -73,7 +73,6 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         struct trace_event *event;
         struct seq_buf *seq;
         unsigned long flags;
-       gfp_t gfpflags;

         if (!psinfo)

         if (!psinfo)
                 return;
@@ -81,20 +80,17 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         if (unlikely(oops_in_progress))
                 return;

-       pstore_record_init(&record, psinfo);
-       record.type = PSTORE_TYPE_EVENT;
-
-       /* Can be called in atomic context */
-       gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : 
GFP_KERNEL;
-
-       iter = kmalloc(sizeof(*iter), gfpflags);
+       iter = tracepoint_pstore_iter;
         if (!iter)
                 return;

+       pstore_record_init(&record, psinfo);
+       record.type = PSTORE_TYPE_EVENT;
+
         event_call = fbuffer->trace_file->event_call;
         if (!event_call || !event_call->event.funcs ||
             !event_call->event.funcs->trace)
-               goto fail_event;
+               return;

         event = &fbuffer->trace_file->event_call->event;

@@ -116,9 +112,6 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         psinfo->write(&record);

         spin_unlock_irqrestore(&psinfo->buf_lock, flags);
-
-fail_event:
-       kfree(iter);
  }

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
