From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Feb 2013 00:22:00 -0500
Subject: [PATCH v4 03/15] ARM: mcpm: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1360041732-17936-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

This provides helper methods to coordinate between CPUs coming down
and CPUs going up, as well as documentation on the used algorithms,
so that cluster teardown and setup
operations are not done for a cluster simultaneously.

For use in the power_down() implementation:
  * __mcpm_cpu_going_down(unsigned int cluster, unsigned int cpu)
  * __mcpm_outbound_enter_critical(unsigned int cluster)
  * __mcpm_outbound_leave_critical(unsigned int cluster)
  * __mcpm_cpu_down(unsigned int cluster, unsigned int cpu)

The power_up_setup() helper should do platform-specific setup in
preparation for turning the CPU on, such as invalidating local caches
or entering coherency.  It must be assembler for now, since it must
run before the MMU can be switched on.  It is passed the affinity level
which should be initialized.

Because the mcpm_sync_struct content is looked-up and modified
with the cache enabled or disabled depending on the code path, it is
crucial to always ensure proper cache maintenance to update main memory
right away.  Therefore, any cached write must be followed by a cache
clean operation and any cached read must be preceded by a cache
invalidate operation (actually a cache flush i.e. clean+invalidate to
avoid discarding possible concurrent writes) on the accessed memory.

Also, in order to prevent a cached writer from interfering with an
adjacent non-cached writer, we ensure each state variable is located to
a separate cache line.

Thanks to Nicolas Pitre and Achin Gupta for the help with this
patch.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm/cluster-pm-race-avoidance.txt | 498 ++++++++++++++++++++++++
 arch/arm/common/mcpm_entry.c                    | 197 ++++++++++
 arch/arm/common/mcpm_head.S                     | 106 ++++-
 arch/arm/include/asm/mcpm_entry.h               |  63 +++
 4 files changed, 862 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm/cluster-pm-race-avoidance.txt

