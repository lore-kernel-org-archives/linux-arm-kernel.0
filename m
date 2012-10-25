From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:56:11 +0530
Subject: [RFC PATCH 12/13] sched: Modify find_idlest_cpu to use PJT's metric
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102611.21022.23199.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additional parameters introduced to perform this function which are
calculated using PJT's metrics and its helpers.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c64be1c1..15ec528 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3230,16 +3230,18 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 static int
 find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 {
-	unsigned long load, min_load = ULONG_MAX;
+	unsigned long load;
+	u64 cpu_load, min_cpu_load = ~0ULL;
 	int idlest = -1;
 	int i;
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
 		load = weighted_cpuload(i);
+		cpu_load = cpu_rq(i)->cfs.runnable_load_avg;
 
-		if (load < min_load || (load == min_load && i == this_cpu)) {
-			min_load = load;
+		if (cpu_load < min_cpu_load || (cpu_load == min_cpu_load && i == this_cpu)) {
+			min_cpu_load = cpu_load;
 			idlest = i;
 		}
 	}
