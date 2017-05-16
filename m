From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 16 May 2017 20:42:33 +0200
Subject: [patch V2 02/17] arm: Adjust system_state check
References: <20170516184231.564888231@linutronix.de>
Message-ID: <20170516184735.020718977@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in ipi_cpu_stop() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/smp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -555,8 +555,7 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	if (system_state == SYSTEM_BOOTING ||
-	    system_state == SYSTEM_RUNNING) {
+	if (system_state <= SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
