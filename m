From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu, 15 Nov 2012 18:17:58 +0000
Subject: [RFC PATCH 3.7.0-rc4] ARM:smp: introduce smp_notify_cpu_stop to fix
 kexec smp case
Message-ID: <1353003478-22291-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Use-case is simple kexec on smp system.

Lets say there are two cores core-0 and core-1.

sequence here is:
As part of kexec call, the secondary cores are stopped by calling
machine_shutdown(), which in turn issues IPIs to off-line the other CPUs
and then call smp_ops.cpu_kill.

machine_shutdown invokes smp_send_stop from core-0 which then sends
IPI_CPU_STOP ipi message for core-1 and then smp_kill_cpus call
smp_ops.cpu_kill from core-0 with cpu=1.

The expectation here is that cpu_kill will relocate secondary-core
to safe location from primary-core(core-0).

This is a catch 22 situation for SOCs, which can't change PC's of other
cores. At the point when cpu_kill is invoked, it cant execute any
function calls for core-1, as it is off-line and is spinning in
cpu_relax.

So the only way is to put the core into safe place by executing some
SOC specific relocation code.

Having a callback from ipi handler when cpu is stopped would be very
usefull for SOC's which want to relocate the secondary-core to safe
location.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
Hi All, 
I just tried kexec on an CA9 dual core board, and it looks like it is broken
 on smp system.

It looks like its a very basic issue, Am not not sure if I missed something here?

It is almost impossible to get kexec working, For cases where SOC's can't change PC 
of secondary-core from a primary-core.

As cpu_kill is the only callback which is invoked from primary core to stop an 
secondary-core during machine_shutdown it to relocate the secondary-core to safe place,
as it is offine and it is spinning in cpu_relax.

Having a callback from ipi handler when cpu is stopped would be very usefull for SOC's
which want to relocate the secondary-core to safe location.


Thanks,
srini


 arch/arm/include/asm/smp.h |    7 +++++++
 arch/arm/kernel/smp.c      |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 2e3be16..0071a54 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -100,6 +100,13 @@ struct smp_operations {
 	 * This also gives us the initial stack to use for this CPU.
 	 */
 	int  (*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
+
+	/* Notify interested parties before parking core in cpu_relax.
+	 * SOC's can park cores in safe place in this callback, is very useful
+	 * for cases like kexec. Stopping cpu is the victim cpu in this case.
+	 */
+	int  (*smp_notify_cpu_stop)(unsigned int cpu);
+
 #ifdef CONFIG_HOTPLUG_CPU
 	int  (*cpu_kill)(unsigned int cpu);
 	void (*cpu_die)(unsigned int cpu);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fbc8b26..06fcef9 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -564,6 +564,9 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
+	if (smp_ops.smp_notify_cpu_stop)
+		smp_ops.smp_notify_cpu_stop(cpu);
+
 	while (1)
 		cpu_relax();
 }
-- 
1.7.0.4
