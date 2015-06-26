From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 26 Jun 2015 20:47:23 +0300
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <558D8492.2090503@ti.com>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
 <20150625144511.GA6844@leverpostej> <558C174F.80108@oracle.com>
 <558C25E0.3010102@ti.com> <20150625161308.GF6844@leverpostej>
 <558C328C.5070803@ti.com> <20150625165741.GA10564@leverpostej>
 <20150625172057.GA11952@leverpostej> <558C4B84.9030303@oracle.com>
 <558D8492.2090503@ti.com>
Message-ID: <558D902B.1050603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/26/2015 07:57 PM, Vitaly Andrianov wrote:
> On 06/25/2015 02:42 PM, santosh shilimkar wrote:
>> On 6/25/2015 10:20 AM, Mark Rutland wrote:
>>>>> I need rework and re-test the patch.
>>>>> One more question. Shall I post the dts related commit, which add PSCI
>>>>> command together with this commit? Or it may be posted later
>>>>> independently?
>>>>
>>>> The DTS and Kconfig changes can be seaprate patches, but they'll 
>>>> need to
>>>> go through at the same time.
>>>
>>> If your bootloader patches the DTB then you don't even need a dts
>>> update. That should make things less confusing for existing users...
>>>
>> More than confusing we need to keep existing DTB binding work with
>> updated kernel at least for as basic as booting all the CPUs.
>>
>> Regards,
>> Santosh
>>
>>
> OK. Now I'm confused :) We may have several different configurations here:
> 
> 1) CONFIG_HOTPLUG_CPU and CONFIG_ARM_PSCI are not set.
>     In this case keystone arch needs to have
>     keystone_smp_boot_secondary();
> 
> 2) CONFIG_HOTPLUG_CPU=y and CONFIG_ARM_PSCI is not set.
>     keystone_smp_boot_secondary() is required and non PSCI
>     implementation of keystone_cpu_die() is also required.
> 
> 3) CONFIG_HOTPLUG_CPU is not set and CONFIG_ARM_PSCI=y
> 4) CONFIG_HOTPLUG_CPU=y and CONFIG_ARM_PSCI=y
> 
>     How do I boot secondary CPUs in cases of 3 and 4?
>     Do I need to implement PSCI version of the
>     keystone_smp_boot_secondary() of adding PSCI commands to DTB is
>     enough?
> 
>     Do I need to implement keystone_cpu_die() if PSCI commands are
>     added to DTB?

Things are more or less simple here :)
1) to support psci you need to have DT entry like below:
	psci {
		compatible	= "arm,psci";
		method		= "smc";
		cpu_off		= <0x84000002>;
		cpu_on		= <0x84000003>;
	};
and CONFIG_ARM_PSCI=y

in this case Kernel will ignore mach.smp = smp_ops(keystone_smp_ops),
and will use PSCU interface (see setup_arch()0

2) if don't have PSCI DT entry, but still have custom smp_operations - 
they will be used.

So, question here is not about   CONFIG_HOTPLUG_CPU, but rather 
will you support "PSCI only" or "PSCI and legacy boot".

For the last case You should keep mach specific code in mach-kestone/platsmp.c.
For the first case "PSCI only" - above code can be removed.

3) if you'd like CONFIG_HOTPLUG_CPU in legacy mode - platsmp.c can be updated as below,
without using psci:


+#define KEYSTONE_MON_CPU_DOWN_IDX              0x01
+#ifdef CONFIG_HOTPLUG_CPU
+static void __ref keystone_smp_cpu_die(unsigned int cpu)
+{
+       int error;
+
+       error = keystone_cpu_smc(KEYSTONE_MON_CPU_DOWN_IDX, cpu, 0);
+       if (error)
+               pr_err("CPU %u->%u down failed with %d\n",
+                      smp_processor_id(), cpu, error);
+
+       cpu_do_idle();
+}
+#endif

Another question is how well current PSCI implementation supports keystone2/LPAE !?

- It seems, at least below hack should be applied :(

+++ b/arch/arm/kernel/psci_smp.c
@@ -51,7 +51,7 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
        if (psci_ops.cpu_on)
                return psci_ops.cpu_on(cpu_logical_map(cpu),
-                                      __pa(secondary_startup));
+                                       virt_to_idmap(&secondary_startup));
        return -ENODEV;
 }

- and what to do with code in keystone_smp_secondary_initmem() ?:

static void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
{
	pgd_t *pgd0 = pgd_offset_k(0);
	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
	local_flush_tlb_all();
}


-- 
regards,
-grygorii
