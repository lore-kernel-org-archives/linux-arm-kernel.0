From: preeti@linux.vnet.ibm.com (preeti)
Date: Wed, 17 Oct 2012 17:50:50 +0530
Subject: [RFC PATCH 0/2] sched: Load Balancing using Per-entity-Load-tracking
In-Reply-To: <20121012044618.18271.88332.stgit@preeti.in.ibm.com>
References: <20121012044618.18271.88332.stgit@preeti.in.ibm.com>
Message-ID: <507EA2A2.60708@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Can you please have a look at the below patchset? Your review comments
are very necessary and valuable.Thanks in advance.

> This patchset uses the per-entity-load-tracking patchset which will soon be
> available in the kernel.It is based on the tip/master tree and the first 8
> latest patches of sched:per-entity-load-tracking alone have been imported to
> the tree to avoid the complexities of task groups and to hold back the
> optimizations of this patch for now.
> 
> This patchset is an attempt to begin the integration of Per-entity-load-
> metric for the cfs_rq,henceforth referred to as PJT's metric,with the load
> balancer in a step wise fashion,and progress based on the consequences.
> 
> The following issues have been considered towards this:
> [NOTE:an x% task referred to in the logs and below is calculated over a
> duty cycle of 10ms.]
> 
> 1.Consider a scenario,where there are two 10% tasks running on a cpu.The
>   present code will consider the load on this queue to be 2048,while
>   using PJT's metric the load is calculated to be <1000,rarely exceeding this
>   limit.Although the tasks are not contributing much to the cpu load,they are
>   decided to be moved by the scheduler.
> 
>   But one could argue that 'not moving one of these tasks could throttle
>   them.If there was an idle cpu,perhaps we could have moved them'.While the
>   power save mode would have been fine with not moving the task,the
>   performance mode would prefer not to throttle the tasks.We could strive
>   to strike a balance by making this decision tunable with certain parameters.
>   This patchset includes such tunables.This issue is addressed in Patch[1/2].
> 
> 2.We need to be able to do this cautiously,as the scheduler code is too
>   complex.This patchset is an attempt to begin the integration of PJT's
>   metric with the load balancer in a step wise fashion,and progress based on
>   the consequences.
>   I dont intend to vary the parameters used by the load balancer.Some
>   parameters are however included anew to make decisions about including a
>   sched group as a candidate for load balancing.
> 
>   This patchset therefore has two primary aims.
>          Patch[1/2]: This patch aims at detecting short running tasks and
> 	 prevent their movement.In update_sg_lb_stats,dismiss a sched group
> 	 as a candidate for load balancing,if load calculated by PJT's metric
> 	 says that the average load on the sched_group <= 1024+(.15*1024).
> 	 This is a tunable,which can be varied after sufficient experiments.
> 
>          Patch[2/2]:In the current scheduler greater load would be analogous
>          to more number of tasks.Therefore when the busiest group is picked
>          from the sched domain in update_sd_lb_stats,only the loads of the
>          groups are compared between them.If we were to use PJT's metric,a
>          higher load does not necessarily mean more number of tasks.This
> 	 patch addresses this issue.
> 
> 3.The next step towards integration should be in using the PJT's metric for
>   comparison between the loads of the busy sched group and the sched
>   group which has to pull the tasks,which happens in find_busiest_group.
> ---
> 
> Preeti U Murthy (2):
>       sched:Prevent movement of short running tasks during load balancing
>       sched:Pick the apt busy sched group during load balancing
> 
> 
>  kernel/sched/fair.c |   38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> --
The links to PATCH[1/2] https://lkml.org/lkml/2012/10/12/13
             PATCH[2/2] https://lkml.org/lkml/2012/10/12/11
Regards
Preeti U Murthy
