From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  9 Jul 2013 08:36:57 -0700
Subject: [PATCH] ARM: Fix deadlock scenario with smp_send_stop()
Message-ID: <1373384217-26307-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
completion.

Reported-by: Sundarajan Srinivasan <sundaraj@codeaurora.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Resending this patch now that the context has changed.

 arch/arm/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 7f1efcd..8bc12d7 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -206,6 +206,7 @@ void machine_shutdown(void)
  */
 void machine_halt(void)
 {
+	preempt_disable();
 	smp_send_stop();
 
 	local_irq_disable();
@@ -220,6 +221,7 @@ void machine_halt(void)
  */
 void machine_power_off(void)
 {
+	preempt_disable();
 	smp_send_stop();
 
 	if (pm_power_off)
@@ -239,6 +241,7 @@ void machine_power_off(void)
  */
 void machine_restart(char *cmd)
 {
+	preempt_disable();
 	smp_send_stop();
 
 	arm_pm_restart(reboot_mode, cmd);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
