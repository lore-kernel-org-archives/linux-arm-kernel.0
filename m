From: lersek@redhat.com (Laszlo Ersek)
Date: Fri, 14 Oct 2016 17:45:50 +0200
Subject: aarch64 ACPI boot regressed by commit 7ba5f605f3a0 ("arm64/numa:
 remove the limitation that cpu0 must bind to node0")
In-Reply-To: <20161014134411.cgba46xpznceucta@hawk.localdomain>
References: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
 <20161014080524.4hm2b4p373r7rhel@hawk.localdomain>
 <04f22a79-301b-f05b-033d-c7a24c9f4084@redhat.com>
 <20161014134411.cgba46xpznceucta@hawk.localdomain>
Message-ID: <019e65d6-d545-c074-ec1d-5d045461b02f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/16 15:44, Andrew Jones wrote:
> On Fri, Oct 14, 2016 at 03:18:00PM +0200, Laszlo Ersek wrote:
>> On 10/14/16 10:05, Andrew Jones wrote:
>>> On Fri, Oct 14, 2016 at 12:50:29AM +0200, Laszlo Ersek wrote:
>>>> (4) Analysis (well, a lame attempt at that, because I have zero
>>>> familiarity with this code). Let me quote the patch:
>>>>
>>>>> commit 7ba5f605f3a0d9495aad539eeb8346d726dfc183
>>>>> Author: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> Date:   Thu Sep 1 14:55:04 2016 +0800
>>>>>
>>>>>     arm64/numa: remove the limitation that cpu0 must bind to node0
>>>>>
>>>>>     1. Remove the old binding code.
>>>>>     2. Read the nid of cpu0 from dts.
>>>>>     3. Fallback the nid of cpu0 to 0 when numa=off is set in bootargs.
>>>>>
>>>>>     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>     Signed-off-by: Will Deacon <will.deacon@arm.com>
>>>>>
>>>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>>>> index c3c08368a685..8b048e6ec34a 100644
>>>>> --- a/arch/arm64/kernel/smp.c
>>>>> +++ b/arch/arm64/kernel/smp.c
>>>>> @@ -624,6 +624,7 @@ static void __init of_parse_and_init_cpus(void)
>>>>>  			}
>>>>>
>>>>>  			bootcpu_valid = true;
>>>>> +			early_map_cpu_to_node(0, of_node_to_nid(dn));
>>>>>
>>>>>  			/*
>>>>>  			 * cpu_logical_map has already been
>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>>>> index 0a15f010b64a..778a985c8a70 100644
>>>>> --- a/arch/arm64/mm/numa.c
>>>>> +++ b/arch/arm64/mm/numa.c
>>>>> @@ -116,16 +116,24 @@ static void __init setup_node_to_cpumask_map(void)
>>>>>   */
>>>>>  void numa_store_cpu_info(unsigned int cpu)
>>>>>  {
>>>>> -	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
>>>>> +	map_cpu_to_node(cpu, cpu_to_node_map[cpu]);
>>>>>  }
>>>>>
>>>>>  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>>>>>  {
>>>>>  	/* fallback to node 0 */
>>>>> -	if (nid < 0 || nid >= MAX_NUMNODES)
>>>>> +	if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
>>>>>  		nid = 0;
>>>
>>> The ACPI equivalent code must be missing (at least) the above, because,
>>> even with DT, mach-virt won't have cpu to node mappings unless numa
>>> is configured on the command line. Can you try adding something like
>>>
>>>     -m 512 -smp 4 \
>>>     -numa node,mem=256M,cpus=0-1,nodeid=0 \
>>>     -numa node,mem=256M,cpus=2-3,nodeid=1
>>>
>>> to your QEMU command line?
>>
>> I added the following to my domain XML, under <cpu>:
>>
>>     <numa>
>>       <cell id='0' cpus='0-1' memory='2097152' unit='KiB'/>
>>       <cell id='1' cpus='2-3' memory='2097152' unit='KiB'/>
>>     </numa>
>>
>> (See <http://libvirt.org/formatdomain.html#elementsCPU>.)
>>
>> With that, each NUMA node gets half of the VCPUs and half of the guest RAM.
>>
>> (This is in a different guest now, one that has a bleeding edge Fedora kernel -- I didn't want to rebuild the upstream kernel yet again, just for this test. So, "4.9.0-0.rc0.git7.1.fc26.aarch64" is based on upstream v4.8-14109-g1573d2c, and it reproduces the problem too.)
>>
>>> Then when you boot with ACPI you'll get a
>>> SRAT.
>>
>> Yes, that's confirmed by the guest kernel log (see below).
>>
>>> If that works, then we're just missing the "no SRAT, nid = 0"
>>> code (that should have been added with this patch)
>>
>> It still crashes with the SRAT, with the following log:
> 
> Rats.
> 
>> Note the warning message (from wq_numa_init()):
>>
>>   workqueue: NUMA node mapping not available for cpu0, disabling NUMA support
>>
>> Something looks genuinely broken with the cpu <-> numa-node associations in the ACPI case -- it even seems to fail when the SRAT does exist.
>>
>> So, perhaps, commit 7ba5f605f3a0 may not have introduced the bug, only exposed one in the ACPI code?...
> 
> The kernel's ACPI NUMA support used to work. It was the test case for
> QEMU's SRAT generation code.
> 
> Two more experiments I wouldn't mind having you try, if you have time;
>  1) confirm that this NUMA configured guest and this latest kernel works
>     with DT. This is just for sanity, but I guess it will.

Yes, it boots fine. It's at v4.8-14604-g29fbff8.

>  2) If (1) succeeds, then try the last-known-good kernel with ACPI again,
>     but this time with the NUMA configured guest.

v4.8, which was my known-good starting point in the acpi=force bisection -- at that time without using a NUMA configuration --, also boots fine under this two-node NUMA configuration, using acpi=force:

> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.8.0 (root at aarch64-vgpu-1) (gcc version 6.2.1 20160916 (Red Hat 6.2.1-2) (GCC) ) #2 SMP Thu Oct 13 17:17:59 CEST 2016
> [    0.000000] Boot CPU: AArch64 Processor [500f0000]
> [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.60 by EDK II
> [    0.000000] efi:  SMBIOS 3.0=0x13bdb0000  ACPI 2.0=0x1386d0000  MEMATTR=0x13a665018
> [    0.000000] cma: Reserved 512 MiB at 0x00000000c0000000
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000001386D0000 000024 (v02 BOCHS )
> [    0.000000] ACPI: XSDT 0x00000001386C0000 000054 (v01 BOCHS  BXPCFACP 00000001      01000013)
> [    0.000000] ACPI: FACP 0x0000000138410000 00010C (v05 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> [    0.000000] ACPI: DSDT 0x0000000138420000 001159 (v02 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: APIC 0x0000000138400000 0002BC (v03 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> [    0.000000] ACPI: GTDT 0x00000001383F0000 000060 (v02 BOCHS  BXPCGTDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: MCFG 0x00000001383E0000 00003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
> [    0.000000] ACPI: SPCR 0x00000001383D0000 000050 (v02 BOCHS  BXPCSPCR 00000001 BXPC 00000001)
> [    0.000000] ACPI: SRAT 0x00000001383C0000 000110 (v03 BOCHS  BXPCSRAT 00000001 BXPC 00000001)
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x0 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x4 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x5 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x6 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x7 -> Node 1
> [    0.000000] NUMA: Adding memblock [0x40000000 - 0x13fffffff] on node 0
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0x13fffffff]
> [    0.000000] NUMA: Adding memblock [0x140000000 - 0x23fffffff] on node 1
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x140000000-0x23fffffff]
> [    0.000000] NUMA: Initmem setup node 0 [mem 0x40000000-0x13fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x13fff2580-0x13fffffff]
> [    0.000000] NUMA: Initmem setup node 1 [mem 0x140000000-0x23fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x23fff2580-0x23fffffff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000fffeffff]
> [    0.000000]   node   0: [mem 0x00000000ffff0000-0x00000000ffffffff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x00000001383bffff]
> [    0.000000]   node   0: [mem 0x00000001383c0000-0x000000013874ffff]
> [    0.000000]   node   0: [mem 0x0000000138750000-0x000000013bc1ffff]
> [    0.000000]   node   0: [mem 0x000000013bc20000-0x000000013bffffff]
> [    0.000000]   node   0: [mem 0x000000013c000000-0x000000013fffffff]
> [    0.000000]   node   1: [mem 0x0000000140000000-0x000000023fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
> [    0.000000] On node 0 totalpages: 65536
> [    0.000000]   DMA zone: 48 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 49152 pages, LIFO batch:1
> [    0.000000]   Normal zone: 16 pages used for memmap
> [    0.000000]   Normal zone: 16384 pages, LIFO batch:1
> [    0.000000] Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
> [    0.000000] On node 1 totalpages: 65536
> [    0.000000]   Normal zone: 64 pages used for memmap
> [    0.000000]   Normal zone: 65536 pages, LIFO batch:1
> [    0.000000] psci: probing for conduit method from ACPI.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] percpu: Embedded 3 pages/cpu @fffffe01ffdc0000 s117320 r8192 d71096 u196608
> [    0.000000] pcpu-alloc: s117320 r8192 d71096 u196608 alloc=3*65536
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 130944
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.8.0 root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap console=ttyAMA0 earlyprintk=pl011,0x9000000 earlycon ignore_loglevel acpi=force
> [    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
> [    0.000000] software IO TLB [mem 0xfbfe0000-0xfffe0000] (64MB) mapped at [fffffe00bbfe0000-fffffe00bffdffff]
> [    0.000000] Memory: 7717184K/8388608K available (8956K kernel code, 1565K rwdata, 3712K rodata, 1536K init, 15876K bss, 147136K reserved, 524288K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     modules : 0xfffffc0000000000 - 0xfffffc0008000000   (   128 MB)
> [    0.000000]     vmalloc : 0xfffffc0008000000 - 0xfffffdff5fff0000   (  2045 GB)
> [    0.000000]       .text : 0xfffffc0008080000 - 0xfffffc0008940000   (  8960 KB)
> [    0.000000]     .rodata : 0xfffffc0008940000 - 0xfffffc0008cf0000   (  3776 KB)
> [    0.000000]       .init : 0xfffffc0008cf0000 - 0xfffffc0008e70000   (  1536 KB)
> [    0.000000]       .data : 0xfffffc0008e70000 - 0xfffffc0008ff7400   (  1565 KB)
> [    0.000000]        .bss : 0xfffffc0008ff7400 - 0xfffffc0009f78628   ( 15877 KB)
> [    0.000000]     fixed   : 0xfffffdff7e7d0000 - 0xfffffdff7ec00000   (  4288 KB)
> [    0.000000]     PCI I/O : 0xfffffdff7ee00000 - 0xfffffdff7fe00000   (    16 MB)
> [    0.000000]     vmemmap : 0xfffffdff80000000 - 0xfffffe0000000000   (     2 GB maximum)
> [    0.000000]               0xfffffdff80000000 - 0xfffffdff80800000   (     8 MB actual)
> [    0.000000]     memory  : 0xfffffe0000000000 - 0xfffffe0200000000   (  8192 MB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=2
> [    0.000000] Running RCU self tests
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU lockdep checking is enabled.
> [    0.000000] 	Build-time adjustment of leaf fanout to 64.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
> [    0.000000] kmemleak: Kernel memory leak detector disabled
> [    0.000000] NR_IRQS:64 nr_irqs:64 0
> [    0.000000] GICv2m: ACPI overriding V2M MSI_TYPER (base:80, num:64)
> [    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> [    0.000000] GIC: PPI11 is secure or misconfigured
> [    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3, assuming level low
> [    0.000000] arm_arch_timer: WARNING: Please fix your firmware
> [    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 50.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> [    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
> [    0.002263] Console: colour dummy device 80x25
> [    0.003385] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.005291] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.006233] ... MAX_LOCK_DEPTH:          48
> [    0.007335] ... MAX_LOCKDEP_KEYS:        8191
> [    0.008339] ... CLASSHASH_SIZE:          4096
> [    0.009334] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.010497] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.011517] ... CHAINHASH_SIZE:          32768
> [    0.012541]  memory used by lock dependency info: 8159 kB
> [    0.013810]  per task-struct memory footprint: 1920 bytes
> [    0.015809] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
> [    0.018762] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=50000)
> [    0.021262] pid_max: default: 32768 minimum: 301
> [    0.022804] ACPI: Core revision 20160422
> [    0.027895] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    0.029485]
> [    0.030614] Security Framework initialized
> [    0.031599] Yama: becoming mindful.
> [    0.032422] SELinux:  Initializing.
> [    0.033949] SELinux:  Starting in permissive mode
> [    0.035498] Dentry cache hash table entries: 1048576 (order: 7, 8388608 bytes)
> [    0.039287] Inode-cache hash table entries: 524288 (order: 6, 4194304 bytes)
> [    0.042406] Mount-cache hash table entries: 16384 (order: 1, 131072 bytes)
> [    0.044138] Mountpoint-cache hash table entries: 16384 (order: 1, 131072 bytes)
> [    0.047820] ftrace: allocating 28926 entries in 8 pages
> [    0.082086] ASID allocator initialised with 65536 entries
> [    0.086231] Remapping and enabling EFI services.
> [    0.087582]   EFI remap 0x0000000004000000 => 0000000020000000
> [    0.089058]   EFI remap 0x0000000009010000 => 0000000024000000
> [    0.090486]   EFI remap 0x0000000138430000 => 0000000024010000
> [    0.091877]   EFI remap 0x0000000138490000 => 0000000024070000
> [    0.093269]   EFI remap 0x00000001384e0000 => 00000000240c0000
> [    0.094687]   EFI remap 0x0000000138530000 => 0000000024110000
> [    0.096076]   EFI remap 0x0000000138580000 => 0000000024160000
> [    0.097471]   EFI remap 0x00000001385d0000 => 00000000241b0000
> [    0.098855]   EFI remap 0x0000000138620000 => 0000000024200000
> [    0.100243]   EFI remap 0x0000000138670000 => 0000000024250000
> [    0.101638]   EFI remap 0x00000001386e0000 => 00000000242a0000
> [    0.103022]   EFI remap 0x000000013bc20000 => 0000000024310000
> [    0.104420]   EFI remap 0x000000013bdb0000 => 00000000244a0000
> [    0.120433] Detected PIPT I-cache on CPU1
> [    0.120539] CPU1: Booted secondary processor [500f0000]
> [    0.134831] Detected PIPT I-cache on CPU2
> [    0.134918] CPU2: Booted secondary processor [500f0000]
> [    0.149136] Detected PIPT I-cache on CPU3
> [    0.149226] CPU3: Booted secondary processor [500f0000]
> [    0.163487] Detected PIPT I-cache on CPU4
> [    0.163576] CPU4: Booted secondary processor [500f0000]
> [    0.177837] Detected PIPT I-cache on CPU5
> [    0.177926] CPU5: Booted secondary processor [500f0000]
> [    0.192172] Detected PIPT I-cache on CPU6
> [    0.192260] CPU6: Booted secondary processor [500f0000]
> [    0.206722] Detected PIPT I-cache on CPU7
> [    0.206811] CPU7: Booted secondary processor [500f0000]
> [    0.207003] Brought up 8 CPUs
> [    0.223904] SMP: Total of 8 processors activated.
> [    0.225110] CPU features: detected feature: 32-bit EL0 Support
> [    0.226534] CPU: All CPU(s) started at EL1
> [    0.319814] devtmpfs: initialized
> [    0.321977] SMBIOS 3.0.0 present.
> [    0.323394] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.331773] atomic64_test: passed
> [    0.332749] pinctrl core: initialized pinctrl subsystem
> [    0.335763] NET: Registered protocol family 16
> [    0.342141] cpuidle: using governor menu
> [    0.343192] PCCT header not found.
> [    0.344082] vdso: 2 pages (1 code @ fffffc0008960000, 1 data @ fffffc0008e90000)
> [    0.346114] hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.
> [    0.349683] DMA: preallocated 256 KiB pool for atomic allocations
> [    0.351473] ACPI: bus type PCI registered
> [    0.352483] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.354595] Serial: AMBA PL011 UART driver
> [    0.373196] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.374902] HugeTLB registered 512 MB page size, pre-allocated 0 pages
> [    0.380062] ACPI: Added _OSI(Module Device)
> [    0.381157] ACPI: Added _OSI(Processor Device)
> [    0.382200] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.383303] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.392501] ACPI: Interpreter enabled
> [    0.393484] ACPI: Using GIC for interrupt routing
> [    0.394751] ACPI: MCFG table detected, 1 entries
> [    0.414519] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 5, base_baud = 0) is a SBSA
> [    0.416591] console [ttyAMA0] enabled
> [    0.416591] console [ttyAMA0] enabled
> [    0.418231] bootconsole [pl11] disabled
> [    0.418231] bootconsole [pl11] disabled
> [    0.428624] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-0f])
> [    0.429962] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.432827] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    0.434477] acpi PNP0A08:00: ECAM at [mem 0x3f000000-0x3fffffff] for [bus 00-0f]
> [    0.436078] Remapped I/O 0x000000003eff0000 to [io  0x0000-0xffff window]
> [    0.438129] PCI host bridge to bus 0000:00
> [    0.438987] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff window]
> [    0.440462] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
> [    0.441750] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff window]
> [    0.443252] pci_bus 0000:00: root bus resource [bus 00-0f]
> [    0.444377] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> [    0.446402] pci 0000:00:01.0: [8086:3420] type 01 class 0x060400
> [    0.489217] pci 0000:00:01.1: [8086:3420] type 01 class 0x060400
> [    0.528741] pci 0000:00:01.2: [8086:3420] type 01 class 0x060400
> [    0.567928] pci 0000:00:01.3: [8086:3420] type 01 class 0x060400
> [    0.613634] pci 0000:01:00.0: [1033:0194] type 00 class 0x0c0330
> [    0.614948] pci 0000:01:00.0: reg 0x10: [mem 0x10300000-0x10303fff 64bit]
> [    0.631100] pci 0000:02:00.0: [1af4:1048] type 00 class 0x010000
> [    0.679413] pci 0000:02:00.0: reg 0x14: [mem 0x10200000-0x10200fff]
> [    0.752358] pci 0000:02:00.0: reg 0x20: [mem 0x8000000000-0x80007fffff 64bit pref]
> [    0.793032] pci 0000:03:00.0: [1af4:1041] type 00 class 0x020000
> [    0.841238] pci 0000:03:00.0: reg 0x14: [mem 0x10100000-0x10100fff]
> [    0.914350] pci 0000:03:00.0: reg 0x20: [mem 0x8000800000-0x8000ffffff 64bit pref]
> [    0.939819] pci 0000:03:00.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
> [    0.956386] pci 0000:04:00.0: [1af4:1050] type 00 class 0x038000
> [    1.004617] pci 0000:04:00.0: reg 0x14: [mem 0x10000000-0x10000fff]
> [    1.077643] pci 0000:04:00.0: reg 0x20: [mem 0x8001000000-0x80017fffff 64bit pref]
> [    1.213423] pci 0000:00:01.1: BAR 15: assigned [mem 0x8000000000-0x80007fffff 64bit pref]
> [    1.215037] pci 0000:00:01.2: BAR 15: assigned [mem 0x8000800000-0x8000ffffff 64bit pref]
> [    1.216626] pci 0000:00:01.3: BAR 15: assigned [mem 0x8001000000-0x80017fffff 64bit pref]
> [    1.219273] pci 0000:00:01.0: BAR 14: assigned [mem 0x10000000-0x101fffff]
> [    1.220663] pci 0000:00:01.0: BAR 15: assigned [mem 0x8001800000-0x80019fffff 64bit pref]
> [    1.222265] pci 0000:00:01.1: BAR 14: assigned [mem 0x10200000-0x103fffff]
> [    1.223605] pci 0000:00:01.2: BAR 14: assigned [mem 0x10400000-0x105fffff]
> [    1.224945] pci 0000:00:01.3: BAR 14: assigned [mem 0x10600000-0x107fffff]
> [    1.226270] pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
> [    1.227475] pci 0000:00:01.1: BAR 13: assigned [io  0x2000-0x2fff]
> [    1.228668] pci 0000:00:01.2: BAR 13: assigned [io  0x3000-0x3fff]
> [    1.229853] pci 0000:00:01.3: BAR 13: assigned [io  0x4000-0x4fff]
> [    1.231064] pci 0000:01:00.0: BAR 0: assigned [mem 0x10000000-0x10003fff 64bit]
> [    1.232564] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    1.233530] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
> [    1.253214] pci 0000:00:01.0:   bridge window [mem 0x10000000-0x101fffff]
> [    1.267540] pci 0000:00:01.0:   bridge window [mem 0x8001800000-0x80019fffff 64bit pref]
> [    1.294996] pci 0000:02:00.0: BAR 4: assigned [mem 0x8000000000-0x80007fffff 64bit pref]
> [    1.321082] pci 0000:02:00.0: BAR 1: assigned [mem 0x10200000-0x10200fff]
> [    1.323053] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    1.324004] pci 0000:00:01.1:   bridge window [io  0x2000-0x2fff]
> [    1.344149] pci 0000:00:01.1:   bridge window [mem 0x10200000-0x103fffff]
> [    1.358181] pci 0000:00:01.1:   bridge window [mem 0x8000000000-0x80007fffff 64bit pref]
> [    1.384572] pci 0000:03:00.0: BAR 4: assigned [mem 0x8000800000-0x8000ffffff 64bit pref]
> [    1.410293] pci 0000:03:00.0: BAR 6: assigned [mem 0x10400000-0x1043ffff pref]
> [    1.412715] pci 0000:03:00.0: BAR 1: assigned [mem 0x10440000-0x10440fff]
> [    1.426032] pci 0000:00:01.2: PCI bridge to [bus 03]
> [    1.427117] pci 0000:00:01.2:   bridge window [io  0x3000-0x3fff]
> [    1.446229] pci 0000:00:01.2:   bridge window [mem 0x10400000-0x105fffff]
> [    1.460070] pci 0000:00:01.2:   bridge window [mem 0x8000800000-0x8000ffffff 64bit pref]
> [    1.486803] pci 0000:04:00.0: BAR 4: assigned [mem 0x8001000000-0x80017fffff 64bit pref]
> [    1.512454] pci 0000:04:00.0: BAR 1: assigned [mem 0x10600000-0x10600fff]
> [    1.526310] pci 0000:00:01.3: PCI bridge to [bus 04]
> [    1.527283] pci 0000:00:01.3:   bridge window [io  0x4000-0x4fff]
> [    1.546456] pci 0000:00:01.3:   bridge window [mem 0x10600000-0x107fffff]
> [    1.560368] pci 0000:00:01.3:   bridge window [mem 0x8001000000-0x80017fffff 64bit pref]
> [    1.587389] ACPI: PCI Interrupt Link [GSI0] (IRQs *35)
> [    1.588527] ACPI: PCI Interrupt Link [GSI1] (IRQs *36)
> [    1.589607] ACPI: PCI Interrupt Link [GSI2] (IRQs *37)
> [    1.590670] ACPI: PCI Interrupt Link [GSI3] (IRQs *38)
> [    1.594331] vgaarb: loaded
> [    1.595642] SCSI subsystem initialized
> [    1.596943] libata version 3.00 loaded.
> [    1.597907] ACPI: bus type USB registered
> [    1.598884] usbcore: registered new interface driver usbfs
> [    1.600034] usbcore: registered new interface driver hub
> [    1.601350] usbcore: registered new device driver usb
> [    1.604990] NetLabel: Initializing
> [    1.605716] NetLabel:  domain hash size = 128
> [    1.606524] NetLabel:  protocols = UNLABELED CIPSOv4
> [    1.607669] NetLabel:  unlabeled traffic allowed by default
> [    1.611142] DMA-API: preallocated 4096 debug entries
> [    1.612105] DMA-API: debugging enabled by kernel config
> [    1.705795] clocksource: Switched to clocksource arch_sys_counter
> [    1.787821] VFS: Disk quotas dquot_6.6.0
> [    1.789040] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
> [    1.791938] pnp: PnP ACPI init
> [    1.793312] pnp: PnP ACPI: found 0 devices
> [    1.810253] NET: Registered protocol family 2
> [    1.813094] TCP established hash table entries: 65536 (order: 3, 524288 bytes)
> [    1.814846] TCP bind hash table entries: 65536 (order: 6, 4194304 bytes)
> [    1.822396] TCP: Hash tables configured (established 65536 bind 65536)
> [    1.823873] UDP hash table entries: 4096 (order: 3, 655360 bytes)
> [    1.825936] UDP-Lite hash table entries: 4096 (order: 3, 655360 bytes)
> [    1.828672] NET: Registered protocol family 1
> [    1.829673] pci 0000:01:00.0: enabling device (0000 -> 0002)
> [    1.837906] PCI: CLS 0 bytes, default 128
> [    1.839209] Unpacking initramfs...
> [    2.755342] Freeing initrd memory: 30400K (fffffe00f53c0000 - fffffe00f7170000)
> [    2.757373] kvm [1]: HYP mode not available
> [    2.758651] alg: No test for __ecb-aes-neon (__driver-ecb-aes-neon)
> [    2.760171] cryptomgr_test (75) used greatest stack depth: 13824 bytes left
> [    2.767725] modprobe (81) used greatest stack depth: 12944 bytes left
> [    2.772040] alg: No test for __ecb-aes-neon (cryptd(__driver-ecb-aes-neon))
> [    2.774374] cryptomgr_test (79) used greatest stack depth: 12368 bytes left
> [    2.777350] futex hash table entries: 2048 (order: 2, 262144 bytes)
> [    2.779027] audit: initializing netlink subsys (disabled)
> [    2.780231] audit: type=2000 audit(2.600:1): initialized
> [    2.782020] Initialise system trusted keyrings
> [    2.784150] workingset: timestamp_bits=37 max_order=17 bucket_order=0
> [    2.802041] zbud: loaded
> [    2.808395] Key type big_key registered
> [    2.809229] SELinux:  Registering netfilter hooks
> [    2.897252] alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
> [    2.898554] cryptomgr_test (104) used greatest stack depth: 12016 bytes left
> [    2.908631] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
> [    2.910204] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
> [    2.911772] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes256
> [    2.915338] NET: Registered protocol family 38
> [    2.916380] Key type asymmetric registered
> [    2.917318] Asymmetric key parser 'x509' registered
> [    2.918805] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> [    2.920707] io scheduler noop registered
> [    2.921443] io scheduler deadline registered
> [    2.923122] io scheduler cfq registered (default)
> [    2.924139] start plist test
> [    2.927415] end plist test
> [    2.931670] pl061_gpio ARMH0061:00: PL061 GPIO chip @0x0000000009030000 registered
> [    2.934507] ACPI: PCI Interrupt Link [GSI1] enabled at IRQ 36
> [    2.973148] aer 0000:00:01.0:pcie002: service driver aer loaded
> [    2.974725] aer 0000:00:01.1:pcie002: service driver aer loaded
> [    2.976977] aer 0000:00:01.2:pcie002: service driver aer loaded
> [    2.978502] aer 0000:00:01.3:pcie002: service driver aer loaded
> [    2.979878] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
> [    2.981335] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    2.982761] pcie_pme 0000:00:01.0:pcie001: service driver pcie_pme loaded
> [    2.984298] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
> [    2.985781] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
> [    2.987087] pcie_pme 0000:00:01.1:pcie001: service driver pcie_pme loaded
> [    2.988619] pcieport 0000:00:01.2: Signaling PME through PCIe PME interrupt
> [    2.990050] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
> [    2.991448] pcie_pme 0000:00:01.2:pcie001: service driver pcie_pme loaded
> [    2.993019] pcieport 0000:00:01.3: Signaling PME through PCIe PME interrupt
> [    2.994518] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
> [    2.995867] pcie_pme 0000:00:01.3:pcie001: service driver pcie_pme loaded
> [    2.997328] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    2.998614] pciehp 0000:00:01.0:pcie004: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- LLActRep-
> [    3.001848] pciehp 0000:00:01.0:pcie004: service driver pciehp loaded
> [    3.003202] pciehp 0000:00:01.1:pcie004: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- LLActRep-
> [    3.006097] pciehp 0000:00:01.1:pcie004: service driver pciehp loaded
> [    3.007533] pciehp 0000:00:01.2:pcie004: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- LLActRep-
> [    3.010330] pciehp 0000:00:01.2:pcie004: service driver pciehp loaded
> [    3.011748] pciehp 0000:00:01.3:pcie004: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- LLActRep-
> [    3.014587] pciehp 0000:00:01.3:pcie004: service driver pciehp loaded
> [    3.015864] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    3.017707] efifb: invalid framebuffer address
> [    3.020376] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    3.033876] msm_serial: driver initialized
> [    3.035876] Failed to find cpu0 device node
> [    3.036713] Unable to detect cache hierarchy from DT for CPU 0
> [    3.038968] libphy: Fixed MDIO Bus: probed
> [    3.040219] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    3.041636] ehci-pci: EHCI PCI platform driver
> [    3.042554] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    3.043761] ohci-pci: OHCI PCI platform driver
> [    3.044666] uhci_hcd: USB Universal Host Controller Interface driver
> [    3.054963] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [    3.056725] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
> [    3.060495] xhci_hcd 0000:01:00.0: hcc params 0x00087001 hci version 0x100 quirks 0x00000014
> [    3.064236] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.065654] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.067032] usb usb1: Product: xHCI Host Controller
> [    3.067982] usb usb1: Manufacturer: Linux 4.8.0 xhci-hcd
> [    3.069014] usb usb1: SerialNumber: 0000:01:00.0
> [    3.071283] hub 1-0:1.0: USB hub found
> [    3.072298] hub 1-0:1.0: 4 ports detected
> [    3.074921] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [    3.076485] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
> [    3.078304] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [    3.080160] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
> [    3.081526] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.082893] usb usb2: Product: xHCI Host Controller
> [    3.083821] usb usb2: Manufacturer: Linux 4.8.0 xhci-hcd
> [    3.084825] usb usb2: SerialNumber: 0000:01:00.0
> [    3.086840] hub 2-0:1.0: USB hub found
> [    3.087745] hub 2-0:1.0: 4 ports detected
> [    3.090180] usbcore: registered new interface driver usbserial
> [    3.091473] usbcore: registered new interface driver usbserial_generic
> [    3.093048] usbserial: USB Serial support registered for generic
> [    3.094847] mousedev: PS/2 mouse device common for all mice
> [    3.097427] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
> [    3.099602] device-mapper: uevent: version 1.0.3
> [    3.101336] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel at redhat.com
> [    3.104534] EFI Variables Facility v0.08 2004-May-17
> [    3.107690] hidraw: raw HID events driver (C) Jiri Kosina
> [    3.109001] usbcore: registered new interface driver usbhid
> [    3.110141] usbhid: USB HID core driver
> [    3.111920] drop_monitor: Initializing network drop monitor service
> [    3.113583] ip_tables: (C) 2000-2006 Netfilter Core Team
> [    3.114948] Initializing XFRM netlink socket
> [    3.117302] NET: Registered protocol family 10
> [    3.120493] mip6: Mobile IPv6
> [    3.121237] NET: Registered protocol family 17
> [    3.123363] registered taskstats version 1
> [    3.124289] Loading compiled-in X.509 certificates
> [    3.132881] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
> [    3.136159] Loaded X.509 cert 'Build time autogenerated kernel key: 646bee5e17f26888c6e6ef5950998cb2000dfbae'
> [    3.138723] zswap: loaded using pool lzo/zbud
> [    3.166483] rtc-efi rtc-efi: setting system clock to 2016-10-14 15:41:17 UTC (1476459677)
> [    3.168727] PM: Hibernation image not present or could not be loaded.
> [    3.170839] Freeing unused kernel memory: 1536K (fffffe0000cf0000 - fffffe0000e70000)
> [    3.190833] random: systemd: uninitialized urandom read (16 bytes read)
> [    3.194327] random: systemd: uninitialized urandom read (16 bytes read)
> [    3.213481] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> [    3.217655] systemd[1]: Detected virtualization kvm.
> [    3.218614] systemd[1]: Detected architecture arm64.
> [    3.219547] systemd[1]: Running in initial RAM disk.
>
> Welcome to Fedora 24 (Server Edition) dracut-044-20.fc24 (Initramfs)!

> If (2) fails then we may need to expand the bisection :-(

Thankfully, it didn't fail.

Thanks
Laszlo
