From: rafael.tinoco@linaro.org (Rafael David Tinoco)
Date: Thu, 18 Oct 2018 00:30:34 -0300
Subject: ARM32: It appears that vector_swi does not update
 (thread_info)->syscall variable
Message-ID: <CABdQkv_wT4waAOZ+chxhgWgjBDFHvp0w6PKP2gMSMfGS_ug0HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During LKFT functional tests, we have realized that /proc/*/syscall
first field (current syscall number) is not correct for arm32. It
appears that some syscalls have their syscall numbers correctly
displayed and others show only 0 (even if showing argument pointers),
while in arm64 all of them are correctly displayed.

/proc/*/syscall:

# good

252 0xa 0xbef3d930 0x9 0xffffffff 0x0 0x6c 0xbef3d908 0xb6e6f286
142 0x4 0x0 0xbea3eb2c 0x0 0x0 0x6c 0xbea3ea88 0xb6e40286
252 0x4 0xbe8d59e8 0x9 0xffffffff 0xbe8d59e8 0x4 0xbe8d59c0 0xb6e11286

# bad

0 0xbed0a544 0xbed0a29c 0x0 0x8 0xbed0a544 0xbed0a29c 0xbed0a1e8 0xb6e47286
0 0x4 0xbed0a528 0x3f 0xffffffff 0x0 0x6c 0xbed0a500 0xb6e47286
0 0x400 0xbec61920 0x0 0x0 0x0 0x400 0xbec61860 0xb6dfe286

It appears that:

ARM64: syscall_get_nr() gets syscall number from (struct pt_regs)->syscallno

=> syscallno is updated in el0_svc_common(), right in the beginning,
independently of "has_syscall_work()" result. with that,
proc_pid_syscall()->collect_syscall()->syscall_get_nr() is able to
read syscallno from task's pt_regs whenever procfs needs.

ARM32: syscall_get_nr() gets syscall no from task_thread_info(task)->syscall

=> From vector_swi:

thread_info->syscall variable seems to be updated ONLY when
_TIF_SYSCALL_WORK flag is set into TI_FLAGS (similar to
has_syscall_work() function used in el0_svc_common() for arm64): it
makes a branch to __sys_trace, which calls syscall_trace_enter()
function, which will update thread_info->syscall correctly (and this
seems to be the only place where it is updated).

=> If there is NO branch to __sys_trace (likely), it seems that
(thread_info)->syscall is never updated, making the procfs logic, for
getting the task current syscall number, to display 0 only (like in
#bad).

If this analysis is right, solution could be to set
(thread_info)->syscall variable directly in vector_swi entry, before
calling the invoke_syscall macro (similar to what el0_svc_common() ?).
I did not send a patch because that area is sensitive in amount of
registers being used.

If analysis is wrong, sorry for the burden.

Link: https://bugs.linaro.org/show_bug.cgi?id=3783

Thank you
Rafael
