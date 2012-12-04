From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Tue, 04 Dec 2012 10:16:32 +0530
Subject: [RFC v2 PATCH 2.1] sched: Use Per-Entity-Load-Tracking metric
 for load balancing
In-Reply-To: <20121115165422.17426.3978.stgit@preeti.in.ibm.com>
References: <20121115164730.17426.36051.stgit@preeti.in.ibm.com>
 <20121115165422.17426.3978.stgit@preeti.in.ibm.com>
Message-ID: <50BD8028.1040909@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


sched: Use Per-Entity-Load-Tracking metric for load balancing

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Currently the load balancer weighs a task based upon its priority,and this
weight consequently gets added up to the weight of the run queue that it is
on.It is this weight of the runqueue that sums up to a sched group's load
which is used to decide the busiest or the idlest group and the runqueue
thereof.

The Per-Entity-Load-Tracking metric however measures how long a task has
been runnable over the duration of its lifetime.This gives us a hint of
the amount of CPU time that the task can demand.This metric takes care of the
task priority as well.Therefore apart from the priority of a task we also
have an idea of the live behavior of the task.This seems to be a more
realistic metric to use to compute task weight which adds upto the run queue
weight and the weight of the sched group.Consequently they can be used for
load balancing.

The semantics of load balancing is left untouched.The two functions
load_balance() and select_task_rq_fair() perform the task of load
balancing.These two paths have been browsed through in this patch to make
necessary changes.

weighted_cpuload() and task_h_load() provide the run queue weight and the
weight of the task respectively.They have been modified to provide the
Per-Entity-Load-Tracking metric as relevant for each.
The rest of the modifications had to be made to suit these two changes.

Completely Fair Scheduler class is the only sched_class which contributes to
the run queue load.Therefore the rq->load.weight==cfs_rq->load.weight when
the cfs_rq is the root cfs_rq (rq->cfs) of the hierarchy.When replacing this
with Per-Entity-Load-Tracking metric,cfs_rq->runnable_load_avg needs to be
used as this is the right reflection of the run queue load when
the cfs_rq is the root cfs_rq (rq->cfs) of the hierarchy.This metric reflects
the percentage uptime of the tasks that are queued on it and hence that contribute
to the load.Thus cfs_rq->runnable_load_avg replaces the metric earlier used in
weighted_cpuload().

The task load is aptly captured by se.avg.load_avg_contrib which captures the
runnable time vs the alive time of the task against its priority.This metric
replaces the earlier metric used in task_h_load().

The consequent changes appear as data type changes for the helper variables;
they abound in number.Because cfs_rq->runnable_load_avg needs to be big enough
to capture the tasks' load often and accurately.

The following patch does not consider CONFIG_FAIR_GROUP_SCHED AND
CONFIG_SCHED_NUMA.This is done so as to evaluate this approach starting from the
simplest scenario.Earlier discussions can be found in the link below.

Link: https://lkml.org/lkml/2012/10/25/162
Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
I apologise about having overlooked this one change in the patchset.This needs to
be applied on top of patch2 of this patchset.The experiment results that have been
posted in reply to this thread are done after having applied this patch.

 kernel/sched/fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f8f3a29..19094eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4362,7 +4362,7 @@ struct sd_lb_stats {
  * sg_lb_stats - stats of a sched_group required for load_balancing
  */
 struct sg_lb_stats {
-	unsigned long avg_load; /*Avg load across the CPUs of the group */
+	u64 avg_load; /*Avg load across the CPUs of the group */
 	u64 group_load; /* Total load over the CPUs of the group */
 	unsigned long sum_nr_running; /* Nr tasks running in the group */
 	u64 sum_weighted_load; /* Weighted load of group's tasks */
