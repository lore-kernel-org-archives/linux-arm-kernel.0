From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Fri,  4 Aug 2017 15:04:23 +0900
Subject: [PATCH] arm:kexec: have own crash_smp_send_stop() for crash dump for
 nonpanic cores
Message-ID: <1501826682-14148-1-git-send-email-hoeun.ryu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Commit 0ee5941 : (x86/panic: replace smp_send_stop() with kdump friendly
version in panic path) introduced crash_smp_send_stop() which is a weak
function and can be overriden by architecture codes to fix the side effect
caused by commit f06e515 : (kernel/panic.c: add "crash_kexec_post_
notifiers" option).

 ARM architecture uses the weak version function and the problem is that
the weak function simply calls smp_send_stop() which makes other CPUs
offline and takes away the chance to save crash information for nonpanic
CPUs in machine_crash_shutdown() when crash_kexec_post_notifiers kernel
option is enabled.

 Calling smp_call_function(machine_crash_nonpanic_core, NULL, false) in
the function is useless because all nonpanic CPUs are already offline by
smp_send_stop() in this case and smp_call_function() only works against
online CPUs.

 The result is that /proc/vmcore is not available with the error messages;
"Warning: Zero PT_NOTE entries found", "Kdump: vmcore not initialized".

 crash_smp_send_stop() is implemented for ARM architecture to fix this
problem and the function (strong symbol version) saves crash information
for nonpanic CPUs using smp_call_function() and machine_crash_shutdown()
saves crash information only for the panic CPU.

 We might be able to implement the function like arm64 or x86 using a
dedicated IPI (let's say IPI_CPU_CRASH_STOP), but we cannot implement this
function like that because of the lack of IPI slot. Please see the commit
e7273ff4 : (ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI)

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 arch/arm/kernel/machine_kexec.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index fe1419e..18d084a 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -94,6 +94,31 @@ void machine_crash_nonpanic_core(void *unused)
 		cpu_relax();
 }
 
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+	unsigned long msecs;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
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
@@ -119,20 +144,10 @@ static void machine_kexec_mask_interrupts(void)
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
-	unsigned long msecs;
+	WARN_ON(num_online_cpus() > 1);
 
 	local_irq_disable();
 
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("Non-crashing CPUs did not react to IPI\n");
-
 	crash_save_cpu(regs, smp_processor_id());
 	machine_kexec_mask_interrupts();
 
-- 
2.7.4
