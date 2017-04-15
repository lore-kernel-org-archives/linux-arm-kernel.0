From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 15 Apr 2017 19:01:18 +0200
Subject: [patch 11/20] ARM/hw_breakpoint: Use cpuhp_setup_state_locked()
References: <20170415170107.643253702@linutronix.de>
Message-ID: <20170415171652.156858127@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

arch_hw_breakpoint_init() holds get_online_cpus() while registerring the
hotplug callbacks.

cpuhp_setup_state() invokes get_online_cpus() as well. This is correct, but
prevents the conversion of the hotplug locking to a percpu rwsem.

Use cpuhp_setup_state_locked() to avoid the nested call.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org

---
 arch/arm/kernel/hw_breakpoint.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1098,8 +1098,9 @@ static int __init arch_hw_breakpoint_ini
 	 * assume that a halting debugger will leave the world in a nice state
 	 * for us.
 	 */
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm/hw_breakpoint:online",
-				dbg_reset_online, NULL);
+	ret = cpuhp_setup_state_locked(CPUHP_AP_ONLINE_DYN,
+				       "arm/hw_breakpoint:online",
+				       dbg_reset_online, NULL);
 	unregister_undef_hook(&debug_reg_hook);
 	if (WARN_ON(ret < 0) || !cpumask_empty(&debug_err_mask)) {
 		core_num_brps = 0;
