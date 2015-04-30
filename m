From: houpengyang@huawei.com (Hou Pengyang)
Date: Thu, 30 Apr 2015 21:55:58 +0800
Subject: [PATCH] arm64: perf: Fix callchain parse error with kernel
 tracepoint events
In-Reply-To: <20150429101234.GJ8236@arm.com>
References: <1430227248-19657-1-git-send-email-houpengyang@huawei.com>
 <20150429101234.GJ8236@arm.com>
Message-ID: <5542346E.7070803@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/4/29 18:12, Will Deacon wrote:
> Hello,
>
> On Tue, Apr 28, 2015 at 02:20:48PM +0100, Hou Pengyang wrote:
>> For ARM64, when tracing with tracepoint events, the IP and cpsr are set
>> to 0, preventing the perf code parsing the callchain and resolving the
>> symbols correctly.
>>
>>   ./perf record -e sched:sched_switch -g --call-graph dwarf ls
>> 	[ perf record: Captured and wrote 0.146 MB perf.data ]
>>   ./perf report -f
>>      Samples: 194  of event 'sched:sched_switch', Event count (approx.): 194
>>      Children      Self    Command  Shared Object     Symbol
>> 	100.00%       100.00%  ls       [unknown]         [.] 0000000000000000
>>
>> The fix is to implement perf_arch_fetch_caller_regs for ARM64, which fills
>> several necessary registers used for callchain unwinding, including pc,sp,
>> fp and psr .
>>
>> With this patch, callchain can be parsed correctly as follows:
>>
>>       ......
>> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] vfs_symlink
>> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] follow_down
>> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] pfkey_get
>> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] do_execveat_common.isra.33
>> -    2.63%     0.00%  ls       [kernel.kallsyms]  [k] pfkey_send_policy_notify
>>       pfkey_send_policy_notify
>>       pfkey_get
>>       v9fs_vfs_rename
>>       page_follow_link_light
>>       link_path_walk
>>       el0_svc_naked
>>      .......
>>
>> For tracepoint event, stack parsing also doesn't work well for ARM. Jean Pihet
>> comed up a patch:
>> http://thread.gmane.org/gmane.linux.kernel/1734283/focus=1734280
>
> Any chance you could revive that series too, please? I'd like to update both
> arm and arm64 together, since we're currently working at merging the two
> perf backends and introducing discrepencies is going to delay that even
> longer.
>
   hi, Will, following your suggestion, I have rewrite the patch in four
lines of C, which would be shown in patch v2. what's more, both arm and
arm64 are offered. code between arm and arm64 are almost the same, so it
would be convenient to merge them together.

BTW, you're working on merging perf backends of arm and arm64, by which
git address can I follow the progress? thanks.

Hou.

>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>> ---
>>   arch/arm64/include/asm/perf_event.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
>> index d26d1d5..16a074f 100644
>> --- a/arch/arm64/include/asm/perf_event.h
>> +++ b/arch/arm64/include/asm/perf_event.h
>> @@ -24,4 +24,20 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>>   #define perf_misc_flags(regs)	perf_misc_flags(regs)
>>   #endif
>>
>> +#define perf_arch_fetch_caller_regs(regs, __ip) { \
>> +   unsigned long sp;   \
>> +   __asm__ ("mov %[sp], sp\n" : [sp] "=r" (sp)); \
>> +       (regs)->pc = (__ip);    \
>> +       __asm__ (      \
>> +               "str %[sp],  %[_arm64_sp]  \n\t"    \
>> +               "str x29, %[_arm64_fp]  \n\t"    \
>> +               "mrs %[_arm64_cpsr], spsr_el1 \n\t"     \
>> +               : [_arm64_sp] "=m" (regs->sp),      \
>> +                 [_arm64_fp] "=m" (regs->regs[29]),  \
>> +                 [_arm64_cpsr] "=r" (regs->pstate) \
>
> Does this really all need to be in assembly code? Ideally we'd use something
> like __builtin_stack_pointer and __builtin_frame_pointer. That just leaves
> the CPSR, but given that it's (a) only used for user_mode_regs tests and (b)
> this macro is only used by ftrace, then we just set it to a static value
> indicating that we're at EL1.
>
> So I *think* we should be able to write this as three lines of C.
>
> Will
>
> .
>