diff --git a/Documentation/arm/cluster-pm-race-avoidance.txt b/Documentation/arm/cluster-pm-race-avoidance.txt
new file mode 100644
index 0000000000..750b6fc24a
--- /dev/null
+++ b/Documentation/arm/cluster-pm-race-avoidance.txt
@@ -0,0 +1,498 @@
+Cluster-wide Power-up/power-down race avoidance algorithm
+=========================================================
+
+This file documents the algorithm which is used to coordinate CPU and
+cluster setup and teardown operations and to manage hardware coherency
+controls safely.
+
+The section "Rationale" explains what the algorithm is for and why it is
+needed.  "Basic model" explains general concepts using a simplified view
+of the system.  The other sections explain the actual details of the
+algorithm in use.
+
+
+Rationale
+---------
+
+In a system containing multiple CPUs, it is desirable to have the
+ability to turn off individual CPUs when the system is idle, reducing
+power consumption and thermal dissipation.
+
+In a system containing multiple clusters of CPUs, it is also desirable
+to have the ability to turn off entire clusters.
+
+Turning entire clusters off and on is a risky business, because it
+involves performing potentially destructive operations affecting a group
+of independently running CPUs, while the OS continues to run.  This
+means that we need some coordination in order to ensure that critical
+cluster-level operations are only performed when it is truly safe to do
+so.
+
+Simple locking may not be sufficient to solve this problem, because
+mechanisms like Linux spinlocks may rely on coherency mechanisms which
+are not immediately enabled when a cluster powers up.  Since enabling or
+disabling those mechanisms may itself be a non-atomic operation (such as
+writing some hardware registers and invalidating large caches), other
+methods of coordination are required in order to guarantee safe
+power-down and power-up at the cluster level.
+
+The mechanism presented in this document describes a coherent memory
+based protocol for performing the needed coordination.  It aims to be as
+lightweight as possible, while providing the required safety properties.
+
+
+Basic model
+-----------
+
+Each cluster and CPU is assigned a state, as follows:
+
+	DOWN
+	COMING_UP
+	UP
+	GOING_DOWN
+
+	    +---------> UP ----------+
+	    |                        v
+
+	COMING_UP                GOING_DOWN
+
+	    ^                        |
+	    +--------- DOWN <--------+
+
+
+DOWN:	The CPU or cluster is not coherent, and is either powered off or
+	suspended, or is ready to be powered off or suspended.
+
+COMING_UP: The CPU or cluster has committed to moving to the UP state.
+	It may be part way through the process of initialisation and
+	enabling coherency.
+
+UP:	The CPU or cluster is active and coherent at the hardware
+	level.  A CPU in this state is not necessarily being used
+	actively by the kernel.
+
+GOING_DOWN: The CPU or cluster has committed to moving to the DOWN
+	state.  It may be part way through the process of teardown and
+	coherency exit.
+
+
+Each CPU has one of these states assigned to it at any point in time.
+The CPU states are described in the "CPU state" section, below.
+
+Each cluster is also assigned a state, but it is necessary to split the
+state value into two parts (the "cluster" state and "inbound" state) and
+to introduce additional states in order to avoid races between different
+CPUs in the cluster simultaneously modifying the state.  The cluster-
+level states are described in the "Cluster state" section.
+
+To help distinguish the CPU states from cluster states in this
+discussion, the state names are given a CPU_ prefix for the CPU states,
+and a CLUSTER_ or INBOUND_ prefix for the cluster states.
+
+
+CPU state
+---------
+
+In this algorithm, each individual core in a multi-core processor is
+referred to as a "CPU".  CPUs are assumed to be single-threaded:
+therefore, a CPU can only be doing one thing@a single point in time.
+
+This means that CPUs fit the basic model closely.
+
+The algorithm defines the following states for each CPU in the system:
+
+	CPU_DOWN
+	CPU_COMING_UP
+	CPU_UP
+	CPU_GOING_DOWN
+
+	 cluster setup and
+	CPU setup complete          policy decision
+	      +-----------> CPU_UP ------------+
+	      |                                v
+
+	CPU_COMING_UP                   CPU_GOING_DOWN
+
+	      ^                                |
+	      +----------- CPU_DOWN <----------+
+	 policy decision           CPU teardown complete
+	or hardware event
+
+
+The definitions of the four states correspond closely to the states of
+the basic model.
+
+Transitions between states occur as follows.
+
+A trigger event (spontaneous) means that the CPU can transition to the
+next state as a result of making local progress only, with no
+requirement for any external event to happen.
+
+
+CPU_DOWN:
+
+	A CPU reaches the CPU_DOWN state when it is ready for
+	power-down.  On reaching this state, the CPU will typically
+	power itself down or suspend itself, via a WFI instruction or a
+	firmware call.
+
+	Next state:	CPU_COMING_UP
+	Conditions:	none
+
+	Trigger events:
+
+		a) an explicit hardware power-up operation, resulting
+		   from a policy decision on another CPU;
+
+		b) a hardware event, such as an interrupt.
+
+
+CPU_COMING_UP:
+
+	A CPU cannot start participating in hardware coherency until the
+	cluster is set up and coherent.  If the cluster is not ready,
+	then the CPU will wait in the CPU_COMING_UP state until the
+	cluster has been set up.
+
+	Next state:	CPU_UP
+	Conditions:	The CPU's parent cluster must be in CLUSTER_UP.
+	Trigger events:	Transition of the parent cluster to CLUSTER_UP.
+
+	Refer to the "Cluster state" section for a description of the
+	CLUSTER_UP state.
+
+
+CPU_UP:
+	When a CPU reaches the CPU_UP state, it is safe for the CPU to
+	start participating in local coherency.
+
+	This is done by jumping to the kernel's CPU resume code.
+
+	Note that the definition of this state is slightly different
+	from the basic model definition: CPU_UP does not mean that the
+	CPU is coherent yet, but it does mean that it is safe to resume
+	the kernel.  The kernel handles the rest of the resume
+	procedure, so the remaining steps are not visible as part of the
+	race avoidance algorithm.
+
+	The CPU remains in this state until an explicit policy decision
+	is made to shut down or suspend the CPU.
+
+	Next state:	CPU_GOING_DOWN
+	Conditions:	none
+	Trigger events:	explicit policy decision
+
+
+CPU_GOING_DOWN:
+
+	While in this state, the CPU exits coherency, including any
+	operations required to achieve this (such as cleaning data
+	caches).
+
+	Next state:	CPU_DOWN
+	Conditions:	local CPU teardown complete
+	Trigger events:	(spontaneous)
+
+
+Cluster state
+-------------
+
+A cluster is a group of connected CPUs with some common resources.
+Because a cluster contains multiple CPUs, it can be doing multiple
+things@the same time.  This has some implications.  In particular, a
+CPU can start up while another CPU is tearing the cluster down.
+
+In this discussion, the "outbound side" is the view of the cluster state
+as seen by a CPU tearing the cluster down.  The "inbound side" is the
+view of the cluster state as seen by a CPU setting the CPU up.
+
+In order to enable safe coordination in such situations, it is important
+that a CPU which is setting up the cluster can advertise its state
+independently of the CPU which is tearing down the cluster.  For this
+reason, the cluster state is split into two parts:
+
+	"cluster" state: The global state of the cluster; or the state
+		on the outbound side:
+
+		CLUSTER_DOWN
+		CLUSTER_UP
+		CLUSTER_GOING_DOWN
+
+	"inbound" state: The state of the cluster on the inbound side.
+
+		INBOUND_NOT_COMING_UP
+		INBOUND_COMING_UP
+
+
+	The different pairings of these states results in six possible
+	states for the cluster as a whole:
+
+	                            CLUSTER_UP
+	          +==========> INBOUND_NOT_COMING_UP -------------+
+	          #                                               |
+	                                                          |
+	     CLUSTER_UP     <----+                                |
+	  INBOUND_COMING_UP      |                                v
+
+	          ^             CLUSTER_GOING_DOWN       CLUSTER_GOING_DOWN
+	          #              INBOUND_COMING_UP <=== INBOUND_NOT_COMING_UP
+
+	    CLUSTER_DOWN         |                                |
+	  INBOUND_COMING_UP <----+                                |
+	                                                          |
+	          ^                                               |
+	          +===========     CLUSTER_DOWN      <------------+
+	                       INBOUND_NOT_COMING_UP
+
+	Transitions -----> can only be made by the outbound CPU, and
+	only involve changes to the "cluster" state.
+
+	Transitions ===##> can only be made by the inbound CPU, and only
+	involve changes to the "inbound" state, except where there is no
+	further transition possible on the outbound side (i.e., the
+	outbound CPU has put the cluster into the CLUSTER_DOWN state).
+
+	The race avoidance algorithm does not provide a way to determine
+	which exact CPUs within the cluster play these roles.  This must
+	be decided in advance by some other means.  Refer to the section
+	"Last man and first man selection" for more explanation.
+
+
+	CLUSTER_DOWN/INBOUND_NOT_COMING_UP is the only state where the
+	cluster can actually be powered down.
+
+	The parallelism of the inbound and outbound CPUs is observed by
+	the existence of two different paths from CLUSTER_GOING_DOWN/
+	INBOUND_NOT_COMING_UP (corresponding to GOING_DOWN in the basic
+	model) to CLUSTER_DOWN/INBOUND_COMING_UP (corresponding to
+	COMING_UP in the basic model).  The second path avoids cluster
+	teardown completely.
+
+	CLUSTER_UP/INBOUND_COMING_UP is equivalent to UP in the basic
+	model.  The final transition to CLUSTER_UP/INBOUND_NOT_COMING_UP
+	is trivial and merely resets the state machine ready for the
+	next cycle.
+
+	Details of the allowable transitions follow.
+
+	The next state in each case is notated
+
+		<cluster state>/<inbound state> (<transitioner>)
+
+	where the <transitioner> is the side on which the transition
+	can occur; either the inbound or the outbound side.
+
+
+CLUSTER_DOWN/INBOUND_NOT_COMING_UP:
+
+	Next state:	CLUSTER_DOWN/INBOUND_COMING_UP (inbound)
+	Conditions:	none
+	Trigger events:
+
+		a) an explicit hardware power-up operation, resulting
+		   from a policy decision on another CPU;
+
+		b) a hardware event, such as an interrupt.
+
+
+CLUSTER_DOWN/INBOUND_COMING_UP:
+
+	In this state, an inbound CPU sets up the cluster, including
+	enabling of hardware coherency at the cluster level and any
+	other operations (such as cache invalidation) which are required
+	in order to achieve this.
+
+	The purpose of this state is to do sufficient cluster-level
+	setup to enable other CPUs in the cluster to enter coherency
+	safely.
+
+	Next state:	CLUSTER_UP/INBOUND_COMING_UP (inbound)
+	Conditions:	cluster-level setup and hardware coherency complete
+	Trigger events:	(spontaneous)
+
+
+CLUSTER_UP/INBOUND_COMING_UP:
+
+	Cluster-level setup is complete and hardware coherency is
+	enabled for the cluster.  Other CPUs in the cluster can safely
+	enter coherency.
+
+	This is a transient state, leading immediately to
+	CLUSTER_UP/INBOUND_NOT_COMING_UP.  All other CPUs on the cluster
+	should consider treat these two states as equivalent.
+
+	Next state:	CLUSTER_UP/INBOUND_NOT_COMING_UP (inbound)
+	Conditions:	none
+	Trigger events:	(spontaneous)
+
+
+CLUSTER_UP/INBOUND_NOT_COMING_UP:
+
+	Cluster-level setup is complete and hardware coherency is
+	enabled for the cluster.  Other CPUs in the cluster can safely
+	enter coherency.
+
+	The cluster will remain in this state until a policy decision is
+	made to power the cluster down.
+
+	Next state:	CLUSTER_GOING_DOWN/INBOUND_NOT_COMING_UP (outbound)
+	Conditions:	none
+	Trigger events:	policy decision to power down the cluster
+
+
+CLUSTER_GOING_DOWN/INBOUND_NOT_COMING_UP:
+
+	An outbound CPU is tearing the cluster down.  The selected CPU
+	must wait in this state until all CPUs in the cluster are in the
+	CPU_DOWN state.
+
+	When all CPUs are in the CPU_DOWN state, the cluster can be torn
+	down, for example by cleaning data caches and exiting
+	cluster-level coherency.
+
+	To avoid wasteful unnecessary teardown operations, the outbound
+	should check the inbound cluster state for asynchronous
+	transitions to INBOUND_COMING_UP.  Alternatively, individual
+	CPUs can be checked for entry into CPU_COMING_UP or CPU_UP.
+
+
+	Next states:
+
+	CLUSTER_DOWN/INBOUND_NOT_COMING_UP (outbound)
+		Conditions:	cluster torn down and ready to power off
+		Trigger events:	(spontaneous)
+
+	CLUSTER_GOING_DOWN/INBOUND_COMING_UP (inbound)
+		Conditions:	none
+		Trigger events:
+
+			a) an explicit hardware power-up operation,
+			   resulting from a policy decision on another
+			   CPU;
+
+			b) a hardware event, such as an interrupt.
+
+
+CLUSTER_GOING_DOWN/INBOUND_COMING_UP:
+
+	The cluster is (or was) being torn down, but another CPU has
+	come online in the meantime and is trying to set up the cluster
+	again.
+
+	If the outbound CPU observes this state, it has two choices:
+
+		a) back out of teardown, restoring the cluster to the
+		   CLUSTER_UP state;
+
+		b) finish tearing the cluster down and put the cluster
+		   in the CLUSTER_DOWN state; the inbound CPU will
+		   set up the cluster again from there.
+
+	Choice (a) permits the removal of some latency by avoiding
+	unnecessary teardown and setup operations in situations where
+	the cluster is not really going to be powered down.
+
+
+	Next states:
+
+	CLUSTER_UP/INBOUND_COMING_UP (outbound)
+		Conditions:	cluster-level setup and hardware
+				coherency complete
+		Trigger events:	(spontaneous)
+
+	CLUSTER_DOWN/INBOUND_COMING_UP (outbound)
+		Conditions:	cluster torn down and ready to power off
+		Trigger events:	(spontaneous)
+
+
+Last man and First man selection
+--------------------------------
+
+The CPU which performs cluster tear-down operations on the outbound side
+is commonly referred to as the "last man".
+
+The CPU which performs cluster setup on the inbound side is commonly
+referred to as the "first man".
+
+The race avoidance algorithm documented above does not provide a
+mechanism to choose which CPUs should play these roles.
+
+
+Last man:
+
+When shutting down the cluster, all the CPUs involved are initially
+executing Linux and hence coherent.  Therefore, ordinary spinlocks can
+be used to select a last man safely, before the CPUs become
+non-coherent.
+
+
+First man:
+
+Because CPUs may power up asynchronously in response to external wake-up
+events, a dynamic mechanism is needed to make sure that only one CPU
+attempts to play the first man role and do the cluster-level
+initialisation: any other CPUs must wait for this to complete before
+proceeding.
+
+Cluster-level initialisation may involve actions such as configuring
+coherency controls in the bus fabric.
+
+The current implementation in mcpm_head.S uses a separate mutual exclusion
+mechanism to do this arbitration.  This mechanism is documented in
+detail in vlocks.txt.
+
+
+Features and Limitations
+------------------------
+
+Implementation:
+
+	The current ARM-based implementation is split between
+	arch/arm/common/mcpm_head.S (low-level inbound CPU operations) and
+	arch/arm/common/mcpm_entry.c (everything else):
+
+	__mcpm_cpu_going_down() signals the transition of a CPU to the
+		CPU_GOING_DOWN state.
+
+	__mcpm_cpu_down() signals the transition of a CPU to the CPU_DOWN
+		state.
+
+	A CPU transitions to CPU_COMING_UP and then to CPU_UP via the
+		low-level power-up code in mcpm_head.S.  This could
+		involve CPU-specific setup code, but in the current
+		implementation it does not.
+
+	__mcpm_outbound_enter_critical() and __mcpm_outbound_leave_critical()
+		handle transitions from CLUSTER_UP to CLUSTER_GOING_DOWN
+		and from there to CLUSTER_DOWN or back to CLUSTER_UP (in
+		the case of an aborted cluster power-down).
+
+		These functions are more complex than the __mcpm_cpu_*()
+		functions due to the extra inter-CPU coordination which
+		is needed for safe transitions at the cluster level.
+
+	A cluster transitions from CLUSTER_DOWN back to CLUSTER_UP via
+		the low-level power-up code in mcpm_head.S.  This
+		typically involves platform-specific setup code,
+		provided by the platform-specific power_up_setup
+		function registered via mcpm_sync_init.
+
+Deep topologies:
+
+	As currently described and implemented, the algorithm does not
+	support CPU topologies involving more than two levels (i.e.,
+	clusters of clusters are not supported).  The algorithm could be
+	extended by replicating the cluster-level states for the
+	additional topological levels, and modifying the transition
+	rules for the intermediate (non-outermost) cluster levels.
+
+
+Colophon
+--------
+
+Originally created and documented by Dave Martin for Linaro Limited, in
+collaboration with Nicolas Pitre and Achin Gupta.
+
+Copyright (C) 2012-2013  Linaro Limited
+Distributed under the terms of Version 2 of the GNU General Public
+License, as defined in linux/COPYING.
diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index c8c0e2113e..2b83121966 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -18,6 +18,7 @@
 #include <asm/proc-fns.h>
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
+#include <asm/cputype.h>
 
 extern volatile unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
 
