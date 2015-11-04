From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Nov 2015 17:10:49 +0000
Subject: PSCI_CPU_ON flow
In-Reply-To: <BY1PR0301MB1303B5D1A8CD0B7FA07AA40A822A0@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <BY1PR0301MB1303B5D1A8CD0B7FA07AA40A822A0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <20151104171048.GE23860@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 04:18:40PM +0000, Sharma Bhupesh wrote:
> Hi,

Hi,

> I am trying to build and verify a custom ARM trusted firmware like implementation with
> the linux-next to verify if I can use the PSCI interface to get the CPU hotplug
> to work (CPU_OFF and CPU_ON sequence).
> 
> My EL3 firmware implements the PSCI v0.2 specifications and I enable the same
> as the CPU enable_method in the DTS.
> 
> Now, while I can get the secondary CPU to shutdown properly via the PSCI implementing
> firmware, I cannot seem to get them back-on:
> 
> # echo 0 > /sys/devices/system/cpu/cpu2/online
> CPU2: shutdown
> psci: CPU2 killed.
> 
> # echo 1 > /sys/devices/system/cpu/cpu2/online
> CPU2: failed to come online
> 
> I notice that the call to PSCI CPU_ON from kernel returns successfully,
> so the EL3 FW returns PSCI_SUCCESS: 
> 
> static int cpu_psci_cpu_boot(unsigned int cpu)
> {
> 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_entry));
> 	if (err)
> 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
> 
> 	return err;
> }
> 
> However, I cannot seem to get the secondaries to enter the 'secondary_entry'
> leg, i.e. I cannot see the normal 'CPU%u: Booted secondary processor' prints
> from here:
> 
> /*
>  * This is the secondary CPU boot entry.  We're using this CPUs
>  * idle thread stack, but a set of temporary page tables.
>  */
> asmlinkage void secondary_start_kernel(void)
> {
> 	struct mm_struct *mm = &init_mm;
> 	unsigned int cpu = smp_processor_id();
> 
> 	/*
> 	 * All kernel threads share the same mm context; grab a
> 	 * reference and switch to it.
> 	 */
> 	atomic_inc(&mm->mm_count);
> 	current->active_mm = mm;
> 	cpumask_set_cpu(cpu, mm_cpumask(mm));
> 
> 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
> 	printk("CPU%u: Booted secondary processor\n", cpu);

I see this isn't the same as next-20151104, though the difference is a
trivial change to the logging. Which linux-next version are you using?

> So, I am wondering if my understanding is correct, as to whether the 
> secondaries will start execution from __pa(secondary_entry), i.e. 
> secondary_start_kernel

Yes, the CPU should start at __pa(secondary_entry) in head.S. From there
it will branch to secondary_startup:

ENTRY(secondary_entry)
	bl      el2_setup                       // Drop to EL1
	bl      set_cpu_boot_mode_flag
	b       secondary_startup
ENDPROC(secondary_entry)

> and I should see the above prints in the PSCI CPU_ON case as well,

Yes, the print should occur for any PSCI CPU_ON of any CPU.

> or is this path only taken in case of a cold boot.

The same path is taken regardless of cold/warm boot.

I don't see issues on Juno with next-20151104:

root at ribbensteg:/home/nanook# echo 0 > /sys/devices/system/cpu/cpu2/online 
CPU2: shutdown
psci: CPU2 killed.
root at ribbensteg:/home/nanook# echo 1 > /sys/devices/system/cpu/cpu2/online 
Detected PIPT I-cache on CPU2
CPU2: Booted secondary processor [410fd070]

Given that, and the successful cold boot, it looks like the issue is
with the FW rather than the kernel.

I guess that either the CPU is stuck in the FW, or that it left the FW
in a bad state, and things went wrong before it could execute
secondary_start_kernel.

The following patch may be able to tell you if the CPU is stuck in the
FW (the CPU will likely never leave state 2 / ON_PENDING in this case).

Thanks,
Mark.
---->8----
>From 0573953e0426b2990a71d9993b550d542bf36d87 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 4 Nov 2015 17:01:45 +0000
Subject: [PATCH] arm64: psci: HACK: query AFFINTIY_INFO after CPU_ON

Buggy PSCI firmware can report a successful CPU_ON, yet the CPU may
never leave ON_PENDING. Query AFFINITY_INFO after a successful CPU_ON to
aid debugging such issues.

This is rather noisy, and is only useful as a debugging tool.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/psci.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f67f35b..8dd9e0a 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -111,13 +111,37 @@ static int __init cpu_psci_cpu_prepare(unsigned int cpu)
 	return 0;
 }
 
+static int cpu_psci_check_online(int cpu)
+{
+	int err, i;
+
+	if (!psci_ops.affinity_info)
+		return 0;
+
+	for (i = 0; i < 10; i++) {
+		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
+		if (err == PSCI_0_2_AFFINITY_LEVEL_ON) {
+			pr_info("CPU%d reported online\n", cpu);
+			return 0;
+		}
+		msleep(10);
+		pr_info("CPU%d reported in state %d", cpu, err);
+	}
+
+	pr_warn("CPU%d was not reported online in a timely fashion\n", cpu);
+
+	return -ETIMEDOUT;
+}
+
 static int cpu_psci_cpu_boot(unsigned int cpu)
 {
 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_entry));
-	if (err)
+	if (err) {
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
+		return err;
+	}
 
-	return err;
+	return cpu_psci_check_online(cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.9.1
