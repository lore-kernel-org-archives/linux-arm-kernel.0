From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 19 Sep 2014 16:03:01 -0700
Subject: [PATCH v3] arm64: dmi: Add SMBIOS/DMI support
Message-ID: <1411167781-18571-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yi Li <yi.li@linaro.org>

SMBIOS is important for server hardware vendors. It implements a spec for
providing descriptive information about the platform. Things like serial
numbers, physical layout of the ports, build configuration data, and the like.

This has been tested by dmidecode and lshw tools.

This patch adds the call to dmi_scan_machine() to arm64_enter_virtual_mode(),
as that is the point where the EFI Configuration Tables are registered as
being available. It needs to be in an early_initcall anyway as dmi_id_init(),
which is an arch_initcall itself, depends on dmi_scan_machine() having been
called already.

Signed-off-by: Yi Li <yi.li@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

It has been a long adventure getting this patch into shape, apologies for that.
A FVP Base model boot log is pasted at then end of this patch, which shows the
boot log and the output of the tools when dumping the SMBIOS tables.

 arch/arm64/Kconfig           | 11 +++++++++++
 arch/arm64/include/asm/dmi.h | 31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/efi.c      |  8 ++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/include/asm/dmi.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a4e1ce..c69ab5a3a321 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -368,6 +368,17 @@ config EFI
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
+config DMI
+	bool "Enable support for SMBIOS (DMI) tables"
+	depends on EFI
+	default y
+	help
+	  This enables SMBIOS/DMI feature for systems.
+
+	  This option is only useful on systems that have UEFI firmware.
+	  However, even with this option, the resultant kernel should
+	  continue to boot on existing non-UEFI platforms.
+
 endmenu
 
 menu "Userspace binary formats"
diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
new file mode 100644
index 000000000000..69d37d87b159
--- /dev/null
+++ b/arch/arm64/include/asm/dmi.h
@@ -0,0 +1,31 @@
+/*
+ * arch/arm64/include/asm/dmi.h
+ *
+ * Copyright (C) 2013 Linaro Limited.
+ * Written by: Yi Li (yi.li at linaro.org)
+ *
+ * based on arch/ia64/include/asm/dmi.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ASM_DMI_H
+#define __ASM_DMI_H
+
+#include <linux/io.h>
+#include <linux/slab.h>
+
+/*
+ * According to section 2.3.6 of the UEFI spec, the firmware should not
+ * request a virtual mapping for configuration tables such as SMBIOS.
+ * This means we have to map them before use.
+ */
+#define dmi_early_remap(x, l)		ioremap_cache(x, l)
+#define dmi_early_unmap(x, l)		iounmap(x)
+#define dmi_remap(x, l)			ioremap_cache(x, l)
+#define dmi_unmap(x)			iounmap(x)
+#define dmi_alloc(l)			kzalloc(l, GFP_KERNEL)
+
+#endif
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 03aaa99e1ea0..b71ab0e5780c 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -435,6 +436,13 @@ static int __init arm64_enter_virtual_mode(void)
 	}
 	set_bit(EFI_SYSTEM_TABLES, &efi.flags);
 
+	/*
+	 * DMI depends on EFI on arm64, and dmi_scan_machine() needs to be
+	 * called early because dmi_id_init(), which is an arch_initcall itself,
+	 * depends on dmi_scan_machine() having been called already.
+	 */
+	dmi_scan_machine();
+
 	local_irq_save(flags);
 	cpu_switch_mm(idmap_pg_dir, &init_mm);
 
-- 
1.8.3.2


