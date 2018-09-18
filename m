From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Tue, 18 Sep 2018 23:22:48 +0530
Subject: [PATCH 2/6] pstore: Add event tracing support
In-Reply-To: <20180917193426.41c99fd5@gandalf.local.home>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180917193426.41c99fd5@gandalf.local.home>
Message-ID: <cb17a8c9-fca1-5492-3255-eab0ea33577c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/18/2018 5:04 AM, Steven Rostedt wrote:
> 
> It looks like pstore_event_call() gets called from a trace event. You
> can't call kmalloc() from one. One thing is that kmalloc has
> tracepoints itself. You trace those you just entered an infinite loop.
> 
> 

Ok will remove it in v2. But any alternative way to do this?

>> +
>> +	event_call = fbuffer->trace_file->event_call;
>> +	if (!event_call || !event_call->event.funcs ||
>> +	    !event_call->event.funcs->trace)
>> +		goto fail_event;
>> +
>> +	event = &fbuffer->trace_file->event_call->event;
>> +
>> +	spin_lock_irqsave(&psinfo->buf_lock, flags);
>> +
>> +	trace_seq_init(&iter->seq);
>> +	iter->ent = fbuffer->entry;
> 
> I guess what you are doing is needing to translate the raw data into
> ascii output, and need the trace_iterator to do so.
> 
> You are already under a psinfo->buf_lock. Add a dummy iterator to that
> and use it instead.
> 
> 	trace_seq_init(&psinfo->iter->seq);
> 
>> +	event_call->event.funcs->trace(iter, 0, event);
> 
> 				      (psinfo->iter, 0 , event);
> 
> etc.
> 

Sure, will update in v2.

>> +	trace_seq_putc(&iter->seq, 0);
>> +
>> +	if (seq->size > psinfo->bufsize)
>> +		seq->size = psinfo->bufsize;
>> +
>> +	s = &iter->seq;
>> +	seq = &s->seq;
>> +
>> +	record.buf = (char *)(seq->buffer);
>> +	record.size = seq->len;
>> +	psinfo->write(&record);
>> +
>> +	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> 
> You may also need to convert these spin_locks into raw_spin_locks as
> when PREEMPT_RT enters the kernel you don't want them to turn into
> mutexes.
> 
> But that can be another patch.
> 

I will change this in v2, but can't we have it in same patch?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
