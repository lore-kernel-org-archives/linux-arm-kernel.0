From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Fri,  4 Aug 2017 16:02:29 +0900
Subject: [PATCH] arm64:kexec: have own crash_smp_send_stop() for crash dump
 for nonpanic cores
Message-ID: <1501830173-15989-1-git-send-email-hoeun.ryu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Commit 0ee5941 : (x86/panic: replace smp_send_stop() with kdump friendly
version in panic path) introduced crash_smp_send_stop() which is a weak
function and can be overriden by architecture codes to fix the side effect
caused by commit f06e515 : (kernel/panic.c: add "crash_kexec_post_
notifiers" option).

 ARM64 architecture uses the weak version function and the problem is that
the weak function simply calls smp_send_stop() which makes other CPUs
offline and takes away the chance to save crash information for nonpanic
CPUs in machine_crash_shutdown() when crash_kexec_post_notifiers kernel
option is enabled.

 Calling smp_send_crash_stop() in the function is useless because all
nonpanic CPUs are already offline by smp_send_stop() in this case and
smp_send_crash_stop() only works against online CPUs.

 The result is that /proc/vmcore is not available with the error messages;
"Warning: Zero PT_NOTE entries found", "Kdump: vmcore not initialized".

 crash_smp_send_stop() is implemented for ARM64 architecture to fix this
problem and the function (strong symbol version) saves crash information
for nonpanic CPUs using smp_send_crash_stop() and machine_crash_shutdown()
tries to save crash information for nonpanic CPUs only when
crash_kexec_post_notifiers kernel option is disabled.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 arch/arm64/kernel/machine_kexec.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 481f54a..ec55cd8 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -213,6 +213,23 @@ void machine_kexec(struct kimage *kimage)
 	BUG(); /* Should never get here. */
 }
 
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	/* shutdown non-crashing cpus */
+	smp_send_crash_stop();
+
+	cpus_stopped = 1;
+}
+
 static void machine_kexec_mask_interrupts(void)
 {
 	unsigned int i;
@@ -252,7 +269,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	local_irq_disable();
 
 	/* shutdown non-crashing cpus */
-	smp_send_crash_stop();
+	crash_smp_send_stop();
 
 	/* for crashing cpu */
 	crash_save_cpu(regs, smp_processor_id());
-- 
2.7.4
