From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Wed, 4 Nov 2015 16:18:40 +0000
Subject: PSCI_CPU_ON flow
Message-ID: <BY1PR0301MB1303B5D1A8CD0B7FA07AA40A822A0@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to build and verify a custom ARM trusted firmware like implementation with
the linux-next to verify if I can use the PSCI interface to get the CPU hotplug
to work (CPU_OFF and CPU_ON sequence).

My EL3 firmware implements the PSCI v0.2 specifications and I enable the same
as the CPU enable_method in the DTS.

Now, while I can get the secondary CPU to shutdown properly via the PSCI implementing
firmware, I cannot seem to get them back-on:

# echo 0 > /sys/devices/system/cpu/cpu2/online
CPU2: shutdown
psci: CPU2 killed.

# echo 1 > /sys/devices/system/cpu/cpu2/online
CPU2: failed to come online

I notice that the call to PSCI CPU_ON from kernel returns successfully,
so the EL3 FW returns PSCI_SUCCESS: 

static int cpu_psci_cpu_boot(unsigned int cpu)
{
	int err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_entry));
	if (err)
		pr_err("failed to boot CPU%d (%d)\n", cpu, err);

	return err;
}

However, I cannot seem to get the secondaries to enter the 'secondary_entry'
leg, i.e. I cannot see the normal 'CPU%u: Booted secondary processor' prints
from here:

/*
 * This is the secondary CPU boot entry.  We're using this CPUs
 * idle thread stack, but a set of temporary page tables.
 */
asmlinkage void secondary_start_kernel(void)
{
	struct mm_struct *mm = &init_mm;
	unsigned int cpu = smp_processor_id();

	/*
	 * All kernel threads share the same mm context; grab a
	 * reference and switch to it.
	 */
	atomic_inc(&mm->mm_count);
	current->active_mm = mm;
	cpumask_set_cpu(cpu, mm_cpumask(mm));

	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
	printk("CPU%u: Booted secondary processor\n", cpu);

So, I am wondering if my understanding is correct, as to whether the 
secondaries will start execution from __pa(secondary_entry), i.e. 
secondary_start_kernel and I should see the above prints in the PSCI CPU_ON case as well,
or is this path only taken in case of a cold boot.

Thanks for any pointers.

Regards,
Bhupesh
