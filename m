From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 12 Apr 2018 14:22:12 +0100
Subject: [PATCH 1/2] ARM: kexec: fix kdump register saving on panic()
Message-ID: <E1f6cB2-0004A9-Pa@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a panic() occurs, the kexec code uses smp_send_stop() to stop
the other CPUs, but this results in the CPU register state not being
saved, and gdb is unable to inspect the state of other CPUs.

Commit 0ee59413c967 ("x86/panic: replace smp_send_stop() with kdump
friendly version in panic path") addressed the issue on x86, but
ignored other architectures.  Address the issue on ARM by splitting
out the crash stop implementation to crash_smp_send_stop() and
adding the necessary protection.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/machine_kexec.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 75d4f5ce6cfd..39dc6bf4610a 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -96,6 +96,27 @@ void machine_crash_nonpanic_core(void *unused)
 		cpu_do_idle();
 }
 
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+	unsigned long msecs;
+
+	if (cpus_stopped)
+		return;
+
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	msecs = 1000; /* Wait at most a second for the other cpus to stop */
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
+		mdelay(1);
+		msecs--;
+	}
+	if (atomic_read(&waiting_for_crash_ipi) > 0)
+		pr_warn("Non-crashing CPUs did not react to IPI\n");
+
+	cpus_stopped = 1;
+}
+
 static void machine_kexec_mask_interrupts(void)
 {
 	unsigned int i;
@@ -121,19 +142,8 @@ static void machine_kexec_mask_interrupts(void)
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
-	unsigned long msecs;
-
 	local_irq_disable();
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("Non-crashing CPUs did not react to IPI\n");
+	crash_smp_send_stop();
 
 	crash_save_cpu(regs, smp_processor_id());
 	machine_kexec_mask_interrupts();
-- 
2.7.4
