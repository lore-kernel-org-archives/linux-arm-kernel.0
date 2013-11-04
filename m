From: ac@alexeicolin.com (Alexei Colin)
Date: Mon, 04 Nov 2013 05:42:56 -0500
Subject: [PATCH v2 3/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131025100633.GN3061@cat.local>
Message-ID: <52777A30.8040103@alexeicolin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aliaksei,

On 12/31/1969 07:00 PM,  wrote:
>> From: Tarek Dakhran <t.dakhran@samsung.com>
>>
>> Add EDCS(Exynos Dual Cluster Support) for Samsung Exynos5410 SoC.
>> This enables all 8 cores, 4 x A7 and 4 x A15 run at the same time.
>>
>> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
>> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Makefile |   2 +
>>  arch/arm/mach-exynos/edcs.c   | 270 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 272 insertions(+)
>>  create mode 100644 arch/arm/mach-exynos/edcs.c
>>
[snip]
>> +
>> +/*
>> + * Enable cluster-level coherency, in preparation for turning on the MMU.
>> + */
>> +static void __naked edcs_power_up_setup(unsigned int affinity_level)
>> +{
>> +	asm volatile ("\n"
>> +	"b	cci_enable_port_for_self");
>> +}
> 
> 	This code breaks odroid-xu boot with NR_CPUS set to 8. Kernel panics
> 	like this:
> 
> %< -----------------------------------------------------------------------
> [    5.315000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    5.320000] Freeing unused kernel memory: 216K (c049b000 - c04d1000)
> [    5.325000] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> [    5.340000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
> [    5.340000] 
> [    5.345000] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 200000Hz, actual 200000HZ div = 250)
> [    5.355000] CPU: 3 PID: 1 Comm: init Not tainted 3.12.0-rc5-00006-g847e427-dirty #1
> [    5.365000] [<c0014d40>] (unwind_backtrace+0x0/0xf8) from [<c00117cc>] (show_stack+0x10/0x14)
> [    5.370000] [<c00117cc>] (show_stack+0x10/0x14) from [<c03633ac>] (dump_stack+0x6c/0xac)
> [    5.380000] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 196079Hz, actual 196078HZ div = 255)
> [    5.390000] [<c03633ac>] (dump_stack+0x6c/0xac) from [<c03609fc>] (panic+0x90/0x1e8)
> [    5.395000] [<c03609fc>] (panic+0x90/0x1e8) from [<c002048c>] (do_exit+0x780/0x834)
> [    5.405000] [<c002048c>] (do_exit+0x780/0x834) from [<c002062c>] (do_group_exit+0x3c/0xb0)
> [    5.410000] [<c002062c>] (do_group_exit+0x3c/0xb0) from [<c002ae80>] (get_signal_to_deliver+0x1d4/0x534)
> [    5.420000] [<c002ae80>] (get_signal_to_deliver+0x1d4/0x534) from [<c0010d08>] (do_signal+0x100/0x40c)
> [    5.430000] [<c0010d08>] (do_signal+0x100/0x40c) from [<c0011348>] (do_work_pending+0x68/0xa8)
> [    5.430000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 50000000Hz, actual 50000000HZ div = 1)
> [    5.430000] mmc1: new high speed SDHC card at address b368
> [    5.435000] mmcblk0: mmc1:b368 USD   14.9 GiB 
> [    5.440000]  mmcblk0: p1 p2 p3 < p5 p6 p7 >
> [    5.455000] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 400000Hz, actual 400000HZ div = 125)
> [    5.475000] [<c0011348>] (do_work_pending+0x68/0xa8) from [<c000e420>] (work_pending+0xc/0x20)
> [    5.480000] CPU1: stopping
> [    5.480000] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.0-rc5-00006-g847e427-dirty #1
> [    5.480000] [<c0014d40>] (unwind_backtrace+0x0/0xf8) from [<c00117cc>] (show_stack+0x10/0x14)
> [    5.480000] [<c00117cc>] (show_stack+0x10/0x14) from [<c03633ac>] (dump_stack+0x6c/0xac)
> [    5.480000] [<c03633ac>] (dump_stack+0x6c/0xac) from [<c0013604>] (handle_IPI+0xf8/0x11c)
> [    5.480000] [<c0013604>] (handle_IPI+0xf8/0x11c) from [<c000851c>] (gic_handle_irq+0x60/0x68)
> [    5.480000] [<c000851c>] (gic_handle_irq+0x60/0x68) from [<c00122c0>] (__irq_svc+0x40/0x70)
> [    5.480000] Exception stack(0xef0a7f88 to 0xef0a7fd0)
> [    5.480000] 7f80:                   00000001 00000000 008d20ff 00000001 00000000 00000000
> [    5.480000] 7fa0: c04d07a0 60000113 010da000 412fc0f3 c15aa7a0 00000000 00000001 ef0a7fd0
> [    5.480000] 7fc0: c0072d74 c0072d78 20000113 ffffffff
> [    5.480000] [<c00122c0>] (__irq_svc+0x40/0x70) from [<c0072d78>] (rcu_idle_exit+0x68/0xb8)
> [    5.480000] [<c0072d78>] (rcu_idle_exit+0x68/0xb8) from [<c00550a4>] (cpu_startup_entry+0x6c/0x148)
> [    5.480000] [<c00550a4>] (cpu_startup_entry+0x6c/0x148) from [<400085c4>] (0x400085c4)
> [    5.480000] CPU0: stopping
> [    5.480000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.12.0-rc5-00006-g847e427-dirty #1
> [    5.480000] [<c0014d40>] (unwind_backtrace+0x0/0xf8) from [<c00117cc>] (show_stack+0x10/0x14)
> [    5.480000] [<c00117cc>] (show_stack+0x10/0x14) from [<c03633ac>] (dump_stack+0x6c/0xac)
> [    5.480000] [<c03633ac>] (dump_stack+0x6c/0xac) from [<c0013604>] (handle_IPI+0xf8/0x11c)
> [    5.480000] [<c0013604>] (handle_IPI+0xf8/0x11c) from [<c000851c>] (gic_handle_irq+0x60/0x68)
> [    5.480000] [<c000851c>] (gic_handle_irq+0x60/0x68) from [<c00122c0>] (__irq_svc+0x40/0x70)
> [    5.480000] Exception stack(0xc04d3f70 to 0xc04d3fb8)
> [    5.480000] SMP: failed to stop secondary CPUs
> [    5.480000] 3f60:                                     00000000 00000000 00002190 00000000
> [    5.480000] 3f80: c04d2000 c050a88f 00000001 c050a88f c04da44c 412fc0f3 c036a960 00000000
> [    5.480000] 3fa0: 00000020 c04d3fb8 c000f5d4 c000f5d8 60000113 ffffffff
> [    5.480000] [<c00122c0>] (__irq_svc+0x40/0x70) from [<c000f5d8>] (arch_cpu_idle+0x28/0x30)
> [    5.480000] [<c000f5d8>] (arch_cpu_idle+0x28/0x30) from [<c0055094>] (cpu_startup_entry+0x5c/0x148)
> [    5.480000] [<c0055094>] (cpu_startup_entry+0x5c/0x148) from [<c049ba9c>] (start_kernel+0x32c/0x384)
> [    5.480000] CPU2: stopping
> [    5.480000] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.12.0-rc5-00006-g847e427-dirty #1
> [    5.480000] [<c0014d40>] (unwind_backtrace+0x0/0xf8) from [<c00117cc>] (show_stack+0x10/0x14)
> [    5.480000] [<c00117cc>] (show_stack+0x10/0x14) from [<c03633ac>] (dump_stack+0x6c/0xac)
> [    5.480000] [<c03633ac>] (dump_stack+0x6c/0xac) from [<c0013604>] (handle_IPI+0xf8/0x11c)
> [    5.480000] [<c0013604>] (handle_IPI+0xf8/0x11c) from [<c000851c>] (gic_handle_irq+0x60/0x68)
> [    5.480000] [<c000851c>] (gic_handle_irq+0x60/0x68) from [<c00122c0>] (__irq_svc+0x40/0x70)
> [    5.480000] Exception stack(0xef0a9fa0 to 0xef0a9fe8)
> [    5.480000] 9fa0: 00000002 00000000 008e4858 00000000 ef0a8000 c050a88f 00000001 c050a88f
> [    5.480000] 9fc0: c04da44c 412fc0f3 c036a960 00000000 00000001 ef0a9fe8 c000f5d4 c000f5d8
> [    5.480000] 9fe0: 60000113 ffffffff
> [    5.480000] [<c00122c0>] (__irq_svc+0x40/0x70) from [<c000f5d8>] (arch_cpu_idle+0x28/0x30)
> [    5.480000] [<c000f5d8>] (arch_cpu_idle+0x28/0x30) from [<c0055094>] (cpu_startup_entry+0x5c/0x148)
> [    5.480000] [<c0055094>] (cpu_startup_entry+0x5c/0x148) from [<400085c4>] (0x400085c4)
> %< -----------------------------------------------------------------------
> 
> 	I checked arch/arm/mach-vexpress/tc2_pm.c to see how CCI is enabled
> 	there an realized that you should follow same pattern, i.e.:
> 
>         asm volatile (" \n"
> "       cmp     r0, #1 \n"
> "       bxne    lr \n"
> "       b       cci_enable_port_for_self ");
> 
> 	In this case only one cluster (4 LITTLE cores for Exynos5410) will be
> 	initialized at boot time. And no panic.

After this modification the same crash goes away for me too: Odroid
XU+E, 3.12-rc5 + this patchset, exynos_defconfig, exynos5410-smdk5410.dtb.

But, the other four cores fail to come online at boot time and fail when
manually brought online 'echo 1 > /sys/devices/system/cpu/cpu4/online'.
The write of S5P_CORE_LOCAL_PWR_EN to EDCS_CORE_CONFIGURATION happens
but the CPU never reaches mcpm_entry_point.

If I change the above to 'cmp r0, #0' (the A15 cluster?), then I get the
same crash as with unconditional call, and _the same_ 4 CPUs online.
Does this mean that enabling coherence for the A15 cluster causes the
above crash? And, is it true that for the A15 CPUs to wake up and
proceed to the entry point coherence must be enabled (or is some other
reason preventing them from waking up)?

[    0.045000] CPU: Testing write buffer coherency: ok
[    0.050000] CPU0: update cpu_power 1468
[    0.055000] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.060000] Setting up static identity map for 0xc038c4b8 - 0xc038c510
[    0.065000] ARM CCI driver probed
[    0.065000] edcs_init: configuring entry points
[    0.070000] edcs_init: calling data init
[    0.075000] edcs_data_init: cpu 0 cluster 0
[    0.080000] EDCS power management initialized
[    0.115000] exynos_power_up: cpu 1 cluster 0
[    0.115000] exynos_power_up: cpu 1 cluster 0 use count 1
[    0.115000] exynos_core_power_control: changing value to 3
CPU01 cluster00: kernel mcpm_entry_point
CPU01 cluster00: released
[    0.125000] CPU1: Booted secondary processor
[    0.125000] mcpm_cpu_powered_up: up
[    0.160000] CPU1: update cpu_power 1468
[    0.165000] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.175000] exynos_power_up: cpu 2 cluster 0
[    0.180000] exynos_power_up: cpu 2 cluster 0 use count 1
[    0.180000] exynos_core_power_control: changing value to 3
CPU02 cluster00: kernel mcpm_entry_point
CPU02 cluster00: released
[    0.190000] CPU2: Booted secondary processor
...
[    0.280000] exynos_power_up: cpu 0 cluster 1
[    0.285000] exynos_power_up: cpu 0 cluster 1 use count 1
[    0.285000] exynos_core_power_control: changing value to 3
[    1.290000] CPU4: failed to come online
[    1.300000] exynos_power_up: cpu 1 cluster 1
[    1.300000] exynos_power_up: cpu 1 cluster 1 use count 1
[    1.300000] exynos_core_power_control: changing value to 3
[    2.305000] CPU5: failed to come online
...
[    4.340000] SMP: Total of 4 processors activated.
[    4.345000] CPU: All CPU(s) started in SVC mode.
