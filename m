From: will.deacon@arm.com (Will Deacon)
Date: Tue,  9 Mar 2010 18:20:31 +0000
Subject: [PATCH] KGDB: add smp_mb() in synchronisation during exception
	handler exit
Message-ID: <1268158831-6976-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KGDB uses atomic variables and busy-wait loops to co-ordinate between
multiple CPUs on an SMP system. When an exception is handled, the primary
CPU executes kgdb_handle_exception() whilst the others execute kgdb_wait.

There comes a point when the waiters are waiting for the primary CPU to finish:

	/* Wait till primary CPU is done with debugging */
(1)	while (atomic_read(&passive_cpu_wait[cpu]))
		cpu_relax();

	/* Do important KGDB stuff */

	/* Signal the primary CPU that we are done: */
	atomic_set(&cpu_in_kgdb[cpu], 0);

In parallel to this, the primary CPU is doing:

	for (i = NR_CPUS-1; i >= 0; i--)
		atomic_set(&passive_cpu_wait[i], 0);
	/*
	 * Wait till all the CPUs have quit
	 * from the debugger.
	 */
	for_each_online_cpu(i) {
(1)		while (atomic_read(&cpu_in_kgdb[i]))
			cpu_relax();
	}

There is a potential deadlock situation at point (1) because the previous
writes to the passive_cpu_wait variables by the primary CPU may not yet be
visible to the other CPUs [for instance, they may be sitting in the local
store buffer]. This means that the waiter CPUs will never exit the while loop
and therefore never write to the cpu_in_kgdb variables, which the primary CPU
is blocked on. Furthermore, because the primary CPU is aggressively performing
reads, the store buffer may not necessarily drain so the system will deadlock.

This deadlock has been experienced on a quad-core ARM11MPCore platform.

The following patch addresses the issue by adding a memory barrier to the
primary CPU before the polling loop, therefore forcing the previous atomic_sets
to be visible before waiting for the waiters to finish.

Cc: KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/kgdb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/kgdb.c b/kernel/kgdb.c
index 761fdd2..ee7694b 100644
--- a/kernel/kgdb.c
+++ b/kernel/kgdb.c
@@ -1537,6 +1537,7 @@ acquirelock:
 		 * Wait till all the CPUs have quit
 		 * from the debugger.
 		 */
+		smp_mb();
 		for_each_online_cpu(i) {
 			while (atomic_read(&cpu_in_kgdb[i]))
 				cpu_relax();
-- 
1.6.3.3
