From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 29 Nov 2011 12:51:43 -0500
Subject: [PATCH 2/3] ARM: add TRACEHOOK support
In-Reply-To: <20111129170435.GA1104@mudshark.cambridge.arm.com>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
 <1322584095-30439-3-git-send-email-stevenrwalter@gmail.com>
 <20111129170435.GA1104@mudshark.cambridge.arm.com>
Message-ID: <CAK8d-a+4PH3Rr3ANQ9UXqzKy4v89_YmNCN9tp5qum1bs=ed+YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 12:04 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Steven,
>
> On Tue, Nov 29, 2011 at 04:28:14PM +0000, Steven Walter wrote:
>> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
>> index 9726006..1411848 100644
>> --- a/arch/arm/kernel/ptrace.c
>> +++ b/arch/arm/kernel/ptrace.c
>> @@ -22,6 +22,7 @@
>> ?#include <linux/perf_event.h>
>> ?#include <linux/hw_breakpoint.h>
>> ?#include <linux/regset.h>
>> +#include <linux/tracehook.h>
>>
>> ?#include <asm/pgtable.h>
>> ?#include <asm/system.h>
>> @@ -928,8 +929,6 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
>>
>> ? ? ? if (!test_thread_flag(TIF_SYSCALL_TRACE))
>> ? ? ? ? ? ? ? return scno;
>> - ? ? if (!(current->ptrace & PT_PTRACED))
>> - ? ? ? ? ? ? return scno;
>
> This means that we can potentially corrupt current_thread_info()->syscall
> for tasks that aren't being traced. I don't think that matters as it's only
> used by ptrace, but worth bearing in mind.

Is it valid for a process to have TIF_SYSCALL_TRACE set but not
PT_PTRACED?  Given that they were checking both before, one might
assume so, but I don't really know what that would mean.

>> ? ? ? /*
>> ? ? ? ?* Save IP. ?IP is used to denote syscall entry/exit:
>> @@ -940,19 +939,13 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
>>
>> ? ? ? current_thread_info()->syscall = scno;
>>
>> - ? ? /* the 0x80 provides a way for the tracing parent to distinguish
>> - ? ? ? ?between a syscall stop and SIGTRAP delivery */
>> - ? ? ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?? 0x80 : 0));
>> - ? ? /*
>> - ? ? ?* this isn't the same as continuing with a signal, but it will do
>> - ? ? ?* for normal use. ?strace only continues with a signal if the
>> - ? ? ?* stopping signal is not SIGTRAP. ?-brl
>> - ? ? ?*/
>> - ? ? if (current->exit_code) {
>> - ? ? ? ? ? ? send_sig(current->exit_code, current, 1);
>> - ? ? ? ? ? ? current->exit_code = 0;
>> + ? ? if (why == 0) {
>> + ? ? ? ? ? ? if (tracehook_report_syscall_entry(regs))
>> + ? ? ? ? ? ? ? ? ? ? current_thread_info()->syscall = -1;
>
> Why do you set syscall to -1 here? It looks like
> tracehook_report_syscall_entry always returns 0, but even so, I'm not sure
> what this -1 represents. You could also rewrite this a bit more neatly:

tracehook_report_syscall_entry is marked __must_check, and the comment
says that if it returns non-zero the arch could should abort the
system call.  x86 just returns -1 from its trace function in that
case, so I took the same approach.  In particular, if we treat -1 as
the system call number, the system call should fail with ENOSYS, which
include/linux/tracehook.h says is acceptable.

> if (why)
> ? ? ? ?tracehook_report_syscall_exit(...);
> else
> ? ? ? ?tracehook_report_syscall_entry(...);

Agreed, will fix

>> + ? ? } else {
>> + ? ? ? ? ? ? tracehook_report_syscall_exit(regs, 0);
>> ? ? ? }
>> +
>> ? ? ? regs->ARM_ip = ip;
>>
>> ? ? ? return current_thread_info()->syscall;
>> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
>> index 0340224..26c26f5 100644
>> --- a/arch/arm/kernel/signal.c
>> +++ b/arch/arm/kernel/signal.c
>> @@ -645,6 +645,8 @@ handle_signal(unsigned long sig, struct k_sigaction *ka,
>> ? ? ? recalc_sigpending();
>> ? ? ? spin_unlock_irq(&tsk->sighand->siglock);
>>
>> + ? ? tracehook_signal_handler(sig, info, ka, regs, 0);
>> +
>
> This doesn't appear to do anything but I guess that's where it should live.

Right, I just added it because arch/Kconfig said to :-)
-- 
-Steven Walter <stevenrwalter@gmail.com>
