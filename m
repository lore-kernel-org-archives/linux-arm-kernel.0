From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Thu, 06 Feb 2014 03:39:45 +0530
Subject: [PATCH 28/51] arm64,
 hw_breakpoint.c: Fix CPU hotplug callback registration
In-Reply-To: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20140205220944.19080.26519.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsystems that want to register CPU hotplug callbacks, as well as perform
initialization for the CPUs that are already online, often do it as shown
below:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is wrong, since it is prone to ABBA deadlocks involving the
cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
with CPU hotplug operations).

Instead, the correct and race-free way of performing the callback
registration is:

	cpu_maps_update_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_maps_update_done();


Fix the hw-breakpoint code in arm64 by using this latter form of callback
registration.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/arm64/kernel/hw_breakpoint.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index f17f581..24e88d0 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -913,6 +913,8 @@ static int __init arch_hw_breakpoint_init(void)
 	pr_info("found %d breakpoint and %d watchpoint registers.\n",
 		core_num_brps, core_num_wrps);
 
+	cpu_maps_update_begin();
+
 	/*
 	 * Reset the breakpoint resources. We assume that a halting
 	 * debugger will leave the world in a nice state for us.
@@ -927,7 +929,10 @@ static int __init arch_hw_breakpoint_init(void)
 			      TRAP_HWBKPT, "hw-watchpoint handler");
 
 	/* Register hotplug notifier. */
-	register_cpu_notifier(&hw_breakpoint_reset_nb);
+	__register_cpu_notifier(&hw_breakpoint_reset_nb);
+
+	cpu_maps_update_done();
+
 	/* Register cpu_suspend hw breakpoint restore hook */
 	cpu_suspend_set_dbg_restorer(hw_breakpoint_reset);
 
