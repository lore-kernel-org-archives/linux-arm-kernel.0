From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Mon,  7 Aug 2017 14:09:22 +0900
Subject: [PATCHv2] arm64:kexec: have own crash_smp_send_stop() for crash dump
 for nonpanic cores
Message-ID: <1502082623-23952-1-git-send-email-hoeun.ryu@gmail.com>
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

 Calling smp_send_crash_stop() in machine_crash_shutdown() is useless
because all nonpanic CPUs are already offline by smp_send_stop() in this
case and smp_send_crash_stop() only works against online CPUs.

 The result is that /proc/vmcore is not available with the error messages;
"Warning: Zero PT_NOTE entries found", "Kdump: vmcore not initialized".

 crash_smp_send_stop() is implemented to fix this problem by replacing the
exising smp_send_crash_stop() and adding a check for multiple calling to
the function. The function (strong symbol version) saves crash information
for nonpanic CPUs and machine_crash_shutdown() tries to save crash
information for nonpanic CPUs only when crash_kexec_post_notifiers kernel
option is disabled.

* crash_kexec_post_notifiers : false

  panic()
    __crash_kexec()
      machine_crash_shutdown()
        crash_smp_send_stop()    <= save crash dump for nonpanic cores

* crash_kexec_post_notifiers : true

  panic()
    crash_smp_send_stop()        <= save crash dump for nonpanic cores
    __crash_kexec()
      machine_crash_shutdown()
        crash_smp_send_stop()    <= just return.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 v2:
   - replace the existing smp_send_crash_stop() with crash_smp_send_stop()
     and adding called-twice logic to it.
   - modify the commit message

 arch/arm64/include/asm/smp.h      |  2 +-
 arch/arm64/kernel/machine_kexec.c |  2 +-
 arch/arm64/kernel/smp.c           | 12 +++++++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 55f08c5..f82b447 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -148,7 +148,7 @@ static inline void cpu_panic_kernel(void)
  */
 bool cpus_are_stuck_in_kernel(void);
 
-extern void smp_send_crash_stop(void);
+extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
 
 #endif /* ifndef __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 481f54a..11121f6 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -252,7 +252,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	local_irq_disable();
 
 	/* shutdown non-crashing cpus */
-	smp_send_crash_stop();
+	crash_smp_send_stop();
 
 	/* for crashing cpu */
 	crash_save_cpu(regs, smp_processor_id());
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dc66e6e..73d8f5e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -977,11 +977,21 @@ void smp_send_stop(void)
 }
 
 #ifdef CONFIG_KEXEC_CORE
-void smp_send_crash_stop(void)
+void crash_smp_send_stop(void)
 {
+	static int cpus_stopped;
 	cpumask_t mask;
 	unsigned long timeout;
 
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	cpus_stopped = 1;
+
 	if (num_online_cpus() == 1)
 		return;
 
-- 
2.7.4
