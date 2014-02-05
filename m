From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Thu, 06 Feb 2014 03:36:04 +0530
Subject: [PATCH 08/51] arm,
 hw-breakpoint: Fix CPU hotplug callback registration
In-Reply-To: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20140205220603.19080.80971.stgit@srivatsabhat.in.ibm.com>
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


Fix the hw-breakpoint code in arm by using this latter form of callback
registration.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/arm/kernel/hw_breakpoint.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 3d44660..eaa7fcf 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1072,6 +1072,8 @@ static int __init arch_hw_breakpoint_init(void)
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
 
+	cpu_maps_update_begin();
+
 	/*
 	 * We need to tread carefully here because DBGSWENABLE may be
 	 * driven low on this core and there isn't an architected way to
@@ -1088,6 +1090,7 @@ static int __init arch_hw_breakpoint_init(void)
 	if (!cpumask_empty(&debug_err_mask)) {
 		core_num_brps = 0;
 		core_num_wrps = 0;
+		cpu_maps_update_done();
 		return 0;
 	}
 
@@ -1107,7 +1110,10 @@ static int __init arch_hw_breakpoint_init(void)
 			TRAP_HWBKPT, "breakpoint debug exception");
 
 	/* Register hotplug and PM notifiers. */
-	register_cpu_notifier(&dbg_reset_nb);
+	__register_cpu_notifier(&dbg_reset_nb);
+
+	cpu_maps_update_done();
+
 	pm_init();
 	return 0;
 }