FS3:\> Image dtb=dtb/fvp.dtb console=ttyAMA0,38400n8 debug user_debug=31 loglevel=9 uefi_debug root=/dev/vda2 rootfstype=ext4 rootwait rw
EFI stub: Booting Linux Kernel...
Initializing cgroup subsys cpu
Linux version 3.17.0-rc3+ (liyi at liyi-T530) (gcc version 4.8.3 20140203 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2014.02 - Linaro GCC 2014.02) ) #12 SMP PREEMPT Sat Sep 20 03:41:08 HKT 2014
CPU: AArch64 Processor [410fd0f0] revision 0
Detected PIPT I-cache on CPU0
efi: Getting EFI parameters from FDT:
efi:   System Table: 0x00000008ffffef18
efi:   MemMap Address: 0x00000008fa7d2618
efi:   MemMap Size: 0x00000540
efi:   MemMap Desc. Size: 0x00000030
efi:   MemMap Desc. Version: 0x00000001
EFI v2.40 by ARM Fixed Virtual Platform EFI Sep  3 2014 01:10:30
efi:  SMBIOS=0xfec06000
Processing EFI memory map:
  0x000080000000-0x000080000fff [Loader Data]
  0x000080001000-0x00008007ffff [Conventional Memory]
  0x000080080000-0x000080608fff [Loader Data]
  0x000080609000-0x000087ffffff [Conventional Memory]
  0x00008c000000-0x00009fdfffff [Conventional Memory]
  0x00009fe00000-0x00009fe03fff [Loader Data]
  0x00009fe04000-0x0000fec04fff [Conventional Memory]
  0x0000fec05000-0x0000fec06fff [Runtime Data]*
  0x0000fec07000-0x0000feffffff [Boot Data]*
  0x000880000000-0x0008fa7d1fff [Conventional Memory]
  0x0008fa7d2000-0x0008fa7d2fff [Loader Data]
  0x0008fa7d3000-0x0008fae23fff [Loader Code]
  0x0008fae24000-0x0008faf1cfff [Boot Code]*
  0x0008faf1d000-0x0008fafa9fff [Runtime Data]*
  0x0008fafaa000-0x0008fe802fff [Conventional Memory]
  0x0008fe803000-0x0008fe8fbfff [Boot Data]*
  0x0008fe8fc000-0x0008fe988fff [Conventional Memory]
  0x0008fe989000-0x0008fe9adfff [Boot Data]*
  0x0008fe9ae000-0x0008fe9b9fff [Conventional Memory]
  0x0008fe9ba000-0x0008ffdddfff [Boot Data]*
  0x0008ffdde000-0x0008ffe96fff [Conventional Memory]
  0x0008ffe97000-0x0008ffe99fff [Loader Data]
  0x0008ffe9a000-0x0008fff6dfff [Boot Code]*
  0x0008fff6e000-0x0008fffaefff [Runtime Code]*
  0x0008fffaf000-0x0008ffffefff [Runtime Data]*
  0x0008fffff000-0x0008ffffffff [Boot Data]*
  0x00000c000000-0x00000ffeffff [Memory Mapped I/O]
  0x00001c170000-0x00001c170fff [Memory Mapped I/O]
On node 0 totalpages: 1028096
  DMA zone: 7168 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 503808 pages, LIFO batch:31
  Normal zone: 7168 pages used for memmap
  Normal zone: 524288 pages, LIFO batch:31
