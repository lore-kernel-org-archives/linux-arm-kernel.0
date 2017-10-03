From: fengguang.wu@intel.com (Fengguang Wu)
Date: Tue, 3 Oct 2017 21:45:36 +0800
Subject: 4879b7ae05 ("Merge tag 'dmaengine-4.12-rc1' of .."): WARNING:
 kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value
 000001be
In-Reply-To: <20171002213109.5n3skzy76edhwkvf@treble>
References: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
 <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
 <20171002212654.rsm4uj3hfioddldd@treble>
 <20171002213109.5n3skzy76edhwkvf@treble>
Message-ID: <20171003134536.yz35wjgxuf7rc46s@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Mon, Oct 02, 2017 at 04:31:09PM -0500, Josh Poimboeuf wrote:
>On Mon, Oct 02, 2017 at 04:26:54PM -0500, Josh Poimboeuf wrote:
>> Fengguang, assuming it's reliably recreatable, any chance you could
>> recreate with the following patch?
>
>Sorry, here's a version which actually compiles.
>
>diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
>index d145a0b1f529..00234fa5a33a 100644
>--- a/arch/x86/kernel/unwind_frame.c
>+++ b/arch/x86/kernel/unwind_frame.c
>@@ -44,7 +44,8 @@ static void unwind_dump(struct unwind_state *state)
> 			state->stack_info.type, state->stack_info.next_sp,
> 			state->stack_mask, state->graph_idx);
>
>-	for (sp = state->orig_sp; sp; sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
>+	for (sp = PTR_ALIGN(state->orig_sp, sizeof(long)); sp;
>+	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> 		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
> 			break;

With the patch applied on v4.14-rc3, I get these WARNINGs in 300+
kernel boots:

[  185.430011] WARNING: kernel stack regs at bb68dcc2 in 01-cpu-hotplug:22473 has bad 'bp' value 000001bc
[   86.190009] WARNING: kernel stack regs at be3c9c9a in 01-cpu-hotplug:4941 has bad 'bp' value 000001be
[  144.450014] WARNING: kernel stack regs at be3d5c9a in 01-cpu-hotplug:14750 has bad 'bp' value 000001be
[  180.074990] WARNING: kernel stack regs at b0209c4e in 01-cpu-hotplug:22741 has bad 'bp' value 000001b0
[  138.140012] WARNING: kernel stack regs at be3c9c9a in 01-cpu-hotplug:12181 has bad 'bp' value 000001be
[  120.658716] WARNING: kernel stack regs at be3b9c4e in 01-cpu-hotplug:5548 has bad 'bp' value 000001be
[   88.390022] WARNING: kernel stack regs at be3adcc2 in 01-cpu-hotplug:3874 has bad 'bp' value 000001be
[  174.380015] WARNING: kernel stack regs at be3e1f68 in 01-cpu-hotplug:22049 has bad 'bp' value   (null)
[   98.150011] WARNING: kernel stack regs at be38dcc2 in 01-cpu-hotplug:2549 has bad 'bp' value 000001be
[  114.450013] WARNING: kernel stack regs at be36bc9a in 01-cpu-hotplug:7747 has bad 'bp' value 000001be
[  151.020011] WARNING: kernel stack regs at b0203cc2 in 01-cpu-hotplug:14901 has bad 'bp' value 000001b8
[  106.770011] WARNING: kernel stack regs at be3c3c9a in 01-cpu-hotplug:5970 has bad 'bp' value 000001be
[  114.290012] WARNING: kernel stack regs at be3d7c9a in 01-cpu-hotplug:6287 has bad 'bp' value 000001be
[  118.818622] WARNING: kernel stack regs at be3cfc4e in 01-cpu-hotplug:5183 has bad 'bp' value 000001be
[  142.540011] WARNING: kernel stack regs at be3b9cc2 in 01-cpu-hotplug:9450 has bad 'bp' value 000001be
[   96.020013] WARNING: kernel stack regs at be3d9f6c in 01-cpu-hotplug:8433 has bad 'bp' value   (null)
[  149.300010] WARNING: kernel stack regs at be3b1c9a in 01-cpu-hotplug:14589 has bad 'bp' value 000001be
[  140.580013] WARNING: kernel stack regs at be3bfc9a in 01-cpu-hotplug:15779 has bad 'bp' value 000001be
[   93.656698] WARNING: kernel stack regs at c0b9fc9a in 01-cpu-hotplug:6618 has bad 'bp' value 000001c0
[  112.863654] WARNING: kernel stack regs at c05d7c9a in procd:172 has bad 'bp' value 000001c0
[   77.683057] WARNING: kernel stack regs at c0bcbc9a in 01-cpu-hotplug:5798 has bad 'bp' value 000001c0
[   46.071067] WARNING: kernel stack regs at c51e5d0a in rhashtable_thra:126 has bad 'bp' value 000003c6
[  149.471498] WARNING: kernel stack regs at c5d6bf68 in udevd:285 has bad 'bp' value   (null)
[  178.575899] WARNING: kernel stack regs at c21e5d02 in lock_torture_wr:46 has bad 'bp' value 000003bc
[  129.175338] WARNING: kernel stack regs at cdde5d0a in swapper/0:0 has bad 'bp' value 000003c6
[   80.686106] WARNING: kernel stack regs at c7e29cca in ifup:339 has bad 'bp' value 000001c8
[    0.437556] WARNING: kernel stack regs at c6e15c4e in swapper/0:1 has bad 'bp' value 000001c6
[   12.354954] WARNING: kernel stack regs at c6ff7ca2 in rhashtable_thra:126 has bad 'bp' value 000003be
[  122.627926] WARNING: kernel stack regs at c6ff7d0a in swapper/1:0 has bad 'bp' value 000003c6

Here is one of them. The full dmesg is attached.

Please press Enter to activate this console.
[   89.505747] sock: process `trinity-main' is using obsolete setsockopt SO_BSDCOMPAT
procd: Instance odhcpd::instance1 s in a crash loop 6 crashes, 0 seconds since last crash
procd: Instance uhttpd::instance1 s in a crash loop 6 crashes, 0 seconds since last crash
procd: Instance dnsmasq::instance1 s in a crash loop 6 crashes, 0 seconds since last crash
[  114.450013] WARNING: kernel stack regs at be36bc9a in 01-cpu-hotplug:7747 has bad 'bp' value 000001be
[  114.450017] unwind stack type:0 next_sp:  (null) mask:0x2 graph_idx:0
[  114.450020] be36bc9c: 81be36bc (0x81be36bc)
[  114.450023] be36bca0: ebb56272 (0xebb56272)
[  114.450029] be36bca4: b5be36bc (drm_setup_crtcs+0x10ac/0x12e0)
[  114.450031] be36bca8: 4000bcb4 (0x4000bcb4)
[  114.450033] be36bcac: 00be02b2 (0xbe02b2)
[  114.450035] be36bcb0: 00000000 ...
[  114.450037] be36bcb4: 00be36a0 (0xbe36a0)
[  114.450039] be36bcb8: 00be36c0 (0xbe36c0)
[  114.450041] be36bcbc: 02000000 (0x2000000)
[  114.450043] be36bcc0: 40000000 (0x40000000)
[  114.450045] be36bcc4: 00be02b2 (0xbe02b2)
[  114.450046] be36bcc8: 01000000 (0x1000000)
[  114.450048] be36bccc: 00000001 (0x1)
[  114.450050] be36bcd0: 9a000000 (0x9a000000)
[  114.450052] be36bcd4: 00be36bc (0xbe36bc)
[  114.450054] be36bcd8: 9a000100 (0x9a000100)
[  114.450056] be36bcdc: dcbe36bc (0xdcbe36bc)
[  114.450057] be36bce0: 00be02b7 (0xbe02b7)
[  114.450059] be36bce4: 40000000 (0x40000000)
[  114.450061] be36bce8: f7be02b2 (0xf7be02b2)
[  114.450063] be36bcec: 80be36bc (0x80be36bc)
[  114.450065] be36bcf0: 00b56273 (0xb56273)
[  114.450067] be36bcf4: 57000000 (0x57000000)
[  114.450069] be36bcf8: 3fbe36bd (0x3fbe36bd)
[  114.450071] be36bcfc: 00b56ef2 (0xb56ef2)
[  114.450072] be36bd00: bb19e5a8 (0xbb19e5a8)
[  114.450074] be36bd04: edf1e285 (0xedf1e285)
[  114.450076] be36bd08: 00000002 (0x2)
[  114.450078] be36bd0c: be02b7bc (0xbe02b7bc)
[  114.450080] be36bd10: be02b7bc (0xbe02b7bc)
[  114.450084] be36bd14: b5627380 (save_stack_trace+0x20/0x30)
[  114.450086] be36bd18: be02b240 (0xbe02b240)
[  114.450088] be36bd1c: 0036bdbc (0x36bdbc)

Thanks,
Fengguang
-------------- next part --------------
early console in setup code
[    0.000000] Linux version 4.14.0-rc3-00001-g02e6a26 (kbuild at lkp-hsx02) (gcc version 4.8.4 (Debian 4.8.4-1)) #1 SMP PREEMPT Tue Oct 3 21:07:27 CST 2017
[    0.000000] KERNEL supported cpus:
[    0.000000]   AMD AuthenticAMD
[    0.000000] CPU: vendor_id 'GenuineIntel' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000ffe0000-0x000000000fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0xffe0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f6ba0-0x000f6baf] mapped at [ffc67ba0]
[    0.000000]   mpc: f6bb0-f6c80
[    0.000000] initial memory mapped: [mem 0x00000000-0x083fffff]
[    0.000000] Base memory trampoline at [b009b000] 9b000 size 16384
[    0.000000] BRK [0x08127000, 0x08127fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x0fddb000-0x0ffdffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F69C0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000000FFE18DC 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000000FFE17B8 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000000FFE0040 001778 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000000FFE0000 000040
[    0.000000] ACPI: APIC 0x000000000FFE182C 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000000FFE18A4 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 255MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 0ffe0000
[    0.000000]   low ram: 0 - 0ffe0000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:fdda001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 207736580 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] BRK [0x08128000, 0x08128fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000000ffdffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000000ffdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000000ffdffff]
[    0.000000] On node 0 totalpages: 65406
[    0.000000] free_area_init_node: node 0, pgdat b66dda00, node_mem_map bfb5a028
[    0.000000]   DMA zone: 40 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 600 pages used for memmap
[    0.000000]   Normal zone: 61408 pages, LIFO batch:15
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
[    0.000000] e820: [mem 0x10000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @bfb44000 s54528 r0 d23296 u77824
[    0.000000] pcpu-alloc: s54528 r0 d23296 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr fb46ac0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 64766
[    0.000000] Kernel command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw link=/kbuild-tests/run-queue/kvm/i386-randconfig-i0-201739/wfg:unwind_dump-Josh:02e6a26e2f9518e3528bc5a33da568ae156d40b0/.vmlinuz-02e6a26e2f9518e3528bc5a33da568ae156d40b0-20171003211807-79:openwrt-lkp-hsw01-43 branch=wfg/unwind_dump-Josh BOOT_IMAGE=/pkg/linux/i386-randconfig-i0-201739/gcc-4.8/02e6a26e2f9518e3528bc5a33da568ae156d40b0/vmlinuz-4.14.0-rc3-00001-g02e6a26 drbd.minor_count=8
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] allocated 266108 bytes of page_ext
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 212160K/261624K available (10846K kernel code, 3467K rwdata, 5548K rodata, 916K init, 23160K bss, 49464K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffe66000 - 0xfffff000   (1636 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xc07e0000 - 0xff7fe000   (1008 MB)
[    0.000000]     lowmem  : 0xb0000000 - 0xbffe0000   ( 255 MB)
[    0.000000]       .init : 0xb697d000 - 0xb6a62000   ( 916 kB)
[    0.000000]       .data : 0xb60978cc - 0xb6966f00   (9021 kB)
[    0.000000]       .text : 0xb5600000 - 0xb60978cc   (10846 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] 
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** trace_printk() being used. Allocating extra memory.  **
[    0.000000] **                                                      **
[    0.000000] ** This means that this is a DEBUG kernel and it is     **
[    0.000000] ** unsafe for production use.                           **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your vendor!  **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.008521] Running RCU self tests
[    0.008531] Preemptible hierarchical RCU implementation.
[    0.008537] 	RCU lockdep checking is enabled.
[    0.008543] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.008549] 	RCU debug extended QS entry/exit.
[    0.008556] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
[    0.008562] 	Tasks RCU enabled.
[    0.008569] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.010000] NR_IRQS: 2304, nr_irqs: 256, preallocated irqs: 16
[    0.010000] CPU 0 irqstacks, hard=bf5dc000 soft=bf5de000
[    0.010000] console [ttyS0] enabled
[    0.010000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.010000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.010000] ... MAX_LOCK_DEPTH:          48
[    0.010000] ... MAX_LOCKDEP_KEYS:        8191
[    0.010000] ... CLASSHASH_SIZE:          4096
[    0.010000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.010000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.010000] ... CHAINHASH_SIZE:          32768
[    0.010000]  memory used by lock dependency info: 4399 kB
[    0.010000]  per task-struct memory footprint: 1536 bytes
[    0.010000] ------------------------
[    0.010000] | Locking API testsuite:
[    0.010000] ----------------------------------------------------------------------------
[    0.010000]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.010000]   --------------------------------------------------------------------------
[    0.010000]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]   --------------------------------------------------------------------------
[    0.010000]               recursive read-lock:             |  ok  |             |  ok  |
[    0.010000]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.010000]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.010000]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.010000]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
[    0.010000]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
[    0.010000]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
[    0.010000]   --------------------------------------------------------------------------
[    0.010000]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.010000]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.010000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.010000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.010000]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.010000]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.010000]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.010000]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.010000]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.010000]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.010000]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.010000]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.010000]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.010000]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.010000]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.010000]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.010000]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.010000]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.010000]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.010000]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.010000]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.010000]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.010000]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.010000]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.010000]       hard-irq read-recursion/123:  ok  |
[    0.010000]       soft-irq read-recursion/123:  ok  |
[    0.010000]       hard-irq read-recursion/132:  ok  |
[    0.010000]       soft-irq read-recursion/132:  ok  |
[    0.010000]       hard-irq read-recursion/213:  ok  |
[    0.010000]       soft-irq read-recursion/213:  ok  |
[    0.010000]       hard-irq read-recursion/231:  ok  |
[    0.010000]       soft-irq read-recursion/231:  ok  |
[    0.010000]       hard-irq read-recursion/312:  ok  |
[    0.010000]       soft-irq read-recursion/312:  ok  |
[    0.010000]       hard-irq read-recursion/321:  ok  |
[    0.010000]       soft-irq read-recursion/321:  ok  |
[    0.010000]   --------------------------------------------------------------------------
[    0.010000]   | Wound/wait tests |
[    0.010000]   ---------------------
[    0.010000]                   ww api failures:  ok  |  ok  |  ok  |
[    0.010000]                ww contexts mixing:  ok  |  ok  |
[    0.010000]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.010000]                locking mismatches:  ok  |  ok  |  ok  |
[    0.010000]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.010000]            spinlock nest unlocked:  ok  |
[    0.010000]   -----------------------------------------------------
[    0.010000]                                  |block | try  |context|
[    0.010000]   -----------------------------------------------------
[    0.010000]                           context:  ok  |  ok  |  ok  |
[    0.010000]                               try:  ok  |  ok  |  ok  |
[    0.010000]                             block:  ok  |  ok  |  ok  |
[    0.010000]                          spinlock:  ok  |  ok  |  ok  |
[    0.010000] -------------------------------------------------------
[    0.010000] Good, all 261 testcases passed! |
[    0.010000] ---------------------------------
[    0.010000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.010000] hpet clockevent registered
[    0.010032] tsc: Detected 2593.992 MHz processor
[    0.010515] Calibrating delay loop (skipped) preset value.. 5187.98 BogoMIPS (lpj=25939920)
[    0.010862] pid_max: default: 32768 minimum: 301
[    0.011416] ACPI: Core revision 20170728
[    0.017767] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.018664] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.020028] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.022433] mce: CPU supports 10 MCE banks
[    0.022871] mce: unknown CPU type - not enabling MCE support
[    0.023465] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.023942] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.031677] Freeing SMP alternatives memory: 20K
[    0.033756] smpboot: Max logical packages: 1
[    0.034206] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.034772] enabled ExtINT on CPU#0
[    0.036147] ENABLING IO-APIC IRQs
[    0.036532] init IO_APIC IRQs
[    0.036859]  apic 0 pin 0 not connected
[    0.037312] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Active:0 Dest:1)
[    0.038141] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
[    0.038944] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Active:0 Dest:1)
[    0.039781] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 Active:0 Dest:1)
[    0.040000] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 Active:0 Dest:1)
[    0.040000]  apic 0 pin 16 not connected
[    0.040000]  apic 0 pin 17 not connected
[    0.040000]  apic 0 pin 18 not connected
[    0.040000]  apic 0 pin 19 not connected
[    0.040000]  apic 0 pin 20 not connected
[    0.040000]  apic 0 pin 21 not connected
[    0.040000]  apic 0 pin 22 not connected
[    0.040000]  apic 0 pin 23 not connected
[    0.040000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.040000] TSC deadline timer enabled
[    0.040000] smpboot: CPU0: GenuineIntel Intel Core Processor (Haswell) (family: 0x6, model: 0x3c, stepping: 0x1)
[    0.070090] Performance Events: no PMU driver, software events only.
[    0.090046] Hierarchical SRCU implementation.
[    0.150044] smp: Bringing up secondary CPUs ...
[    0.150528] smp: Brought up 1 node, 1 CPU
[    0.150937] smpboot: Total of 1 processors activated (5187.98 BogoMIPS)
[    0.153345] devtmpfs: initialized
[    0.157599] workqueue: round-robin CPU selection forced, expect performance impact
[    0.160216] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.161206] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.162194] prandom: seed boundary self test passed
[    0.163519] prandom: 100 self tests passed
[    0.164670] regulator-dummy: no parameters
[    0.166331] NET: Registered protocol family 16
[    0.169744] cpuidle: using governor ladder
[    0.170993] ACPI: bus type PCI registered
[    0.171976] PCI: PCI BIOS revision 2.10 entry at 0xfd3e3, last bus=0
[    0.172625] PCI: Using configuration type 1 for base access
[    0.210407] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[    0.220303] gpio-f7188x: Not a Fintek device at 0x0000002e
[    0.220928] gpio-f7188x: Not a Fintek device at 0x0000004e
[    0.222145] ACPI: Added _OSI(Module Device)
[    0.222602] ACPI: Added _OSI(Processor Device)
[    0.223094] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.223590] ACPI: Added _OSI(Processor Aggregator Device)
[    0.243958] ACPI: Interpreter enabled
[    0.244417] ACPI: (supports S0 S5)
[    0.244795] ACPI: Using IOAPIC for interrupt routing
[    0.245440] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.248349] ACPI: Enabled 3 GPEs in block 00 to 0F
[    0.301762] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.302463] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.303086] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.303791] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.305466] PCI host bridge to bus 0000:00
[    0.305920] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.306618] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.307298] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.308046] pci_bus 0000:00: root bus resource [mem 0x10000000-0xfebfffff window]
[    0.308810] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.309487] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.311995] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.314676] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.318805] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.320928] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.321649] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.322337] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.323076] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.325695] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.326836] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.327585] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.330102] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.332724] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.337038] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.345428] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.348431] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.350024] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.351798] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.359258] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.361770] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
[    0.363108] pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
[    0.370648] pci_bus 0000:00: on NUMA node 0
[    0.375433] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.377149] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.378810] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.380507] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.381598] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.386419] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.387166] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.388207] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.388788] vgaarb: loaded
[    0.390940] ACPI: bus type USB registered
[    0.391538] usbcore: registered new interface driver usbfs
[    0.392215] usbcore: registered new interface driver hub
[    0.392912] usbcore: registered new device driver usb
[    0.393931] pps_core: LinuxPPS API ver. 1 registered
[    0.394437] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.395439] EDAC MC: Ver: 3.0.0
[    0.396252] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.400396] Unable to find dmi tokens
[    0.410382] FPGA manager framework
[    0.410872] PCI: Using ACPI for IRQ routing
[    0.411308] PCI: pci_cache_line_size set to 64 bytes
[    0.411968] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.412644] e820: reserve RAM buffer [mem 0x0ffe0000-0x0fffffff]
[    0.415464] clocksource: Switched to clocksource kvm-clock
[    0.416984] Warning: could not register all branches stats
[    0.417629] Warning: could not register annotated branches stats
[    0.598439] VFS: Disk quotas dquot_6.6.0
[    0.598971] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.600125] FS-Cache: Loaded
[    0.600904] pnp: PnP ACPI init
[    0.601863] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.603120] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.604194] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.605100] pnp 00:03: [dma 2]
[    0.605681] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.607052] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.608438] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.609673] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.613531] pnp: PnP ACPI: found 7 devices
[    0.652000] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.653390] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.654024] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.654834] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.655568] pci_bus 0000:00: resource 7 [mem 0x10000000-0xfebfffff window]
[    0.657186] NET: Registered protocol family 1
[    0.657775] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.658543] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.661522] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.662226] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.663222] PCI: CLS 0 bytes, default 64
[    0.664373] Unpacking initramfs...
[    0.895842] Freeing initrd memory: 2068K
[    0.897576] Machine check injector initialized
[    0.903399] The force parameter has not been set to 1. The Iris poweroff handler will not be installed.
[    0.904475] NatSemi SCx200 Driver
[    0.905092] spin_lock-torture:--- Start of test [debug]: nwriters_stress=2 nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
[    0.906992] spin_lock-torture: Creating torture_shuffle task
[    0.907904] spin_lock-torture: Creating torture_stutter task
[    0.908633] spin_lock-torture: torture_shuffle task started
[    0.909345] spin_lock-torture: Creating lock_torture_writer task
[    0.910322] spin_lock-torture: torture_stutter task started
[    0.911030] spin_lock-torture: Creating lock_torture_writer task
[    0.911830] spin_lock-torture: lock_torture_writer task started
[    0.912542] spin_lock-torture: Creating lock_torture_stats task
[    0.915799] spin_lock-torture: lock_torture_writer task started
[    0.920401] spin_lock-torture: lock_torture_stats task started
[    0.922787] Key type blacklist registered
[    0.923640] workingset: timestamp_bits=14 max_order=16 bucket_order=2
[    0.990218] zbud: loaded
[    0.994333] orangefs_debugfs_init: called with debug mask: :none: :0:
[    0.995283] orangefs_init: module version upstream loaded
[    1.023848] Key type asymmetric registered
[    1.024364] test_string_helpers: Running tests...
[    1.029445] test_hexdump: all 1184 tests passed
[    1.030885] test_firmware: interface ready
[    1.047111] test_hash: __hash_32() has no arch implementation to test.
[    1.047856] test_hash: hash_32() has no arch implementation to test.
[    1.048569] test_hash: hash_64() has no arch implementation to test.
[    1.049295] test_hash: 33152 tests passed.
[    1.049830] test_siphash: self-tests: pass
[    1.053121] Running rhashtable test nelem=8, max_size=0, shrinking=0
[    1.053843] Test 00:
[    1.057814]   Adding 50000 keys
[    1.658398]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    1.804318]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    1.806432]   Deleting 50000 keys
[    1.920195] tsc: Refined TSC clocksource calibration: 2593.991 MHz
[    1.920881] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25640fc6114, max_idle_ns: 440795275253 ns
[    1.998510]   Duration of test: 940282994 ns
[    1.998941] Test 01:
[    2.001154]   Adding 50000 keys
[    2.507833]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    2.648777]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    2.649658]   Deleting 50000 keys
[    2.845729]   Duration of test: 844294144 ns
[    2.846302] Test 02:
[    2.848644]   Adding 50000 keys
[    3.517107]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    3.667612]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    3.668550]   Deleting 50000 keys
[    3.865005]   Duration of test: 1015992348 ns
[    3.868218] Test 03:
[    3.870640]   Adding 50000 keys
[    4.560469]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    4.723216]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
[    4.724132]   Deleting 50000 keys
[    4.913728]   Duration of test: 1042722781 ns
[    4.914291] Average test time: 960823066
[    4.914695] Testing concurrent rhashtable access from 10 threads
[   25.753870] Started 10 threads, 0 failed
[   25.757298] test passed
[   25.758057] test_printf: all 260 tests passed
[   25.956100] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 1600
[   25.965338] test_bitmap: all 460506 tests passed
[   25.980088] crc32: CRC_LE_BITS = 1, CRC_BE BITS = 1
[   25.980616] crc32: self tests passed, processed 225944 bytes in 3658198 nsec
[   25.983918] crc32c: CRC_LE_BITS = 1
[   25.984296] crc32c: self tests passed, processed 225944 bytes in 1295913 nsec
[   26.203070] crc32_combine: 8373 self tests passed
[   26.344808] crc32c_combine: 8373 self tests passed
[   26.345817] atomic64_test: passed for i386+ platform with CX8 and with SSE
[   26.346580] glob: 64 self-tests passed, 0 failed
[   26.347102] interval tree insert/remove
[   27.909117]  -> 40517 cycles
[   27.909874] interval tree search
[   28.726075]  -> 211713 cycles (2692 results)
[   28.729902] no IO addresses supplied
[   28.730808] usbcore: registered new interface driver udlfb
[   28.731596] ipmi message handler version 39.2
[   28.732193] IPMI System Interface driver.
[   28.733007] ipmi_si: Unable to find any System Interface(s)
[   28.733584] IPMI SSIF Interface driver
[   28.734166] IPMI Watchdog: driver initialized
[   28.734649] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
[   28.736502] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   28.737327] ACPI: Power Button [PWRF]
[   28.909032] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   28.958503] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   28.995529] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   28.999127] lp: driver loaded but no devices found
[   28.999959] Non-volatile memory driver v1.3
[   29.000449] scx200_gpio: no SCx200 gpio present
[   29.001373] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver Initializing
[   29.002179] platform pc8736x_gpio.0: no device found
[   29.003046] nsc_gpio initializing
[   29.003451] telclk_interrupt = 0xf non-mcpbl0010 hw.
[   29.004070] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[   29.005285] drm_mm: Testing DRM range manger (struct drm_mm), with random_seed=0x5100b482 max_iterations=8192 max_prime=128
[   29.006452] drm_mm: igt_sanitycheck - ok!
[   64.480088] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
[   68.121875] drm_mm: lookup failed for node 0 + 1
[   68.125707] parport_pc 00:04: reported by Plug and Play ACPI
[   68.126537] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
[   68.127905] lp0: using parport0 (interrupt-driven).
[   68.131991] dummy-irq: no IRQ given.  Use irq=N
[   68.133474] usbcore: registered new interface driver rtsx_usb
[   68.135351] usbcore: registered new interface driver viperboard
[   68.136998] parport0: cannot grant exclusive access for device spi-lm70llp
[   68.137711] spi_lm70llp: spi_lm70llp probe fail, status -12
[   68.138996] parport0: cannot grant exclusive access for device ks0108
[   68.139634] ks0108: ERROR: parport didn't register new device
[   68.140376] cfag12864b: ERROR: ks0108 is not initialized
[   68.140934] cfag12864bfb: ERROR: cfag12864b is not initialized
[   68.330426] panel: panel driver registered on parport0 (io=0x378).
[   68.331393] usbcore: registered new interface driver hwa-rc
[   68.332453] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   68.333103] ehci-pci: EHCI PCI platform driver
[   68.333648] ehci-platform: EHCI generic platform driver
[   68.334389] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   68.335140] ohci-pci: OHCI PCI platform driver
[   68.335717] ohci-platform: OHCI generic platform driver
[   68.336522] fotg210_hcd: FOTG210 Host Controller (EHCI) Driver
[   68.337121] Warning! fotg210_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[   68.350167] usbcore: registered new interface driver wusb-cbaf
[   68.350843] usbcore: registered new interface driver cdc_wdm
[   68.351511] usbcore: registered new interface driver mdc800
[   68.352091] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
[   68.352942] usbcore: registered new interface driver adutux
[   68.353568] usbcore: registered new interface driver appledisplay
[   68.354251] usbcore: registered new interface driver cytherm
[   68.354914] usbcore: registered new interface driver emi62 - firmware loader
[   68.355625] ftdi_elan: driver ftdi-elan
[   68.356108] usbcore: registered new interface driver ftdi-elan
[   68.356775] usbcore: registered new interface driver iowarrior
[   68.357430] usbcore: registered new interface driver isight_firmware
[   68.358135] usbcore: registered new interface driver usblcd
[   68.358788] usbcore: registered new interface driver ldusb
[   68.359430] usbcore: registered new interface driver legousbtower
[   68.370167] usbcore: registered new interface driver rio500
[   68.370839] usbcore: registered new interface driver usbtest
[   68.371499] usbcore: registered new interface driver usb_ehset_test
[   68.372213] usbcore: registered new interface driver uss720
[   68.372773] uss720: USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
[   68.373630] uss720: NOTE: this is a special purpose driver to allow nonstandard
[   68.374345] uss720: protocols (eg. bitbang) over USS720 usb to parallel cables
[   68.375082] uss720: If you just want to connect to a printer, use usblp instead
[   68.375903] usbcore: registered new interface driver usbsevseg
[   68.376574] usbcore: registered new interface driver yurex
[   68.377482] usbcore: registered new interface driver sisusb
[   68.378118] usbcore: registered new interface driver lvs
[   68.379537] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[   68.382006] serio: i8042 KBD port at 0x60,0x64 irq 1
[   68.382963] serio: i8042 AUX port at 0x60,0x64 irq 12
[   68.383965] parport0: cannot grant exclusive access for device parkbd
[   68.436849] mousedev: PS/2 mouse device common for all mice
[   68.437484] evbug: Connected device: input0 (Power Button at LNXPWRBN/button/input0)
[   68.439540] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[   68.441249] evbug: Connected device: input1 (AT Translated Set 2 keyboard at isa0060/serio0/input0)
[   68.442637] usbcore: registered new interface driver appletouch
[   68.444049] usbcore: registered new interface driver bcm5974
[   68.446696] usbcore: registered new interface driver xpad
[   68.447472] usbcore: registered new interface driver gtco
[   68.448100] usbcore: registered new interface driver hanwang
[   68.448735] usbcore: registered new interface driver kbtab
[   68.449403] usbcore: registered new interface driver pegasus_notetaker
[   68.453663] i2c /dev entries driver
[   68.454389] usbcore: registered new interface driver i2c-tiny-usb
[   68.455658] pps pps0: new PPS source ktimer
[   68.456119] pps pps0: ktimer PPS source registered
[   68.456688] Driver for 1-wire Dallas network protocol.
[   68.457475] usbcore: registered new interface driver DS9490R
[   68.458043] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[   68.458855] w1_f0d_init()
[   68.462228] applesmc: supported laptop not found!
[   68.462709] applesmc: driver init failed (ret=-19)!
[   68.466470] pc87360: PC8736x not detected, module not inserted
[   68.468346] sdhci: Secure Digital Host Controller Interface driver
[   68.468996] sdhci: Copyright(c) Pierre Ossman
[   68.469432] wbsd: Winbond W83L51xD SD/MMC card interface driver
[   68.470059] wbsd: Copyright(c) Pierre Ossman
[   68.470714] VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
[   68.550211] usbcore: registered new interface driver vub300
[   68.584465] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   68.586825] hidraw: raw HID events driver (C) Jiri Kosina
[   68.592634] usbcore: registered new interface driver usbkbd
[   68.593287] usbcore: registered new interface driver usbmouse
[   68.595610]  fake-fmc-carrier: mezzanine 0
[   68.596060]       Manufacturer: fake-vendor
[   68.596495]       Product name: fake-design-for-testing
[   68.597305] fmc fake-design-for-testing-f001: Driver has no ID: matches all
[   68.598084] fmc_trivial: probe of fake-design-for-testing-f001 failed with error -95
[   68.598943] fmc fake-design-for-testing-f001: Driver has no ID: matches all
[   68.599683] fmc_write_eeprom fake-design-for-testing-f001: fmc_write_eeprom: no busid passed, refusing all cards
[   68.603795] start plist test
[   68.613733] end plist test
[   68.614044] mce: Unable to init MCE device (rc: -5)
[   68.615451] ... APIC ID:      00000000 (0)
[   68.615875] ... APIC VERSION: 01050014
[   68.616270] 0000000000000000000000000000000000000000000000000000000000000000
[   68.617061] 0000000000000000000000000000000000000000000000000000000000000000
[   68.617839] 0000000000000000000000000000000000000000000000000000000000000000
[   68.618645] number of MP IRQ sources: 15.
[   68.619071] number of IO-APIC #0 registers: 24.
[   68.619535] testing the IO APIC.......................
[   68.620163] IO APIC #0......
[   68.620476] .... register #00: 00000000
[   68.620884] .......    : physical APIC id: 00
[   68.621340] .......    : Delivery Type: 0
[   68.621741] .......    : LTS          : 0
[   68.622150] .... register #01: 00170011
[   68.622535] .......     : max redirection entries: 17
[   68.623045] .......     : PRQ implemented: 0
[   68.623472] .......     : IO APIC version: 11
[   68.623913] .... register #02: 00000000
[   68.624313] .......     : arbitration: 00
[   68.624728] .... IRQ redirection table:
[   68.625135] IOAPIC 0:
[   68.625398]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.626201]  pin01, enabled , edge , high, V(31), IRR(0), S(0), logical , D(01), M(1)
[   68.626994]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(1)
[   68.627789]  pin03, enabled , edge , high, V(33), IRR(0), S(0), logical , D(01), M(1)
[   68.628583]  pin04, enabled , edge , high, V(34), IRR(0), S(0), logical , D(01), M(1)
[   68.629391]  pin05, disabled, level, high, V(35), IRR(0), S(0), logical , D(01), M(1)
[   68.630272]  pin06, enabled , edge , high, V(36), IRR(0), S(0), logical , D(01), M(1)
[   68.631052]  pin07, enabled , edge , high, V(37), IRR(0), S(0), logical , D(01), M(1)
[   68.631827]  pin08, enabled , edge , high, V(38), IRR(0), S(0), logical , D(01), M(1)
[   68.632620]  pin09, enabled , level, high, V(39), IRR(0), S(0), logical , D(01), M(1)
[   68.633430]  pin0a, disabled, level, high, V(3A), IRR(0), S(0), logical , D(01), M(1)
[   68.634232]  pin0b, disabled, level, high, V(3B), IRR(0), S(0), logical , D(01), M(1)
[   68.635025]  pin0c, enabled , edge , high, V(3C), IRR(0), S(0), logical , D(01), M(1)
[   68.635799]  pin0d, enabled , edge , high, V(3D), IRR(0), S(0), logical , D(01), M(1)
[   68.636583]  pin0e, enabled , edge , high, V(3E), IRR(0), S(0), logical , D(01), M(1)
[   68.637385]  pin0f, enabled , edge , high, V(3F), IRR(0), S(0), logical , D(01), M(1)
[   68.638188]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.638983]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.639750]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.640566]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.641358]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.642159]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.642965]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.643766]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   68.644548] IRQ to pin mappings:
[   68.644898] IRQ0 -> 0:2
[   68.645186] IRQ1 -> 0:1
[   68.645481] IRQ3 -> 0:3
[   68.645764] IRQ4 -> 0:4
[   68.646045] IRQ5 -> 0:5
[   68.646323] IRQ6 -> 0:6
[   68.646601] IRQ7 -> 0:7
[   68.646886] IRQ8 -> 0:8
[   68.647163] IRQ9 -> 0:9
[   68.647441] IRQ10 -> 0:10
[   68.647733] IRQ11 -> 0:11
[   68.648036] IRQ12 -> 0:12
[   68.648330] IRQ13 -> 0:13
[   68.648624] IRQ14 -> 0:14
[   68.648925] IRQ15 -> 0:15
[   68.649218] .................................... done.
[   68.649757] Using IPI Shortcut mode
[   68.650233] sched_clock: Marking stable (68650136540, 0)->(68959429126, -309292586)
[   68.652390] page_owner is disabled
[   68.654142] Key type big_key registered
[   68.655079] Key type trusted registered
[   68.656085] Key type encrypted registered
[   68.661137] OF: Duplicate name in testcase-data, renamed to "duplicate-name#1"
[   68.669760] ### dt-test ### start of unittest - you will see error messages
[   68.671631] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[   68.672837] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[   68.674064] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[   68.674818] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[   68.675570] OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
[   68.676393] OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
[   68.714101] OF: overlay: overlay_is_topmost: #5 clashes #6 @/testcase-data/overlay-node/test-bus/test-unittest8
[   68.715134] OF: overlay: overlay #5 is not topmost
[   68.737686] i2c i2c-0: Added multiplexed i2c bus 1
[   68.748076] i2c i2c-0: Added multiplexed i2c bus 2
[   68.762476] ### dt-test ### FAIL of_unittest_overlay_high_level():2201 overlay_base_root not initialized
[   68.763452] ### dt-test ### end of unittest - 188 passed, 1 failed
[   68.766884] Freeing unused kernel memory: 916K
[   68.768678] Write protecting the kernel text: 10848k
[   68.782143] Write protecting the kernel read-only data: 5552k
procd: Console is alive
procd: - preinit -
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
mounting /dev/root
mount: mounting 1 on /mnt failed: No such device
mv: can't rename '/mnt/sysupgrade.tgz': No such file or directory
umount: can't umount /mnt: Invalid argument
procd: - early -
procd: - ubus -
procd: - init -
Please press Enter to activate this console.
[   89.505747] sock: process `trinity-main' is using obsolete setsockopt SO_BSDCOMPAT
procd: Instance odhcpd::instance1 s in a crash loop 6 crashes, 0 seconds since last crash
procd: Instance uhttpd::instance1 s in a crash loop 6 crashes, 0 seconds since last crash
procd: Instance dnsmasq::instance1 s in a crash loop 6 crashes, 0 seconds since last crash
[  114.450013] WARNING: kernel stack regs at be36bc9a in 01-cpu-hotplug:7747 has bad 'bp' value 000001be
[  114.450017] unwind stack type:0 next_sp:  (null) mask:0x2 graph_idx:0
[  114.450020] be36bc9c: 81be36bc (0x81be36bc)
[  114.450023] be36bca0: ebb56272 (0xebb56272)
[  114.450029] be36bca4: b5be36bc (drm_setup_crtcs+0x10ac/0x12e0)
[  114.450031] be36bca8: 4000bcb4 (0x4000bcb4)
[  114.450033] be36bcac: 00be02b2 (0xbe02b2)
[  114.450035] be36bcb0: 00000000 ...
[  114.450037] be36bcb4: 00be36a0 (0xbe36a0)
[  114.450039] be36bcb8: 00be36c0 (0xbe36c0)
[  114.450041] be36bcbc: 02000000 (0x2000000)
[  114.450043] be36bcc0: 40000000 (0x40000000)
[  114.450045] be36bcc4: 00be02b2 (0xbe02b2)
[  114.450046] be36bcc8: 01000000 (0x1000000)
[  114.450048] be36bccc: 00000001 (0x1)
[  114.450050] be36bcd0: 9a000000 (0x9a000000)
[  114.450052] be36bcd4: 00be36bc (0xbe36bc)
[  114.450054] be36bcd8: 9a000100 (0x9a000100)
[  114.450056] be36bcdc: dcbe36bc (0xdcbe36bc)
[  114.450057] be36bce0: 00be02b7 (0xbe02b7)
[  114.450059] be36bce4: 40000000 (0x40000000)
[  114.450061] be36bce8: f7be02b2 (0xf7be02b2)
[  114.450063] be36bcec: 80be36bc (0x80be36bc)
[  114.450065] be36bcf0: 00b56273 (0xb56273)
[  114.450067] be36bcf4: 57000000 (0x57000000)
[  114.450069] be36bcf8: 3fbe36bd (0x3fbe36bd)
[  114.450071] be36bcfc: 00b56ef2 (0xb56ef2)
[  114.450072] be36bd00: bb19e5a8 (0xbb19e5a8)
[  114.450074] be36bd04: edf1e285 (0xedf1e285)
[  114.450076] be36bd08: 00000002 (0x2)
[  114.450078] be36bd0c: be02b7bc (0xbe02b7bc)
[  114.450080] be36bd10: be02b7bc (0xbe02b7bc)
[  114.450084] be36bd14: b5627380 (save_stack_trace+0x20/0x30)
[  114.450086] be36bd18: be02b240 (0xbe02b240)
[  114.450088] be36bd1c: 0036bdbc (0x36bdbc)
[  114.450090] be36bd20: 6d000000 (0x6d000000)
[  114.450092] be36bd24: 3aef640e (0x3aef640e)
[  114.450094] be36bd28: 6900002b (0x6900002b)
[  114.450096] be36bd2c: 02e9adb3 (0x2e9adb3)
[  114.450098] be36bd30: dc000000 (0xdc000000)
[  114.450100] be36bd34: 02be02b7 (0x2be02b7)
[  114.450101] be36bd38: 00000000 ...
[  114.450103] be36bd3c: be36bdbc (0xbe36bdbc)
[  114.450105] be36bd40: be36bf78 (0xbe36bf78)
[  114.450107] be36bd44: be36bf74 (0xbe36bf74)
[  114.450109] be36bd48: 4036bd7c (0x4036bd7c)
[  114.450111] be36bd4c: 46be02b2 (0x46be02b2)
[  114.450112] be36bd50: 00000000 ...
[  114.450114] be36bd54: 93000000 (0x93000000)
[  114.450116] be36bd58: 32be36bd (0x32be36bd)
[  114.450118] be36bd5c: 00b56efd (0xb56efd)
[  114.450120] be36bd60: 01000000 (0x1000000)
[  114.450122] be36bd64: 01000000 (0x1000000)
[  114.450123] be36bd68: 00000000 ...
[  114.450125] be36bd6c: 0a000000 (0xa000000)
[  114.450127] be36bd70: 00b5741c (0xb5741c)
[  114.450128] be36bd74: 00000000 ...
[  114.450130] be36bd78: 46000000 (0x46000000)
[  114.450131] be36bd7c: 00000000 ...
[  114.450133] be36bd80: e8000000 (0xe8000000)
[  114.450135] be36bd84: d8b660ae (0xd8b660ae)
[  114.450137] be36bd88: 80b660ae (0x80b660ae)
[  114.450139] be36bd8c: 1aa5c068 (0x1aa5c068)
[  114.450141] be36bd90: af000000 (0xaf000000)
[  114.450143] be36bd94: 02be36bd (0x2be36bd)
[  114.450144] be36bd98: 00b60903 (0xb60903)
[  114.450146] be36bd9c: 01000000 (0x1000000)
[  114.450148] be36bda0: 00000000 ...
[  114.450149] be36bda4: 0a000000 (0xa000000)
[  114.450151] be36bda8: 00b5741c (0xb5741c)
[  114.450153] be36bdac: c7bfb46a (0xc7bfb46a)
[  114.450155] be36bdb0: 0abe36bd (0xabe36bd)
[  114.450157] be36bdb4: 00b5741c (0xb5741c)
[  114.450159] be36bdb8: e9000000 (0xe9000000)
[  114.450161] be36bdbc: c700002b (0xc700002b)
[  114.450162] be36bdc0: d2be36bd (0xd2be36bd)
[  114.450164] be36bdc4: e3b5a184 (0xe3b5a184)
[  114.450166] be36bdc8: 83be36bd (0x83be36bd)
[  114.450168] be36bdcc: 00b5741f (0xb5741f)
[  114.450169] be36bdd0: 00000000 ...
[  114.450171] be36bdd8: 00bfb46a (0xbfb46a)
[  114.450173] be36bddc: e9000000 (0xe9000000)
[  114.450175] be36bde0: ff00002b (0xff00002b)
[  114.450177] be36bde4: cbbe36bd (0xcbbe36bd)
[  114.450179] be36bde8: 00b6094e (0xb6094e)
[  114.450181] be36bdec: 07000000 (0x7000000)
[  114.450183] be36bdf0: 00be36be (0xbe36be)
[  114.450184] be36bdf4: 00be0b3c (0xbe0b3c)
[  114.450186] be36bdf8: c2000000 (0xc2000000)
[  114.450188] be36bdfc: 07000426 (0x7000426)
[  114.450190] be36be00: 53be36be (0x53be36be)
[  114.450192] be36be04: 00b6091b (0xb6091b)
[  114.450194] be36be08: 18be0b3c (0x18be0b3c)
[  114.450196] be36be0c: 2fbf6610 (0x2fbf6610)
[  114.450197] be36be10: 00000000 ...
[  114.450199] be36be14: c2000000 (0xc2000000)
[  114.450201] be36be18: 50000426 (0x50000426)
[  114.450203] be36be1c: 00be36be (0xbe36be)
[  114.450205] be36be20: 7b000000 (0x7b000000)
[  114.450207] be36be24: 7b000000 (0x7b000000)
[  114.450209] be36be28: d864a700 (0xd864a700)
[  114.450211] be36be2c: 00001f00 (0x1f00)
[  114.450213] be36be30: 10000000 (0x10000000)
[  114.450215] be36be34: d6ffffff (0xd6ffffff)
[  114.450217] be36be38: 60b60782 (0x60b60782)
[  114.450219] be36be3c: 02000000 (0x2000000)
[  114.450220] be36be40: 2e000002 (0x2e000002)
[  114.450222] be36be44: be0b3c00 (0xbe0b3c00)
[  114.450224] be36be48: 00001fc2 (0x1fc2)
[  114.450226] be36be4c: be02b240 (0xbe02b240)
[  114.450228] be36be50: be36bf10 (0xbe36bf10)
[  114.450234] be36be54: b5915198 (load_misc_binary+0x78/0x893)
[  114.450236] be36be58: be36beb8 (0xbe36beb8)
[  114.450242] be36be5c: b56ef520 (__lock_acquire+0x12c0/0x1330)
[  114.450243] be36be60: be36bec0 (0xbe36bec0)
[  114.450247] be36be64: b56ef520 (__lock_acquire+0x12c0/0x1330)
[  114.450248] be36be68: 00000002 (0x2)
[  114.450250] be36be6c: d3579900 (0xd3579900)
[  114.450252] be36be70: be0b3c00 (0xbe0b3c00)
[  114.450254] be36be74: 00000002 (0x2)
[  114.450256] be36be78: be36be84 (0xbe36be84)
[  114.450257] be36be7c: be02b7bc (0xbe02b7bc)
[  114.450259] be36be80: 00000000 ...
[  114.450261] be36be84: 17789ec6 (0x17789ec6)
[  114.450265] be36be88: b6a8b3bc (lock_chains+0x10a7c/0x140000)
[  114.450267] be36be8c: 2060ad7f (0x2060ad7f)
[  114.450269] be36be90: 00000001 (0x1)
[  114.450271] be36be94: be02b7bc (0xbe02b7bc)
[  114.450273] be36be98: 00000001 (0x1)
[  114.450275] be36be9c: be02b7dc (0xbe02b7dc)
[  114.450276] be36bea0: 00000001 (0x1)
[  114.450278] be36bea4: 00000000 ...
[  114.450279] be36bea8: 00000003 (0x3)
[  114.450281] be36beac: 00000002 (0x2)
[  114.450283] be36beb0: be02b7b0 (0xbe02b7b0)
[  114.450285] be36beb4: be02b240 (0xbe02b240)
[  114.450286] be36beb8: 00000001 (0x1)
[  114.450288] be36bebc: f03abd6a (0xf03abd6a)
[  114.450290] be36bec0: cccf9fb5 (0xcccf9fb5)
[  114.450292] be36bec4: 00000001 (0x1)
[  114.450294] be36bec8: be02b79c (0xbe02b79c)
[  114.450296] be36becc: be02b240 (0xbe02b240)
[  114.450297] be36bed0: 00000001 (0x1)
[  114.450303] be36bed4: b6641694 (binfmt_lock+0x14/0x28)
[  114.450305] be36bed8: be36bf00 (0xbe36bf00)
[  114.450307] be36bedc: ffffffff (0xffffffff)
[  114.450311] be36bee0: b58a6cb1 (search_binary_handler+0x61/0x140)
[  114.450313] be36bee4: be02b240 (0xbe02b240)
[  114.450315] be36bee8: be36bf00 (0xbe36bf00)
[  114.450319] be36beec: b56ba232 (preempt_count_sub+0x122/0x2e0)
[  114.450320] be36bef0: 00000000 ...
[  114.450324] be36bef8: b664a660 (aout_format+0x30/0x30)
[  114.450326] be36befc: be02b240 (0xbe02b240)
[  114.450328] be36bf00: be36bf10 (0xbe36bf10)
[  114.450329] be36bf04: be0b3c00 (0xbe0b3c00)
[  114.450333] be36bf08: b664a660 (aout_format+0x30/0x30)
[  114.450334] be36bf0c: be02b240 (0xbe02b240)
[  114.450336] be36bf10: be36bf24 (0xbe36bf24)
[  114.450340] be36bf14: b58a6cbd (search_binary_handler+0x6d/0x140)
[  114.450341] be36bf18: bf661000 (0xbf661000)
[  114.450343] be36bf1c: 00000000 ...
[  114.450345] be36bf20: be02b240 (0xbe02b240)
[  114.450347] be36bf24: be36bf64 (0xbe36bf64)
[  114.450350] be36bf28: b58a7616 (do_execveat_common+0x886/0xe20)
[  114.450351] be36bf2c: 00000002 (0x2)
[  114.450353] be36bf30: 00000000 ...
[  114.450356] be36bf38: b58a7529 (do_execveat_common+0x799/0xe20)
[  114.450358] be36bf3c: be362480 (0xbe362480)
[  114.450360] be36bf40: 00001d92 (0x1d92)
[  114.450362] be36bf44: 00001e43 (0x1e43)
[  114.450363] be36bf48: be0b3c00 (0xbe0b3c00)
[  114.450365] be36bf4c: 00001e43 (0x1e43)
[  114.450367] be36bf50: be274580 (0xbe274580)
[  114.450369] be36bf54: 00000000 ...
[  114.450370] be36bf58: be36bfac (0xbe36bfac)
[  114.450372] be36bf5c: 00000001 (0x1)
[  114.450374] be36bf60: 0000000b (0xb)
[  114.450376] be36bf64: be36bf74 (0xbe36bf74)
[  114.450379] be36bf68: b58a7ef0 (SyS_execve+0x30/0x40)
[  114.450381] be36bf6c: 0809618c (0x809618c)
[  114.450382] be36bf70: 00000000 ...
[  114.450384] be36bf74: be36bfa4 (0xbe36bfa4)
[  114.450387] be36bf78: b5602098 (do_int80_syscall_32+0xb8/0x3c0)
[  114.450389] be36bf7c: 080961c4 (0x80961c4)
[  114.450391] be36bf80: 0809617c (0x809617c)
[  114.450393] be36bf84: 0809618c (0x809618c)
[  114.450395] be36bf88: 080961c4 (0x80961c4)
[  114.450397] be36bf8c: 0809618c (0x809618c)
[  114.450399] be36bf90: afb9d690 (0xafb9d690)
[  114.450401] be36bf94: afb9d690 (0xafb9d690)
[  114.450402] be36bf98: 080961c4 (0x80961c4)
[  114.450404] be36bf9c: 080961c4 (0x80961c4)
[  114.450406] be36bfa0: 0809618c (0x809618c)
[  114.450408] be36bfa4: afb9d690 (0xafb9d690)
[  114.450414] be36bfa8: b609125b (entry_INT80_32+0x2f/0x2f)
[  114.450416] be36bfac: 080961c4 (0x80961c4)
[  114.450418] be36bfb0: 0809617c (0x809617c)
[  114.450420] be36bfb4: 0809618c (0x809618c)
[  114.450422] be36bfb8: 080961c4 (0x80961c4)
[  114.450424] be36bfbc: 0809618c (0x809618c)
[  114.450426] be36bfc0: afb9d690 (0xafb9d690)
[  114.450427] be36bfc4: ffffffda (0xffffffda)
[  114.450429] be36bfc8: 0000007b (0x7b)
[  114.450431] be36bfcc: 0000007b (0x7b)
[  114.450432] be36bfd0: 00000000 ...
[  114.450434] be36bfd8: 0000000b (0xb)
[  114.450436] be36bfdc: a7f4ad1d (0xa7f4ad1d)
[  114.450438] be36bfe0: 00000073 (0x73)
[  114.450440] be36bfe4: 00000282 (0x282)
[  114.450442] be36bfe8: afb9d66c (0xafb9d66c)
[  114.450443] be36bfec: 0000007b (0x7b)
[  114.450445] be36bff0: 7fffffff (0x7fffffff)
[  114.450447] be36bff4: 00000004 (0x4)
[  114.450449] be36bff8: 30060f3d (0x30060f3d)
[  114.450451] be36bffc: 7fffffff (0x7fffffff)
[  125.920163] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 
procd: - shutdown -
procd: - reboot -
[  180.542361] Unregister pv shared memory for cpu 0
[  180.542927] spin_lock-torture: Unscheduled system shutdown detected
[  180.580164] torture thread torture_shuffle parking due to system shutdown
[  180.580854] torture thread torture_stutter parking due to system shutdown
[  180.589825] reboot: Restarting system
[  180.593388] reboot: machine restart

Elapsed time: 180

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel /pkg/linux/i386-randconfig-i0-201739/gcc-4.8/02e6a26e2f9518e3528bc5a33da568ae156d40b0/vmlinuz-4.14.0-rc3-00001-g02e6a26
	-initrd /osimage/openwrt/openwrt-trinity-i386.cgz
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-pidfile /dev/shm/kboot/pid-openwrt-lkp-hsw01-43
	-serial file:/dev/shm/kboot/openwrt-lkp-hsw01-43/serial
	-serial file:/dev/shm/kboot/openwrt-lkp-hsw01-43/kmsg
	-daemonize
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	link=/kbuild-tests/run-queue/kvm/i386-randconfig-i0-201739/wfg:unwind_dump-Josh:02e6a26e2f9518e3528bc5a33da568ae156d40b0/.vmlinuz-02e6a26e2f9518e3528bc5a33da568ae156d40b0-20171003211807-79:openwrt-lkp-hsw01-43
	branch=wfg/unwind_dump-Josh
	BOOT_IMAGE=/pkg/linux/i386-randconfig-i0-201739/gcc-4.8/02e6a26e2f9518e3528bc5a33da568ae156d40b0/vmlinuz-4.14.0-rc3-00001-g02e6a26
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"
