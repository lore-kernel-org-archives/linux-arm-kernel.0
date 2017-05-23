From: julien.grall@arm.com (Julien Grall)
Date: Tue, 23 May 2017 17:40:28 +0100
Subject: irqchip/irq-gic: BAD_MADT_GICC_ENTRY may fail when booting with ACPI
 5.1
Message-ID: <432c3a63-c89f-dccc-7bdf-9d9a0aaabfe2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am currently looking at adding support of ACPI 5.1 in Xen.
When trying to boot DOM00 I get a panic in Linux (for the full
log see [1]):

(XEN) DOM0: [    0.000000] No valid GICC entries exist

The error message is coming from gic_v2_acpi_init.
Digging down in the code, it is failing because of
BAD_MADT_GICC_ENTRY is returning false in
gic_acpi_parse_madt_cpu:

/* Macros for consistency checks of the GICC subtable of MADT */
#define ACPI_MADT_GICC_LENGTH	\
	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)

#define BAD_MADT_GICC_ENTRY(entry, end)						\
	(!(entry) || (unsigned long)(entry) + sizeof(*(entry)) > (end) ||	\
	 (entry)->header.length != ACPI_MADT_GICC_LENGTH)

The 'end' parameter corresponds to the end of the MADT table.
In the case of ACPI 5.1, the size of GICC is smaller compare
to 6.0+ (76 vs 80 bytes) but the parameter 'entry' is type
of acpi_madt_generic_interrupt (sizeof(...) = 80).

This mean that if the GICC entry is at the end of table, the
check will return false.

Indeed the way the MADT table is generated in Xen will put
the GICC entries at the end of the table.

I haven't seen this issue on ACPI 5.1 platforms (such as Juno
and Seattle) because the GICC entries are not at the end
of the table.

I have looked at the usage of BAD_MADT_GICC_ENTRY, it spreads
in few places over the kernel (e.g smp, gic-v2, gic-v3).
The structure acpi_madt_generic_interrupt is even more widespread.

My current workaround is to re-order the GICC entries in the
MADT. I am not sure what would be the correct way to fix it
in Linux, I am seeking any advice here.

Cheers,

