From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jul 2010 17:48:10 +0100
Subject: [PATCH v2] ARM: Stop secondary cpus in machine_halt()
In-Reply-To: <20100703184614.GA9693@lixom.net>
References: <20100701224706.GA26473@lixom.net>
	<20100703184614.GA9693@lixom.net>
Message-ID: <20100712164810.GB9897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 03, 2010 at 01:46:14PM -0500, Olof Johansson wrote:
> ARM doesn't spin down secondary cpus on halt, which resulted interrupts
> being delivered even after the "System halted" message, etc.
> 
> Change that to use smp_send_stop() to halt them.
> 
> Also, change the smp_send_stop() on ARM to not do a stack dump when
> stopping the cpus during halt (but still print during other stops,
> i.e. panic).

Hmm... what about kexec on a SMP system, or we try to reboot a SMP
system?

The x86 code suggests that we put smp_send_stop() inside
machine_shutdown() (and move that function into arch/arm/kernel/process.c)
and call it from machine_halt() and machine_reboot().

This will cover the kexec and reboot cases too.

So, something like this:

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 598ca61..4acce99 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -37,10 +37,6 @@ void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-void machine_shutdown(void)
-{
-}
-
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 }
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index a4a9cc8..ceb2aa4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -189,19 +189,29 @@ int __init reboot_setup(char *str)
 
 __setup("reboot=", reboot_setup);
 
-void machine_halt(void)
+void machine_shutdown(void)
 {
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
 }
 
+void machine_halt(void)
+{
+	machine_shutdown();
+	while (1);
+}
 
 void machine_power_off(void)
 {
+	machine_shutdown();
 	if (pm_power_off)
 		pm_power_off();
 }
 
 void machine_restart(char *cmd)
 {
+	machine_shutdown();
 	arm_pm_restart(reboot_mode, cmd);
 }
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b8c3d0f..11f631b 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -467,10 +467,13 @@ static DEFINE_SPINLOCK(stop_lock);
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	spin_lock(&stop_lock);
-	printk(KERN_CRIT "CPU%u: stopping\n", cpu);
-	dump_stack();
-	spin_unlock(&stop_lock);
+	if (system_state == SYSTEM_BOOTING ||
+	    system_state == SYSTEM_RUNNING) {
+		spin_lock(&stop_lock);
+		printk(KERN_CRIT "CPU%u: stopping\n", cpu);
+		dump_stack();
+		spin_unlock(&stop_lock);
+	}
 
 	set_cpu_online(cpu, false);
 
