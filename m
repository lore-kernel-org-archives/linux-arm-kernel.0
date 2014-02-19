From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 19 Feb 2014 19:48:57 +0900
Subject: [PATCH v3 5/6] arm64: ftrace: Add system call tracepoint
In-Reply-To: <20140217192936.GH26590@mudshark.cambridge.arm.com>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
 <1391768336-5642-1-git-send-email-takahiro.akashi@linaro.org>
 <1391768336-5642-6-git-send-email-takahiro.akashi@linaro.org>
 <20140217192936.GH26590@mudshark.cambridge.arm.com>
Message-ID: <53048C19.6040509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 04:29 AM, Will Deacon wrote:
> On Fri, Feb 07, 2014 at 10:18:55AM +0000, AKASHI Takahiro wrote:
>> This patch allows system call entry or exit to be traced as ftrace events,
>> ie. sys_enter_*/sys_exit_*, if CONFIG_FTRACE_SYSCALLS is enabled.
>> Those events appear and can be controlled under
>>      ${sysfs}/tracing/events/syscalls/
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm64/Kconfig               |    1 +
>>   arch/arm64/include/asm/syscall.h |    1 +
>>   arch/arm64/include/asm/unistd.h  |    2 ++
>>   arch/arm64/kernel/ptrace.c       |    5 +++++
>>   4 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 43fce76..9bdaf5c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -42,6 +42,7 @@ config ARM64
>>   	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>>   	select HAVE_MEMBLOCK
>>   	select HAVE_PERF_EVENTS
>> +	select HAVE_SYSCALL_TRACEPOINTS
>>   	select IRQ_DOMAIN
>>   	select MODULES_USE_ELF_RELA
>>   	select NO_BOOTMEM
>> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
>> index 70ba9d4..383771e 100644
>> --- a/arch/arm64/include/asm/syscall.h
>> +++ b/arch/arm64/include/asm/syscall.h
>> @@ -18,6 +18,7 @@
>>
>>   #include <linux/err.h>
>>
>> +extern const void *sys_call_table[];
>>
>>   static inline int syscall_get_nr(struct task_struct *task,
>>   				 struct pt_regs *regs)
>> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
>> index 82ce217..c335479 100644
>> --- a/arch/arm64/include/asm/unistd.h
>> +++ b/arch/arm64/include/asm/unistd.h
>> @@ -28,3 +28,5 @@
>>   #endif
>>   #define __ARCH_WANT_SYS_CLONE
>>   #include <uapi/asm/unistd.h>
>> +
>> +#define NR_syscalls (__NR_syscalls)
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 64ce39f..f4c3c4e 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -41,6 +41,9 @@
>>   #include <asm/traps.h>
>>   #include <asm/system_misc.h>
>>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/syscalls.h>
>> +
>>   /*
>>    * TODO: does not yet catch signals sent when the child dies.
>>    * in exit.c or in signal.c.
>> @@ -1076,10 +1079,12 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
>>   	}
>>
>>   	if (dir) {
>> +		trace_sys_exit(regs, regs->syscallno);
>>   		tracehook_report_syscall_exit(regs, 0);
>>   	} else {
>>   		if (tracehook_report_syscall_entry(regs))
>>   			regs->syscallno = ~0UL;
>> +		trace_sys_enter(regs, regs->syscallno);
>
> Shouldn't these calls be guarded by a TIF_SYSCALL_TRACEPOINT check?

Yes. I will add the guard.

-Takahiro AKASHI

> Will
>
