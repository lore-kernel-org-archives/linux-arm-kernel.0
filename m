From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 21 Jun 2011 17:32:04 -0500
Subject: [PATCH] ARM: quiet sparse noise due to
	__ARCH_WANT_SYS_RT_SIG(ACTION|SUSPEND)
In-Reply-To: <BANLkTi=8mstQAWKxBBBFH_+byGoXr8ieRg@mail.gmail.com>
References: <201106211209.46462.hartleys@visionengravers.com>
	<BANLkTi=8mstQAWKxBBBFH_+byGoXr8ieRg@mail.gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F38227C321@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 21, 2011 12:31 PM, Mike Frysinger wrote:
> On Tue, Jun 21, 2011 at 15:09, H Hartley Sweeten wrote:
>> --- a/arch/arm/include/asm/unistd.h
>> +++ b/arch/arm/include/asm/unistd.h
>> @@ -467,6 +467,20 @@
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/types.h>
>> +#include <linux/linkage.h>
>> +#include <linux/compiler.h>
>> +#include <linux/signal.h>
>> +
>> +asmlinkage long sys_rt_sigaction(int sig, const struct sigaction __user *act,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct sigaction __user *oact,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?size_t sigsetsize);
>> +asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize);
>> +
>> +#endif /* !__ASSEMBLY__ */
>
> yikes ... this really the only way to fix the sparse warning ?

Not sure...

Russell's patch to add an asm/syscalls.h fixes the other system call
sparse warnings in arm/arm/kernel/* but it doesn't fix the ones in
kernel/signal.c.  This patch does but, as Russell said, asm/unistd.h
is exported to it's a bit ugly.

BTW, arch/ia64 does something very similar:


#if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)

#include <linux/types.h>
#include <linux/linkage.h>
#include <linux/compiler.h>

extern long __ia64_syscall (long a0, long a1, long a2, long a3, long a4, long nr);

asmlinkage unsigned long sys_mmap(
				unsigned long addr, unsigned long len,
				int prot, int flags,
				int fd, long off);
asmlinkage unsigned long sys_mmap2(
				unsigned long addr, unsigned long len,
				int prot, int flags,
				int fd, long pgoff);
struct pt_regs;
struct sigaction;
asmlinkage long sys_ia64_pipe(void);
asmlinkage long sys_rt_sigaction(int sig,
				 const struct sigaction __user *act,
				 struct sigaction __user *oact,
				 size_t sigsetsize);

Regards,
Hartley
