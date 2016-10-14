From: lersek@redhat.com (Laszlo Ersek)
Date: Fri, 14 Oct 2016 15:18:00 +0200
Subject: aarch64 ACPI boot regressed by commit 7ba5f605f3a0 ("arm64/numa:
 remove the limitation that cpu0 must bind to node0")
In-Reply-To: <20161014080524.4hm2b4p373r7rhel@hawk.localdomain>
References: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
 <20161014080524.4hm2b4p373r7rhel@hawk.localdomain>
Message-ID: <04f22a79-301b-f05b-033d-c7a24c9f4084@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/16 10:05, Andrew Jones wrote:
> On Fri, Oct 14, 2016 at 12:50:29AM +0200, Laszlo Ersek wrote:
>> (4) Analysis (well, a lame attempt at that, because I have zero
>> familiarity with this code). Let me quote the patch:
>>
>>> commit 7ba5f605f3a0d9495aad539eeb8346d726dfc183
>>> Author: Zhen Lei <thunder.leizhen@huawei.com>
>>> Date:   Thu Sep 1 14:55:04 2016 +0800
>>>
>>>     arm64/numa: remove the limitation that cpu0 must bind to node0
>>>
>>>     1. Remove the old binding code.
>>>     2. Read the nid of cpu0 from dts.
>>>     3. Fallback the nid of cpu0 to 0 when numa=off is set in bootargs.
>>>
>>>     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>     Signed-off-by: Will Deacon <will.deacon@arm.com>
>>>
>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>> index c3c08368a685..8b048e6ec34a 100644
>>> --- a/arch/arm64/kernel/smp.c
>>> +++ b/arch/arm64/kernel/smp.c
>>> @@ -624,6 +624,7 @@ static void __init of_parse_and_init_cpus(void)
>>>  			}
>>>
>>>  			bootcpu_valid = true;
>>> +			early_map_cpu_to_node(0, of_node_to_nid(dn));
>>>
>>>  			/*
>>>  			 * cpu_logical_map has already been
>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>> index 0a15f010b64a..778a985c8a70 100644
>>> --- a/arch/arm64/mm/numa.c
>>> +++ b/arch/arm64/mm/numa.c
>>> @@ -116,16 +116,24 @@ static void __init setup_node_to_cpumask_map(void)
>>>   */
>>>  void numa_store_cpu_info(unsigned int cpu)
>>>  {
>>> -	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
>>> +	map_cpu_to_node(cpu, cpu_to_node_map[cpu]);
>>>  }
>>>
>>>  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>>>  {
>>>  	/* fallback to node 0 */
>>> -	if (nid < 0 || nid >= MAX_NUMNODES)
>>> +	if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
>>>  		nid = 0;
> 
> The ACPI equivalent code must be missing (at least) the above, because,
> even with DT, mach-virt won't have cpu to node mappings unless numa
> is configured on the command line. Can you try adding something like
> 
>     -m 512 -smp 4 \
>     -numa node,mem=256M,cpus=0-1,nodeid=0 \
>     -numa node,mem=256M,cpus=2-3,nodeid=1
> 
> to your QEMU command line?

I added the following to my domain XML, under <cpu>:

    <numa>
      <cell id='0' cpus='0-1' memory='2097152' unit='KiB'/>
      <cell id='1' cpus='2-3' memory='2097152' unit='KiB'/>
    </numa>

(See <http://libvirt.org/formatdomain.html#elementsCPU>.)

With that, each NUMA node gets half of the VCPUs and half of the guest RAM.

(This is in a different guest now, one that has a bleeding edge Fedora kernel -- I didn't want to rebuild the upstream kernel yet again, just for this test. So, "4.9.0-0.rc0.git7.1.fc26.aarch64" is based on upstream v4.8-14109-g1573d2c, and it reproduces the problem too.)

> Then when you boot with ACPI you'll get a
> SRAT.

Yes, that's confirmed by the guest kernel log (see below).

> If that works, then we're just missing the "no SRAT, nid = 0"
> code (that should have been added with this patch)

It still crashes with the SRAT, with the following log:

> EFI stub: Booting Linux Kernel...
> ConvertPages: Incompatible memory types
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.9.0-0.rc0.git7.1.fc26.aarch64 (mockbuild at buildvm-aarch64-01.arm.fedoraproject.org) (gcc version 6.2.1 20160916 (Red Hat 6.2.1-2) (GCC) ) #1 SMP Wed Oct 12 17:44:54 UTC 2016
> [    0.000000] Boot CPU: AArch64 Processor [500f0000]
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.60 by EDK II
> [    0.000000] efi:  SMBIOS 3.0=0xbbdb0000  ACPI 2.0=0xb86d0000  MEMATTR=0xb936b018
> [    0.000000] cma: Reserved 512 MiB at 0x00000000e0000000
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000B86D0000 000024 (v02 BOCHS )
> [    0.000000] ACPI: XSDT 0x00000000B86C0000 000054 (v01 BOCHS  BXPCFACP 00000001      01000013)
> [    0.000000] ACPI: FACP 0x00000000B83E0000 00010C (v05 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> [    0.000000] ACPI: DSDT 0x00000000B83F0000 0010E5 (v02 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: APIC 0x00000000B83D0000 00018C (v03 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> [    0.000000] ACPI: GTDT 0x00000000B83C0000 000060 (v02 BOCHS  BXPCGTDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: MCFG 0x00000000B83B0000 00003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
> [    0.000000] ACPI: SPCR 0x00000000B83A0000 000050 (v02 BOCHS  BXPCSPCR 00000001 BXPC 00000001)
> [    0.000000] ACPI: SRAT 0x00000000B8390000 0000C8 (v03 BOCHS  BXPCSRAT 00000001 BXPC 00000001)
> [    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
> [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '9600')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x0 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x2 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x3 -> Node 1
> [    0.000000] NUMA: Adding memblock [0x40000000 - 0xbfffffff] on node 0
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0xbfffffff]
> [    0.000000] NUMA: Adding memblock [0xc0000000 - 0x13fffffff] on node 1
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0xc0000000-0x13fffffff]
> [    0.000000] NUMA: Initmem setup node 0 [mem 0x40000000-0xbfffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0xbfff2580-0xbfffffff]
> [    0.000000] NUMA: Initmem setup node 1 [mem 0xc0000000-0x13fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x13fff2580-0x13fffffff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000b838ffff]
> [    0.000000]   node   0: [mem 0x00000000b8390000-0x00000000b83fffff]
> [    0.000000]   node   0: [mem 0x00000000b8400000-0x00000000b841ffff]
> [    0.000000]   node   0: [mem 0x00000000b8420000-0x00000000b874ffff]
> [    0.000000]   node   0: [mem 0x00000000b8750000-0x00000000bbc1ffff]
> [    0.000000]   node   0: [mem 0x00000000bbc20000-0x00000000bbffffff]
> [    0.000000]   node   0: [mem 0x00000000bc000000-0x00000000bfffffff]
> [    0.000000]   node   1: [mem 0x00000000c0000000-0x000000013fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 1 [mem 0x00000000c0000000-0x000000013fffffff]
> [    0.000000] psci: probing for conduit method from ACPI.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] percpu: Embedded 3 pages/cpu @fffffe007fda0000 s117832 r8192 d70584 u196608
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 65472
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.9.0-0.rc0.git7.1.fc26.aarch64 root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap LANG=en_US.UTF-8 earlycon acpi=force
> [    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
> [    0.000000] software IO TLB [mem 0xdbff0000-0xdfff0000] (64MB) mapped at [fffffe009bff0000-fffffe009ffeffff]
> [    0.000000] Memory: 3542976K/4194304K available (9148K kernel code, 1612K rwdata, 3776K rodata, 1600K init, 15899K bss, 127040K reserved, 524288K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     modules : 0xfffffc0000000000 - 0xfffffc0008000000   (   128 MB)
>     vmalloc : 0xfffffc0008000000 - 0xfffffdff5fff0000   (  2045 GB)
>       .text : 0xfffffc0008080000 - 0xfffffc0008970000   (  9152 KB)
>     .rodata : 0xfffffc0008970000 - 0xfffffc0008d30000   (  3840 KB)
>       .init : 0xfffffc0008d30000 - 0xfffffc0008ec0000   (  1600 KB)
>       .data : 0xfffffc0008ec0000 - 0xfffffc0009053200   (  1613 KB)
>        .bss : 0xfffffc0009053200 - 0xfffffc0009fda058   ( 15900 KB)
>     fixed   : 0xfffffdff7e7d0000 - 0xfffffdff7ec00000   (  4288 KB)
>     PCI I/O : 0xfffffdff7ee00000 - 0xfffffdff7fe00000   (    16 MB)
>     vmemmap : 0xfffffdff80000000 - 0xfffffe0000000000   (     2 GB maximum)
>               0xfffffdff80000000 - 0xfffffdff80400000   (     4 MB actual)
>     memory  : 0xfffffe0000000000 - 0xfffffe0100000000   (  4096 MB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=2
> [    0.000000] Running RCU self tests
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU lockdep checking is enabled.
> [    0.000000] 	Build-time adjustment of leaf fanout to 64.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
> [    0.000000] kmemleak: Kernel memory leak detector disabled
> [    0.000000] NR_IRQS:64 nr_irqs:64 0
> [    0.000000] GICv2m: ACPI overriding V2M MSI_TYPER (base:80, num:64)
> [    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> [    0.000000] GIC: PPI11 is secure or misconfigured
> [    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3, assuming level low
> [    0.000000] arm_arch_timer: WARNING: Please fix your firmware
> [    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 50.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> [    0.000003] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
> [    0.002198] Console: colour dummy device 80x25
> [    0.003319] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.005236] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.006183] ... MAX_LOCK_DEPTH:          48
> [    0.007273] ... MAX_LOCKDEP_KEYS:        8191
> [    0.008287] ... CLASSHASH_SIZE:          4096
> [    0.009296] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.010327] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.011318] ... CHAINHASH_SIZE:          32768
> [    0.012453]  memory used by lock dependency info: 8159 kB
> [    0.013736]  per task-struct memory footprint: 1920 bytes
> [    0.015742] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
> [    0.018710] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=50000)
> [    0.021221] pid_max: default: 32768 minimum: 301
> [    0.022806] ACPI: Core revision 20160831
> [    0.027885] ACPI: 1 ACPI AML tables successfully acquired and loaded
>
> [    0.030252] Security Framework initialized
> [    0.031355] Yama: becoming mindful.
> [    0.032176] SELinux:  Initializing.
> [    0.033925] Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
> [    0.037039] Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
> [    0.039383] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
> [    0.041135] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
> [    0.044725] ftrace: allocating 29596 entries in 8 pages
> [    0.080467] ASID allocator initialised with 65536 entries
> [    0.082070] ------------[ cut here ]------------
> [    0.083227] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:5458 wq_numa_init+0x178/0x21c
> [    0.085304] Modules linked in:
> [    0.086102]
> [    0.086499] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-0.rc0.git7.1.fc26.aarch64 #1
> [    0.088611] Hardware name: linux,dummy-virt (DT)
> [    0.089816] task: fffffe00700aac00 task.stack: fffffe00f8044000
> [    0.091375] PC is at wq_numa_init+0x178/0x21c
> [    0.092514] LR is at wq_numa_init+0x14c/0x21c
> [    0.093654] pc : [<fffffc0008d3f434>] lr : [<fffffc0008d3f408>] pstate: 60000045
> [    0.095589] sp : fffffe00f8047cb0
> [    0.096457] x29: fffffe00f8047cb0 [    0.097311] x28: 0000000000000000
> [    0.098201]
> [    0.098601] x27: 0000000000000000 [    0.099450] x26: fffffc0008ef4a28
> [    0.100342]
> [    0.100730] x25: fffffc0008ef3000 [    0.101576] x24: fffffc0008ef3574
> [    0.102466]
> [    0.102853] x23: 0000000000000000 [    0.103700] x22: fffffe007937de00
> [    0.104593]
> [    0.104982] x21: fffffc0008e887f8 [    0.105829] x20: fffffc0009091000
> [    0.106723]
> [    0.107111] x19: 0000000000000000 [    0.107956] x18: 0000000050642c6a
> [    0.108847]
> [    0.109234] x17: 0000000000000000 [    0.110078] x16: 0000000000000000
> [    0.110968]
> [    0.111363] x15: 00000000fcacdc89 [    0.112199] x14: 0000000000000000
> [    0.113087]
> [    0.113481] x13: 0000000000000000 [    0.114324] x12: 00000000fe2ce6e0
> [    0.115204]
> [    0.115597] x11: 0000000000000001 [    0.116439] x10: 0000000000000048
> [    0.117328]
> [    0.117716] x9 : 0000000000000000 [    0.118563] x8 : fffffe00f4010080
> [    0.119453]
> [    0.119833] x7 : 0000000000000000 [    0.120678] x6 : 0000000000000000
> [    0.121571]
> [    0.121959] x5 : 000000000000000f [    0.122804] x4 : 0000000000000000
> [    0.123695]
> [    0.124084] x3 : 0000000000000000 [    0.124922] x2 : 0000000000000000
> [    0.125815]
> [    0.126204] x1 : 0000000000000004 [    0.127055] x0 : 00000000ffffffff
> [    0.127966]
> [    0.128361]
> [    0.128767] ---[ end trace 0000000000000000 ]---
> [    0.129983] Call trace:
> [    0.130629] Exception stack(0xfffffe00f8047ad0 to 0xfffffe00f8047c00)
> [    0.132316] 7ac0:                                   0000000000000000 0000040000000000
> [    0.134360] 7ae0: fffffe00f8047cb0 fffffc0008d3f434 0000000060000045 000000000000003d
> [    0.136405] 7b00: fffffc0008ef4000 fffffe007937df00 0000000000000000 0000000000000000
> [    0.138446] 7b20: fffffc0008bf4110 0000000000000189 0000000000000018 0000000000000028
> [    0.140498] 7b40: fffffe00f8047b80 0000000000000000 fffffe0000000000 fffffc000848af30
> [    0.142541] 7b60: fffffe00f8047ba0 fffffc0008134d24 fffffe00f8044000 0000000000000040
> [    0.144558] 7b80: 00000000ffffffff 0000000000000004 0000000000000000 0000000000000000
> [    0.146607] 7ba0: 0000000000000000 000000000000000f 0000000000000000 0000000000000000
> [    0.148664] 7bc0: fffffe00f4010080 0000000000000000 0000000000000048 0000000000000001
> [    0.150704] 7be0: 00000000fe2ce6e0 0000000000000000 0000000000000000 00000000fcacdc89
> [    0.152752] [<fffffc0008d3f434>] wq_numa_init+0x178/0x21c
> [    0.154160] [<fffffc0008d3f578>] init_workqueues+0xa0/0x4b8
> [    0.155596] [<fffffc0008083594>] do_one_initcall+0x44/0x138
> [    0.157059] [<fffffc0008d30d28>] kernel_init_freeable+0x178/0x2dc
> [    0.158670] [<fffffc0008956f48>] kernel_init+0x18/0x110
> [    0.160036] [<fffffc0008083330>] ret_from_fork+0x10/0x20
> [    0.161440] workqueue: NUMA node mapping not available for cpu0, disabling NUMA support
> [    0.165296] Remapping and enabling EFI services.
> [    0.166586] Unable to handle kernel paging request at virtual address b91000006be8
> [    0.168448] pgd = fffffc000a010000
> [    0.169341] [b91000006be8] *pgd=0000000000000000[    0.170505] , *pud=0000000000000000
> , *pmd=0000000000000000[    0.171942]
> [    0.172332] Internal error: Oops: 96000004 [#1] SMP
> [    0.173600] Modules linked in:
> [    0.174407] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.0-0.rc0.git7.1.fc26.aarch64 #1
> [    0.176836] Hardware name: linux,dummy-virt (DT)
> [    0.178038] task: fffffe00700aac00 task.stack: fffffe00f8044000
> [    0.179579] PC is at __ll_sc_atomic_add+0x20/0x40
> [    0.180800] LR is at __lock_acquire+0xe8/0x698
> [    0.181961] pc : [<fffffc0008487390>] lr : [<fffffc0008138c08>] pstate: 800000c5
> [    0.183895] sp : fffffe00f8047820
> [    0.184755] x29: fffffe00f8047820 [    0.185588] x28: fffffc0008ef3000
> [    0.186479]
> [    0.186868] x27: fffffc0008ef2358 [    0.187713] x26: fffffc0009ce6000
> [    0.188606]
> [    0.188997] x25: 0000000000000001 [    0.189857] x24: 0000000000000000
> [    0.190731]
> [    0.191115] x23: fffffe00700aac00 [    0.191951] x22: 0000000000000000
> [    0.192843]
> [    0.193231] x21: fffffe007fd9a018 [    0.194074] x20: 0000000000000000
> [    0.194966]
> [    0.195361] x19: fffffe007fd9a018 [    0.196192] x18: 0000000000000010
> [    0.197077]
> [    0.197476] x17: 0000000057181979 [    0.198325] x16: 0000000000000000
> [    0.199209]
> [    0.199604] x15: 0000000000000000 [    0.200450] x14: 0000000000000000
> [    0.201337]
> [    0.201723] x13: 0000000000000001 [    0.202555] x12: fffffe007fff2580
> [    0.203432]
> [    0.203819] x11: 0000000000000000 [    0.204664] x10: 0000000000000011
> [    0.205550]
> [    0.205937] x9 : 0000000000000001 [    0.206784] x8 : 0000b91000006be8
> [    0.207678]
> [    0.208062] x7 : fffffc0008299fcc [    0.208899] x6 : 0000000000000000
> [    0.209787]
> [    0.210176] x5 : 0000000000000080 [    0.211022] x4 : 0000b91000006a50
> [    0.211913]
> [    0.212307] x3 : 0000000000000000 [    0.213147] x2 : 000022c80000f420
> [    0.214034]
> [    0.214421] x1 : 0000b91000006be8 [    0.215251] x0 : fffffc0008138c08
> [    0.216134]
> [    0.216527]
> [    0.216916] Process swapper/0 (pid: 1, stack limit = 0xfffffe00f8044020)
> [    0.218671] Stack: (0xfffffe00f8047820 to 0xfffffe00f8048000)
> [    0.220167] 7820: fffffe00f8047840 fffffc0008138c08 fffffe00f8044000 0000000000000001
> [    0.222190] 7840: fffffe00f80478c0 fffffc0008139590 fffffe007fd9a018 0000000000000000
> [    0.224238] 7860: 0000000000000000 0000000000000000 0000000000000001 0000000000000000
> [    0.226284] 7880: fffffc0008299fcc 00000000000000c0 fffffc0008ef2358 fffffc0008ef3000
> [    0.228318] 78a0: 0000000000000001 fffffc0009ce6000 0000000000000000 fffffe0000000000
> [    0.230362] 78c0: fffffe00f8047930 fffffc000895f2c4 fffffe007fd9a000 fffffc0008299fcc
> [    0.232394] 78e0: fffffe007fd9a000 fffffc000829ad94 fffffe007001db00 000000000000e8e8
> [    0.234435] 7900: fffffe007001db00 fffffe007001dbf8 fffffe00fff3ef50 0000000000000000
> [    0.236481] 7920: fffffe00f8047a20 fffffc0008ef2000 fffffe00f8047950 fffffc0008299fcc
> [    0.238516] 7940: 00000000ffffffff fffffe007fd9a000 fffffe00f8047a70 fffffc000829aa68
> [    0.240560] 7960: 00000000ffffffff 0000000000000001 00000000024000c0 fffffc000829ad94
> [    0.242604] 7980: 0000000000210d00 000000000000e8e8 fffffe007001db00 fffffe007001dbf8
> [    0.244634] 79a0: fffffe00fff3ef50 0000000000000000 fffffe00f8044000 0000000000000040
> [    0.246678] 79c0: fffffc000828d620 fffffc0008ef3000 00000000026080c0 fffffe00fff3ef60
> [    0.248733] 79e0: fffffe00f8047a00 fffffc00024000c0 fffffc0008f89000 0000000000000000
> [    0.250783] 7a00: fffffe00f8047a20 fffffc000822f62c fffffc0009016b30 fffffe00f8047b40
> [    0.252896] 7a20: fffffe00f8047ba0 fffffc000828d620 0000000000000000 fffffc0008ef0b28
> [    0.255009] 7a40: fffffe007fff3c00 0000000000000000 0000000000000000 0000000000000000
> [    0.257121] 7a60: fffffe00f8044000 0000000000000000 fffffe00f8047b90 fffffc000829ad94
> [    0.259240] 7a80: 0000000000000040 fffffe007001db00 00000000024000c0 00000000ffffffff
> [    0.261358] 7aa0: fffffc0008266284 fffffe00fff3ef50 0000000020000000 00e8000000000f07
> [    0.263472] 7ac0: 0000000000000000 0000000000000400 fffffc0008f89000 0000000000000000
> [    0.265662] 7ae0: fffffe00f8047b00 fffffc000822f62c fffffe00fff3ef60 0000000000000000
> [    0.267787] 7b00: 0000001000000000 fffffc0008266284 fffffe00f8047b50 fffffc0008134d24
> [    0.269905] 7b20: fffffe00f8044000 0000000000000040 fffffc0008bf4110 0000000000000189
> [    0.272020] 7b40: fffffc0008ef4000 0000000000000000 fffffe00f8047b70 fffffc000810267c
> [    0.274136] 7b60: fffffc0009016893 0000000000000000 fffffe00f8047ba0 fffffc0008102784
> [    0.276250] 7b80: fffffe00f8047b90 fffffc000829ad7c fffffe00f8047bd0 fffffc000829b13c
> [    0.278371] 7ba0: fffffe007001db00 00000000024000c0 fffffc0008266284 fffffe007001db00
> [    0.280484] 7bc0: fffffc0008ef4000 0000000000000000 fffffe00f8047c30 fffffc0008266284
> [    0.282600] 7be0: fffffdff801b0200 fffffe006c080000 000000006c080000 0000000020000000
> [    0.284715] 7c00: fffffe00f0010008 0000000004000000 0000000020000000 00e8000000000f07
> [    0.286831] 7c20: 0000000000000000 0000000000000000 fffffe00f8047c50 fffffc0008098e24
> [    0.288948] 7c40: fffffdff801b0200 0000000000000001 fffffe00f8047c80 fffffc00080991d0
> [    0.291062] 7c60: 0000000024000000 0000000000000001 0000000024000000 fffffc0008ef0b28
> [    0.293178] 7c80: fffffe00f8047d00 fffffc0008d361cc fffffe0078416018 00e8000000000707
> [    0.295296] 7ca0: fffffc0008ff6410 fffffc0008ef7000 0000000000000000 fffffc0008ff6410
> [    0.297408] 7cc0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.299523] 7ce0: 0000000000000000 00e8000000000f05 fffffc0008098dd0 0000000023ffffff
> [    0.301636] 7d00: fffffe00f8047d10 fffffc0008d35020 fffffe00f8047d40 fffffc0008d88284
> [    0.303748] 7d20: fffffe0078416018 fffffc0008ff6000 fffffc0008c87348 fffffc0008d8821c
> [    0.305863] 7d40: fffffe00f8047d90 fffffc0008083594 fffffc0008d88154 fffffe00f8044000
> [    0.307987] 7d60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.310099] 7d80: 0000000000000000 0000000004000000 fffffe00f8047e00 fffffc0008d30d28
> [    0.312217] 7da0: fffffc0008e622d8 fffffc0008e622e0 0000000000000040 0000000000000000
> [    0.314333] 7dc0: fffffe00f8047e00 fffffc0008d30d18 fffffc0008e62220 fffffc0008e622e0
> [    0.316445] 7de0: 0000000000000040 0000000000000000 0000000000000000 fffffc0008e622e0
> [    0.318572] 7e00: fffffe00f8047ea0 fffffc0008956f48 fffffc0008956f30 0000000000000000
> [    0.320692] 7e20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.322805] 7e40: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
> [    0.324914] 7e60: 0000000000000003 0000000000000000 0000000000000000 0000000000000000
> [    0.327027] 7e80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.329139] 7ea0: 0000000000000000 fffffc0008083330 fffffc0008956f30 0000000000000000
> [    0.331248] 7ec0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.333361] 7ee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.335470] 7f00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.337585] 7f20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.339695] 7f40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.341810] 7f60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.343923] 7f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.346037] 7fa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.348154] 7fc0: 0000000000000000 0000000000000005 0000000000000000 0000000000000000
> [    0.350272] 7fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.352392] Call trace:
> [    0.353049] Exception stack(0xfffffe00f8047650 to 0xfffffe00f8047780)
> [    0.354792] 7640:                                   fffffe007fd9a018 0000040000000000
> [    0.356910] 7660: fffffe00f8047820 fffffc0008487390 fffffe00f80476e0 fffffc0008131290
> [    0.359025] 7680: fffffc000901690b fffffc0008f1e000 0000000000000001 fffffe00700aac00
> [    0.361140] 76a0: fffffc000901690b fffffc0008f27a28 fffffe00fff3b700 fffffc0008e8b700
> [    0.363255] 76c0: fffffe00fff3b700 fffffc0008ef1000 fffffe00f80476e0 00000000000000c0
> [    0.365373] 76e0: fffffe00f8047720 fffffc000811a374 fffffc0008138c08 0000b91000006be8
> [    0.367483] 7700: 000022c80000f420 0000000000000000 0000b91000006a50 0000000000000080
> [    0.369593] 7720: 0000000000000000 fffffc0008299fcc 0000b91000006be8 0000000000000001
> [    0.371702] 7740: 0000000000000011 0000000000000000 fffffe007fff2580 0000000000000001
> [    0.373817] 7760: 0000000000000000 0000000000000000 0000000000000000 0000000057181979
> [    0.375935] [<fffffc0008487390>] __ll_sc_atomic_add+0x20/0x40
> [    0.377489] [<fffffc0008138c08>] __lock_acquire+0xe8/0x698
> [    0.378960] [<fffffc0008139590>] lock_acquire+0xd8/0x2c0
> [    0.380394] [<fffffc000895f2c4>] _raw_spin_lock+0x4c/0x60
> [    0.381843] [<fffffc0008299fcc>] get_partial_node.isra.23+0x4c/0x440
> [    0.383559] [<fffffc000829aa68>] ___slab_alloc+0x438/0x710
> [    0.385031] [<fffffc000829ad94>] __slab_alloc+0x54/0xa0
> [    0.386441] [<fffffc000829b13c>] kmem_cache_alloc+0x35c/0x428
> [    0.387983] [<fffffc0008266284>] ptlock_alloc+0x2c/0x58
> [    0.389394] [<fffffc0008098e24>] pgd_pgtable_alloc+0x54/0xd8
> [    0.390912] [<fffffc00080991d0>] __create_pgd_mapping+0x158/0x2a8
> [    0.392556] [<fffffc0008d361cc>] create_pgd_mapping+0x30/0x38
> [    0.394100] [<fffffc0008d35020>] efi_create_mapping+0xfc/0x110
> [    0.395682] [<fffffc0008d88284>] arm_enable_runtime_services+0x130/0x204
> [    0.397501] [<fffffc0008083594>] do_one_initcall+0x44/0x138
> [    0.399001] [<fffffc0008d30d28>] kernel_init_freeable+0x178/0x2dc
> [    0.400646] [<fffffc0008956f48>] kernel_init+0x18/0x110
> [    0.402053] [<fffffc0008083330>] ret_from_fork+0x10/0x20
> [    0.403488] Code: aa1e03e0 aa0103e8 d503201f f9800111 (885f7d00)
> [    0.405145] ---[ end trace f6be31446b0a9526 ]---
> [    0.406286] note: swapper/0[1] exited with preempt_count 1
> [    0.407687] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.407687]
> [    0.410047] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.410047]
>

This log contains two call traces. The first is a WARNING in wq_numa_init(). The second is the unhandled page fault.

Note the warning message (from wq_numa_init()):

  workqueue: NUMA node mapping not available for cpu0, disabling NUMA support

Something looks genuinely broken with the cpu <-> numa-node associations in the ACPI case -- it even seems to fail when the SRAT does exist.

So, perhaps, commit 7ba5f605f3a0 may not have introduced the bug, only exposed one in the ACPI code?...

Thanks
Laszlo