@@ -115,3 +116,199 @@ int mcpm_cpu_powered_up(void)
 		platform_ops->powered_up();
 	return 0;
 }
+
+struct sync_struct mcpm_sync;
+
+/*
+ * There is no __cpuc_clean_dcache_area but we use it anyway for
+ * code intent clarity, and alias it to __cpuc_flush_dcache_area.
+ */
+#define __cpuc_clean_dcache_area __cpuc_flush_dcache_area
+
+/*
+ * Ensure preceding writes to *p by this CPU are visible to
+ * subsequent reads by other CPUs:
+ */
+static void __sync_range_w(volatile void *p, size_t size)
+{
+	char *_p = (char *)p;
+
+	__cpuc_clean_dcache_area(_p, size);
+	outer_clean_range(__pa(_p), __pa(_p + size));
+}
+
+/*
+ * Ensure preceding writes to *p by other CPUs are visible to
+ * subsequent reads by this CPU.  We must be careful not to
+ * discard data simultaneously written by another CPU, hence the
+ * usage of flush rather than invalidate operations.
+ */
+static void __sync_range_r(volatile void *p, size_t size)
+{
+	char *_p = (char *)p;
+
+#ifdef CONFIG_OUTER_CACHE
+	if (outer_cache.flush_range) {
+		/*
+		 * Ensure dirty data migrated from other CPUs into our cache
+		 * are cleaned out safely before the outer cache is cleaned:
+		 */
+		__cpuc_clean_dcache_area(_p, size);
+
+		/* Clean and invalidate stale data for *p from outer ... */
+		outer_flush_range(__pa(_p), __pa(_p + size));
+	}
+#endif
+
+	/* ... and inner cache: */
+	__cpuc_flush_dcache_area(_p, size);
+}
+
+#define sync_w(ptr) __sync_range_w(ptr, sizeof *(ptr))
+#define sync_r(ptr) __sync_range_r(ptr, sizeof *(ptr))
+
+/*
+ * __mcpm_cpu_going_down: Indicates that the cpu is being torn down.
+ *    This must be called at the point of committing to teardown of a CPU.
+ *    The CPU cache (SCTRL.C bit) is expected to still be active.
+ */
+void __mcpm_cpu_going_down(unsigned int cpu, unsigned int cluster)
+{
+	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_GOING_DOWN;
+	sync_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
+}
+
+/*
+ * __mcpm_cpu_down: Indicates that cpu teardown is complete and that the
+ *    cluster can be torn down without disrupting this CPU.
+ *    To avoid deadlocks, this must be called before a CPU is powered down.
+ *    The CPU cache (SCTRL.C bit) is expected to be off.
+ */
+void __mcpm_cpu_down(unsigned int cpu, unsigned int cluster)
+{
+	dmb();
+	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
+	sync_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
+	dsb_sev();
+}
+
+/*
+ * __mcpm_outbound_leave_critical: Leave the cluster teardown critical section.
+ * @state: the final state of the cluster:
+ *     CLUSTER_UP: no destructive teardown was done and the cluster has been
+ *         restored to the previous state (CPU cache still active); or
+ *     CLUSTER_DOWN: the cluster has been torn-down, ready for power-off
+ *         (CPU cache disabled).
+ */
+void __mcpm_outbound_leave_critical(unsigned int cluster, int state)
+{
+	dmb();
+	mcpm_sync.clusters[cluster].cluster = state;
+	sync_w(&mcpm_sync.clusters[cluster].cluster);
+	dsb_sev();
+}
+
+/*
+ * __mcpm_outbound_enter_critical: Enter the cluster teardown critical section.
+ * This function should be called by the last man, after local CPU teardown
+ * is complete.  CPU cache expected to be active.
+ *
+ * Returns:
+ *     false: the critical section was not entered because an inbound CPU was
+ *         observed, or the cluster is already being set up;
+ *     true: the critical section was entered: it is now safe to tear down the
+ *         cluster.
+ */
+bool __mcpm_outbound_enter_critical(unsigned int cpu, unsigned int cluster)
+{
+	unsigned int i;
+	struct mcpm_sync_struct *c = &mcpm_sync.clusters[cluster];
+
+	/* Warn inbound CPUs that the cluster is being torn down: */
+	c->cluster = CLUSTER_GOING_DOWN;
+	sync_w(&c->cluster);
+
+	/* Back out if the inbound cluster is already in the critical region: */
+	sync_r(&c->inbound);
+	if (c->inbound == INBOUND_COMING_UP)
+		goto abort;
+
+	/*
+	 * Wait for all CPUs to get out of the GOING_DOWN state, so that local
+	 * teardown is complete on each CPU before tearing down the cluster.
+	 *
+	 * If any CPU has been woken up again from the DOWN state, then we
+	 * shouldn't be taking the cluster down at all: abort in that case.
+	 */
+	sync_r(&c->cpus);
+	for (i = 0; i < MAX_CPUS_PER_CLUSTER; i++) {
+		int cpustate;
+
+		if (i == cpu)
+			continue;
+
+		while (1) {
+			cpustate = c->cpus[i].cpu;
+			if (cpustate != CPU_GOING_DOWN)
+				break;
+
+			wfe();
+			sync_r(&c->cpus[i].cpu);
+		}
+
+		switch (cpustate) {
+		case CPU_DOWN:
+			continue;
+
+		default:
+			goto abort;
+		}
+	}
+
+	return true;
+
+abort:
+	__mcpm_outbound_leave_critical(cluster, CLUSTER_UP);
+	return false;
+}
+
+int __mcpm_mcpm_state(unsigned int cluster)
+{
+	sync_r(&mcpm_sync.clusters[cluster].cluster);
+	return mcpm_sync.clusters[cluster].cluster;
+}
+
+extern unsigned long mcpm_power_up_setup_phys;
+
+int __init mcpm_sync_init(
+	void (*power_up_setup)(unsigned int affinity_level))
+{
+	unsigned int i, j, mpidr, this_cluster;
+
+	BUILD_BUG_ON(MCPM_SYNC_CLUSTER_SIZE * MAX_NR_CLUSTERS != sizeof mcpm_sync);
+	BUG_ON((unsigned long)&mcpm_sync & (__CACHE_WRITEBACK_GRANULE - 1));
+
+	/*
+	 * Set initial CPU and cluster states.
+	 * Only one cluster is assumed to be active at this point.
+	 */
+	for (i = 0; i < MAX_NR_CLUSTERS; i++) {
+		mcpm_sync.clusters[i].cluster = CLUSTER_DOWN;
+		mcpm_sync.clusters[i].inbound = INBOUND_NOT_COMING_UP;
+		for (j = 0; j < MAX_CPUS_PER_CLUSTER; j++)
+			mcpm_sync.clusters[i].cpus[j].cpu = CPU_DOWN;
+	}
+	mpidr = read_cpuid_mpidr();
+	this_cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	for_each_online_cpu(i)
+		mcpm_sync.clusters[this_cluster].cpus[i].cpu = CPU_UP;
+	mcpm_sync.clusters[this_cluster].cluster = CLUSTER_UP;
+	sync_w(&mcpm_sync);
+
+	if (power_up_setup) {
+		mcpm_power_up_setup_phys = virt_to_phys(power_up_setup);
+		sync_w(&mcpm_power_up_setup_phys);
+	}
+
+	return 0;
+}
diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index cda65f200b..86650d4e94 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -7,11 +7,19 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ *
+ * Refer to Documentation/arm/cluster-pm-race-avoidance.txt
+ * for details of the synchronisation algorithms used here.
  */
 
 #include <linux/linkage.h>
 #include <asm/mcpm_entry.h>
 
