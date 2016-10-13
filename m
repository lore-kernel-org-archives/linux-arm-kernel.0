From: lersek@redhat.com (Laszlo Ersek)
Date: Fri, 14 Oct 2016 00:50:29 +0200
Subject: aarch64 ACPI boot regressed by commit 7ba5f605f3a0 ("arm64/numa:
 remove the limitation that cpu0 must bind to node0")
Message-ID: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following regression is experienced in aarch64 qemu/KVM virtual
machines, using the ArmVirtQemu virtual UEFI firmware platform built
from edk2 (EFI Development Kit II).

(1) When booting current master (b67be92feb48) or the bisected first bad
    commit (7ba5f605f3a0) with DT enabled, everything works fine.

(2) When booting the above two commits with DT disabled -- meaning:
    either the firmware provides ACPI only and no DT, or "acpi=force" is
    passed on the kernel command line --, the boot breaks with one of
    the following symptoms:

(2a) no messages are printed after

> EFI stub: Booting Linux Kernel...
> ConvertPages: Incompatible memory types
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...

     and the kernel seems to be spinning in an infinite loop (no
     messages despite "earlycon" and friends),

(2b) or the following crash dump is printed:

> EFI stub: Booting Linux Kernel...
> ConvertPages: Incompatible memory types
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> Booting Linux on physical CPU 0x0
> Linux version 4.8.0-rc3+ (root at aarch64-vgpu-1) (gcc version 6.2.1 20160916 (Red Hat 6.2.1-2) (GCC) ) #19 SMP Thu Oct 13 22:30:27 CEST 2016
> Boot CPU: AArch64 Processor [500f0000]
> earlycon: pl11 at MMIO 0x0000000009000000 (options '')
> bootconsole [pl11] enabled
> debug: ignoring loglevel setting.
> efi: Getting EFI parameters from FDT:
> efi: EFI v2.60 by EDK II
> efi:  SMBIOS 3.0=0x23bdb0000  ACPI 2.0=0x2386d0000  MEMATTR=0x23a665018
> cma: Reserved 512 MiB at 0x00000000c0000000
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x00000002386D0000 000024 (v02 BOCHS )
> ACPI: XSDT 0x00000002386C0000 00004C (v01 BOCHS  BXPCFACP 00000001      01000013)
> ACPI: FACP 0x0000000238410000 00010C (v05 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> ACPI: DSDT 0x0000000238420000 001159 (v02 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> ACPI: APIC 0x0000000238400000 0002BC (v03 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> ACPI: GTDT 0x00000002383F0000 000060 (v02 BOCHS  BXPCGTDT 00000001 BXPC 00000001)
> ACPI: MCFG 0x00000002383E0000 00003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
> ACPI: SPCR 0x00000002383D0000 000050 (v02 BOCHS  BXPCSPCR 00000001 BXPC 00000001)
> ACPI: NUMA: Failed to initialise from firmware
> NUMA: Faking a node at [mem 0x0000000000000000-0x000000023fffffff]
> NUMA: Adding memblock [0x40000000 - 0xfffeffff] on node 0
> NUMA: Adding memblock [0xffff0000 - 0xffffffff] on node 0
> NUMA: Adding memblock [0x100000000 - 0x2383cffff] on node 0
> NUMA: Adding memblock [0x2383d0000 - 0x23874ffff] on node 0
> NUMA: Adding memblock [0x238750000 - 0x23bc1ffff] on node 0
> NUMA: Adding memblock [0x23bc20000 - 0x23bffffff] on node 0
> NUMA: Adding memblock [0x23c000000 - 0x23fffffff] on node 0
> NUMA: Initmem setup node 0 [mem 0x40000000-0x23fffffff]
> NUMA: NODE_DATA [mem 0x23fff2580-0x23fffffff]
> Zone ranges:
>   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>   Normal   [mem 0x0000000100000000-0x000000023fffffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000040000000-0x00000000fffeffff]
>   node   0: [mem 0x00000000ffff0000-0x00000000ffffffff]
>   node   0: [mem 0x0000000100000000-0x00000002383cffff]
>   node   0: [mem 0x00000002383d0000-0x000000023874ffff]
>   node   0: [mem 0x0000000238750000-0x000000023bc1ffff]
>   node   0: [mem 0x000000023bc20000-0x000000023bffffff]
>   node   0: [mem 0x000000023c000000-0x000000023fffffff]
> Initmem setup node 0 [mem 0x0000000040000000-0x000000023fffffff]
> On node 0 totalpages: 131072
>   DMA zone: 48 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 49152 pages, LIFO batch:1
>   Normal zone: 80 pages used for memmap
>   Normal zone: 81920 pages, LIFO batch:1
> psci: probing for conduit method from ACPI.
> psci: PSCIv0.2 detected in firmware.
> psci: Using standard PSCI v0.2 function IDs
> psci: Trusted OS migration not required
> percpu: Embedded 3 pages/cpu @fffffe01ffdb0000 s117320 r8192 d71096 u196608
> pcpu-alloc: s117320 r8192 d71096 u196608 alloc=3*65536
> pcpu-alloc: [0] 0 [1] 1 [2] 2 [3] 3 [4] 4 [5] 5 [6] 6 [7] 7
> Detected PIPT I-cache on CPU0
> Built 1 zonelists in Node order, mobility grouping on.  Total pages: 130944
> Policy zone: Normal
> Kernel command line: BOOT_IMAGE=/vmlinuz-4.8.0-rc3+ root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap console=ttyAMA0 earlyprintk=pl011,0x9000000 earlycon ignore_loglevel LANG=en_US.UTF-8 acpi=force
> PID hash table entries: 4096 (order: -1, 32768 bytes)
> software IO TLB [mem 0xfbfe0000-0xfffe0000] (64MB) mapped at [fffffe00bbfe0000-fffffe00bffdffff]
> Memory: 7717184K/8388608K available (8956K kernel code, 1564K rwdata, 3712K rodata, 1536K init, 15875K bss, 147136K reserved, 524288K cma-reserved)
> Virtual kernel memory layout:
>     modules : 0xfffffc0000000000 - 0xfffffc0008000000   (   128 MB)
>     vmalloc : 0xfffffc0008000000 - 0xfffffdff5fff0000   (  2045 GB)
>       .text : 0xfffffc0008080000 - 0xfffffc0008940000   (  8960 KB)
>     .rodata : 0xfffffc0008940000 - 0xfffffc0008cf0000   (  3776 KB)
>       .init : 0xfffffc0008cf0000 - 0xfffffc0008e70000   (  1536 KB)
>       .data : 0xfffffc0008e70000 - 0xfffffc0008ff7200   (  1565 KB)
>        .bss : 0xfffffc0008ff7200 - 0xfffffc0009f78120   ( 15876 KB)
>     fixed   : 0xfffffdff7e7d0000 - 0xfffffdff7ec00000   (  4288 KB)
>     PCI I/O : 0xfffffdff7ee00000 - 0xfffffdff7fe00000   (    16 MB)
>     vmemmap : 0xfffffdff80000000 - 0xfffffe0000000000   (     2 GB maximum)
>               0xfffffdff80000000 - 0xfffffdff80800000   (     8 MB actual)
>     memory  : 0xfffffe0000000000 - 0xfffffe0200000000   (  8192 MB)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> Running RCU self tests
> Hierarchical RCU implementation.
>        RCU lockdep checking is enabled.
>        Build-time adjustment of leaf fanout to 64.
>        RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
> RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
> kmemleak: Kernel memory leak detector disabled
> NR_IRQS:64 nr_irqs:64 0
> GICv2m: ACPI overriding V2M MSI_TYPER (base:80, num:64)
> GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> GIC: PPI11 is secure or misconfigured
> arm_arch_timer: WARNING: Invalid trigger for IRQ3, assuming level low
> arm_arch_timer: WARNING: Please fix your firmware
> arm_arch_timer: Architected cp15 timer(s) running at 50.00MHz (virt).
> clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
> Console: colour dummy device 80x25
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     32768
> ... MAX_LOCKDEP_CHAINS:      65536
> ... CHAINHASH_SIZE:          32768
>  memory used by lock dependency info: 8159 kB
>  per task-struct memory footprint: 1920 bytes
> Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=50000)
> pid_max: default: 32768 minimum: 301
> ACPI: Core revision 20160422
> ACPI: 1 ACPI AML tables successfully acquired and loaded
>
> Security Framework initialized
> Yama: becoming mindful.
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> Dentry cache hash table entries: 1048576 (order: 7, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 6, 4194304 bytes)
> Mount-cache hash table entries: 16384 (order: 1, 131072 bytes)
> Mountpoint-cache hash table entries: 16384 (order: 1, 131072 bytes)
> ftrace: allocating 28918 entries in 8 pages
> ASID allocator initialised with 65536 entries
> Unable to handle kernel paging request at virtual address e18000009518
> pgd = fffffc0009fb0000
> [e18000009518] *pgd=0000000000000000, *pud=0000000000000000, *pmd=0000000000000000
> Internal error: Oops: 96000004 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc3+ #19
> Hardware name: linux,dummy-virt (DT)
> task: fffffe01dc07b600 task.stack: fffffe01fa680000
> PC is at __ll_sc_atomic_add+0x20/0x40
> LR is at __lock_acquire+0xe8/0x698
> pc : [<fffffc000847a9a8>] lr : [<fffffc00081357e8>] pstate: 800000c5
> sp : fffffe01fa6838c0
> x29: fffffe01fa6838c0 x28: fffffc0008ea3000
> x27: fffffc0008ea2358 x26: fffffc0009c84000
> x25: 0000000000000001 x24: 0000000000000000
> x23: fffffe01dc07b600 x22: 0000000000000000
> x21: fffffe01ffd80818 x20: 0000000000000000
> x19: fffffe01ffd80818 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: ffffffffffffffff x14: 00000000000002b7
> x13: 00000000000002b7 x12: 0000000000000038
> x11: 0000000000000005 x10: 0101010101010101
> x9 : 0000000000000001 x8 : 0000e18000009518
> x7 : fffffc000829124c x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000e18000009380
> x3 : 0000000000000000 x2 : 000072000000c380
> x1 : 0000e18000009518 x0 : fffffc00081357e8
>
> Process swapper/0 (pid: 1, stack limit = 0xfffffe01fa680020)
> Stack: (0xfffffe01fa6838c0 to 0xfffffe01fa684000)
> 38c0: fffffe01fa6838e0 fffffc00081357e8 fffffe01fa680000 0000000000000001
> 38e0: fffffe01fa683960 fffffc0008136170 fffffe01ffd80818 0000000000000000
> 3900: 0000000000000000 0000000000000000 0000000000000001 0000000000000000
> 3920: fffffc000829124c 00000000000000c0 fffffc0008ea2358 fffffc0008ea3000
> 3940: fffffc000812dde0 00000000000000c0 fffffc0000000000 fffffc0000000000
> 3960: fffffe01fa6839d0 fffffc000892c9ac fffffe01ffd80800 fffffc000829124c
> 3980: fffffe01ffd80800 fffffc000829200c fffffe01f401fc00 000000000000e8e8
> 39a0: fffffe01f401fc00 fffffe01f401fcf8 fffffe01fff1ea90 0000000000000000
> 39c0: fffffe01dc07b680 fffffc0008ea2000 fffffe01fa6839f0 fffffc000829124c
> 39e0: 00000000ffffffff fffffe01ffd80800 fffffe01fa683b10 fffffc0008291ce8
> 3a00: 00000000ffffffff 0000000000000001 00000000024080c0 fffffc000829200c
> 3a20: 0000000000210d00 000000000000e8e8 fffffe01f401fc00 fffffe01f401fcf8
> 3a40: fffffe01fff1ea90 0000000000000000 fffffe01fa683a80 fffffc0008088954
> 3a60: fffffc0009048eb8 fffffe01dc07b600 fffffe01dc07be60 fffffe01fff1eaa0
> 3a80: fffffe01fa683ad0 fffffc00024080c0 fffffc0009048eb8 fffffc00095a3000
> 3aa0: fffffc0008132e80 fffffc0009048eb8 0000000000000000 0000000000000000
> 3ac0: fffffe01fa683eb0 fffffc0008083330 fffffe01fa683b10 fffffc0008291b18
> 3ae0: 7f7f7f7f7f7f7f7f ff1f2877372f2427 0101010101010101 0000000000000005
> 3b00: 0000000000000038 0000000000000000 fffffe01fa683c30 fffffc000829200c
> 3b20: 0000000000000040 fffffe01f401fc00 00000000024080c0 00000000ffffffff
> 3b40: fffffc00084ac9f0 fffffe01fff1ea90 0000000000000000 0000000000000006
> 3b60: 0000000000000043 fffffc0008b89670 fffffc0008f374b8 0000000000000000
> 3b80: fffffe01fa683bd0 fffffc0008135200 fffffe01fff1eaa0 0000000000000000
> 3ba0: fffffe0100000000 fffffc00084ac9f0 fffffe01fa683bf0 fffffc0008131904
> 3bc0: fffffe01fa680000 0000000102000200 fffffc0008bb4cf0 0000000000000189
> 3be0: 0000000000000028 fffffe01dc07b600 fffffe01fa683c10 fffffc00080fff1c
> 3c00: fffffc0008fbb39e 0000000000000000 fffffe01fa683c40 fffffc0008100034
> 3c20: fffffe01fa683c30 fffffc0008291ff4 fffffe01fa683c70 fffffc00082927dc
> 3c40: fffffe01f401fc00 00000000024080c0 fffffc00084ac9f0 fffffe01f401fc00
> 3c60: 0000000000000028 fffffc0008ea4000 fffffe01fa683cd0 fffffc00084ac9f0
> 3c80: fffffc0008ff6090 fffffc0008b89670 fffffc0008fd5f90 0000000000000002
> 3ca0: fffffc0008fd5f10 0000000000000003 00000000000001bd 0000000000000006
> 3cc0: 0000000000000043 fffffc0008b88a10 fffffe01fa683d10 fffffc0008d25090
> 3ce0: fffffc0008ff6090 fffffc0008fd5f90 fffffc0008fd5f90 fffffc0008fd5000
> 3d00: 0000000000000002 fffffc0008ea2398 fffffe01fa683d90 fffffc0008083594
> 3d20: fffffc0008d24fa0 fffffe01fa680000 0000000000000000 0000000000000000
> 3d40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3d60: 0000000000000000 0000000000000000 fffffe01fa683d90 fffffc0008b89d18
> 3d80: 000000000000000e 0000000000000019 fffffe01fa683e00 fffffc0008cf0d2c
> 3da0: fffffc0008e1c288 fffffc0008e1c2c8 0000000000000040 0000000000000000
> 3dc0: fffffe01fa683e00 fffffc0008cf0d1c fffffc0008e1c200 fffffc0008e1c2c8
> 3de0: 0000000000000040 0000000000000000 0000000000000000 fffffc0008e1c2c8
> 3e00: fffffe01fa683ea0 fffffc0008924978 fffffc0008924960 0000000000000000
> 3e20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3e40: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
> 3e60: 0000000000000001 0000000000000000 0000000000000000 0000000000000000
> 3e80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3ea0: 0000000000000000 fffffc0008083330 fffffc0008924960 0000000000000000
> 3ec0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3ee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3f00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3f20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3f40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3f60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3fa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 3fc0: 0000000000000000 0000000000000005 0000000000000000 0000000000000000
> 3fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> Call trace:
> Exception stack(0xfffffe01fa6836f0 to 0xfffffe01fa683820)
> 36e0:                                   fffffe01ffd80818 0000040000000000
> 3700: fffffe01fa6838c0 fffffc000847a9a8 fffffe01fff1b580 fffffe01fff1b580
> 3720: fffffc0008927614 fffffc0008ea1000 fffffe01fa683740 00000000000000c0
> 3740: fffffe01fa683780 fffffc000811794c fffffe01fa6837e0 fffffc0008135a64
> 3760: 87cee53ad487914d fffffe01dc07be60 0000000000000001 0000000000000000
> 3780: fffffe01dc07b600 0000000000000000 fffffc00081357e8 0000e18000009518
> 37a0: 000072000000c380 0000000000000000 0000e18000009380 0000000000000080
> 37c0: 0000000000000000 fffffc000829124c 0000e18000009518 0000000000000001
> 37e0: 0101010101010101 0000000000000005 0000000000000038 00000000000002b7
> 3800: 00000000000002b7 ffffffffffffffff 0000000000000000 0000000000000000
> [<fffffc000847a9a8>] __ll_sc_atomic_add+0x20/0x40
> [<fffffc00081357e8>] __lock_acquire+0xe8/0x698
> [<fffffc0008136170>] lock_acquire+0xd8/0x2c0
> [<fffffc000892c9ac>] _raw_spin_lock+0x4c/0x60
> [<fffffc000829124c>] get_partial_node.isra.23+0x4c/0x440
> [<fffffc0008291ce8>] ___slab_alloc+0x438/0x708
> [<fffffc000829200c>] __slab_alloc+0x54/0xa0
> [<fffffc00082927dc>] kmem_cache_alloc_trace+0x35c/0x428
> [<fffffc00084ac9f0>] ddebug_add_module+0x38/0xf0
> [<fffffc0008d25090>] dynamic_debug_init+0xf0/0x2a0
> [<fffffc0008083594>] do_one_initcall+0x44/0x138
> [<fffffc0008cf0d2c>] kernel_init_freeable+0x17c/0x2e0
> [<fffffc0008924978>] kernel_init+0x18/0x110
> [<fffffc0008083330>] ret_from_fork+0x10/0x20
> Code: aa1e03e0 aa0103e8 d503201f f9800111 (885f7d00)
> ---[ end trace 0000000000000000 ]---
> note: swapper/0[1] exited with preempt_count 1
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>

(3) Please find the bisection log below:

> git bisect start
> # bad: [b67be92feb486f800d80d72c67fd87b47b79b18e] Merge tag 'pwm/for-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> git bisect bad b67be92feb486f800d80d72c67fd87b47b79b18e
> # good: [c8d2bc9bc39ebea8437fd974fdbc21847bb897a3] Linux 4.8
> git bisect good c8d2bc9bc39ebea8437fd974fdbc21847bb897a3
> # bad: [41844e36206be90cd4d962ea49b0abc3612a99d0] Merge tag 'staging-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad 41844e36206be90cd4d962ea49b0abc3612a99d0
> # bad: [d268dbe76a53d72cc41316eb59e7968db60e77ad] Merge tag 'pinctrl-v4.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> git bisect bad d268dbe76a53d72cc41316eb59e7968db60e77ad
> # bad: [02bafd96f3a5d8e610b19033ffec55b92459aaae] Merge tag 'docs-4.9' of git://git.lwn.net/linux
> git bisect bad 02bafd96f3a5d8e610b19033ffec55b92459aaae
> # bad: [9929780e86854833e649b39b290b5fe921eb1701] Merge tag 'driver-core-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect bad 9929780e86854833e649b39b290b5fe921eb1701
> # bad: [12b7bcb43e6ea834ab2f5dc52d971e379a0ca109] Merge branch 'perf-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 12b7bcb43e6ea834ab2f5dc52d971e379a0ca109
> # bad: [72d39926f098b0c4ad95e1461595a8d6d403c14d] Merge tag 'acpi-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad 72d39926f098b0c4ad95e1461595a8d6d403c14d
> # bad: [72ec94560d7ee1d3a61d5904fd9a5bf68bf3b11a] Merge tag 'pm-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad 72ec94560d7ee1d3a61d5904fd9a5bf68bf3b11a
> # bad: [792d47379f4d4c76692f1795f33d38582f8907fa] arm64: alternative: add auto-nop infrastructure
> git bisect bad 792d47379f4d4c76692f1795f33d38582f8907fa
> # good: [dc00247576fdb97211e1959b4dfd2a7893cf9d0b] arm64: kernel: re-export _cpu_resume() from sleep.S
> git bisect good dc00247576fdb97211e1959b4dfd2a7893cf9d0b
> # good: [9787ed6e5cee7a62320f3014eb5e7b373502c292] of/numa: remove a duplicated warning
> git bisect good 9787ed6e5cee7a62320f3014eb5e7b373502c292
> # bad: [c47a1900ad710fd2c97127e2ba19da1df79cf733] arm64: Rearrange CPU errata workaround checks
> git bisect bad c47a1900ad710fd2c97127e2ba19da1df79cf733
> # good: [7af3a0a992524ffddc342cd1481cc4dcb3f1da71] arm64/numa: support HAVE_SETUP_PER_CPU_AREA
> git bisect good 7af3a0a992524ffddc342cd1481cc4dcb3f1da71
> # bad: [7ba5f605f3a0d9495aad539eeb8346d726dfc183] arm64/numa: remove the limitation that cpu0 must bind to node0
> git bisect bad 7ba5f605f3a0d9495aad539eeb8346d726dfc183
> # good: [df7ffa34cc0c06bfa7206732df78725ff34633ee] arm64/numa: remove some useless code
> git bisect good df7ffa34cc0c06bfa7206732df78725ff34633ee
> # first bad commit: [7ba5f605f3a0d9495aad539eeb8346d726dfc183] arm64/numa: remove the limitation that cpu0 must bind to node0

I repeatedly retested the first bad commit:

> commit 7ba5f605f3a0d9495aad539eeb8346d726dfc183
> Author: Zhen Lei <thunder.leizhen@huawei.com>
> Date:   Thu Sep 1 14:55:04 2016 +0800
>
>     arm64/numa: remove the limitation that cpu0 must bind to node0

and its direct ancestor:

> commit df7ffa34cc0c06bfa7206732df78725ff34633ee
> Author: Zhen Lei <thunder.leizhen@huawei.com>
> Date:   Thu Sep 1 14:55:03 2016 +0800
>
>     arm64/numa: remove some useless code

The offending commit consistently fails to boot with the described
symptoms when DT is disabled, and succeeds to boot when DT is enabled.
The predecessor commit consistently succeeds to boot regardless of DT
versus ACPI.

(4) Analysis (well, a lame attempt at that, because I have zero
familiarity with this code). Let me quote the patch:

> commit 7ba5f605f3a0d9495aad539eeb8346d726dfc183
> Author: Zhen Lei <thunder.leizhen@huawei.com>
> Date:   Thu Sep 1 14:55:04 2016 +0800
>
>     arm64/numa: remove the limitation that cpu0 must bind to node0
>
>     1. Remove the old binding code.
>     2. Read the nid of cpu0 from dts.
>     3. Fallback the nid of cpu0 to 0 when numa=off is set in bootargs.
>
>     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index c3c08368a685..8b048e6ec34a 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -624,6 +624,7 @@ static void __init of_parse_and_init_cpus(void)
>  			}
>
>  			bootcpu_valid = true;
> +			early_map_cpu_to_node(0, of_node_to_nid(dn));
>
>  			/*
>  			 * cpu_logical_map has already been
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 0a15f010b64a..778a985c8a70 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -116,16 +116,24 @@ static void __init setup_node_to_cpumask_map(void)
>   */
>  void numa_store_cpu_info(unsigned int cpu)
>  {
> -	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
> +	map_cpu_to_node(cpu, cpu_to_node_map[cpu]);
>  }
>
>  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>  {
>  	/* fallback to node 0 */
> -	if (nid < 0 || nid >= MAX_NUMNODES)
> +	if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
>  		nid = 0;
>
>  	cpu_to_node_map[cpu] = nid;
> +
> +	/*
> +	 * We should set the numa node of cpu0 as soon as possible, because it
> +	 * has already been set up online before. cpu_to_node(0) will soon be
> +	 * called.
> +	 */
> +	if (!cpu)
> +		set_cpu_numa_node(cpu, nid);
>  }
>
>  #ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
> @@ -393,10 +401,6 @@ static int __init numa_init(int (*init_func)(void))
>
>  	setup_node_to_cpumask_map();
>
> -	/* init boot processor */
> -	cpu_to_node_map[0] = 0;
> -	map_cpu_to_node(0, 0);
> -
>  	return 0;
>  }
>

The commit message states that the numa-id (nid) for CPU#0 is read from
the DTS. If there is no DT, I think that won't work so well.

Second, the patch replaces the unconditional, static

  CPU#0 <-> numa-node#0

mapping in numa_init(), which is independent of ACPI vs. DT, with a
DT-dependent early_map_cpu_to_node() call, in of_parse_and_init_cpus().
The ACPI branch is regressed by this, because on that branch we now
don't create a

  CPU#0 <-> numa-node#whatever

mapping at all.

(5) The entry

  ACPI: NUMA: Failed to initialise from firmware

in the dmesg doesn't imply an error in the firmware; it just means that
the firmware does not provide an SRAT table. That is valid if there's
only one NUMA node in the system.

(6) For reference, the MADT is:

> /*
>  * Intel ACPI Component Architecture
>  * AML/ASL+ Disassembler version 20160831-64
>  * Copyright (c) 2000 - 2016 Intel Corporation
>  *
>  * Disassembly of apic.dat, Fri Oct 14 00:21:16 2016
>  *
>  * ACPI Data Table [APIC]
>  *
>  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>  */
>
> [000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
> [004h 0004   4]                 Table Length : 000002BC
> [008h 0008   1]                     Revision : 03
> [009h 0009   1]                     Checksum : 18
> [00Ah 0010   6]                       Oem ID : "BOCHS "
> [010h 0016   8]                 Oem Table ID : "BXPCAPIC"
> [018h 0024   4]                 Oem Revision : 00000001
> [01Ch 0028   4]              Asl Compiler ID : "BXPC"
> [020h 0032   4]        Asl Compiler Revision : 00000001
>
> [024h 0036   4]           Local Apic Address : 00000000
> [028h 0040   4]        Flags (decoded below) : 00000000
>                          PC-AT Compatibility : 0
>
> [02Ch 0044   1]                Subtable Type : 0C [Generic Interrupt Distributor]
> [02Dh 0045   1]                       Length : 18
> [02Eh 0046   2]                     Reserved : 0000
> [030h 0048   4]        Local GIC Hardware ID : 00000000
> [034h 0052   8]                 Base Address : 0000000008000000
> [03Ch 0060   4]               Interrupt Base : 00000000
> [040h 0064   1]                      Version : 02
> [041h 0065   3]                     Reserved : 000000
>
> [044h 0068   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [045h 0069   1]                       Length : 4C
> [046h 0070   2]                     Reserved : 0000
> [048h 0072   4]         CPU Interface Number : 00000000
> [04Ch 0076   4]                Processor UID : 00000000
> [050h 0080   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [054h 0084   4]     Parking Protocol Version : 00000000
> [058h 0088   4]        Performance Interrupt : 00000017
> [05Ch 0092   8]               Parked Address : 0000000000000000
> [064h 0100   8]                 Base Address : 0000000008010000
> [06Ch 0108   8]     Virtual GIC Base Address : 0000000000000000
> [074h 0116   8]  Hypervisor GIC Base Address : 0000000000000000
> [07Ch 0124   4]        Virtual GIC Interrupt : 00000000
> [080h 0128   8]   Redistributor Base Address : 0000000000000000
> [088h 0136   8]                    ARM MPIDR : 0000000000000000
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [090h 0144   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [091h 0145   1]                       Length : 4C
> [092h 0146   2]                     Reserved : 0000
> [094h 0148   4]         CPU Interface Number : 00000001
> [098h 0152   4]                Processor UID : 00000001
> [09Ch 0156   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [0A0h 0160   4]     Parking Protocol Version : 00000000
> [0A4h 0164   4]        Performance Interrupt : 00000017
> [0A8h 0168   8]               Parked Address : 0000000000000000
> [0B0h 0176   8]                 Base Address : 0000000008010000
> [0B8h 0184   8]     Virtual GIC Base Address : 0000000000000000
> [0C0h 0192   8]  Hypervisor GIC Base Address : 0000000000000000
> [0C8h 0200   4]        Virtual GIC Interrupt : 00000000
> [0CCh 0204   8]   Redistributor Base Address : 0000000000000000
> [0D4h 0212   8]                    ARM MPIDR : 0000000000000001
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [0DCh 0220   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [0DDh 0221   1]                       Length : 4C
> [0DEh 0222   2]                     Reserved : 0000
> [0E0h 0224   4]         CPU Interface Number : 00000002
> [0E4h 0228   4]                Processor UID : 00000002
> [0E8h 0232   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [0ECh 0236   4]     Parking Protocol Version : 00000000
> [0F0h 0240   4]        Performance Interrupt : 00000017
> [0F4h 0244   8]               Parked Address : 0000000000000000
> [0FCh 0252   8]                 Base Address : 0000000008010000
> [104h 0260   8]     Virtual GIC Base Address : 0000000000000000
> [10Ch 0268   8]  Hypervisor GIC Base Address : 0000000000000000
> [114h 0276   4]        Virtual GIC Interrupt : 00000000
> [118h 0280   8]   Redistributor Base Address : 0000000000000000
> [120h 0288   8]                    ARM MPIDR : 0000000000000002
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [128h 0296   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [129h 0297   1]                       Length : 4C
> [12Ah 0298   2]                     Reserved : 0000
> [12Ch 0300   4]         CPU Interface Number : 00000003
> [130h 0304   4]                Processor UID : 00000003
> [134h 0308   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [138h 0312   4]     Parking Protocol Version : 00000000
> [13Ch 0316   4]        Performance Interrupt : 00000017
> [140h 0320   8]               Parked Address : 0000000000000000
> [148h 0328   8]                 Base Address : 0000000008010000
> [150h 0336   8]     Virtual GIC Base Address : 0000000000000000
> [158h 0344   8]  Hypervisor GIC Base Address : 0000000000000000
> [160h 0352   4]        Virtual GIC Interrupt : 00000000
> [164h 0356   8]   Redistributor Base Address : 0000000000000000
> [16Ch 0364   8]                    ARM MPIDR : 0000000000000003
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [174h 0372   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [175h 0373   1]                       Length : 4C
> [176h 0374   2]                     Reserved : 0000
> [178h 0376   4]         CPU Interface Number : 00000004
> [17Ch 0380   4]                Processor UID : 00000004
> [180h 0384   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [184h 0388   4]     Parking Protocol Version : 00000000
> [188h 0392   4]        Performance Interrupt : 00000017
> [18Ch 0396   8]               Parked Address : 0000000000000000
> [194h 0404   8]                 Base Address : 0000000008010000
> [19Ch 0412   8]     Virtual GIC Base Address : 0000000000000000
> [1A4h 0420   8]  Hypervisor GIC Base Address : 0000000000000000
> [1ACh 0428   4]        Virtual GIC Interrupt : 00000000
> [1B0h 0432   8]   Redistributor Base Address : 0000000000000000
> [1B8h 0440   8]                    ARM MPIDR : 0000000000000004
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [1C0h 0448   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [1C1h 0449   1]                       Length : 4C
> [1C2h 0450   2]                     Reserved : 0000
> [1C4h 0452   4]         CPU Interface Number : 00000005
> [1C8h 0456   4]                Processor UID : 00000005
> [1CCh 0460   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [1D0h 0464   4]     Parking Protocol Version : 00000000
> [1D4h 0468   4]        Performance Interrupt : 00000017
> [1D8h 0472   8]               Parked Address : 0000000000000000
> [1E0h 0480   8]                 Base Address : 0000000008010000
> [1E8h 0488   8]     Virtual GIC Base Address : 0000000000000000
> [1F0h 0496   8]  Hypervisor GIC Base Address : 0000000000000000
> [1F8h 0504   4]        Virtual GIC Interrupt : 00000000
> [1FCh 0508   8]   Redistributor Base Address : 0000000000000000
> [204h 0516   8]                    ARM MPIDR : 0000000000000005
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [20Ch 0524   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [20Dh 0525   1]                       Length : 4C
> [20Eh 0526   2]                     Reserved : 0000
> [210h 0528   4]         CPU Interface Number : 00000006
> [214h 0532   4]                Processor UID : 00000006
> [218h 0536   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [21Ch 0540   4]     Parking Protocol Version : 00000000
> [220h 0544   4]        Performance Interrupt : 00000017
> [224h 0548   8]               Parked Address : 0000000000000000
> [22Ch 0556   8]                 Base Address : 0000000008010000
> [234h 0564   8]     Virtual GIC Base Address : 0000000000000000
> [23Ch 0572   8]  Hypervisor GIC Base Address : 0000000000000000
> [244h 0580   4]        Virtual GIC Interrupt : 00000000
> [248h 0584   8]   Redistributor Base Address : 0000000000000000
> [250h 0592   8]                    ARM MPIDR : 0000000000000006
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [258h 0600   1]                Subtable Type : 0B [Generic Interrupt Controller]
> [259h 0601   1]                       Length : 4C
> [25Ah 0602   2]                     Reserved : 0000
> [25Ch 0604   4]         CPU Interface Number : 00000007
> [260h 0608   4]                Processor UID : 00000007
> [264h 0612   4]        Flags (decoded below) : 00000001
>                            Processor Enabled : 1
>           Performance Interrupt Trigger Mode : 0
>           Virtual GIC Interrupt Trigger Mode : 0
> [268h 0616   4]     Parking Protocol Version : 00000000
> [26Ch 0620   4]        Performance Interrupt : 00000017
> [270h 0624   8]               Parked Address : 0000000000000000
> [278h 0632   8]                 Base Address : 0000000008010000
> [280h 0640   8]     Virtual GIC Base Address : 0000000000000000
> [288h 0648   8]  Hypervisor GIC Base Address : 0000000000000000
> [290h 0656   4]        Virtual GIC Interrupt : 00000000
> [294h 0660   8]   Redistributor Base Address : 0000000000000000
> [29Ch 0668   8]                    ARM MPIDR : 0000000000000007
> /**** ACPI subtable terminates early - may be older version (dump table) */
>
> [2A4h 0676   1]                Subtable Type : 0D [Generic MSI Frame]
> [2A5h 0677   1]                       Length : 18
> [2A6h 0678   2]                     Reserved : 0000
> [2A8h 0680   4]                 MSI Frame ID : 00000000
> [2ACh 0684   8]                 Base Address : 0000000008020000
> [2B4h 0692   4]        Flags (decoded below) : 00000001
>                                   Select SPI : 1
> [2B8h 0696   2]                    SPI Count : 0040
> [2BAh 0698   2]                     SPI Base : 0050
>
> Raw Table Data: Length 700 (0x2BC)
>
>   0000: 41 50 49 43 BC 02 00 00 03 18 42 4F 43 48 53 20  // APIC......BOCHS
>   0010: 42 58 50 43 41 50 49 43 01 00 00 00 42 58 50 43  // BXPCAPIC....BXPC
>   0020: 01 00 00 00 00 00 00 00 00 00 00 00 0C 18 00 00  // ................
>   0030: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00  // ................
>   0040: 02 00 00 00 0B 4C 00 00 00 00 00 00 00 00 00 00  // .....L..........
>   0050: 01 00 00 00 00 00 00 00 17 00 00 00 00 00 00 00  // ................
>   0060: 00 00 00 00 00 00 01 08 00 00 00 00 00 00 00 00  // ................
>   0070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0090: 0B 4C 00 00 01 00 00 00 01 00 00 00 01 00 00 00  // .L..............
>   00A0: 00 00 00 00 17 00 00 00 00 00 00 00 00 00 00 00  // ................
>   00B0: 00 00 01 08 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   00C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   00D0: 00 00 00 00 01 00 00 00 00 00 00 00 0B 4C 00 00  // .............L..
>   00E0: 02 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00  // ................
>   00F0: 17 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08  // ................
>   0100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0120: 02 00 00 00 00 00 00 00 0B 4C 00 00 03 00 00 00  // .........L......
>   0130: 03 00 00 00 01 00 00 00 00 00 00 00 17 00 00 00  // ................
>   0140: 00 00 00 00 00 00 00 00 00 00 01 08 00 00 00 00  // ................
>   0150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0160: 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  // ................
>   0170: 00 00 00 00 0B 4C 00 00 04 00 00 00 04 00 00 00  // .....L..........
>   0180: 01 00 00 00 00 00 00 00 17 00 00 00 00 00 00 00  // ................
>   0190: 00 00 00 00 00 00 01 08 00 00 00 00 00 00 00 00  // ................
>   01A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   01B0: 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00  // ................
>   01C0: 0B 4C 00 00 05 00 00 00 05 00 00 00 01 00 00 00  // .L..............
>   01D0: 00 00 00 00 17 00 00 00 00 00 00 00 00 00 00 00  // ................
>   01E0: 00 00 01 08 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   01F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0200: 00 00 00 00 05 00 00 00 00 00 00 00 0B 4C 00 00  // .............L..
>   0210: 06 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00  // ................
>   0220: 17 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08  // ................
>   0230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0250: 06 00 00 00 00 00 00 00 0B 4C 00 00 07 00 00 00  // .........L......
>   0260: 07 00 00 00 01 00 00 00 00 00 00 00 17 00 00 00  // ................
>   0270: 00 00 00 00 00 00 00 00 00 00 01 08 00 00 00 00  // ................
>   0280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>   0290: 00 00 00 00 00 00 00 00 00 00 00 00 07 00 00 00  // ................
>   02A0: 00 00 00 00 0D 18 00 00 00 00 00 00 00 00 02 08  // ................
>   02B0: 00 00 00 00 01 00 00 00 40 00 50 00              // ........ at .P.

I'm unsure if this table is supposed to lead to the creation of the
(apparently missing)

  CPU#0 <-> numa-node#0

mapping, via

  smp_init_cpus()                    [arch/arm64/kernel/smp.c]
    acpi_table_parse_madt()          [drivers/acpi/tables.c]
      acpi_parse_gic_cpu_interface() [arch/arm64/kernel/smp.c]
        acpi_map_gic_cpu_interface() [arch/arm64/kernel/smp.c]
          early_map_cpu_to_node()    [arch/arm64/mm/numa.c]

(7) I also tried "numa=off" in addition to "acpi=force", just in case;
it didn't make a difference.

Thanks
Laszlo
