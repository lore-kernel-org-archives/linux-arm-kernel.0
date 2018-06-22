From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 08:49:20 +0100
Subject: [PATCH] locking/qspinlock: Fix build for anonymous union in
 older gcc compilers
In-Reply-To: <20180621203526.172ab5c4@vmware.local.home>
References: <20180621203526.172ab5c4@vmware.local.home>
Message-ID: <20180622074920.GA7601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Jun 21, 2018 at 08:35:26PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> One of my tests compiles the kernel with gcc 4.5.3, and I hit the
> following build error:
> 
> /work/git/linux-trace.git/include/linux/semaphore.h: In function 'sema_init':
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: error: unknown field 'val' specified in initializer
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: missing braces around initializer
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: (near initialization for '(anonymous).raw_lock.<anonymous>.val')
> In file included from /work/git/linux-trace.git/include/linux/sched/user.h:7:0,
>                  from /work/git/linux-trace.git/include/linux/cred.h:22,
>                  from /work/git/linux-trace.git/include/linux/seq_file.h:12,
>                  from /work/git/linux-trace.git/include/linux/cgroup.h:18,
>                  from /work/git/linux-trace.git/include/linux/memcontrol.h:22,
>                  from /work/git/linux-trace.git/include/linux/swap.h:9,
>                  from /work/git/linux-trace.git/include/linux/suspend.h:5,
>                  from /work/git/linux-trace.git/arch/x86/kernel/asm-offsets.c:13:
> 
> 
> I bisected it down to the introduction of the commit that makes
> qspinlock have an anonymous union, which makes initializing it special
> for older compilers. By adding strategic brackets, it makes the build
> happy again.
> 
> Fixes: 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Cheers for spotting this and fixing it up! I know it's already in -tip, but
anyway:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
