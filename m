From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 10:13:39 +0100
Subject: [PATCH] arm64: fix infinite stacktrace
In-Reply-To: <alpine.LRH.2.02.1807092300520.24277@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1806141457200.4243@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115823.2oq5d7amzwlliczg@lakrids.cambridge.arm.com>
 <20180627164150.GB8729@arm.com>
 <20180628164900.GB26019@e103592.cambridge.arm.com>
 <alpine.LRH.2.02.1807092300520.24277@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180710091338.GA29791@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 11:04:33PM -0400, Mikulas Patocka wrote:
> On Thu, 28 Jun 2018, Dave Martin wrote:
> > Alternatively, if someone wants to pick up my patch and take it forward,
> > I'm happy to comment.
> > 
> > Cheers
> > ---Dave
> 
> Or - what about this patch? It doesn't guarantee that infinite loop won't 
> happen, but it at least catches the most obvious loop on the same address.
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> Subject: [PATCH] arm64: fix infinite stacktrace
> 
> I've got this infinite stacktrace when debugging another problem:
> [  908.795225] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  908.796176]  1-...!: (1 GPs behind) idle=952/1/4611686018427387904 softirq=1462/1462 fqs=355
> [  908.797692]  2-...!: (1 GPs behind) idle=f42/1/4611686018427387904 softirq=1550/1551 fqs=355
> [  908.799189]  (detected by 0, t=2109 jiffies, g=130, c=129, q=235)
> [  908.800284] Task dump for CPU 1:
> [  908.800871] kworker/1:1     R  running task        0    32      2 0x00000022
> [  908.802127] Workqueue: writecache-writeabck writecache_writeback [dm_writecache]
> [  908.820285] Call trace:
> [  908.824785]  __switch_to+0x68/0x90
> [  908.837661]  0xfffffe00603afd90
> [  908.844119]  0xfffffe00603afd90
> [  908.850091]  0xfffffe00603afd90
> [  908.854285]  0xfffffe00603afd90
> [  908.863538]  0xfffffe00603afd90
> [  908.865523]  0xfffffe00603afd90
> 
> The machine just locked up and kept on printing the same line over and
> over again. This patch fixes it.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable at vger.kernel.org
> 
> ---
>  arch/arm64/kernel/stacktrace.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/arch/arm64/kernel/stacktrace.c
> ===================================================================
> --- linux-2.6.orig/arch/arm64/kernel/stacktrace.c	2018-07-10 05:01:56.990000000 +0200
> +++ linux-2.6/arch/arm64/kernel/stacktrace.c	2018-07-10 05:02:51.650000000 +0200
> @@ -56,6 +56,9 @@ int notrace unwind_frame(struct task_str
>  	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
>  	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
>  
> +	if (frame->fp == fp)
> +		return -EINVAL;

I've already queued your previous patch using '<=' (it's in -next). If you
want to change it, please send patches on top of the arm64 for-next/core
branch.

Will
