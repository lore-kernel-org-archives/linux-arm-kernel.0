From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Fri, 6 May 2016 20:02:20 +0800
Subject: [PATCH 15/25] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
In-Reply-To: <1459894127-17698-16-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-16-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <572C87CC.4090709@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016/4/6 6:08, Yury Norov wrote:
> Based on patch of Andrew Pinski.
>
> This patch introduces is_a32_compat_task and is_a32_thread so it is
> easier to say this is a a32 specific thread or a generic compat thread/task.
> Corresponding functions are located in <asm/is_compat.h> to avoid mess in
> headers.
>
> Some files include both <linux/compat.h> and <asm/compat.h>,
> and this is wrong because <linux/compat.h> has <asm/compat.h> already
> included. It was fixed too.

1.  in "kernel/seccomp.c"
     There are different list for a32 and LP64. I do not know we
     should add a new one or align to one of them. Currently, we
     align ilp32 to a32 list.
```
/*
  * Secure computing mode 1 allows only read/write/exit/sigreturn.
  * To be fully secure this must be combined with rlimit
  * to limit the stack allocations too.
  */
static int mode1_syscalls[] = {
         __NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
         0, /* null terminated */
};

#ifdef CONFIG_COMPAT
static int mode1_syscalls_32[] = {
         __NR_seccomp_read_32, __NR_seccomp_write_32, __NR_seccomp_exit_32, __NR_seccomp_sigreturn_32,
         0, /* null terminated */
};
#endif

static void __secure_computing_strict(int this_syscall)
{
         int *syscall_whitelist = mode1_syscalls;
#ifdef CONFIG_COMPAT
         if (in_compat_syscall())
                 syscall_whitelist = mode1_syscalls_32;
#endif
```

2.  in "kernel/auditsc.c"
     __audit_seccomp will print if compat or not. But in the same file,
     it call syscall_get_arch() to get the architecture in which ILP32
     is same as LP64.
     And consequenly, do we need to split in_compat_syscall to
     in_a32_compat_syscall and in_ilp32 compat_syscall?

```
void __audit_seccomp(unsigned long syscall, long signr, int code)
{
         struct audit_buffer *ab;

         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_SECCOMP);
         if (unlikely(!ab))
                 return;
         audit_log_task(ab);
         audit_log_format(ab, " sig=%ld arch=%x syscall=%ld compat=%d ip=0x%lx code=0x%x",
                          signr, syscall_get_arch(), syscall,
                          in_compat_syscall(), KSTK_EIP(current), code);
         audit_log_end(ab);
}
```

Thanks

Bamvor
