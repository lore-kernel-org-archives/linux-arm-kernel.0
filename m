From: marcin.nowakowski@imgtec.com (Marcin Nowakowski)
Date: Wed, 12 Oct 2016 09:07:03 +0200
Subject: [PATCH v3 07/11] arm64/tracing: fix compat syscall handling
In-Reply-To: <20161011133623.GE9532@arm.com>
References: <1476182576-15247-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1476182576-15247-8-git-send-email-marcin.nowakowski@imgtec.com>
 <20161011133623.GE9532@arm.com>
Message-ID: <fed0151c-ebfd-18d2-939c-21e315dc7584@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 11.10.2016 15:36, Will Deacon wrote:
> On Tue, Oct 11, 2016 at 12:42:52PM +0200, Marcin Nowakowski wrote:
>> Add arch_syscall_addr for arm64 and define NR_compat_syscalls, as the
>> number of compat syscalls for arm64 exceeds the number defined by
>> NR_syscalls.
>>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>  arch/arm64/include/asm/ftrace.h | 12 +-----------
>>  arch/arm64/include/asm/unistd.h |  1 +
>>  arch/arm64/kernel/Makefile      |  1 +
>>  arch/arm64/kernel/ftrace.c      | 16 ++++++++++++++++
>>  4 files changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
>> index caa955f..b57ff7c 100644
>> --- a/arch/arm64/include/asm/ftrace.h
>> +++ b/arch/arm64/include/asm/ftrace.h
>> @@ -41,17 +41,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>
>>  #define ftrace_return_address(n) return_address(n)
>>
>> -/*
>> - * Because AArch32 mode does not share the same syscall table with AArch64,
>> - * tracing compat syscalls may result in reporting bogus syscalls or even
>> - * hang-up, so just do not trace them.
>> - * See kernel/trace/trace_syscalls.c
>> - *
>> - * x86 code says:
>> - * If the user really wants these, then they should use the
>> - * raw syscall tracepoints with filtering.
>> - */
>> -#define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
>> +#define ARCH_COMPAT_SYSCALL_NUMBERS_OVERLAP 1
>>  static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
>>  {
>>  	return is_compat_task();
>> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
>> index e78ac26..276d049 100644
>> --- a/arch/arm64/include/asm/unistd.h
>> +++ b/arch/arm64/include/asm/unistd.h
>> @@ -45,6 +45,7 @@
>>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
>>
>>  #define __NR_compat_syscalls		394
>> +#define NR_compat_syscalls (__NR_compat_syscalls)
>
> We may as well just define NR_compat_syscalls instead of
> __NR_compat_syscalls and move the handful of users over.

I had tried to minimise the amount of arch-specific changes here - 
especially those that are not directly related to the proposed syscall 
handling change. But I agree having these 2 #defines is a bit 
unnecessary ...

>> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
>> index 40ad08a..75d010f 100644
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -176,4 +176,20 @@ int ftrace_disable_ftrace_graph_caller(void)
>>  	return ftrace_modify_graph_caller(false);
>>  }
>>  #endif /* CONFIG_DYNAMIC_FTRACE */
>> +
>>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>> +
>> +#if (defined CONFIG_FTRACE_SYSCALLS) && (defined CONFIG_COMPAT)
>> +
>> +extern const void *sys_call_table[];
>> +extern const void *compat_sys_call_table[];
>> +
>> +unsigned long __init arch_syscall_addr(int nr, bool compat)
>> +{
>> +	if (compat)
>> +		return (unsigned long)compat_sys_call_table[nr];
>> +
>> +	return (unsigned long)sys_call_table[nr];
>> +}
>
> Do we care about the compat private syscalls (from base 0x0f0000)? We
> need to make sure that we exhibit the same behaviour as a native
> 32-bit ARM machine.
>
> Will

Tracing of such syscalls has been disabled for a long time (see
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=086ba77a6db0).
Apart from using non-contiguous numbers, they are not defined using 
standard SYSCALL macros, so they do not have any metadata generated either.
My suggestion is that if you wanted those to be included in the trace 
then it should be done separately from these changes.

Marcin
