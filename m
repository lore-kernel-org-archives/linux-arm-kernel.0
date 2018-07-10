From: mpatocka@redhat.com (Mikulas Patocka)
Date: Mon, 9 Jul 2018 23:04:33 -0400 (EDT)
Subject: [PATCH] arm64: fix infinite stacktrace
In-Reply-To: <20180628164900.GB26019@e103592.cambridge.arm.com>
References: <alpine.LRH.2.02.1806141457200.4243@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115823.2oq5d7amzwlliczg@lakrids.cambridge.arm.com>
 <20180627164150.GB8729@arm.com>
 <20180628164900.GB26019@e103592.cambridge.arm.com>
Message-ID: <alpine.LRH.2.02.1807092300520.24277@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thu, 28 Jun 2018, Dave Martin wrote:

> On Wed, Jun 27, 2018 at 05:41:51PM +0100, Will Deacon wrote:
> > Hi all,
> > 
> > On Fri, Jun 15, 2018 at 12:58:23PM +0100, Mark Rutland wrote:
> > > On Thu, Jun 14, 2018 at 02:58:21PM -0400, Mikulas Patocka wrote:
> > > > I've got this infinite stacktrace when debugging another problem:
> > > > [  908.795225] INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > [  908.796176]  1-...!: (1 GPs behind) idle=952/1/4611686018427387904 softirq=1462/1462 fqs=355
> > > > [  908.797692]  2-...!: (1 GPs behind) idle=f42/1/4611686018427387904 softirq=1550/1551 fqs=355
> > > > [  908.799189]  (detected by 0, t=2109 jiffies, g=130, c=129, q=235)
> > > > [  908.800284] Task dump for CPU 1:
> > > > [  908.800871] kworker/1:1     R  running task        0    32      2 0x00000022
> > > > [  908.802127] Workqueue: writecache-writeabck writecache_writeback [dm_writecache]
> > > > [  908.820285] Call trace:
> > > > [  908.824785]  __switch_to+0x68/0x90
> > > > [  908.837661]  0xfffffe00603afd90
> > > > [  908.844119]  0xfffffe00603afd90
> > > > [  908.850091]  0xfffffe00603afd90
> > > > [  908.854285]  0xfffffe00603afd90
> > > > [  908.863538]  0xfffffe00603afd90
> > > > [  908.865523]  0xfffffe00603afd90
> > > > 
> > > > The machine just locked up and kept on printing the same line over and
> > > > over again. This patch fixes it.
> > > > 
> > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > > Cc: stable at vger.kernel.org
> > > 
> > > Given this can only occur when there's a corrupted stack (where a frame
> > > record points to itself), I'm not sure this requires a cc stable.
> > > 
> > > > Index: linux-2.6/arch/arm64/kernel/stacktrace.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/arch/arm64/kernel/stacktrace.c
> > > > +++ linux-2.6/arch/arm64/kernel/stacktrace.c
> > > > @@ -56,6 +56,9 @@ int notrace unwind_frame(struct task_str
> > > >  	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
> > > >  	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> > > >  
> > > > +	if (frame->fp <= fp)
> > > > +		return -EINVAL;
> > > > +
> > > 
> > > Dave Martin had a series [1] which addressed this along with a number of
> > > other cases where stack traces might not terminate.
> > > 
> > > Dave, do you plan to respin that?
> > 
> > I'd be interested in an update on that; we clearly should be fixing this in
> > one way or another.
> > 
> > Mikulus -- would you be able to test and/or review it, please?
> 
> My patch was arguably over-engineered, and broken in some way connected
> with SDEI.  Unfortunately I've had too much other stuff to do...
> 
> I could take another look, but it may take time to get to it.
> 
> Alternatively, if someone wants to pick up my patch and take it forward,
> I'm happy to comment.
> 
> Cheers
> ---Dave

Or - what about this patch? It doesn't guarantee that infinite loop won't 
happen, but it at least catches the most obvious loop on the same address.


From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] arm64: fix infinite stacktrace

I've got this infinite stacktrace when debugging another problem:
[  908.795225] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  908.796176]  1-...!: (1 GPs behind) idle=952/1/4611686018427387904 softirq=1462/1462 fqs=355
[  908.797692]  2-...!: (1 GPs behind) idle=f42/1/4611686018427387904 softirq=1550/1551 fqs=355
[  908.799189]  (detected by 0, t=2109 jiffies, g=130, c=129, q=235)
[  908.800284] Task dump for CPU 1:
[  908.800871] kworker/1:1     R  running task        0    32      2 0x00000022
[  908.802127] Workqueue: writecache-writeabck writecache_writeback [dm_writecache]
[  908.820285] Call trace:
[  908.824785]  __switch_to+0x68/0x90
[  908.837661]  0xfffffe00603afd90
[  908.844119]  0xfffffe00603afd90
[  908.850091]  0xfffffe00603afd90
[  908.854285]  0xfffffe00603afd90
[  908.863538]  0xfffffe00603afd90
[  908.865523]  0xfffffe00603afd90

The machine just locked up and kept on printing the same line over and
over again. This patch fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable at vger.kernel.org

---
 arch/arm64/kernel/stacktrace.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/arch/arm64/kernel/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/arm64/kernel/stacktrace.c	2018-07-10 05:01:56.990000000 +0200
+++ linux-2.6/arch/arm64/kernel/stacktrace.c	2018-07-10 05:02:51.650000000 +0200
@@ -56,6 +56,9 @@ int notrace unwind_frame(struct task_str
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
+	if (frame->fp == fp)
+		return -EINVAL;
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