+.if MCPM_SYNC_CLUSTER_CPUS
+.error "cpus must be the first member of struct mcpm_sync_struct"
+.endif
+
 	.macro	pr_dbg	string
 #if defined(CONFIG_DEBUG_LL) && defined(DEBUG)
 	b	1901f
@@ -57,24 +65,114 @@ ENTRY(mcpm_entry_point)
 2:	pr_dbg	"kernel mcpm_entry_point\n"
 
 	/*
-	 * MMU is off so we need to get to mcpm_entry_vectors in a
+	 * MMU is off so we need to get to various variables in a
 	 * position independent way.
 	 */
 	adr	r5, 3f
-	ldr	r6, [r5]
+	ldmia	r5, {r6, r7, r8}
 	add	r6, r5, r6			@ r6 = mcpm_entry_vectors
+	ldr	r7, [r5, r7]			@ r7 = mcpm_power_up_setup_phys
+	add	r8, r5, r8			@ r8 = mcpm_sync
+
+	mov	r0, #MCPM_SYNC_CLUSTER_SIZE
+	mla	r8, r0, r10, r8			@ r8 = sync cluster base
+
+	@ Signal that this CPU is coming UP:
+	mov	r0, #CPU_COMING_UP
+	mov	r5, #MCPM_SYNC_CPU_SIZE
+	mla	r5, r9, r5, r8			@ r5 = sync cpu address
+	strb	r0, [r5]
+
+	@ At this point, the cluster cannot unexpectedly enter the GOING_DOWN
+	@ state, because there is at least one active CPU (this CPU).
+
+	@ Note: the following is racy as another CPU might be testing
+	@ the same flag at the same moment.  That'll be fixed later.
+	ldrb	r0, [r8, #MCPM_SYNC_CLUSTER_CLUSTER]
+	cmp	r0, #CLUSTER_UP			@ cluster already up?
+	bne	mcpm_setup			@ if not, set up the cluster
+
+	@ Otherwise, skip setup:
+	b	mcpm_setup_complete
+
+mcpm_setup:
+	@ Control dependency implies strb not observable before previous ldrb.
+
+	@ Signal that the cluster is being brought up:
+	mov	r0, #INBOUND_COMING_UP
+	strb	r0, [r8, #MCPM_SYNC_CLUSTER_INBOUND]
+	dmb
+
+	@ Any CPU trying to take the cluster into CLUSTER_GOING_DOWN from this
+	@ point onwards will observe INBOUND_COMING_UP and abort.
+
+	@ Wait for any previously-pending cluster teardown operations to abort
+	@ or complete:
+mcpm_teardown_wait:
+	ldrb	r0, [r8, #MCPM_SYNC_CLUSTER_CLUSTER]
+	cmp	r0, #CLUSTER_GOING_DOWN
+	bne	first_man_setup
+	wfe
+	b	mcpm_teardown_wait
+
+first_man_setup:
+	dmb
+
+	@ If the outbound gave up before teardown started, skip cluster setup:
+
+	cmp	r0, #CLUSTER_UP
+	beq	mcpm_setup_leave
+
+	@ power_up_setup is now responsible for setting up the cluster:
+
+	cmp	r7, #0
+	mov	r0, #1		@ second (cluster) affinity level
+	blxne	r7		@ Call power_up_setup if defined
+	dmb
+
+	mov	r0, #CLUSTER_UP
+	strb	r0, [r8, #MCPM_SYNC_CLUSTER_CLUSTER]
+	dmb
+
+mcpm_setup_leave:
+	@ Leave the cluster setup critical section:
+
+	mov	r0, #INBOUND_NOT_COMING_UP
+	strb	r0, [r8, #MCPM_SYNC_CLUSTER_INBOUND]
+	dsb
+	sev
+
+mcpm_setup_complete:
+	@ If a platform-specific CPU setup hook is needed, it is
+	@ called from here.
+
+	cmp	r7, #0
+	mov	r0, #0		@ first (CPU) affinity level
+	blxne	r7		@ Call power_up_setup if defined
+	dmb
+
+	@ Mark the CPU as up:
+
+	mov	r0, #CPU_UP
+	strb	r0, [r5]
+
+	@ Observability order of CPU_UP and opening of the gate does not matter.
 
 mcpm_entry_gated:
 	ldr	r5, [r6, r4, lsl #2]		@ r5 = CPU entry vector
 	cmp	r5, #0
 	wfeeq
 	beq	mcpm_entry_gated
+	dmb
+
 	pr_dbg	"released\n"
 	bx	r5
 
 	.align	2
 
 3:	.word	mcpm_entry_vectors - .
+	.word	mcpm_power_up_setup_phys - 3b
+	.word	mcpm_sync - 3b
 
 ENDPROC(mcpm_entry_point)
 
@@ -84,3 +182,7 @@ ENDPROC(mcpm_entry_point)
 	.type	mcpm_entry_vectors, #object
 ENTRY(mcpm_entry_vectors)
 	.space	4 * MAX_NR_CLUSTERS * MAX_CPUS_PER_CLUSTER
+
+	.type	mcpm_power_up_setup_phys, #object
+ENTRY(mcpm_power_up_setup_phys)
+	.space  4		@ set by mcpm_sync_init()
diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
index 3286d5eb91..e76652209d 100644
--- a/arch/arm/include/asm/mcpm_entry.h
+++ b/arch/arm/include/asm/mcpm_entry.h
@@ -15,8 +15,37 @@
 #define MAX_CPUS_PER_CLUSTER	4
 #define MAX_NR_CLUSTERS		2
 
+/* Definitions for mcpm_sync_struct */
+#define CPU_DOWN		0x11
+#define CPU_COMING_UP		0x12
+#define CPU_UP			0x13
+#define CPU_GOING_DOWN		0x14
+
+#define CLUSTER_DOWN		0x21
+#define CLUSTER_UP		0x22
+#define CLUSTER_GOING_DOWN	0x23
+
+#define INBOUND_NOT_COMING_UP	0x31
+#define INBOUND_COMING_UP	0x32
+
+/* This is a complete guess. */
+#define __CACHE_WRITEBACK_ORDER	6
+#define __CACHE_WRITEBACK_GRANULE (1 << __CACHE_WRITEBACK_ORDER)
+
+/* Offsets for the mcpm_sync_struct members, for use in asm: */
+#define MCPM_SYNC_CLUSTER_CPUS	0
+#define MCPM_SYNC_CPU_SIZE	__CACHE_WRITEBACK_GRANULE
+#define MCPM_SYNC_CLUSTER_CLUSTER \
+	(MCPM_SYNC_CLUSTER_CPUS + MCPM_SYNC_CPU_SIZE * MAX_CPUS_PER_CLUSTER)
+#define MCPM_SYNC_CLUSTER_INBOUND \
+	(MCPM_SYNC_CLUSTER_CLUSTER + __CACHE_WRITEBACK_GRANULE)
+#define MCPM_SYNC_CLUSTER_SIZE \
+	(MCPM_SYNC_CLUSTER_INBOUND + __CACHE_WRITEBACK_GRANULE)
+
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 /*
  * Platform specific code should use this symbol to set up secondary
  * entry location for processors to use when released from reset.
@@ -123,5 +152,39 @@ struct mcpm_platform_ops {
  */
 int __init mcpm_platform_register(const struct mcpm_platform_ops *ops);
 
+/* Synchronisation structures for coordinating safe cluster setup/teardown: */
+
+/*
+ * When modifying this structure, make sure you update the MCPM_SYNC_ defines
+ * to match.
+ */
+struct mcpm_sync_struct {
+	/* individual CPU states */
+	struct {
+		volatile s8 cpu __aligned(__CACHE_WRITEBACK_GRANULE);
+	} cpus[MAX_CPUS_PER_CLUSTER];
+
+	/* cluster state */
+	volatile s8 cluster __aligned(__CACHE_WRITEBACK_GRANULE);
+
+	/* inbound-side state */
+	volatile s8 inbound __aligned(__CACHE_WRITEBACK_GRANULE);
+};
+
+struct sync_struct {
+	struct mcpm_sync_struct clusters[MAX_NR_CLUSTERS];
+};
+
+extern unsigned long sync_phys;	/* physical address of *mcpm_sync */
+
+void __mcpm_cpu_going_down(unsigned int cpu, unsigned int cluster);
+void __mcpm_cpu_down(unsigned int cpu, unsigned int cluster);
+void __mcpm_outbound_leave_critical(unsigned int cluster, int state);
+bool __mcpm_outbound_enter_critical(unsigned int this_cpu, unsigned int cluster);
+int __mcpm_mcpm_state(unsigned int cluster);
+
+int __init mcpm_sync_init(
+	void (*power_up_setup)(unsigned int affinity_level));
+
 #endif /* ! __ASSEMBLY__ */
 #endif
-- 
1.8.1.2
