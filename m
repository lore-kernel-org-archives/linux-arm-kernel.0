From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Mon, 21 Mar 2016 19:23:28 +0800
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <56EE5B6E.6030305@huawei.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de> <20160225202855.GD16123@yury-N73SV>
 <56EBD84D.2060009@huawei.com> <20160318154918.GA1595@yury-N73SV>
 <56EC24EE.6020803@suse.de> <20160318164627.GA3201@yury-N73SV>
 <56EE5B6E.6030305@huawei.com>
Message-ID: <56EFD9B0.6080004@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury

On 2016/3/20 16:12, Zhangjian (Bamvor) wrote:
> Hi, Yury
>
> On 2016/3/19 0:46, Yury Norov wrote:
[...]
>> The minimal test reproducing it is attached. The similar test where
>> parent forks a child and then kills it, works fine. (Attached too).
>>
>> I see that in case of pthread, there's much more stuff that is cloned.
>> Other's looking similar.
>>
>> pthread_create():
>> clone(child_stack=0xb953cea0, flags=CLONE_VM|CLONE_FS|CLONE_FILES
>>          |CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS
>>          |CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
>>          parent_tidptr=0xb953d398, tls=0xb953d7c0, child_tidptr=0xb953d398) = 1650
>>
>> fork():
>> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
>>          child_tidptr=0xe5af6278) = 30537
>>
>> So this most probably means that ilp32 code doesn't handle one of cloned
>> item properly. I have already discovered a bug where child processes
>> used parent TLS,
> It is a kernel bug or glibc bug? Could you please explain it or show the patch?
> The current ILP32 patches looks good to me. Recently, I backport these patches
> to our 4.1 kernel. And I saw crash frequently even if I only do a single print
> or infinite loop. There is some small changes about tls register after 4.1. I
> am not sure if it is a similar issue. It is great if you have some suggestions/
> ideas.
My issue is because I forget to change is_compat_task to
is_a32_compat_task in arch/arm64/kernel/process.c such piece of code
is delete after commit d00a3810c162 ("arm64: context-switch user tls
register tpidr_el0 for compat tasks). It is not exist in upstream
kernel, never mind.

Meanwhile, I found that it seem that there is another is_compat_task
in tls_thread_flush. Is it relative the issue you mentioned?

```
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 432b094..9ab968c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -209,7 +209,7 @@ static void tls_thread_flush(void)
  {
         asm ("msr tpidr_el0, xzr");

-       if (is_compat_task()) {
+       if (is_a32_compat_task()) {
                 current->thread.tp_value = 0;

                 /*
```

Regards

Bamvor

> Thanks.
>
> Bamvor
>  > so maybe this is something similar...
>>
>> Except of this, I think ILP32 series is looking pretty well, at least
>> kernel part.
>>
>> If you have any ideas/suggestions, I'll really appreciate it.
>>
>> Yury.
>>
>> strace -f ./trigo
>> [...]
>> clone(child_stack=0xdbbfb000,
>> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND
>> |CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS
>> |CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
>> parent_tidptr=0xdbbfb4f8, tls=0xdbbfb920, child_tidptr=0xdbbfb4f8) = 32030
>> rt_sigprocmask(SIG_BLOCK, [CHLD], Process 32030 attached [], 8) = 0
>> [pid 32029] rt_sigaction(SIGCHLD, NULL,  <unfinished ...>
>> [pid 32030] set_robust_list(0xdbbfb504, 12 <unfinished ...>
>> [pid 32029] <... rt_sigaction resumed> {SIG_DFL, [ILL ABRT SEGV URG], 0}, 8) = 0
>> [pid 32030] <... set_robust_list resumed> ) = 0
>> [pid 32029] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> [pid 32030] write(1, "started\n", 8started
>> <unfinished ...>
>> [pid 32029] nanosleep({1, 65536},  <unfinished ...>
>> [pid 32030] <... write resumed> )       = 8
>> [pid 32030] rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
>> [pid 32030] rt_sigsuspend([] <unfinished ...>
>> [pid 32029] <... nanosleep resumed> 0xfff9fd98) = 0
>> [pid 32029] write(1, "stoping...\n", 11stoping...) = 11
>> [pid 32029] openat(AT_FDCWD, "/root/sys-root/libilp32/libgcc_s.so.1", O_RDONLY|O_CLOEXEC) = 3
>> [pid 32029] read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0 \0\0004\0\0\0"..., 512) = 512
>> [pid 32029] fstat(3, {st_mode=S_IFREG|0644, st_size=429138, ...}) = 0
>> [pid 32029] mmap(NULL, 135104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xdb3db000
>> [pid 32029] mprotect(0xdb3ec000, 61440, PROT_NONE) = 0
>> [pid 32029] mmap(0xdb3fb000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10000) = 0xdb3fb000
>> [pid 32029] close(3)                    = 0
>> [pid 32029] tgkill(32029, 32030, SIGRTMIN) = 0
>> [pid 32030] <... rt_sigsuspend resumed> ) = ? ERESTARTNOHAND (To be
>> restarted if no handler)
>> [pid 32029] write(1, "pthread_cancel == 0\n", 20pthread_cancel == 0) = 20
>> [pid 32030] --- SIGRTMIN {si_signo=SIGRTMIN, si_code=SI_TKILL, si_pid=32029, si_uid=0} ---
>> [pid 32029] write(1, "stopped\n", 8stopped
>> <unfinished ...>
>> [pid 32030] --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0x14} ---
>> [pid 32029] <... write resumed> )       = ? <unavailable>
>> [pid 32030] +++ killed by SIGSEGV +++
>> +++ killed by SIGSEGV +++
>> Segmentation fault
>>
>> dmesg:
>> trigo[32246]: unhandled level 2 translation fault (11) at 0x00000014,
>> esr 0x90000006
>> pgd = ffffffc009335000
>> [00000014] *pgd=000000007917c003, *pud=000000007917c003,
>> *pmd=0000000000000000
>>
>> CPU: 2 PID: 32246 Comm: trigo Not tainted 4.5.0+ #91
>> Hardware name: linux,dummy-virt (DT)
>> task: ffffffc00900e400 ti: ffffffc009078000 task.ti: ffffffc009078000
>> PC is at 0xda6853f0
>> LR is at 0xda6d5440
>> pc : [<00000000da6853f0>] lr : [<00000000da6d5440>] pstate: 60000000
>> sp : 00000000da511bc0
>> x29: 00000000da512e10 x28: 00000000da6a7000
>> x27: 0000000000000000 x26: 00000000da513490
>> x25: 0000000000000000 x24: 0000000000400820
>> x23: 00000000da6a9000 x22: 00000000ff869acb
>> x21: 00000000da6a9000 x20: 00000000da512e50
>> x19: 0000000000000000 x18: 0000000000000001
>> x17: 0000000000410bd8 x16: 00000000da691138
>> x15: 0000000000000000 x14: 0000000000000000
>> x13: 00000000da535970 x12: 0000000000000038
>> x11: 0000000000000028 x10: 0101010101010101
>> x9 : ff63647371607372 x8 : 0000000000000085
>> x7 : 0000000000007df5 x6 : 00000000da512e1c
>> x5 : 00000000da513518 x4 : 0000000000000002
>> x3 : 00000000da513920 x2 : 0000000000000000
>> x1 : 0000000000000008 x0 : 00000000da513490
>>
>
