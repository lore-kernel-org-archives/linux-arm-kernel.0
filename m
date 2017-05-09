From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 9 May 2017 09:23:05 +0800
Subject: [PATCH 2/2] arm64: Add dump_backtrace() in show_regs
In-Reply-To: <20170508150409.GG5480@leverpostej>
References: <1494251815-55961-1-git-send-email-wangkefeng.wang@huawei.com>
 <1494251815-55961-2-git-send-email-wangkefeng.wang@huawei.com>
 <20170508150409.GG5480@leverpostej>
Message-ID: <18a468b4-d89d-c3f1-f0fe-76ea3a649e2d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/5/8 23:04, Mark Rutland wrote:
> On Mon, May 08, 2017 at 09:56:55PM +0800, Kefeng Wang wrote:
>> When the system trigger a softlockup(eg, infinite loop when
>> PREEMPT_NONE), it only shows regs without stack trace, which
>> makes it difficult to adress the issue.
> 
> How about:
> 
>   Generic code expects show_regs() to dump the stack, but arm64's
>   show_regs() does not. This makes it hard to debug softlockups and
>   other issues that reesult in show_regs() being called.
> 
>   This patch updates arm64's show_regs() to dump the stack, as common
>   code expects.
> 

Will update, thanks.

>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  arch/arm64/include/asm/stacktrace.h | 1 +
>>  arch/arm64/kernel/process.c         | 1 +
>>  arch/arm64/kernel/traps.c           | 2 +-
>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
>> index 801a16db..5b6eafc 100644
>> --- a/arch/arm64/include/asm/stacktrace.h
>> +++ b/arch/arm64/include/asm/stacktrace.h
>> @@ -30,5 +30,6 @@ struct stackframe {
>>  extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
>>  extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>>  			    int (*fn)(struct stackframe *, void *), void *data);
>> +extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
>>  
>>  #endif	/* __ASM_STACKTRACE_H */
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index ae2a835..af1ea25 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -210,6 +210,7 @@ void __show_regs(struct pt_regs *regs)
>>  void show_regs(struct pt_regs * regs)
>>  {
>>  	__show_regs(regs);
>> +	dump_backtrace(regs, NULL);
>>  }
> 
> I believe that as we pass the regs down, this should trigger the frame
> skipping that we want, as I mentioned in reply to v1 [1].
> 
> So FWIW, with the commit message fixup:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks for your careful guidance, will update both.

Kefeng

> 
> Thanks,
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/496377.html
> 
>>  static void tls_thread_flush(void)
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index d4d6ae0..368c3c8 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -140,7 +140,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>>  	}
>>  }
>>  
>> -static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>> +void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>  {
>>  	struct stackframe frame;
>>  	unsigned long irq_stack_ptr;
>> -- 
>> 1.7.12.4
>>
> 
> .
> 