psci: probing for conduit method from DT.
psci: Using PSCI v0.1 Function IDs from DT
PERCPU: Embedded 11 pages/cpu @ffffffc87fe09000 s13504 r8192 d23360 u45056
pcpu-alloc: s13504 r8192 d23360 u45056 alloc=11*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1013760
Kernel command line: Image dtb=dtb/fvp.dtb console=ttyAMA0,38400n8 debug user_debug=31 loglevel=9 uefi_debug root=/dev/vda2 rootfstype=ext4 rootwait rw
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 28672 bytes
log_buf_len min size: 16384 bytes
log_buf_len: 65536 bytes
early log buf free: 12548(76%)
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 4013716K/4112384K available (3699K kernel code, 236K rwdata, 1312K rodata, 213K init, 182K bss, 98668K reserved)
Virtual kernel memory layout:
    vmalloc : 0xffffff8000000000 - 0xffffffbdffff0000   (   247 GB)
    vmemmap : 0xffffffbe00000000 - 0xffffffbfc0000000   (     7 GB maximum)
              0xffffffbe01c00000 - 0xffffffbe1f800000   (   476 MB actual)
    PCI I/O : 0xffffffbffa000000 - 0xffffffbffb000000   (    16 MB)
    fixed   : 0xffffffbffbdfe000 - 0xffffffbffbdff000   (     4 KB)
    modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
    memory  : 0xffffffc000000000 - 0xffffffc880000000   ( 34816 MB)
      .init : 0xffffffc000566000 - 0xffffffc00059b4c0   (   214 KB)
      .text : 0xffffffc000080000 - 0xffffffc000565db4   (  5016 KB)
      .data : 0xffffffc00059c000 - 0xffffffc0005d7360   (   237 KB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:64 nr_irqs:64 0
Architected cp15 and mmio timer(s) running at 100.00MHz (phys/phys).
sched_clock: 56 bits at 100MHz, resolution 10ns, wraps every 2748779069440ns
Console: colour dummy device 80x25
Calibrating delay loop (skipped), value calculated using timer frequency.. 200.00 BogoMIPS (lpj=1000000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 9 counters available
Remapping and enabling EFI services.
  EFI remap 0x0000fec05000 => ffffffc07ec05000
  EFI remap 0x0008faf1d000 => ffffffc87af1d000
  EFI remap 0x0008fff6e000 => ffffffc87ff6e000
  EFI remap 0x0008fffaf000 => ffffffc87ffaf000
  EFI remap 0x00000c000000 => ffffff8000080000
  EFI remap 0x00001c170000 => ffffff800001a000
SMBIOS 2.7 present.
DMI: ARM Arm Versatile Express/Arm Versatile Express, BIOS 01:09:01 Sep  3 2014
  EFI freeing: 0x0000fec07000-0x0000feffffff
  EFI freeing: 0x0008fae24000-0x0008faf1cfff
  EFI freeing: 0x0008fe803000-0x0008fe8fbfff
  EFI freeing: 0x0008fe989000-0x0008fe9adfff
  EFI freeing: 0x0008fe9ba000-0x0008ffdddfff
  EFI freeing: 0x0008ffe9a000-0x0008fff6dfff
  EFI freeing: 0x0008fffff000-0x0008ffffffff
Freed 0x1b09000 bytes of EFI boot services memory
CPU1: Booted secondary processor
Detected PIPT I-cache on CPU1
CPU2: Booted secondary processor
Detected PIPT I-cache on CPU2
CPU3: Booted secondary processor
Detected PIPT I-cache on CPU3
CPU4: Booted secondary processor
Detected PIPT I-cache on CPU4
CPU5: Booted secondary processor
Detected PIPT I-cache on CPU5
CPU6: Booted secondary processor
Detected PIPT I-cache on CPU6
CPU7: Booted secondary processor
Detected PIPT I-cache on CPU7
Brought up 8 CPUs
SMP: Total of 8 processors activated.
devtmpfs: initialized
atomic64_test: passed
regulator-dummy: no parameters
gpiochip_find_base: found new base at 254
gpiochip_add: registered GPIOs 254 to 255 on device: 1c010000.sysreg
NET: Registered protocol family 16
cpuidle: using governor ladder
cpuidle: using governor menu
vdso: 2 pages (1 code @ ffffffc0005a1000, 1 data @ ffffffc0005a0000)
hw-breakpoint: found 16 breakpoint and 16 watchpoint registers.
software IO TLB [mem 0xfe800000-0xfec00000] (4MB) mapped at [ffffffc07e800000-ffffffc07ebfffff]
Serial: AMBA PL011 UART driver
of_amba_device_create(): amba_device_add() failed (-19) for /smb/motherboard/iofpga at 3,00000000/sysctl at 020000
1c090000.uart: ttyAMA0 at MMIO 0x1c090000 (irq = 37, base_baud = 0) is a PL011 rev2
console [ttyAMA0] enabled
1c0a0000.uart: ttyAMA1 at MMIO 0x1c0a0000 (irq = 38, base_baud = 0) is a PL011 rev2
1c0b0000.uart: ttyAMA2 at MMIO 0x1c0b0000 (irq = 39, base_baud = 0) is a PL011 rev2
1c0c0000.uart: ttyAMA3 at MMIO 0x1c0c0000 (irq = 40, base_baud = 0) is a PL011 rev2
of_get_named_gpiod_flags: can't parse 'gpio' property of node '/smb/motherboard/fixedregulator at 0[0]'
3V3: 3300 mV
SCSI subsystem initialized
Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP: reno registered
UDP hash table entries: 2048 (order: 4, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 2048 (order: 5, 131072 bytes)
fuse init (API version 7.23)
msgmni has been set to 7893
io scheduler noop registered
io scheduler cfq registered (default)
gpiochip_find_base: found new base at 246
gpiochip_add: registered GPIOs 246 to 253 on device: sys_led
gpiochip_find_base: found new base at 244
gpiochip_add: registered GPIOs 244 to 245 on device: sys_mci
gpiochip_find_base: found new base at 243
gpiochip_add: registered GPIOs 243 to 243 on device: sys_flash
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
 vda: vda1 vda2
smc91x 1a000000.ethernet (unnamed net_device) (uninitialized): smc91x: IOADDR ffffff800007a000 doesn't match configuration (300).
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
smc91x 1a000000.ethernet eth0: SMC91C11xFD (rev 1) at ffffff800007a000 IRQ 47

smc91x 1a000000.ethernet eth0: Ethernet addr: 20:12:01:04:10:00
mousedev: PS/2 mouse device common for all mice
rtc-pl031 1c170000.rtc: rtc core: registered pl031 as rtc0
sp805-wdt 1c0f0000.wdt: registration successful
EFI Variables Facility v0.08 2004-May-17
TCP: cubic registered
NET: Registered protocol family 17
rtc-pl031 1c170000.rtc: setting system clock to 1970-01-01 00:00:22 UTC (22)
EXT4-fs (vda2): warning: mounting fs with errors, running e2fsck is recommended
EXT4-fs (vda2): recovery complete
EXT4-fs (vda2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 254:2.
Freeing unused kernel memory: 212K (ffffffc000566000 - ffffffc00059b000)
INIT: version 2.88 booting
Starting udev
udevd[564]: starting version 182
Starting Bootlog daemon: bootlogd.
EXT4-fs (vda2): re-mounted. Opts: (null)
random: dd urandom read with 13 bits of entropy available
Populating dev cache
Configuring network interfaces... smc91x 1a000000.ethernet eth0: link up, 10Mbps, half-duplex, lpa 0x0000
udhcpc (v1.21.1) started
Sending discover...
Sending discover...
Sending discover...
No lease, failing
Starting rpcbind daemon...rpcbind: cannot create socket for udp6
rpcbind: cannot create socket for tcp6
done.
Thu Sep 12 11:21:00 UTC 2013
INIT: Entering runlevel: 5
Starting syslogd/klogd: done
Starting auto-serial-console: done

Stopping Bootlog daemon: bootlogd.
Last login: Thu Sep 12 11:21:00 UTC 2013 on tty1
INIT: no more processes left in this runlevel
root at genericarmv8:~# ls /sys/class/dmi/id/
bios_date          board_vendor       chassis_version    subsystem/
bios_vendor        board_version      modalias           sys_vendor
bios_version       chassis_asset_tag  product_name       uevent
board_asset_tag    chassis_serial     product_serial
board_name         chassis_type       product_uuid
board_serial       chassis_vendor     product_version
root at genericarmv8:~# ls /sys/firmware/dmi/entries/
0-0/   127-0/ 17-0/  2-0/   32-0/  7-0/
1-0/   16-0/  19-0/  3-0/   4-0/   9-0/
root at genericarmv8:~# ./dmidecode-2.12/dmidecode
# dmidecode 2.12
# SMBIOS entry point at 0xfec06000
SMBIOS 2.7 present.
12 structures occupying 604 bytes.
Table at 0xFEC05000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
    Vendor: edk2.sourceforge.net
    Version: 01:09:01
    Release Date: Sep  3 2014
    Address: 0xE0000
    Runtime Size: 128 kB
    ROM Size: 8192 kB
    Characteristics:
        BIOS is upgradeable
        BIOS shadowing is allowed
        Selectable boot is supported
        ACPI is supported
        Smart battery is supported
        Function key-initiated network boot is supported
        UEFI is supported
    BIOS Revision: 0.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
    Manufacturer: ARM
    Product Name: Arm Versatile Express
    Version: 1.0
    Serial Number: System Serial#
    UUID: 25EF0280-EC82-42B0-8FB6-10ADCCC67C02
    Wake-up Type: Power Switch
    SKU Number: System SKU#
    Family: edk2

Handle 0x0002, DMI type 2, 17 bytes
Base Board Information
    Manufacturer: ARM
    Product Name: Arm Versatile Express
    Version: 1.0
    Serial Number: Base Board Serial#
    Asset Tag: Base Board Asset Tag#
    Features:
        Board is a hosting board
    Location In Chassis: Part Component
    Chassis Handle: 0x0000
    Type: Motherboard
    Contained Object Handles: 0

Handle 0x0003, DMI type 3, 24 bytes
Chassis Information
    Manufacturer: ARM
    Type: Laptop
    Lock: Not Present
    Version: 1.0
    Serial Number: Chassis Board Serial#
    Asset Tag: Chassis Board Asset Tag#
    Boot-up State: Safe
    Power Supply State: Safe
    Thermal State: Safe
    Security Status: None
    OEM Information: 0x00000000
    Height: Unspecified
    Number Of Power Cords: Unspecified
    Contained Elements: 0
    SKU Number: Not Specified

Handle 0x0004, DMI type 4, 42 bytes
Processor Information
    Socket Designation: Socket
    Type: Other
    Family: ARM
    Manufacturer: ARM
    ID: 00 00 00 00 00 00 00 00
    Version: v7
    Voltage: 5.0 V 3.3 V 2.9 V
    External Clock: Unknown
    Max Speed: Unknown
    Current Speed: Unknown
    Status: Populated, Enabled
    Upgrade: Other
    L1 Cache Handle: 0x0000
    L2 Cache Handle: 0x0000
    L3 Cache Handle: 0x0000
    Serial Number: 1.0
    Asset Tag: 1.0
    Part Number: 1.0
    Core Count: 4
    Core Enabled: 4
    Thread Count: 4
    Characteristics: None

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
    Socket Designation: Cache1
    Configuration: Enabled, Socketed, Level 3
    Operational Mode: Write Back
    Location: Internal
    Installed Size: 255 kB
    Maximum Size: 255 kB
    Supported SRAM Types:
        Burst
        Synchronous
    Installed SRAM Type: Burst Synchronous
    Speed: Unknown
    Error Correction Type: Multi-bit ECC
    System Type: Unknown
    Associativity: 2-way Set-associative

Handle 0x0006, DMI type 9, 17 bytes
System Slot Information
    Designation: SD Card
    Type: Other
    Current Usage: Available
    Length: Other
    Characteristics: Unknown
    Bus Address: 0000:00:00.0

Handle 0x0007, DMI type 16, 23 bytes
Physical Memory Array
    Location: System Board Or Motherboard
    Use: System Memory
    Error Correction Type: Unknown
    Maximum Capacity: 4095 PB
    Error Information Handle: Not Provided
    Number Of Devices: 1

Handle 0x0008, DMI type 17, 34 bytes
Memory Device
    Array Handle: 0x0000
    Error Information Handle: Not Provided
    Total Width: Unknown
    Data Width: Unknown
    Size: Unknown
    Form Factor: Unknown
    Set: Unknown
    Locator: OS Virtual Memory
    Bank Locator: malloc
    Type: DRAM
    Type Detail: Unknown
    Speed: Unknown
    Manufacturer: OSV
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified
    Rank: Unknown
    Configured Clock Speed: Unknown

Handle 0x0009, DMI type 19, 31 bytes
Memory Array Mapped Address
    Starting Address: 0x20000000000
    Ending Address: 0x2FFFFFFFFFF
    Range Size: 1 TB
    Physical Array Handle: 0x0000
    Partition Width: 1

Handle 0x000A, DMI type 32, 11 bytes
System Boot Information
    Status: No errors detected

Handle 0xFEFF, DMI type 127, 4 bytes
End Of Table

root at genericarmv8:~# ./lshw-B.02.17/src/lshw
genericarmv8
    description: Laptop
    product: FVP Base
    vendor: ARM
    version: 1.0
    serial: System Serial#
    width: 64 bits
    capabilities: smbios-2.7 dmi-2.7
    configuration: boot=normal chassis=laptop family=edk2 sku=System SKU# uuid=8002EF25-82EC-B042-8FB6-10ADCCC67C02
  *-core
       description: Motherboard
       product: Arm Versatile Express
       vendor: ARM
       physical id: 0
       version: 1.0
       serial: Base Board Serial#
       slot: Part Component
       capabilities: arm_vfp-base arm_vexpress
     *-firmware
          description: BIOS
          vendor: edk2.sourceforge.net
          physical id: 0
          version: 01:09:01
          date: Sep  3 2014
          size: 128KiB
          capacity: 8128KiB
          capabilities: upgrade shadowing bootselect acpi smartbattery netboot uefi
     *-cpu:0
          description: CPU
          product: (1.0)
          vendor: ARM
          physical id: 4
          bus info: cpu at 0
          version: v7
          serial: 1.0
          slot: Socket
          configuration: cores=4 enabledcores=4 threads=4
     *-cache
          description: L3 cache
          physical id: 5
          slot: Cache1
          size: 255KiB
          capacity: 255KiB
          capabilities: burst synchronous internal write-back
     *-memory:0
          description: System Memory
          physical id: 7
          slot: System board or motherboard
     *-memory:1 UNCLAIMED
          physical id: 1
        *-bank UNCLAIMED
             description: DRAM [empty]
             vendor: OSV
             physical id: 0
             slot: OS Virtual Memory
     *-cpu:1 DISABLED
          description: CPU
          product: cpu
          physical id: 2
          bus info: cpu at 0
     *-cpu:2 DISABLED
          description: CPU
          product: cpu
          physical id: 3
          bus info: cpu at 1
     *-cpu:3 DISABLED
          description: CPU
          product: cpu
          physical id: 6
          bus info: cpu at 2
     *-cpu:4 DISABLED
          description: CPU
          product: cpu
          physical id: 8
          bus info: cpu at 3
     *-cpu:5 DISABLED
          description: CPU
          product: cpu
          physical id: 9
          bus info: cpu at 4
     *-cpu:6 DISABLED
          description: CPU
          product: cpu
          physical id: a
          bus info: cpu at 5
     *-cpu:7 DISABLED
          description: CPU
          product: cpu
          physical id: b
          bus info: cpu at 6
     *-cpu:8 DISABLED
          description: CPU
          product: cpu
          physical id: c
          bus info: cpu at 7
     *-memory:2 UNCLAIMED
          physical id: d
     *-memory:3 UNCLAIMED
          physical id: e
  *-network
       description: Ethernet interface
       physical id: 1
       logical name: eth0
       serial: 20:12:01:04:10:00
       size: 10Mbit/s
       capacity: 100Mbit/s
       capabilities: ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=smc91x driverversion=smc91x.c: v1.1, sep 22 2004 by duplex=half link=yes multicast=yes port=MII speed=10Mbit/s
