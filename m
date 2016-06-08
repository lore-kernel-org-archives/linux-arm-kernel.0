From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 8 Jun 2016 20:00:48 +0300
Subject: [PATCH 17/23] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <57577611.9000607@huawei.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-18-git-send-email-ynorov@caviumnetworks.com>
 <57577611.9000607@huawei.com>
Message-ID: <20160608170048.GA24482@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:34:09AM +0800, zhouchengming wrote:
> On 2016/5/24 8:04, Yury Norov wrote:
> >Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
> >detection of the task type.
> >
> >Signed-off-by: Yury Norov<ynorov@caviumnetworks.com>

[...]

> Hello, I found ilp32 will use sys_ptrace, not compat_sys_ptrace. So I write
> a little patch to see if can solve the problem correctly.
> 
> Thanks.
> 
> From f6156236df578bb05c4a17e7f9776ceaf8f7afe6 Mon Sep 17 00:00:00 2001
> From: Zhou Chengming <zhouchengming1@huawei.com>
> Date: Wed, 8 Jun 2016 09:46:23 +0800
> Subject: [PATCH] ilp32: use compat_sys_ptrace instead of sys_ptrace
> 
> When we analyze a testcase of ptrace that failed on ilp32, we found
> the syscall that the ilp32 uses is sys_ptrace, not compat_sys_ptrace.
> Because in include/uapi/asm-generic/unistd.h it's defined like:
> __SYSCALL(__NR_ptrace, sys_ptrace)
> So we change it to __SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace),
> let compat tasks use the compat_sys_ptrace.
> 
> Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
> ---
>  include/uapi/asm-generic/unistd.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/unistd.h
> b/include/uapi/asm-generic/unistd.h
> index 2862d2e..50ee770 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -364,7 +364,7 @@ __SC_WRAP(__NR_syslog, sys_syslog)
> 
>  /* kernel/ptrace.c */
>  #define __NR_ptrace 117
> -__SYSCALL(__NR_ptrace, sys_ptrace)
> +__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
> 
>  /* kernel/sched/core.c */
>  #define __NR_sched_setparam 118
> -- 
> 1.7.7
> 

Hi Zhou,

Thank you for the catch.

Could you also show the test that is failed for you. It should
probably be sent to LTP maillist.

I'm not sure your fix correct as it affects other architectures that
use standard unistd.h. I think it's better to redirect the syscall in
arch/arm64/kernel/sys_ilp32.c with corresponding definition.

Yury
