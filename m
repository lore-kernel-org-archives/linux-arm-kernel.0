From: arunks.linux@gmail.com (arunks.linux at gmail.com)
Date: Thu,  8 May 2014 18:53:31 +0530
Subject: ARM: Disable preemption along with interrupts during shutdown
Message-ID: <1399555411-15330-1-git-send-email-arunks.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arun KS <arunks.linux@gmail.com>

'irqs disabled' is funtamentally unsafe way of disabling preemption.
Any spin_unlock() decreasing the preemption count to 0 might trigger
a reschedule. A simple printk() might trigger a reschedule.

To be on safe side disable preemption as well using preempt_disable()

Signed-off-by: Arun KS <getarunks@gmail.com>
---
 arch/arm/kernel/process.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686..9ecb7b5 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -193,6 +193,7 @@ void machine_shutdown(void)
 void machine_halt(void)
 {
 	local_irq_disable();
+	preempt_disable();
 	smp_send_stop();
 
 	local_irq_disable();
@@ -208,6 +209,7 @@ void machine_halt(void)
 void machine_power_off(void)
 {
 	local_irq_disable();
+	preempt_disable();
 	smp_send_stop();
 
 	if (pm_power_off)
@@ -228,6 +230,7 @@ void machine_power_off(void)
 void machine_restart(char *cmd)
 {
 	local_irq_disable();
+	preempt_disable();
 	smp_send_stop();
 
 	arm_pm_restart(reboot_mode, cmd);
-- 
1.7.6
