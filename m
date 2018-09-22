From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Sat, 22 Sep 2018 22:07:00 +0530
Subject: [PATCH 2/6] pstore: Add event tracing support
In-Reply-To: <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
Message-ID: <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/22/2018 2:35 PM, Joel Fernandes wrote:
> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
> Could you just split the pstore space into a per-cpu event buffer like
> we are doing for ftrace-on-pstore? Then you don't need to lock. I fear
> the lock contention will be apparent. The pstore code already has
> plumbing to split the store buffer per CPU.
> 

Hi Joel,

Thanks a lot for reviewing.

I just looked at per-cpu buffer for ftrace and itseems the pstore percpu 
records will need to be merged into one record if we add this support 
for events. Merging of ftrace logs is based on timestamp, but for events 
we do not have timestamp field (for this specific reason I have added 
timestamp field for IO event tracing so that atleast we can know the cpu 
number in pstore output). For example, the sched event pstore output 
below has no timestamp field, so how do we merge per-cpu logs?

# tail /sys/fs/pstore/event-ramoops-0
sched_waking: comm=rcu_sched pid=11 prio=120 target_cpu=002
sched_wakeup: comm=rcu_sched pid=11 prio=120 target_cpu=002

Also Pstore ftrace log format is fixed i.e.,(CPU:%d ts:%llu %08lx  %08lx 
  %pf <- %pF\n"), but different events will have different formats and 
we will not be able to add timestamp field like how pstore ftrace does 
using  pstore_ftrace_write_timestamp() and pstore_ftrace_read_timestamp().

Sorry if I am confusing you, I can explain better I guess.

> Also I think this spinlock can be moved further down.
> 

OK. Something like this would suffice?

{{{
spin_lock_irqsave(&psinfo->buf_lock, flags);

record.buf = (char *)(seq->buffer);
record.size = seq->len;
psinfo->write(&record);

spin_unlock_irqrestore(&psinfo->buf_lock, flags);
}}}

>> +
>> +       trace_seq_init(&iter->seq);
>> +       iter->ent = fbuffer->entry;
>> +       event_call->event.funcs->trace(iter, 0, event);
>> +       trace_seq_putc(&iter->seq, 0);
> 
> Would it be possible to store the binary trace record in the pstore
> buffer instead of outputting text? I suspect that will both be faster
> and less space.
> 

I will try this and come back.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
