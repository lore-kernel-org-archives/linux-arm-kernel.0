From: olof@lixom.net (Olof Johansson)
Date: Sat, 3 Jul 2010 13:46:14 -0500
Subject: [PATCH v2] ARM: Stop secondary cpus in machine_halt()
In-Reply-To: <20100701224706.GA26473@lixom.net>
References: <20100701224706.GA26473@lixom.net>
Message-ID: <20100703184614.GA9693@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM doesn't spin down secondary cpus on halt, which resulted interrupts
being delivered even after the "System halted" message, etc.

Change that to use smp_send_stop() to halt them.

Also, change the smp_send_stop() on ARM to not do a stack dump when
stopping the cpus during halt (but still print during other stops,
i.e. panic).

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/kernel/process.c |    6 ++++++
 arch/arm/kernel/smp.c     |   10 ++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index acf5e6f..203fc1b 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -191,6 +191,12 @@ __setup("reboot=", reboot_setup);
 
 void machine_halt(void)
 {
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+	printk(KERN_EMERG "System halted, OK to turn off power\n");
+	local_irq_disable();
+	while (1) ;
 }
 
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b8c3d0f..5496dea 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -467,10 +467,12 @@ static DEFINE_SPINLOCK(stop_lock);
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	spin_lock(&stop_lock);
-	printk(KERN_CRIT "CPU%u: stopping\n", cpu);
-	dump_stack();
-	spin_unlock(&stop_lock);
+	if (system_state != SYSTEM_HALT) {
+		spin_lock(&stop_lock);
+		printk(KERN_CRIT "CPU%u: stopping\n", cpu);
+		dump_stack();
+		spin_unlock(&stop_lock);
+	}
 
 	set_cpu_online(cpu, false);
 
-- 
1.5.6.5
