From: arunks.linux@gmail.com (arunks.linux at gmail.com)
Date: Tue,  6 May 2014 21:25:08 +0530
Subject: arm64: Fix deadlock scenario with smp_send_stop()
In-Reply-To: <1399391708-13442-1-git-send-email-arunks.linux@gmail.com>
References: <1399391708-13442-1-git-send-email-arunks.linux@gmail.com>
Message-ID: <1399391708-13442-2-git-send-email-arunks.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arun KS <arunks.linux@gmail.com>

If one process calls sys_reboot and that process then stops other
CPUs while those CPUs are within a spin_lock() region we can
potentially encounter a deadlock scenario like below.

CPU 0                   CPU 1
-----                   -----
                        spin_lock(my_lock)
smp_send_stop()
 <send IPI>             handle_IPI()
                         disable_preemption/irqs
                          while(1);
 <PREEMPT>
spin_lock(my_lock) <--- Waits forever

We shouldn't attempt to run any other tasks after we send a stop
IPI to a CPU so disable preemption so that this task runs to
completion. We use local_irq_disable() here for cross-arch
consistency with x86.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Arun KS <getarunks@gmail.com>
Signed-off-by: Arun KS <arunks.linux@gmail.com>
---
 arch/arm64/kernel/process.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 2d43614..abe57e0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -134,6 +134,7 @@ void machine_shutdown(void)
  */
 void machine_halt(void)
 {
+	local_irq_disable();
 	smp_send_stop();
 	while (1);
 }
@@ -146,6 +147,7 @@ void machine_halt(void)
  */
 void machine_power_off(void)
 {
+	local_irq_disable();
 	smp_send_stop();
 	if (pm_power_off)
 		pm_power_off();
@@ -164,10 +166,9 @@ void machine_power_off(void)
  */
 void machine_restart(char *cmd)
 {
-	smp_send_stop();
-
 	/* Disable interrupts first */
 	local_irq_disable();
+	smp_send_stop();
 
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
-- 
1.7.6
