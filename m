From: linyongting@gmail.com (ivan lin)
Date: Sun, 27 Apr 2014 12:15:03 +0800
Subject: [PATCH] ftrace/arm: add save_stack_trace_regs() implementation
In-Reply-To: <20140423090355.5a0a98cd@gandalf.local.home>
References: <1398257541-18201-1-git-send-email-linyongting@gmail.com>
 <20140423090355.5a0a98cd@gandalf.local.home>
Message-ID: <CANWV4VnODgQ7xKk2X6vq=OVVANbsTBS1AxX-3UOdwoYbrxWjPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-23 21:03 GMT+08:00 Steven Rostedt <rostedt@goodmis.org>:
> On Wed, 23 Apr 2014 20:52:21 +0800
> Lin Yongting <linyongting@gmail.com> wrote:
>
>> When configure kprobe events of ftrace with "stacktrace" option enabled
>> in arm, there is no stacktrace was recorded after the kprobe event was
>> triggered. The root cause is no save_stack_trace_regs() function implemented.
>>
>> Implement the save_stack_trace_regs() function in arm, then ftrace will
>> call this architecture-related function to record the stacktrace into
>> ring buffer.
>>
>> After this fix, stacktrace can be recorded, for example:
>>
>> # mount -t debugfs nodev /sys/kernel/debug
>> # echo "p:netrx net_rx_action" >> /sys/kernel/debug/tracing/kprobe_events
>> # echo 1 > /sys/kernel/debug/tracing/events/kprobes/netrx/enable
>> # echo 1 > /sys/kernel/debug/tracing/options/stacktrace
>> # echo 1 > /sys/kernel/debug/tracing/tracing_on
>> # ping 127.0.0.1 -c 1
>> # echo 0 > /sys/kernel/debug/tracing/tracing_on
>>
>> # cat /sys/kernel/debug/tracing/trace
>> # tracer: nop
>> #
>> # entries-in-buffer/entries-written: 12/12   #P:1
>> #
>> #                              _-----=> irqs-off
>> #                             / _----=> need-resched
>> #                            | / _---=> hardirq/softirq
>> #                            || / _--=> preempt-depth
>> #                            ||| /     delay
>> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>> #              | |       |   ||||       |         |
>>             <------ missing some entries ---------------->
>>             ping-1200  [000] dNs1   667.603250: netrx: (net_rx_action+0x0/0x1f8)
>>             ping-1200  [000] dNs1   667.604738: <stack trace>
>>  => net_rx_action
>>  => do_softirq
>>  => local_bh_enable
>>  => ip_finish_output
>>  => ip_output
>>  => ip_local_out
>>  => ip_send_skb
>>  => ip_push_pending_frames
>>  => raw_sendmsg
>>  => inet_sendmsg
>>  => sock_sendmsg
>>  => SyS_sendto
>>  => ret_fast_syscall
>>
>> Signed-off-by: Lin Yongting <linyongting@gmail.com>
>> ---
>
> As this affects ftrace for ARM...
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve
>

Hi Russell

  How about my Patch?  any advice is appreciate?

  Best Regards!

  -- Yongting.


>>  arch/arm/kernel/stacktrace.c |   19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
>> index af4e8c8..c558db6 100644
>> --- a/arch/arm/kernel/stacktrace.c
>> +++ b/arch/arm/kernel/stacktrace.c
>> @@ -123,6 +123,25 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>>               trace->entries[trace->nr_entries++] = ULONG_MAX;
>>  }
>>
>> +void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
>> +{
>> +     struct stack_trace_data data;
>> +     struct stackframe frame;
>> +
>> +     data.trace = trace;
>> +     data.skip = trace->skip;
>> +     data.no_sched_functions = 0;
>> +
>> +     frame.fp = regs->ARM_fp;
>> +     frame.sp = regs->ARM_sp;
>> +     frame.lr = regs->ARM_lr;
>> +     frame.pc = regs->ARM_pc;
>> +
>> +     walk_stackframe(&frame, save_trace, &data);
>> +     if (trace->nr_entries < trace->max_entries)
>> +             trace->entries[trace->nr_entries++] = ULONG_MAX;
>> +}
>> +
>>  void save_stack_trace(struct stack_trace *trace)
>>  {
>>       save_stack_trace_tsk(current, trace);
>