[1]
(XEN) DOM0: [    0.000000] Booting Linux on physical CPU 0x0
(XEN) DOM0: [    0.000000] Linux version 4.12.0-rc2-00049-gfde8e33d1068 (julieng at e108454-lin) (gcc version 6.1.1 20160711 (Linaro GCC 6.1-
(XEN) DOM0: 2016.08) ) #547 SMP PREEMPT Tue May 23 17:04:43 BST 2017
(XEN) DOM0: [    0.000000] Boot CPU: AArch64 Processor [410fd033]
(XEN) DOM0: [    0.000000] Machine model: (null)
(XEN) DOM0: [    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
(XEN) DOM0: [    0.000000] bootconsole [pl11] enabled
(XEN) DOM0: [    0.000000] Xen 4.9 support found
(XEN) DOM0: [    0.000000] efi: Getting EFI parameters from FDT:
(XEN) DOM0: [    0.000000] efi: EFI v2.50 by Xen
(XEN) DOM0: [    0.000000] efi:  ACPI 2.0=0x99be00280 
(XEN) DOM0: [    0.000000] cma: Reserved 16 MiB at 0x00000000ef000000
(XEN) DOM0: [    0.000000] ACPI: Early table checksum verification disabled
(XEN) DOM0: [    0.000000] ACPI: RSDP 0x000000099BE00280 000024 (v02 ARMLTD)
(XEN) DOM0: [    0.000000] ACPI: XSDT 0x000000099BE00218 000064 (v01 ARMLTD ARM-JUNO 20140727      01000013)
(XEN) DOM0: [    0.000000] ACPI: FACP 0x000000099BE00000 00010C (v05 ARMLTD ARM-JUNO 20140727 ARM  00000099)
(XEN) DOM0: [    0.000000] ACPI: DSDT 0x00000000F8980000 0006C9 (v01 ARMLTD ARM-JUNO 20140727 INTL 20160527)
(XEN) DOM0: [    0.000000] ACPI: DBG2 0x00000000F89E0000 00005A (v00 ARMLTD ARM-JUNO 20140727 ARM  00000099)
(XEN) DOM0: [    0.000000] ACPI: GTDT 0x00000000F89C0000 000098 (v02 ARMLTD ARM-JUNO 20140727 ARM  00000099)
(XEN) DOM0: [    0.000000] ACPI: APIC 0x000000099BE00110 0000DC (v03 ARMLTD ARM-JUNO 20140727 ARM  00000099)
(XEN) DOM0: [    0.000000] ACPI: SPCR 0x00000000F89A0000 000050 (v02 ARMLTD ARM-JUNO 20140727 ARM  00000099)
(XEN) DOM0: [    0.000000] ACPI: SSDT 0x00000000F8990000 000306 (v01 ARMLTD ARM-JUNO 20140727 INTL 20160527)
(XEN) DOM0: [    0.000000] ACPI: MCFG 0x00000000F8970000 00003C (v01 ARMLTD ARM-JUNO 20140727 ARM  00000099)
(XEN) DOM0: [    0.000000] ACPI: STAO 0x000000099BE001F0 000025 (v01 ARMLTD ARM-JUNO 20140727 ARM  00000099)
(XEN) DOM0: [    0.000000] ACPI: SPCR: console: pl011,mmio,0x7ff80000,115200
(XEN) DOM0: [    0.000000] psci: probing for conduit method from ACPI.
(XEN) DOM0: [    0.000000] psci: PSCIv0.2 detected in firmware.
(XEN) DOM0: [    0.000000] psci: Using standard PSCI v0.2 function IDs
(XEN) DOM0: [    0.000000] psci: Trusted OS migration not required
(XEN) DOM0: [    0.000000] percpu: Embedded 24 pages/cpu @ffff800907fd7000 s59672 r8192 d30440 u98304
(XEN) DOM0: [    0.000000] Detected VIPT I-cache on CPU0
(XEN) DOM0: [    0.000000] CPU features: enabling workaround for ARM erratum 845719
(XEN) DOM0: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 774301
(XEN) DOM0: [    0.000000] Kernel command line: root=/dev/mapper/juno2--julieng--vg-root ro loglvlinfo=all earlycon=pl011,0x7ff80000 conso
(XEN) DOM0: le=hvc0
(XEN) DOM0: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
(XEN) DOM0: [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
(XEN) DOM0: [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
(XEN) DOM0: [    0.000000] software IO TLB [mem 0xeafff000-0xeefff000] (64MB) mapped at [ffff80006afff000-ffff80006effefff]
(XEN) DOM0: [    0.000000] Memory: 2901652K/3146372K available (9212K kernel code, 1016K rwdata, 3844K rodata, 1088K init, 305K bss, 22833
(XEN) DOM0: 6K reserved, 16384K cma-reserved)
(XEN) DOM0: [    0.000000] Virtual kernel memory layout:
(XEN) DOM0: [    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
(XEN) DOM0: [    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
(XEN) DOM0: [    0.000000]       .text : 0xffff000008080000 - 0xffff000008980000   (  9216 KB)
(XEN) DOM0: [    0.000000]     .rodata : 0xffff000008980000 - 0xffff000008d50000   (  3904 KB)
(XEN) DOM0: [    0.000000]       .init : 0xffff000008d50000 - 0xffff000008e60000   (  1088 KB)
(XEN) DOM0: [    0.000000]       .data : 0xffff000008e60000 - 0xffff000008f5e200   (  1017 KB)
(XEN) DOM0: [    0.000000]        .bss : 0xffff000008f5e200 - 0xffff000008faa95c   (   306 KB)
(XEN) DOM0: [    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
(XEN) DOM0: [    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
(XEN) DOM0: [    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
(XEN) DOM0: [    0.000000]               0xffff7e0000000000 - 0xffff7e00246f8040   (   582 MB actual)
(XEN) DOM0: [    0.000000]     memory  : 0xffff800000000000 - 0xffff80091be01000   ( 37310 MB)
(XEN) DOM0: [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
(XEN) DOM0: [    0.000000] Preemptible hierarchical RCU implementation.
(XEN) DOM0: [    0.000000]      RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
(XEN) DOM0: [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
(XEN) DOM0: [    0.000000] NR_IRQS:64 nr_irqs:64 0
(XEN) DOM0: [    0.000000] No valid GICC entries exist
(XEN) DOM0: [    0.000000] Kernel panic - not syncing: No interrupt controller found.
(XEN) DOM0: [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-rc2-00049-gfde8e33d1068 #547
(XEN) DOM0: [    0.000000] Hardware name: (null) (DT)
(XEN) DOM0: [    0.000000] Call trace:
(XEN) DOM0: [    0.000000] [<ffff000008088608>] dump_backtrace+0x0/0x228
(XEN) DOM0: [    0.000000] [<ffff0000080888f4>] show_stack+0x14/0x20
(XEN) DOM0: [    0.000000] [<ffff000008409360>] dump_stack+0x98/0xb8
(XEN) DOM0: [    0.000000] [<ffff0000081698a0>] panic+0x114/0x284
(XEN) DOM0: [    0.000000] [<ffff000008d524a8>] init_IRQ+0x24/0x2c
(XEN) DOM0: [    0.000000] [<ffff000008d509f8>] start_kernel+0x230/0x390
(XEN) DOM0: [    0.000000] [<ffff000008d501e0>] __primary_switched+0x64/0x6c
(XEN) DOM0: [    0.000000] ---[ end Kernel panic - not syncing: No interrupt controller found.

Cheers,

-- 
Julien Grall
