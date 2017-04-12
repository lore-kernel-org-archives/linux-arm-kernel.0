From: denys.zagorui@globallogic.com (Denys Zagorui)
Date: Wed, 12 Apr 2017 17:53:40 +0300
Subject: Testing kexec/kdump on ls2085ardb (arm64) (Pratyush Anand)
In-Reply-To: <98f5b725-a4d4-c881-2b78-d369d6859acc@redhat.com>
References: <799fca3b-8d1c-c1d0-f3d7-e3b060f962fd@globallogic.com>
 <98f5b725-a4d4-c881-2b78-d369d6859acc@redhat.com>
Message-ID: <6c323740-902e-f0ca-2530-8d7cb97df4ef@globallogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10.04.17 11:42, Pratyush Anand wrote:
> Hi Denys,
>
> On Friday 07 April 2017 05:22 PM, Denys Zagorui wrote:
>> Hello,
>>
>> I was testing kexec/kdump on ls2085ardb using kexec-tools from:
>>
>> https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/log/?h=arm64/kdump
>>
>>
>>
>> and kernel from:
>>
>> https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git/log/?h=arm64/kdump
>>
>>
>>
>> ------------------------------------------------------------------------------------
>>
>>
>>
>> Kernel required configs:
>>
>> CONFIG_KEXEC=y
>> CONFIG_SYSFS=y
>> CONFIG_DEBUG_INFO=y
>> CONFIG_CRASH_DUMP=y
>> CONFIG_PROC_VMCORE=y
>>
>> ------------------------------------------------------------------------------------
>>
>>
>> Starting kernel ...
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 4.11.0-rc3 (denyszagorui at kbp1-ldl-f65370)
>> (gcc version 6.2.0 (GCC) ) #4 SMP PREEMPT Tue Apr 4 17:08:07 EEST 2017
>> [    0.000000] Boot CPU: AArch64 Processor [411fd071]
>> [    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0600 (options '')
>> [    0.000000] bootconsole [uart8250] enabled
>> [    0.000000] efi: Getting EFI parameters from FDT:
>> [    0.000000] efi: UEFI not found.
>> [    0.000000] crashkernel reserved: 0x00000000bfe00000 -
>> 0x00000000ffe00000 (1024 MB)
>>
>> .....
>>
>> [    0.000000] Kernel command line: console=ttyS1,115200
>> root=/dev/mmcblk0p1 rootwait earlycon=uart8250,mmio,0x21c0600,
>> ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256
>> crashkernel=1024M
>> ------------------------------------------------------------------------------------
>>
>>
>>
>> I was trying two modes: direct boot (kexec -l than kexec -e) and kdump
>> (kexec -p than echo c > /proc/sysrq-trigger).
>>
>> Direct boot:
>> ------------------------------------------------------------------------------------
>>
>>
>> root at ls2085ardb:~# kexec -l /boot/Image --initrd=/boot/initrd.cpio
>> --command-line="console=ttyS1,115200 root=/dev/ram0
>> earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices" -d
>> arch_process_options:147: command_line: console=ttyS1,115200
>> root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1
>> reset_devices
>> arch_process_options:149: initrd: /boot/initrd.cpio
>> arch_process_options:150: dtb: (null)
>> Try gzip decompression.
>> Try LZMA decompression.
>> lzma_decompress_file: read on /boot/Image of 65536 bytes failed
>> kernel: 0xffffac0f8010 kernel_size: 0xe80a00
>> get_memory_ranges_iomem_cb: 0000000080000000 - 00000000ffffffff : System
>> RAM
>> get_memory_ranges_iomem_cb: 0000008080000000 - 00000083bfffffff : System
>> RAM
>> elf_arm64_probe: Not an ELF executable.
>> image_arm64_load: kernel_segment: 0000000080000000
>> image_arm64_load: text_offset:    0000000000080000
>> image_arm64_load: image_size:     0000000000eea000
>> image_arm64_load: phys_offset:    0000000080000000
>> image_arm64_load: vp_offset:      ffffffffffffffff
>> image_arm64_load: PE format:      yes
>> .....
>> kexec_load: entry = 0x817ed660 flags = 0xb70000
>> nr_segments = 4
>> segment[0].buf   = 0xffffac0f8010
>> segment[0].bufsz = 0xe80a00
>> segment[0].mem   = 0x80080000
>> segment[0].memsz = 0xeea000
>> segment[1].buf   = 0xffffab879010
>> segment[1].bufsz = 0x87e800
>> segment[1].mem   = 0x80f6a000
>> segment[1].memsz = 0x87f000
>> segment[2].buf   = 0x377b3e80
>> segment[2].bufsz = 0x3d64
>> segment[2].mem   = 0x817e9000
>> segment[2].memsz = 0x4000
>> segment[3].buf   = 0x377b7f20
>> segment[3].bufsz = 0x31c8
>> segment[3].mem   = 0x817ed000
>> segment[3].memsz = 0x4000
>> kexec_load failed: Device or resource busy
>
> Since kexec_load failed, so no meaning of trying `kexec -e`. However,
> not sure whats going here.
>
> Can you also share dmesg (kernel console log)?
>
> Are you using spin-table cpu enable method? If yes, do you have
> cpu_die() implemented?
>
> ~Pratyush
>
>> entry       = 0x817ed660 flags = 0xb70000
>> nr_segments = 4
>> segment[0].buf   = 0xffffac0f8010
>> segment[0].bufsz = 0xe80a00
>> segment[0].mem   = 0x80080000
>> segment[0].memsz = 0xeea000
>> segment[1].buf   = 0xffffab879010
>> segment[1].bufsz = 0x87e800
>> segment[1].mem   = 0x80f6a000
>> segment[1].memsz = 0x87f000
>> segment[2].buf   = 0x377b3e80
>> segment[2].bufsz = 0x3d64
>> segment[2].mem   = 0x817e9000
>> segment[2].memsz = 0x4000
>> segment[3].buf   = 0x377b7f20
>> segment[3].bufsz = 0x31c8
>> segment[3].mem   = 0x817ed000
>> segment[3].memsz = 0x4000
>> root at ls2085ardb:~# kexec -e
>> Nothing has been loaded!
>>
>> Not working for me:
>> kexec_load failed: Device or resource busy
>>
>>
>> kdump mode:
>> ------------------------------------------------------------------------------------
>>
>>
>> root at ls2085ardb:~# kexec -p /boot/Image --initrd=/boot/initrd.cpio
>> --command-line="console=ttyS1,115200 root=/dev/ram0
>> earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices" -d
>> arch_process_options:147: command_line: console=ttyS1,115200
>> root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1
>> reset_devices
>> arch_process_options:149: initrd: /boot/initrd.cpio
>> arch_process_options:150: dtb: (null)
>> Try gzip decompression.
>> Try LZMA decompression.
>> lzma_decompress_file: read on /boot/Image of 65536 bytes failed
>> kernel: 0xffff86fa8010 kernel_size: 0xe80a00
>> get_memory_ranges_iomem_cb: 0000000080000000 - 00000000ffffffff : System
>> RAM
>> get_memory_ranges_iomem_cb: 0000008080000000 - 00000083bfffffff : System
>> RAM
>> elf_arm64_probe: Not an ELF executable.
>> image_arm64_load: kernel_segment: 00000000bfe00000
>> image_arm64_load: text_offset:    0000000000080000
>> image_arm64_load: image_size:     0000000000eea000
>> image_arm64_load: phys_offset:    0000000080000000
>> image_arm64_load: vp_offset:      ffffffffffffffff
>> image_arm64_load: PE format:      yes
>> Reserved memory range
>> 00000000bfe00000-00000000ffdfffff (0)
>> Coredump memory ranges
>> 0000000080000000-00000000bfdfffff (0)
>> 00000000ffe00000-00000000ffffffff (0)
>> 0000008080000000-00000083bfffffff (0)
>> kernel symbol _text vaddr = ffff000008080000
>> load_crashdump_segments: page_offset:   ffff800000000000
>> ...
>> kexec_load: entry = 0xc15ed660 flags = 0xb70001
>> nr_segments = 5
>> segment[0].buf   = 0xffff86fa8010
>> segment[0].bufsz = 0xe80a00
>> segment[0].mem   = 0xbfe80000
>> segment[0].memsz = 0xeea000
>> segment[1].buf   = 0xffff86729010
>> segment[1].bufsz = 0x87e800
>> segment[1].mem   = 0xc0d6a000
>> segment[1].memsz = 0x87f000
>> segment[2].buf   = 0x36959590
>> segment[2].bufsz = 0x3dc7
>> segment[2].mem   = 0xc15e9000
>> segment[2].memsz = 0x4000
>> segment[3].buf   = 0x3695d690
>> segment[3].bufsz = 0x31c8
>> segment[3].mem   = 0xc15ed000
>> segment[3].memsz = 0x4000
>> segment[4].buf   = 0x36949490
>> segment[4].bufsz = 0x400
>> segment[4].mem   = 0xffdff000
>> segment[4].memsz = 0x1000
>>
>> root at ls2085ardb:~# echo c > /proc/sysrroot at ls2085ardb:~# echo c >
>> /proc/sysrq-trigger
>>
>> [  265.274402] sysrq: SysRq : Trigger a crash
>> [  265.278588] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000
>> ...
>> [  265.750726] Starting crashdump kernel...
>> [  265.754644] Some CPUs may be stale, kdump will be unreliable.
>> [  265.760388] ------------[ cut here ]------------
>> [  265.765006] WARNING: CPU: 0 PID: 1360 at
>> arch/arm64/kernel/machine_kexec.c:158 machine_kexec+0x44/0x280
>> ...
>>
>> root at ls2085ardb:~# ls -al /proc/
>> ...
>> -r--------    1 root     root     15048032256 Mar 28 15:36 vmcore
>> -r--r--r--    1 root     root             0 Mar 28 15:36 vmstat
>> -r--r--r--    1 root     root             0 Mar 28 15:36 zoneinfo
>>
>> After that watched through /proc/vmcore using gdb. Seems to be working
>>
>> Best Regards,
>> Denys
>>

Hello, Pratyush
Thanks for your reply.

Could you describe how i can find out wich enable method used. One more 
things, i made this tests on qemu, and it works. Logs attached.

Best Regards,
Denys
-- 
Denys Zagorui
GlobalLogic
Kyiv, 03038, Protasov Business Park, N.Grinchenka, 2/1
M +38.067.317.30.93
www.globallogic.com

http://www.globallogic.com/email_disclaimer.txt
-------------- next part --------------
U-Boot 2016.092.0+g2735535 (Mar 17 2017 - 22:45:15 +0200)

SoC:  LS2085AE Rev1.0 (0x87010010)
Clock Configuration:
       CPU0(A57):1800 MHz  CPU1(A57):1800 MHz  CPU2(A57):1800 MHz  
       CPU3(A57):1800 MHz  CPU4(A57):1800 MHz  CPU5(A57):1800 MHz  
       CPU6(A57):1800 MHz  CPU7(A57):1800 MHz  
       Bus:      600  MHz  DDR:      1866.667 MT/s     DP-DDR:   1600 MT/s
Reset Configuration Word (RCW):
       00000000: 48303830 48480048 00000000 00000000
       00000010: 00000000 00200000 00200000 00000000
       00000020: 00c12980 00002580 00000000 00000000
       00000030: 00000e0b 00000000 00000000 00000000
       00000040: 00000000 00000000 00000000 00000000
       00000050: 00000000 00000000 00000000 00000000
       00000060: 00000000 00000000 00027000 00000000
       00000070: 412a0000 00000000 00000000 00000000
Model: Freescale Layerscape 2080a RDB Board
Board: LS2085AE Rev1.0-RDB, Board Arch: V1, Board version: D, boot from vBank: 0
FPGA: v1.18
SERDES1 Reference : Clock1 = 156.25MHz Clock2 = 156.25MHz
SERDES2 Reference : Clock1 = 100MHz Clock2 = 100MHz
I2C:   ready
DRAM:  Initializing DDR....using SPD
Detected UDIMM 18ASF1G72AZ-2G1A1 
Detected UDIMM 18ASF1G72AZ-2G1A1 
DP-DDR:  Detected UDIMM 18ASF1G72AZ-2G1A1 
19 GiB
DDR    15 GiB (DDR4, 64-bit, CL=13, ECC on)
       DDR Controller Interleaving Mode: 256B
       DDR Chip-Select Interleaving Mode: CS0+CS1
DP-DDR 4 GiB (DDR4, 32-bit, CL=11, ECC on)
       DDR Chip-Select Interleaving Mode: CS0+CS1
PSCI: PSCI does not exist.
Waking secondary cores to start from fff00000
All (8) cores are up.
Using SERDES1 Protocol: 42 (0x2a)
Using SERDES2 Protocol: 65 (0x41)
Flash: 128 MiB
NAND:  2048 MiB
MMC:   FSL_SDHC: 0
EEPROM: Invalid ID (ff ff ff ff)
In:    serial
Out:   serial
Err:   serial
Debug Server FW: Not a FIT image
SEC0: RNG instantiated
SATA link 0 timeout.
AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst 
Found 0 device(s).
SCSI:  Net:   PCIe0: pcie at 3400000 disabled
PCIe1: pcie at 3500000 disabled
PCIe2: pcie at 3600000 Root Complex: x1 gen1
PCIe3: pcie at 3700000 Root Complex: no link
e1000: 68:05:ca:36:9b:0d
       DPMAC1 at xgmii, DPMAC2 at xgmii
Warning: DPMAC2 at xgmii (eth1) using random MAC address - 9e:9c:cf:1d:72:65
, DPMAC3 at xgmii, DPMAC4 at xgmii
Warning: DPMAC4 at xgmii (eth3) using random MAC address - c6:c4:75:f4:50:9e
, DPMAC5 at xgmii
Warning: DPMAC5 at xgmii (eth4) using random MAC address - ce:cc:5c:8e:dc:92
, DPMAC6 at xgmii
Warning: DPMAC6 at xgmii (eth5) using random MAC address - 52:7d:51:5b:81:c7
, DPMAC7 at xgmii, DPMAC8 at xgmii
Warning: DPMAC8 at xgmii (eth7) using random MAC address - 7a:74:bd:6e:dc:1b
, e1000#0 [PRIME]
Warning: e1000#0 MAC addresses don't match:
Address in SROM is         68:05:ca:36:9b:0d
Address in environment is  68:05:ca:2e:24:ee

Hit any key to stop autoboot:  1  0 
=> printenv
baudrate=115200
bootargs=console=ttyS1,115200 root=/dev/mmcblk0p1 rootwait earlycon=uart8250,mmio,0x21c0600, crashkernel=1024M
bootcmd=tftpboot 0xa0000000 Image && tftpboot 0x90000000 Image.dtb && booti 0xa0000000 - 0x90000000
bootdelay=2
eth2addr=68:05:ca:12:6e:67
eth8addr=68:05:ca:2e:24:ee
ethact=e1000#0
ethaddr=68:05:ca:12:6e:67
ethprime=e1000#0
fdt_high=0xa0000000
fdtcontroladdr=ffcfa1b0
fileaddr=90000000
filesize=3cb7
hwconfig=fsl_ddr:bank_intlv=auto;sdhc
initrd_high=0xffffffffffffffff
ipaddr=192.168.0.2
ipaddr192.168.0.2
kernel_addr=0x100000
kernel_load=0xa0000000
kernel_size=0x2000000
kernel_start=0x581100000
loadaddr=0x80100000
mcboottimeout=100000
nand_erasesize=80000
nand_oobsize=e0
nand_writesize=1000
ramdisk_addr=0x80000000
ramdisk_size=0x2000000
rootfstype=ext2
scsidevs=0
serverip=192.168.0.1
stderr=serial
stdin=serial
stdout=serial

Environment size: 929/8188 bytes
=> run bootcmd
Using e1000#0 device
TFTP from server 192.168.0.1; our IP address is 192.168.0.2
Filename 'Image'.
Load address: 0xa0000000
Loading: *#################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ##############################################
	 1.7 MiB/s
done
Bytes transferred = 15206912 (e80a00 hex)
Using e1000#0 device
TFTP from server 192.168.0.1; our IP address is 192.168.0.2
Filename 'Image.dtb'.
Load address: 0x90000000
Loading: *###
	 299.8 KiB/s
done
Bytes transferred = 14755 (39a3 hex)
## Flattened Device Tree blob at 90000000
   Booting using the fdt blob at 0x90000000
   reserving fdt memory region: addr=80000000 size=10000
   Loading Device Tree to 000000009fff9000, end 000000009ffff9a2 ... OK
WARNING: fdt_fixup_stdout: could not read serial1 alias: FDT_ERR_NOTFOUND

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc3 (denyszagorui at kbp1-ldl-f65370) (gcc version 6.2.0 (GCC) ) #3 SMP PREEMPT Mon Apr 10 16:59:25 EEST 2017
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0600 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] crashkernel reserved: 0x00000000bfe00000 - 0x00000000ffe00000 (1024 MB)
[    0.000000] cma: Reserved 16 MiB at 0x00000000bec00000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000083bfffffff]
[    0.000000] NUMA: Adding memblock [0x80000000 - 0xffffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x8080000000 - 0x83bfffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x80000000-0x83bfffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x83bfdde000-0x83bfddfaff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000083bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000008080000000-0x00000083bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000083bfffffff]
[    0.000000] WARNING: x1-x3 nonzero in violation of boot protocol:
[    0.000000] 	x1: 0000000000000000
[    0.000000] 	x2: 0000000000000000
[    0.000000] 	x3: 0000000080080000
[    0.000000] This indicates a broken bootloader or old kernel
[    0.000000] percpu: Embedded 23 pages/cpu @ffff80833fd21000 s56856 r8192 d29160 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 832075
[    0.000000] CPU features: enabling workaround for ARM erratum 834220
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 3870720
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyS1,115200 root=/dev/mmcblk0p1 rootwait earlycon=uart8250,mmio,0x21c0600, crashkernel=1024M
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] software IO TLB [mem 0xbac00000-0xbec00000] (64MB) mapped at [ffff80003ac00000-ffff80003ebfffff]
[    0.000000] Memory: 14333632K/15728640K available (8828K kernel code, 962K rwdata, 3944K rodata, 1088K init, 394K bss, 1378624K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008920000   (  8832 KB)
[    0.000000]     .rodata : 0xffff000008920000 - 0xffff000008d00000   (  3968 KB)
[    0.000000]       .init : 0xffff000008d00000 - 0xffff000008e10000   (  1088 KB)
[    0.000000]       .data : 0xffff000008e10000 - 0xffff000008f00a00   (   963 KB)
[    0.000000]        .bss : 0xffff000008f00a00 - 0xffff000008f6332c   (   395 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e020d000000   (  8400 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff808340000000   (537600 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] ITS [mem 0x06020000-0x0603ffff]
[    0.000000] ITS at 0x0000000006020000: allocated 8192 Devices @83b0430000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GIC: using LPI property table @0x00000083b0440000
[    0.000000] ITS: Allocated 1792 chunks for LPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000006100000
[    0.000000] CPU0: using LPI pending table @0x00000083b0450000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] arm_arch_timer: arch_timer: Enabling workaround for fsl,erratum-a008585
[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ2, assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware
[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3, assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[    0.000002] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 4398046511100ns
[    0.008136] Console: colour dummy device 80x25
[    0.012636] Calibrating delay loop (skipped), value calculated using timer frequency.. 50.00 BogoMIPS (lpj=100000)
[    0.023075] pid_max: default: 32768 minimum: 301
[    0.027761] Security Framework initialized
[    0.033480] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.046496] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.056157] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.063122] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.082525] ASID allocator initialised with 65536 entries
[    0.108006] PCI/MSI: /interrupt-controller at 6000000/gic-its at 6020000 domain created
[    0.115597] Platform MSI: /interrupt-controller at 6000000/gic-its at 6020000 domain created
[    0.123728] EFI services will not be available.
[    0.144311] smp: Bringing up secondary CPUs ...
[    1.193289] CPU1: failed to come online
[    1.197148] CPU1: failed in unknown state : 0x0
[    2.254127] CPU2: failed to come online
[    2.257984] CPU2: failed in unknown state : 0x0
[    3.314962] CPU3: failed to come online
[    3.318820] CPU3: failed in unknown state : 0x0
[    4.375804] CPU4: failed to come online
[    4.379662] CPU4: failed in unknown state : 0x0
[    5.436645] CPU5: failed to come online
[    5.440505] CPU5: failed in unknown state : 0x0
[    6.497488] CPU6: failed to come online
[    6.501345] CPU6: failed in unknown state : 0x0
[    7.558326] CPU7: failed to come online
[    7.562185] CPU7: failed in unknown state : 0x0
[    7.566768] smp: Brought up 1 node, 1 CPU
[    7.570805] SMP: Total of 1 processors activated.
[    7.575543] CPU features: detected feature: GIC system register CPU interface
[    7.582732] CPU features: detected feature: 32-bit EL0 Support
[    7.588629] CPU: All CPU(s) started at EL2
[    7.592760] alternatives: patching kernel code
[    7.604593] devtmpfs: initialized
[    7.612222] DMI not present or invalid.
[    7.616263] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    7.626161] futex hash table entries: 2048 (order: 6, 262144 bytes)
[    7.632737] pinctrl core: initialized pinctrl subsystem
[    7.638904] NET: Registered protocol family 16
[    7.647431] cpuidle: using governor menu
[    7.652708] arm-smmu: deprecated "mmu-masters" DT property in use; DMA API support unavailable
[    7.661853] arm-smmu 5000000.iommu: probing hardware configuration...
[    7.668362] arm-smmu 5000000.iommu: SMMUv2 with:
[    7.673049] arm-smmu 5000000.iommu: 	stage 1 translation
[    7.678407] arm-smmu 5000000.iommu: 	stage 2 translation
[    7.683765] arm-smmu 5000000.iommu: 	nested translation
[    7.689031] arm-smmu 5000000.iommu: 	non-coherent table walk
[    7.694735] arm-smmu 5000000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    7.702106] arm-smmu 5000000.iommu: 	stream matching with 128 register groups
[    7.709299] arm-smmu 5000000.iommu: 	64 context banks (0 stage-2 only)
[    7.715879] arm-smmu 5000000.iommu: 	Supported page sizes: 0x61311000
[    7.722372] arm-smmu 5000000.iommu: 	Stage-1: 48-bit VA -> 48-bit IPA
[    7.728867] arm-smmu 5000000.iommu: 	Stage-2: 48-bit IPA -> 48-bit PA
[    7.735636] vdso: 2 pages (1 code @ ffff000008927000, 1 data @ ffff000008e15000)
[    7.743125] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    7.750436] DMA: preallocated 256 KiB pool for atomic allocations
[    7.756897] Serial: AMBA PL011 UART driver
[    7.763438] irq: type mismatch, failed to map hwirq-29 for /interrupt-controller at 6000000!
[    7.788354] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    7.810919] ACPI: Interpreter disabled.
[    7.815392] vgaarb: loaded
[    7.818479] SCSI subsystem initialized
[    7.826517] usbcore: registered new interface driver usbfs
[    7.832349] usbcore: registered new interface driver hub
[    7.837823] usbcore: registered new device driver usb
[    7.843198] imx-i2c 2000000.i2c: can't get pinctrl, bus recovery not supported
[    7.850695] i2c i2c-0: IMX I2C adapter registered
[    7.855480] i2c i2c-0: can't use DMA, using PIO instead.
[    7.860955] pps_core: LinuxPPS API ver. 1 registered
[    7.866032] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    7.875279] PTP clock support registered
[    7.879379] dmi: Firmware registration failed.
[    7.884014] Advanced Linux Sound Architecture Driver Initialized.
[    7.890559] clocksource: Switched to clocksource arch_sys_counter
[    7.896908] VFS: Disk quotas dquot_6.6.0
[    7.900916] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    7.907992] pnp: PnP ACPI: disabled
[    7.915378] NET: Registered protocol family 2
[    7.921422] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    7.929317] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    7.936726] TCP: Hash tables configured (established 131072 bind 65536)
[    7.943542] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    7.949841] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    7.956589] NET: Registered protocol family 1
[    7.969216] RPC: Registered named UNIX socket transport module.
[    7.975201] RPC: Registered udp transport module.
[    7.979944] RPC: Registered tcp transport module.
[    7.984682] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.991392] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
[    7.999325] kvm [1]: 8-bit VMID
[    8.002485] kvm [1]: IDMAP page: 8090f000
[    8.006579] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    8.012716] kvm [1]: Hyp mode initialized successfully
[    8.017919] kvm [1]: vgic-v2 at c0e0000
[    8.021545] kvm [1]: GIC system register CPU interface enabled
[    8.027455] kvm [1]: vgic interrupt IRQ1
[    8.031413] kvm [1]: Invalid trigger for IRQ4, assuming level low
[    8.037559] kvm [1]: virtual timer IRQ4
[    8.042527] audit: initializing netlink subsys (disabled)
[    8.048624] audit: type=2000 audit(7.872:1): state=initialized audit_enabled=0 res=1
[    8.060619] workingset: timestamp_bits=44 max_order=22 bucket_order=0
[    8.072374] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    8.083121] NFS: Registering the id_resolver key type
[    8.088298] Key type id_resolver registered
[    8.092521] Key type id_legacy registered
[    8.096570] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    8.103426] 9p: Installing v9fs 9p2000 file system support
[    8.110046] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    8.117567] io scheduler noop registered
[    8.121638] io scheduler cfq registered (default)
[    8.126459] io scheduler mq-deadline registered
[    8.133046] OF: PCI: host bridge /pcie at 3600000 ranges:
[    8.139102] OF: PCI:    IO 0x1400010000..0x140001ffff -> 0x00000000
[    8.145441] OF: PCI:   MEM 0x1440000000..0x147fffffff -> 0x40000000
[    8.152010] layerscape-pcie 3600000.pcie: PCI host bridge to bus 0000:00
[    8.158810] pci_bus 0000:00: root bus resource [bus 00-ff]
[    8.164371] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    8.170613] pci_bus 0000:00: root bus resource [mem 0x1440000000-0x147fffffff] (bus address [0x40000000-0x7fffffff])
[    8.181409] pci 0000:00:00.0: bridge configuration invalid ([bus 03-03]), reconfiguring
[    8.202639] pci 0000:00:00.0: BAR 1: assigned [mem 0x1440000000-0x1443ffffff]
[    8.209843] pci 0000:00:00.0: BAR 0: assigned [mem 0x1444000000-0x1444ffffff]
[    8.217047] pci 0000:00:00.0: BAR 6: assigned [mem 0x1445000000-0x1445ffffff pref]
[    8.224681] pci 0000:00:00.0: BAR 14: assigned [mem 0x1446000000-0x14460fffff]
[    8.231961] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    8.238192] pci 0000:01:00.0: BAR 1: assigned [mem 0x1446000000-0x144607ffff]
[    8.245401] pci 0000:01:00.0: BAR 6: assigned [mem 0x1446080000-0x14460bffff pref]
[    8.253033] pci 0000:01:00.0: BAR 0: assigned [mem 0x14460c0000-0x14460dffff]
[    8.260244] pci 0000:01:00.0: BAR 3: assigned [mem 0x14460e0000-0x14460e3fff]
[    8.267456] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    8.273629] pci 0000:00:00.0: PCI bridge to [bus 01]
[    8.278634] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    8.284777] pci 0000:00:00.0:   bridge window [mem 0x1446000000-0x14460fffff]
[    8.292413] pcieport 0000:00:00.0: Signaling PME with IRQ 100
[    8.298318] pcieport 0000:00:00.0: AER enabled with IRQ 101
[    8.304035] OF: PCI: host bridge /pcie at 3700000 ranges:
[    8.309250] OF: PCI:    IO 0x1600010000..0x160001ffff -> 0x00000000
[    8.315579] OF: PCI:   MEM 0x1640000000..0x167fffffff -> 0x40000000
[    8.321973] layerscape-pcie 3700000.pcie: PCI host bridge to bus 0001:00
[    8.328758] pci_bus 0001:00: root bus resource [bus 00-ff]
[    8.334297] pci_bus 0001:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    8.343338] pci_bus 0001:00: root bus resource [mem 0x1640000000-0x167fffffff] (bus address [0x40000000-0x7fffffff])
[    8.354100] pci 0001:00:00.0: bridge configuration invalid ([bus 05-05]), reconfiguring
[    8.362261] pci 0001:00:00.0: BAR 6: assigned [mem 0x1640000000-0x16400007ff pref]
[    8.369923] pci 0001:00:00.0: PCI bridge to [bus 01]
[    8.375064] pcieport 0001:00:00.0: Signaling PME with IRQ 103
[    8.380941] pcieport 0001:00:00.0: AER enabled with IRQ 103
[    8.388638] xenfs: not registering filesystem on non-xen platform
[    8.397478] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.405486] 21c0500.serial: ttyS0 at MMIO 0x21c0500 (irq = 84, base_baud = 18750000) is a 16550A
[    8.415044] 21c0600.serial: ttyS1 at MMIO 0x21c0600 (irq = 84, base_baud = 18750000) is a 16550A
[    8.424153] console [ttyS1] enabled
[    8.424153] console [ttyS1] enabled
[    8.431218] bootconsole [uart8250] disabled
[    8.431218] bootconsole [uart8250] disabled
[    8.439850] SuperH (H)SCI(F) driver initialized
[    8.444599] msm_serial: driver initialized
[    8.448945] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    8.490419] loop: module loaded
[    8.494089] hisi_sas: driver version v1.6
[    8.498888] ahci-qoriq 3200000.sata: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    8.508006] ahci-qoriq 3200000.sata: flags: 64bit ncq sntf pm clo only pmp fbs pio slum part ccc sds apst 
[    8.522182] scsi host0: ahci-qoriq
[    8.525720] ata1: SATA max UDMA/133 mmio [mem 0x03200000-0x0320ffff] port 0x100 irq 94
[    8.533773] ahci-qoriq 3210000.sata: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    8.542757] ahci-qoriq 3210000.sata: flags: 64bit ncq sntf pm clo only pmp fbs pio slum part ccc sds apst 
[    8.556787] scsi host1: ahci-qoriq
[    8.560297] ata2: SATA max UDMA/133 mmio [mem 0x03210000-0x0321ffff] port 0x100 irq 95
[    8.568938] libphy: Fixed MDIO Bus: probed
[    8.573180] tun: Universal TUN/TAP device driver, 1.6
[    8.579143] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    8.585720] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    8.592053] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    8.659031] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): registered PHC clock
[    8.728565] e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 68:05:ca:36:9b:0d
[    8.736550] e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    8.743451] e1000e 0000:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: E46981-008
[    8.750203] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    8.757213] igb: Copyright (c) 2007-2014 Intel Corporation.
[    8.762831] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    8.770690] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    8.776653] sky2: driver version 1.30
[    8.780635] VFIO - User Level meta-driver version: 0.3
[    8.790976] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.797765] ehci-pci: EHCI PCI platform driver
[    8.802263] ehci-platform: EHCI generic platform driver
[    8.807588] ehci-exynos: EHCI EXYNOS driver
[    8.811878] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    8.817523] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.823748] ohci-pci: OHCI PCI platform driver
[    8.828230] ohci-platform: OHCI generic platform driver
[    8.833526] ohci-exynos: OHCI EXYNOS driver
[    8.837860] xhci-hcd: probe of xhci-hcd.0.auto failed with error -5
[    8.844185] xhci-hcd: probe of xhci-hcd.1.auto failed with error -5
[    8.850582] usbcore: registered new interface driver usb-storage
[    8.857578] i2c /dev entries driver
[    8.861672] ata1: SATA link down (SStatus 0 SControl 300)
[    8.867982] i2c i2c-0: Added multiplexed i2c bus 1
[    8.882939] ata2: SATA link down (SStatus 0 SControl 300)
[    9.478585] rtc-ds3232: probe of 2-0068 failed with error -110
[    9.484442] i2c i2c-0: Added multiplexed i2c bus 2
[    9.489365] i2c i2c-0: Added multiplexed i2c bus 3
[    9.494358] i2c i2c-0: Added multiplexed i2c bus 4
[    9.499300] i2c i2c-0: Added multiplexed i2c bus 5
[    9.504226] i2c i2c-0: Added multiplexed i2c bus 6
[    9.509165] i2c i2c-0: Added multiplexed i2c bus 7
[    9.514093] i2c i2c-0: Added multiplexed i2c bus 8
[    9.518931] pca954x 0-0075: registered 8 multiplexed busses for I2C mux pca9547
[    9.527098] sdhci: Secure Digital Host Controller Interface driver
[    9.533581] sdhci: Copyright(c) Pierre Ossman
[    9.538095] Synopsys Designware Multimedia Card Interface Driver
[    9.544441] sdhci-pltfm: SDHCI platform and OF driver helper
[    9.594578] mmc0: SDHCI controller on 2140000.esdhc [2140000.esdhc] using ADMA 64-bit
[    9.604688] ledtrig-cpu: registered to indicate activity on CPUs
[    9.617410] usbcore: registered new interface driver usbhid
[    9.625263] usbhid: USB HID core driver
[    9.638384] NET: Registered protocol family 17
[    9.646071] 9pnet: Installing 9P2000 support
[    9.650447] Key type dns_resolver registered
[    9.655082] registered taskstats version 1
[    9.663910] hctosys: unable to open rtc device (rtc0)
[    9.669053] ALSA device list:
[    9.672050]   No soundcards found.
[    9.675590] Waiting for root device /dev/mmcblk0p1...
[    9.814747] mmc0: new high speed SD card at address aaaa
[    9.824285] mmcblk0: mmc0:aaaa SU02G 1.84 GiB 
[    9.836697]  mmcblk0: p1
[    9.855431] EXT4-fs (mmcblk0p1): mounting ext3 file system using the ext4 subsystem
[    9.864294] EXT4-fs (mmcblk0p1): INFO: recovery required on readonly filesystem
[    9.871634] EXT4-fs (mmcblk0p1): write access will be enabled during recovery
[    9.924628] random: fast init done
[   10.005685] EXT4-fs (mmcblk0p1): recovery complete
[   10.019881] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[   10.027999] VFS: Mounted root (ext3 filesystem) readonly on device 179:1.
[   10.044449] devtmpfs: mounted
[   10.047787] Freeing unused kernel memory: 1088K
INIT: version 2.88 booting
Starting udev
udev: Not using udev cache because of changes detected in the following files:
udev:     /proc/version /proc/cmdline /proc/devices
udev:     lib/udev/rules.d/* etc/udev/rules.d/*
udev: The udev cache will be regenerated. To identify the detected changes,
udev: compare the cached sysconf at   /etc/udev/cache.data
udev: against the current sysconf at  /dev/shm/udev.cache
[   10.355338] udevd[1215]: starting version 3.2
[   10.392282] udevd[1216]: starting eudev-3.2
[   10.603706] EXT4-fs (mmcblk0p1): re-mounted. Opts: data=ordered
Populating dev cache
hwclock: can't open '/dev/misc/rtc': No such file or directory
Wed Apr  5 11:28:11 UTC 2017
INIT: Entering runlevel: 5
Configuring network interfaces... done.
hwclock: can't open '/dev/misc/rtc': No such file or directory
Starting syslogd/klogd: done
No makedumpfile found.

OpenEmbedded nodistro.0 ls2085ardb /dev/ttyS1

ls2085ardb login: root
root at ls2085ardb:~# uname a-a
Linux ls2085ardb 4.11.0-rc3 #3 SMP PREEMPT Mon Apr 10 16:59:25 EEST 2017 aarch64 GNU/Linux
root at ls2085ardb:~# kexec -l /boot/Image --initrd=/boot/initrd.cpio --command-line="console=ttyS1,115200 root=/dev/ram0 ea
rlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices" -d
arch_process_options:147: command_line: console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices
arch_process_options:149: initrd: /boot/initrd.cpio
arch_process_options:150: dtb: (null)
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /boot/Image of 65536 bytes failed
kernel: 0xffff8eff6010 kernel_size: 0xe80a00
get_memory_ranges_iomem_cb: 0000000080000000 - 00000000ffffffff : System RAM
get_memory_ranges_iomem_cb: 0000008080000000 - 00000083bfffffff : System RAM
elf_arm64_probe: Not an ELF executable.
image_arm64_load: kernel_segment: 0000000080000000
image_arm64_load: text_offset:    0000000000080000
image_arm64_load: image_size:     0000000000eea000
image_arm64_load: phys_offset:    0000000080000000
image_arm64_load: vp_offset:      ffffffffffffffff
image_arm64_load: PE format:      yes
read_1st_dtb: found /sys/firmware/fdt
dump_reservemap: dtb_sys {80000000, 10000}
dump_reservemap: dtb_sys {fff01f10, 678}
dump_reservemap: dtb_sys {9fff9000, 4000}
initrd: base 80f6a000, size b34000h (11747328)
dtb_set_initrd: start 2163646464, end 2175393792, size 11747328 (11472 KiB)
dtb:    base 81a9e000, size 3d64h (15716)
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa20f8 addr: 81aa2010
machine_apply_elf_rel: ADR_PREL_PG_HI21 a9025bf590000013->a9025bf590000013
sym: sha256_starts info: 12 other: 00 shndx: 1 value: ea0 size: 58
sym: sha256_starts value: 81aa2ea0 addr: 81aa2018
machine_apply_elf_rel: CALL26 f940027594000000->f9400275940003a2
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa20f8 addr: 81aa201c
machine_apply_elf_rel: LDST64_ABS_LO12_NC f94006a2f9400275->f94006a2f9407e75
sym: sha256_update info: 12 other: 00 shndx: 1 value: 2e10 size: c
sym: sha256_update value: 81aa4e10 addr: 81aa202c
machine_apply_elf_rel: CALL26 f940027494000000->f940027494000b79
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa20f8 addr: 81aa2030
machine_apply_elf_rel: LDST64_ABS_LO12_NC 91040294f9400274->91040294f9407e74
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 2e20 size: 1c0
sym: sha256_finish value: 81aa4e20 addr: 81aa204c
machine_apply_elf_rel: CALL26 aa1403e194000000->aa1403e194000b75
sym:     memcmp info: 12 other: 00 shndx: 1 value: 62c size: 34
sym: memcmp value: 81aa262c addr: 81aa205c
machine_apply_elf_rel: CALL26 3400044094000000->3400044094000174
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2100 addr: 81aa2064
machine_apply_elf_rel: ADR_PREL_PG_HI21 d280001490000000->d280001490000000
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2100 addr: 81aa206c
machine_apply_elf_rel: LDST64_ABS_LO12_NC 94000000f9400000->94000000f9408000
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa2070
machine_apply_elf_rel: CALL26 9000000094000000->9000000094000137
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2108 addr: 81aa2074
machine_apply_elf_rel: ADR_PREL_PG_HI21 f940000090000000->f940000090000000
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2108 addr: 81aa2078
machine_apply_elf_rel: LDST64_ABS_LO12_NC 94000000f9400000->94000000f9408400
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa207c
machine_apply_elf_rel: CALL26 9000000094000000->9000000094000134
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2110 addr: 81aa2080
machine_apply_elf_rel: ADR_PREL_PG_HI21 f940001690000000->f940001690000000
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2110 addr: 81aa2084
machine_apply_elf_rel: LDST64_ABS_LO12_NC 38746aa1f9400016->38746aa1f9408816
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa2094
machine_apply_elf_rel: CALL26 f100829f94000000->f100829f9400012e
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2118 addr: 81aa20a0
machine_apply_elf_rel: ADR_PREL_PG_HI21 d280001590000014->d280001590000014
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2118 addr: 81aa20a8
machine_apply_elf_rel: LDST64_ABS_LO12_NC 94000000f9400280->94000000f9408e80
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa20ac
machine_apply_elf_rel: CALL26 9000000094000000->9000000094000128
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2120 addr: 81aa20b0
machine_apply_elf_rel: ADR_PREL_PG_HI21 f940000090000000->f940000090000000
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2120 addr: 81aa20b4
machine_apply_elf_rel: LDST64_ABS_LO12_NC 94000000f9400000->94000000f9409000
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa20b8
machine_apply_elf_rel: CALL26 f940027394000000->f940027394000125
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa20f8 addr: 81aa20bc
machine_apply_elf_rel: LDST64_ABS_LO12_NC 91040273f9400273->91040273f9407e73
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa20d0
machine_apply_elf_rel: CALL26 f10082bf94000000->f10082bf9400011f
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2118 addr: 81aa20dc
machine_apply_elf_rel: LDST64_ABS_LO12_NC 94000000f9400280->94000000f9408e80
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa20e0
machine_apply_elf_rel: CALL26 5280002094000000->528000209400011b
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 81aa5058 addr: 81aa20f8
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa5058
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 81aa4fe8 addr: 81aa2100
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa4fe8
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 81aa5008 addr: 81aa2108
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa5008
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 81aa5018 addr: 81aa2110
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa5018
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 81aa501e addr: 81aa2118
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa501e
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 81aa5020 addr: 81aa2120
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa5020
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2158 addr: 81aa2128
machine_apply_elf_rel: ADR_PREL_PG_HI21 a9bf7bfd90000000->a9bf7bfd90000000
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa2158 addr: 81aa2134
machine_apply_elf_rel: LDST64_ABS_LO12_NC 94000000f9400000->94000000f940ac00
sym:     printf info: 12 other: 00 shndx: 1 value: 54c size: 80
sym: printf value: 81aa254c addr: 81aa2138
machine_apply_elf_rel: CALL26 9400000094000000->9400000094000105
sym: setup_arch info: 12 other: 00 shndx: 1 value: e98 size: 4
sym: setup_arch value: 81aa2e98 addr: 81aa213c
machine_apply_elf_rel: CALL26 9400000094000000->9400000094000357
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: f8
sym: verify_sha256_digest value: 81aa2000 addr: 81aa2140
machine_apply_elf_rel: CALL26 3400004094000000->3400004097ffffb0
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: e94 size: 4
sym: post_verification_setup_arch value: 81aa2e94 addr: 81aa2150
machine_apply_elf_rel: JUMP26 d503201f14000000->d503201f14000351
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 81aa5030 addr: 81aa2158
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa5030
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa24d0 addr: 81aa2190
machine_apply_elf_rel: ADR_PREL_PG_HI21 b940185390000018->b940185390000018
sym:    putchar info: 12 other: 00 shndx: 1 value: e90 size: 4
sym: putchar value: 81aa2e90 addr: 81aa21ec
machine_apply_elf_rel: CALL26 2a1303e194000000->2a1303e194000329
sym:    putchar info: 12 other: 00 shndx: 1 value: e90 size: 4
sym: putchar value: 81aa2e90 addr: 81aa2260
machine_apply_elf_rel: CALL26 b9406ba194000000->b9406ba19400030c
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa24d0 addr: 81aa22ac
machine_apply_elf_rel: LDST64_ABS_LO12_NC 2a0203f3f9400306->2a0203f3f9426b06
sym:    putchar info: 12 other: 00 shndx: 1 value: e90 size: 4
sym: putchar value: 81aa2e90 addr: 81aa24c0
machine_apply_elf_rel: CALL26 f94037a194000000->f94037a194000274
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 81aa5042 addr: 81aa24d0
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa5042
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 160 size: 36c
sym: vsprintf value: 81aa2160 addr: 81aa2540
machine_apply_elf_rel: CALL26 a8d07bfd94000000->a8d07bfd97ffff08
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 160 size: 36c
sym: vsprintf value: 81aa2160 addr: 81aa25c0
machine_apply_elf_rel: CALL26 a8d17bfd94000000->a8d17bfd97fffee8
sym:  purgatory info: 12 other: 00 shndx: 1 value: 128 size: 2c
sym: purgatory value: 81aa2128 addr: 81aa2668
machine_apply_elf_rel: CALL26 5800001194000000->5800001197fffeb0
sym: arm64_kernel_entry info: 10 other: 00 shndx: 4 value: 120 size: 8
sym: arm64_kernel_entry value: 81aa5178 addr: 81aa266c
machine_apply_elf_rel: LD_PREL_LO19 5800000058000011->5800000058015871
sym: arm64_dtb_addr info: 10 other: 00 shndx: 4 value: 128 size: 8
sym: arm64_dtb_addr value: 81aa5180 addr: 81aa2670
machine_apply_elf_rel: LD_PREL_LO19 aa1f03e158000000->aa1f03e158015880
sym: sha256_process info: 12 other: 00 shndx: 1 value: ef8 size: 1e00
sym: sha256_process value: 81aa2ef8 addr: 81aa4d7c
machine_apply_elf_rel: CALL26 eb15027f94000000->eb15027f97fff85f
sym:     memcpy info: 12 other: 00 shndx: 1 value: 60c size: 20
sym: memcpy value: 81aa260c addr: 81aa4ddc
machine_apply_elf_rel: JUMP26 9100c29314000000->9100c29317fff60c
sym:     memcpy info: 12 other: 00 shndx: 1 value: 60c size: 20
sym: memcpy value: 81aa260c addr: 81aa4df8
machine_apply_elf_rel: CALL26 aa1303e194000000->aa1303e197fff605
sym: sha256_process info: 12 other: 00 shndx: 1 v[   60.561873] any_cpu = 0, cpu_ops[any_cpu]->cpu_die =           (null)
alue: ef8 size: [   60.561877] Can't kexec: CPUs are stuck in the kernel.
1e00
sym: sha256_process value: 81aa2ef8 addr: 81aa4e04
machine_apply_elf_rel: CALL26 17ffffd394000000->17ffffd397fff83d
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa4fe0 addr: 81aa4e24
machine_apply_elf_rel: ADR_PREL_PG_HI21 5280070690000005->5280070690000005
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 81aa4fe0 addr: 81aa4e3c
machine_apply_elf_rel: LDST64_ABS_LO12_NC aa0003f3f94000a1->aa0003f3f947f0a1
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 81aa5188 addr: 81aa4fe0
machine_apply_elf_rel: ABS64 0000000000000000->0000000081aa5188
kexec_load: entry = 0x81aa2660 flags = 0xb70000
nr_segments = 4
segment[0].buf   = 0xffff8eff6010
segment[0].bufsz = 0xe80a00
segment[0].mem   = 0x80080000
segment[0].memsz = 0xeea000
segment[1].buf   = 0xffff8e4c1010
segment[1].bufsz = 0xb34000
segment[1].mem   = 0x80f6a000
segment[1].memsz = 0xb34000
segment[2].buf   = 0x2c5bde80
segment[2].bufsz = 0x3d64
segment[2].mem   = 0x81a9e000
segment[2].memsz = 0x4000
segment[3].buf   = 0x2c5c1f20
segment[3].bufsz = 0x31c8
segment[3].mem   = 0x81aa2000
segment[3].memsz = 0x4000
kexec_load failed: Device or resource busy
entry       = 0x81aa2660 flags = 0xb70000
nr_segments = 4
segment[0].buf   = 0xffff8eff6010
segment[0].bufsz = 0xe80a00
segment[0].mem   = 0x80080000
segment[0].memsz = 0xeea000
segment[1].buf   = 0xffff8e4c1010
segment[1].bufsz = 0xb34000
segment[1].mem   = 0x80f6a000
segment[1].memsz = 0xb34000
segment[2].buf   = 0x2c5bde80
segment[2].bufsz = 0x3d64
segment[2].mem   = 0x81a9e000
segment[2].memsz = 0x4000
segment[3].buf   = 0x2c5c1f20
segment[3].bufsz = 0x31c8
segment[3].mem   = 0x81aa2000
segment[3].memsz = 0x4000
root at ls2085ardb:~# dmesg | tail -10
[    9.924628] random: fast init done
[   10.005685] EXT4-fs (mmcblk0p1): recovery complete
[   10.019881] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[   10.027999] VFS: Mounted root (ext3 filesystem) readonly on device 179:1.
[   10.044449] devtmpfs: mounted
[   10.047787] Freeing unused kernel memory: 1088K
[   10.355338] udevd[1215]: starting version 3.2
[   10.392282] udevd[1216]: starting eudev-3.2
[   10.603706] EXT4-fs (mmcblk0p1): re-mounted. Opts: data=ordered
[   60.561877] Can't kexec: CPUs are stuck in the kernel.
root at ls2085ardb:~# 
-------------- next part --------------
denyszagorui at kbp1-ldl-f65370:~$/home/denyszagorui/ls2085ardb-yocto/build/tmp-glibc/sysroots/x86_64-linux/usr/bin/qemu-system-aarch64 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device virtio-net-device,netdev=net0,mac=52:54:00:12:34:02  -machine virt -cpu cortex-a57 -m 2048 -drive id=disk0,file=/home/denyszagorui/ls2085ardb-yocto/build/tmp-glibc/deploy/images/qemuarm64/core-image-minimal-qemuarm64.ext4,if=none,format=raw -device virtio-blk-device,drive=disk0 -show-cursor -device virtio-rng-pci -monitor null -serial stdio -smp 4 -kernel /home/denyszagorui/ls2085ardb-yocto/build/tmp-glibc/deploy/images/qemuarm64/Image -append 'root=/dev/vda rw highres=off  mem=2048M ip=192.168.7.2::192.168.7.1:255.255.255.0 console=ttyAMA0,38400 console=ttyS0 crashkernel=1024M'


[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc3 (denyszagorui at kbp1-ldl-f65370) (gcc version 6.2.0 (GCC) ) #9 SMP Mon Apr 10 19:15:40 EEST 2017
[    0.000000] Boot CPU: AArch64 Processor [411fd070]
[    0.000000] Memory limited to 2048MB
[    0.000000] crashkernel reserved: 0x000000007fe00000 - 0x00000000bfe00000 (1024 MB)
[    0.000000] cma: Reserved 16 MiB at 0x000000007ec00000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] percpu: Embedded 23 pages/cpu @ffff80003fd8a000 s56344 r8192 d29672 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 832075
[    0.000000] CPU features: enabling workaround for ARM erratum 834220
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 516096
[    0.000000] Kernel command line: root=/dev/vda rw highres=off  mem=2048M ip=192.168.7.2::192.168.7.1:255.255.255.0 console=ttyAMA0,38400 console=ttyS0 crashkernel=1024M
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 14660(89%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Memory: 978544K/2097152K available (8894K kernel code, 962K rwdata, 3924K rodata, 1024K init, 299K bss, 1102224K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008930000   (  8896 KB)
[    0.000000]     .rodata : 0xffff000008930000 - 0xffff000008d10000   (  3968 KB)
[    0.000000]       .init : 0xffff000008d10000 - 0xffff000008e10000   (  1024 KB)
[    0.000000]       .data : 0xffff000008e10000 - 0xffff000008f00808   (   963 KB)
[    0.000000]        .bss : 0xffff000008f00808 - 0xffff000008f4b6c4   (   300 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0002000000   (    32 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800080000000   (  2048 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3, assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 62.50MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
[    0.000112] sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
[    0.002818] Console: colour dummy device 80x25
[    0.005384] Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=250000)
[    0.005502] pid_max: default: 32768 minimum: 301
[    0.006112] Security Framework initialized
[    0.006530] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.006559] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.030713] ASID allocator initialised with 65536 entries
[    0.039725] smp: Bringing up secondary CPUs ...
[    0.042155] Detected PIPT I-cache on CPU1
[    0.043334] CPU1: Booted secondary processor [411fd070]
[    0.046145] Detected PIPT I-cache on CPU2
[    0.046260] CPU2: Booted secondary processor [411fd070]
[    0.048093] Detected PIPT I-cache on CPU3
[    0.048215] CPU3: Booted secondary processor [411fd070]
[    0.048548] smp: Brought up 1 node, 4 CPUs
[    0.048616] SMP: Total of 4 processors activated.
[    0.048673] CPU features: detected feature: 32-bit EL0 Support
[    0.049803] CPU: All CPU(s) started at EL1
[    0.050473] alternatives: patching kernel code
[    0.064714] devtmpfs: initialized
[    0.077394] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.077490] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.085310] pinctrl core: initialized pinctrl subsystem
[    0.109488] NET: Registered protocol family 16
[    0.127189] cpuidle: using governor menu
[    0.129028] vdso: 2 pages (1 code @ ffff000008937000, 1 data @ ffff000008e15000)
[    0.129203] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.143386] DMA: preallocated 256 KiB pool for atomic allocations
[    0.144771] Serial: AMBA PL011 UART driver
[    0.179170] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 39, base_baud = 0) is a PL011 rev1
[    0.199117] console [ttyAMA0] enabled
[    0.207923] irq: type mismatch, failed to map hwirq-27 for /intc!
[    0.319340] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.328050] ACPI: Interpreter disabled.
[    0.338437] vgaarb: loaded
[    0.340151] SCSI subsystem initialized
[    0.346238] usbcore: registered new interface driver usbfs
[    0.346650] usbcore: registered new interface driver hub
[    0.348136] usbcore: registered new device driver usb
[    0.354057] pps_core: LinuxPPS API ver. 1 registered
[    0.354205] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.354452] PTP clock support registered
[    0.357383] Advanced Linux Sound Architecture Driver Initialized.
[    0.371052] clocksource: Switched to clocksource arch_sys_counter
[    0.372203] VFS: Disk quotas dquot_6.6.0
[    0.373024] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.375767] pnp: PnP ACPI: disabled
[    0.431873] NET: Registered protocol family 2
[    0.438232] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.439147] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.439716] TCP: Hash tables configured (established 16384 bind 16384)
[    0.440984] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.441299] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.442611] NET: Registered protocol family 1
[    0.446675] RPC: Registered named UNIX socket transport module.
[    0.448688] RPC: Registered udp transport module.
[    0.448852] RPC: Registered tcp transport module.
[    0.448944] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.456407] kvm [1]: HYP mode not available
[    0.475907] audit: initializing netlink subsys (disabled)
[    0.479169] audit: type=2000 audit(0.424:1): state=initialized audit_enabled=0 res=1
[    0.482579] workingset: timestamp_bits=46 max_order=18 bucket_order=0
[    0.522101] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.528473] NFS: Registering the id_resolver key type
[    0.529232] Key type id_resolver registered
[    0.529367] Key type id_legacy registered
[    0.533125] 9p: Installing v9fs 9p2000 file system support
[    0.557053] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.557344] io scheduler noop registered
[    0.558100] io scheduler cfq registered (default)
[    0.558206] io scheduler mq-deadline registered
[    0.576551] pl061_gpio 9030000.pl061: PL061 GPIO chip @0x0000000009030000 registered
[    0.580689] OF: PCI: host bridge /pcie at 10000000 ranges:
[    0.581110] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
[    0.581445] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
[    0.581557] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x8000000000
[    0.583393] pci-host-generic 3f000000.pcie: ECAM at [mem 0x3f000000-0x3fffffff] for [bus 00-0f]
[    0.584814] pci-host-generic 3f000000.pcie: PCI host bridge to bus 0000:00
[    0.585272] pci_bus 0000:00: root bus resource [bus 00-0f]
[    0.585468] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.585560] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[    0.585653] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
[    0.593702] pci 0000:00:01.0: BAR 4: assigned [mem 0x8000000000-0x80007fffff 64bit pref]
[    0.594246] pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x101f]
[    0.633939] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
[    0.637899] xenfs: not registering filesystem on non-xen platform
[    0.657274] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.666373] SuperH (H)SCI(F) driver initialized
[    0.669079] msm_serial: driver initialized
[    0.671311] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.721591] loop: module loaded
[    0.768742] hisi_sas: driver version v1.6
[    0.790308] libphy: Fixed MDIO Bus: probed
[    0.792735] tun: Universal TUN/TAP device driver, 1.6
[    0.817892] enic: Cisco VIC Ethernet NIC Driver, ver 2.3.0.31
[    0.824652] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    0.824771] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.825136] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    0.825246] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.825529] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    0.825647] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.825918] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
[    0.826027] ixgb: Copyright (c) 1999-2008 Intel Corporation.
[    0.826279] sky2: driver version 1.30
[    0.837132] VFIO - User Level meta-driver version: 0.3
[    0.843601] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.843755] ehci-pci: EHCI PCI platform driver
[    0.844120] ehci-platform: EHCI generic platform driver
[    0.844721] ehci-exynos: EHCI EXYNOS driver
[    0.845201] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    0.845671] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.845844] ohci-pci: OHCI PCI platform driver
[    0.846213] ohci-platform: OHCI generic platform driver
[    0.847311] ohci-exynos: OHCI EXYNOS driver
[    0.849026] usbcore: registered new interface driver usb-storage
[    0.856336] i2c /dev entries driver
[    0.866509] sdhci: Secure Digital Host Controller Interface driver
[    0.866617] sdhci: Copyright(c) Pierre Ossman
[    0.868451] Synopsys Designware Multimedia Card Interface Driver
[    0.872742] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.882524] usbcore: registered new interface driver usbhid
[    0.883021] usbhid: USB HID core driver
[    0.923846] NET: Registered protocol family 10
[    0.933474] Segment Routing with IPv6
[    0.933959] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.940577] NET: Registered protocol family 17
[    0.941619] 9pnet: Installing 9P2000 support
[    0.942140] Key type dns_resolver registered
[    0.948088] registered taskstats version 1
[    0.957660] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    0.960643] hctosys: unable to open rtc device (rtc0)
[    0.999399] IP-Config: Complete:
[    0.999644]      device=eth0, hwaddr=52:54:00:12:34:02, ipaddr=192.168.7.2, mask=255.255.255.0, gw=192.168.7.1
[    0.999785]      host=192.168.7.2, domain=, nis-domain=(none)
[    0.999878]      bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
[    1.001869] ALSA device list:
[    1.001974]   No soundcards found.
[    1.010347] uart-pl011 9000000.pl011: no DMA platform data
[    1.016622] EXT4-fs (vda): couldn't mount as ext3 due to feature incompatibilities
[    2.014540] EXT4-fs (vda): recovery complete
[    2.414628] EXT4-fs (vda): mounted filesystem with ordered data mode. Opts: (null)
[    2.417260] VFS: Mounted root (ext4 filesystem) on device 254:0.
[    2.425646] devtmpfs: mounted
[    2.482566] Freeing unused kernel memory: 1024K

INIT: version 2.88 booting
Starting udev
[    3.412561] random: fast init done
[    3.462420] udevd[1131]: starting version 3.2
[    3.525306] udevd[1132]: starting eudev-3.2
[    4.219431] EXT4-fs (vda): re-mounted. Opts: data=ordered
hwclock: can't open '/dev/misc/rtc': No such file or directory
Fri Apr  7 14:24:30 UTC 2017
hwclock: can't open '/dev/misc/rtc': No such file or directory

INIT: Entering runlevel: 5

Configuring network interfaces... done.

hwclock: can't open '/dev/misc/rtc': No such file or directory

Starting syslogd/klogd: done

No makedumpfile found.
OpenEmbedded nodistro.0 qemuarm64 /dev/ttyAMA0

qemuarm64 login: 
INIT: Id "hvc0" respawning too fast: disabled for 5 minutes

qemuarm64 login: root
root at qemuarm64:~# kexec -l /boot/Image --initrd=/boot/initrd.cpio --command-line=" root=/dev/ram0 1 maxcpus=1 reset_devices" -d
arch_process_options:147: command_line:  root=/dev/ram0 1 maxcpus=1 reset_devices
arch_process_options:149: initrd: /boot/rootfs.cpio
arch_process_options:150: dtb: (null)
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /boot/Image of 65536 bytes failed
kernel: 0xffffac595010 kernel_size: 0xe80808
get_memory_ranges_iomem_cb: 0000000040000000 - 00000000bfffffff : System RAM
elf_arm64_probe: Not an ELF executable.
image_arm64_load: kernel_segment: 0000000040000000
image_arm64_load: text_offset:    0000000000080000
image_arm64_load: image_size:     0000000000ed2000
image_arm64_load: phys_offset:    0000000040000000
image_arm64_load: vp_offset:      ffffffffffffffff
image_arm64_load: PE format:      no
read_1st_dtb: found /sys/firmware/fdt
initrd: base 40f52000, size 1183200h (18362880)
dtb_set_initrd: start 1089806336, end 1108169216, size 18362880 (17932 KiB)
dtb:    base 420d6000, size 1c36h (7222)
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d80f8 addr: 420d8010
machine_apply_elf_rel: ADR_PREL_PG_HI21 13000090f55b02a9->13000090f55b02a9
sym: sha256_starts info: 12 other: 00 shndx: 1 value: ed0 size: 58
sym: sha256_starts value: 420d8ed0 addr: 420d8018
machine_apply_elf_rel: CALL26 00000094750240f9->ae030094750240f9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d80f8 addr: 420d801c
machine_apply_elf_rel: LDST64_ABS_LO12_NC 750240f9a20640f9->757e40f9a20640f9
sym: sha256_update info: 12 other: 00 shndx: 1 value: 2df8 size: c
sym: sha256_update value: 420dadf8 addr: 420d802c
machine_apply_elf_rel: CALL26 00000094740240f9->730b0094740240f9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d80f8 addr: 420d8030
machine_apply_elf_rel: LDST64_ABS_LO12_NC 740240f994020491->747e40f994020491
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 2e08 size: 1c0
sym: sha256_finish value: 420dae08 addr: 420d804c
machine_apply_elf_rel: CALL26 00000094e10314aa->6f0b0094e10314aa
sym:     memcmp info: 12 other: 00 shndx: 1 value: 654 size: 34
sym: memcmp value: 420d8654 addr: 420d805c
machine_apply_elf_rel: CALL26 0000009440040034->7e01009440040034
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8100 addr: 420d8064
machine_apply_elf_rel: ADR_PREL_PG_HI21 00000090140080d2->00000090140080d2
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8100 addr: 420d806c
machine_apply_elf_rel: LDST64_ABS_LO12_NC 000040f900000094->008040f900000094
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d8070
machine_apply_elf_rel: CALL26 0000009400000090->4101009400000090
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8108 addr: 420d8074
machine_apply_elf_rel: ADR_PREL_PG_HI21 00000090000040f9->00000090000040f9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8108 addr: 420d8078
machine_apply_elf_rel: LDST64_ABS_LO12_NC 000040f900000094->008440f900000094
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d807c
machine_apply_elf_rel: CALL26 0000009400000090->3e01009400000090
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8110 addr: 420d8080
machine_apply_elf_rel: ADR_PREL_PG_HI21 00000090160040f9->00000090160040f9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8110 addr: 420d8084
machine_apply_elf_rel: LDST64_ABS_LO12_NC 160040f9a16a7438->168840f9a16a7438
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d8094
machine_apply_elf_rel: CALL26 000000949f8200f1->380100949f8200f1
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8118 addr: 420d80a0
machine_apply_elf_rel: ADR_PREL_PG_HI21 14000090150080d2->14000090150080d2
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8118 addr: 420d80a8
machine_apply_elf_rel: LDST64_ABS_LO12_NC 800240f900000094->808e40f900000094
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d80ac
machine_apply_elf_rel: CALL26 0000009400000090->3201009400000090
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8120 addr: 420d80b0
machine_apply_elf_rel: ADR_PREL_PG_HI21 00000090000040f9->00000090000040f9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8120 addr: 420d80b4
machine_apply_elf_rel: LDST64_ABS_LO12_NC 000040f900000094->009040f900000094
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d80b8
machine_apply_elf_rel: CALL26 00000094730240f9->2f010094730240f9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d80f8 addr: 420d80bc
machine_apply_elf_rel: LDST64_ABS_LO12_NC 730240f973020491->737e40f973020491
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d80d0
machine_apply_elf_rel: CALL26 00000094bf8200f1->29010094bf8200f1
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8118 addr: 420d80dc
machine_apply_elf_rel: LDST64_ABS_LO12_NC 800240f900000094->808e40f900000094
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d80e0
machine_apply_elf_rel: CALL26 0000009420008052->2501009420008052
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 420db040 addr: 420d80f8
machine_apply_elf_rel: ABS64 0000000000000000->00000000420db040
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 420dafd0 addr: 420d8100
machine_apply_elf_rel: ABS64 0000000000000000->00000000420dafd0
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 420daff0 addr: 420d8108
machine_apply_elf_rel: ABS64 0000000000000000->00000000420daff0
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 420db000 addr: 420d8110
machine_apply_elf_rel: ABS64 0000000000000000->00000000420db000
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 420db006 addr: 420d8118
machine_apply_elf_rel: ABS64 0000000000000000->00000000420db006
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 420db008 addr: 420d8120
machine_apply_elf_rel: ABS64 0000000000000000->00000000420db008
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8158 addr: 420d8128
machine_apply_elf_rel: ADR_PREL_PG_HI21 00000090fd7bbfa9->00000090fd7bbfa9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d8158 addr: 420d8134
machine_apply_elf_rel: LDST64_ABS_LO12_NC 000040f900000094->00ac40f900000094
sym:     printf info: 12 other: 00 shndx: 1 value: 574 size: 80
sym: printf value: 420d8574 addr: 420d8138
machine_apply_elf_rel: CALL26 0000009400000094->0f01009400000094
sym: setup_arch info: 12 other: 00 shndx: 1 value: ec8 size: 4
sym: setup_arch value: 420d8ec8 addr: 420d813c
machine_apply_elf_rel: CALL26 0000009400000094->6303009400000094
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: f8
sym: verify_sha256_digest value: 420d8000 addr: 420d8140
machine_apply_elf_rel: CALL26 0000009440000034->b0ffff9740000034
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: ec4 size: 4
sym: post_verification_setup_arch value: 420d8ec4 addr: 420d8150
machine_apply_elf_rel: JUMP26 000000141f2003d5->5d0300141f2003d5
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 420db018 addr: 420d8158
machine_apply_elf_rel: ABS64 0000000000000000->00000000420db018
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d84f8 addr: 420d8190
machine_apply_elf_rel: ADR_PREL_PG_HI21 18000090531840b9->18000090531840b9
sym:    putchar info: 12 other: 00 shndx: 1 value: ec0 size: 4
sym: putchar value: 420d8ec0 addr: 420d81ec
machine_apply_elf_rel: CALL26 00000094e103132a->35030094e103132a
sym:    putchar info: 12 other: 00 shndx: 1 value: ec0 size: 4
sym: putchar value: 420d8ec0 addr: 420d8260
machine_apply_elf_rel: CALL26 00000094a16b40b9->18030094a16b40b9
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420d84f8 addr: 420d82b0
machine_apply_elf_rel: LDST64_ABS_LO12_NC 060340f921001b12->067f42f921001b12
sym:    putchar info: 12 other: 00 shndx: 1 value: ec0 size: 4
sym: putchar value: 420d8ec0 addr: 420d84e8
machine_apply_elf_rel: CALL26 00000094a13740f9->76020094a13740f9
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: 420db02a addr: 420d84f8
machine_apply_elf_rel: ABS64 0000000000000000->00000000420db02a
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 160 size: 394
sym: vsprintf value: 420d8160 addr: 420d8568
machine_apply_elf_rel: CALL26 00000094fd7bd0a8->fefeff97fd7bd0a8
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 160 size: 394
sym: vsprintf value: 420d8160 addr: 420d85e8
machine_apply_elf_rel: CALL26 00000094fd7bd1a8->defeff97fd7bd1a8
sym:  purgatory info: 12 other: 00 shndx: 1 value: 128 size: 2c
sym: purgatory value: 420d8128 addr: 420d8698
machine_apply_elf_rel: CALL26 0000009411000058->a4feff9711000058
sym: arm64_kernel_entry info: 10 other: 00 shndx: 4 value: 120 size: 8
sym: arm64_kernel_entry value: 420db160 addr: 420d869c
machine_apply_elf_rel: LD_PREL_LO19 1100005800000058->3156015800000058
sym: arm64_dtb_addr info: 10 other: 00 shndx: 4 value: 128 size: 8
sym: arm64_dtb_addr value: 420db168 addr: 420d86a0
machine_apply_elf_rel: LD_PREL_LO19 00000058e1031faa->40560158e1031faa
sym: sha256_process info: 12 other: 00 shndx: 1 value: f28 size: 1db4
sym: sha256_process value: 420d8f28 addr: 420dad64
machine_apply_elf_rel: CALL26 000000947f0215eb->71f8ff977f0215eb
sym:     memcpy info: 12 other: 00 shndx: 1 value: 634 size: 20
sym: memcpy value: 420d8634 addr: 420dadc4
machine_apply_elf_rel: JUMP26 0000001493c20091->1cf6ff1793c20091
sym:     memcpy info: 12 other: 00 shndx: 1 value: 634 size: 20
sym: memcpy value: 420d8634 addr: 420dade0
machine_apply_elf_rel: CALL26 00000094e10313aa->15f6ff97e10313aa
sym: sha256_process info: 12 other: 00 shndx: 1 value: f28 size: 1db4
sym: sha256_process value: 420d8f28 addr: 420dadec
machine_apply_elf_rel: CALL26 00000094d3ffff17->4ff8ff97d3ffff17
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420dafc8 addr: 420dae0c
machine_apply_elf_rel: ADR_PREL_PG_HI21 0500009006078052->0500009006078052
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 420dafc8 addr: 420dae24
machine_apply_elf_rel: LDST64_ABS_LO12_NC a10040f9f30300aa->a1e447f9f30300aa
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 420db170 addr: 420dafc8
machine_apply_elf_rel: ABS64 0000000000000000->00000000420db170
kexec_load: entry = 0x420d8690 flags = 0xb70000
nr_segments = 4
segment[0].buf   = 0xffffac595010
segment[0].bufsz = 0xe80808
segment[0].mem   = 0x40080000
segment[0].memsz = 0xed2000
segment[1].buf   = 0xffffab411010
segment[1].bufsz = 0x1183200
segment[1].mem   = 0x40f52000
segment[1].memsz = 0x1184000
segment[2].buf   = 0x1821dcf0
segment[2].bufsz = 0x1c36
segment[2].mem   = 0x420d6000
segment[2].memsz = 0x2000
segment[3].buf   = 0x1821fc60
segment[3].bufsz = 0x31b0
segment[3].mem   = 0x420d8000
segment[3].memsz = 0x4000
root at qemuarm64:~# kexec -e
[   53.383372] kexec_core: Starting new kernel
[   53.383642] Disabling non-boot CPUs ...
[   53.408519] CPU1: shutdown
[   53.408714] psci: CPU1 killed.
[   53.476375] CPU2: shutdown
[   53.476727] psci: CPU2 killed.
[   53.557239] CPU3: shutdown
[   53.557364] psci: CPU3 killed.
[   53.584383] any_cpu = 0, cpu_ops[any_cpu]->cpu_die = ffff00000808a0b8
[   53.593235] Bye!
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc3 (denyszagorui at kbp1-ldl-f65370) (gcc version 6.2.0 (GCC) ) #2 SMP Mon Apr 10 17:28:44 EEST 2017
[    0.000000] Boot CPU: AArch64 Processor [411fd070]
[    0.000000] cma: Reserved 16 MiB at 0x00000000bf000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] percpu: Embedded 23 pages/cpu @ffff80007ef8d000 s56344 r8192 d29672 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 832075
[    0.000000] CPU features: enabling workaround for ARM erratum 834220
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 516096
[    0.000000] Kernel command line:  root=/dev/ram0 1 maxcpus=1 reset_devices
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 14880(90%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Memory: 2011284K/2097152K available (8894K kernel code, 962K rwdata, 3924K rodata, 1024K init, 299K bss, 69484K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008930000   (  8896 KB)
[    0.000000]     .rodata : 0xffff000008930000 - 0xffff000008d10000   (  3968 KB)
[    0.000000]       .init : 0xffff000008d10000 - 0xffff000008e10000   (  1024 KB)
[    0.000000]       .data : 0xffff000008e10000 - 0xffff000008f00808   (   963 KB)
[    0.000000]        .bss : 0xffff000008f00808 - 0xffff000008f4b6c4   (   300 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0002000000   (    32 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800080000000   (  2048 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3, assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 62.50MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
[    0.000129] sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
[    0.005194] Console: colour dummy device 80x25
[    0.007405] console [tty0] enabled
[    0.007915] Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=250000)
[    0.008086] pid_max: default: 32768 minimum: 301
[    0.008950] Security Framework initialized
[    0.009392] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.009459] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.028979] ASID allocator initialised with 65536 entries
[    0.035492] smp: Bringing up secondary CPUs ...
[    0.035573] smp: Brought up 1 node, 1 CPU
[    0.035620] SMP: Total of 1 processors activated.
[    0.035701] CPU features: detected feature: 32-bit EL0 Support
[    0.036085] CPU: All CPU(s) started at EL1
[    0.037171] alternatives: patching kernel code
[    0.048787] devtmpfs: initialized
[    0.056961] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.057243] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.059825] pinctrl core: initialized pinctrl subsystem
[    0.087260] NET: Registered protocol family 16
[    0.093535] cpuidle: using governor menu
[    0.094935] vdso: 2 pages (1 code @ ffff000008937000, 1 data @ ffff000008e15000)
[    0.095156] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.110948] DMA: preallocated 256 KiB pool for atomic allocations
[    0.112652] Serial: AMBA PL011 UART driver
[    0.146391] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 39, base_baud = 0) is a PL011 rev1
[    0.166805] console [ttyAMA0] enabled
[    0.171748] irq: type mismatch, failed to map hwirq-27 for /intc!
[    0.261315] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.267267] ACPI: Interpreter disabled.
[    0.277842] vgaarb: loaded
[    0.279695] SCSI subsystem initialized
[    0.284030] usbcore: registered new interface driver usbfs
[    0.284456] usbcore: registered new interface driver hub
[    0.285066] usbcore: registered new device driver usb
[    0.286484] pps_core: LinuxPPS API ver. 1 registered
[    0.286611] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.286896] PTP clock support registered
[    0.288343] Advanced Linux Sound Architecture Driver Initialized.
[    0.304122] clocksource: Switched to clocksource arch_sys_counter
[    0.304997] VFS: Disk quotas dquot_6.6.0
[    0.306076] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.308200] pnp: PnP ACPI: disabled
[    0.368006] NET: Registered protocol family 2
[    0.372506] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.373073] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.373666] TCP: Hash tables configured (established 16384 bind 16384)
[    0.374763] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.375147] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.376819] NET: Registered protocol family 1
[    0.381576] RPC: Registered named UNIX socket transport module.
[    0.381764] RPC: Registered udp transport module.
[    0.381868] RPC: Registered tcp transport module.
[    0.381960] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.386216] Unpacking initramfs...
[    0.604107] Freeing initrd memory: 17932K
[    0.605856] kvm [1]: HYP mode not available
[    0.615339] audit: initializing netlink subsys (disabled)
[    0.622458] audit: type=2000 audit(0.596:1): state=initialized audit_enabled=0 res=1
[    0.624762] workingset: timestamp_bits=46 max_order=19 bucket_order=0
[    0.666085] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.674972] NFS: Registering the id_resolver key type
[    0.676219] Key type id_resolver registered
[    0.676384] Key type id_legacy registered
[    0.679451] 9p: Installing v9fs 9p2000 file system support
[    0.693628] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.694031] io scheduler noop registered
[    0.694938] io scheduler cfq registered (default)
[    0.695085] io scheduler mq-deadline registered
[    0.718943] pl061_gpio 9030000.pl061: PL061 GPIO chip @0x0000000009030000 registered
[    0.722685] OF: PCI: host bridge /pcie at 10000000 ranges:
[    0.723170] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
[    0.723577] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
[    0.723740] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x8000000000
[    0.724609] pci-host-generic 3f000000.pcie: ECAM at [mem 0x3f000000-0x3fffffff] for [bus 00-0f]
[    0.725811] pci-host-generic 3f000000.pcie: PCI host bridge to bus 0000:00
[    0.726107] pci_bus 0000:00: root bus resource [bus 00-0f]
[    0.726294] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.726424] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[    0.726592] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
[    0.739034] pci 0000:00:01.0: BAR 4: assigned [mem 0x8000000000-0x80007fffff 64bit pref]
[    0.740214] pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x101f]
[    0.769679] xenfs: not registering filesystem on non-xen platform
[    0.813888] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.830106] SuperH (H)SCI(F) driver initialized
[    0.832070] msm_serial: driver initialized
[    0.835576] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.874700] loop: module loaded
[    0.907442] hisi_sas: driver version v1.6
[    0.921023] libphy: Fixed MDIO Bus: probed
[    0.922468] tun: Universal TUN/TAP device driver, 1.6
[    0.948212] enic: Cisco VIC Ethernet NIC Driver, ver 2.3.0.31
[    0.953511] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    0.953685] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.954109] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    0.954272] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.954604] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    0.954791] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.955131] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
[    0.955293] ixgb: Copyright (c) 1999-2008 Intel Corporation.
[    0.955620] sky2: driver version 1.30
[    0.968874] VFIO - User Level meta-driver version: 0.3
[    0.976743] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.976966] ehci-pci: EHCI PCI platform driver
[    0.977355] ehci-platform: EHCI generic platform driver
[    0.978044] ehci-exynos: EHCI EXYNOS driver
[    0.978610] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    0.979144] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.979380] ohci-pci: OHCI PCI platform driver
[    0.979769] ohci-platform: OHCI generic platform driver
[    0.980532] ohci-exynos: OHCI EXYNOS driver
[    0.982454] usbcore: registered new interface driver usb-storage
[    0.987915] i2c /dev entries driver
[    0.997181] sdhci: Secure Digital Host Controller Interface driver
[    0.997324] sdhci: Copyright(c) Pierre Ossman
[    0.998648] Synopsys Designware Multimedia Card Interface Driver
[    1.001796] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.008996] usbcore: registered new interface driver usbhid
[    1.009156] usbhid: USB HID core driver
[    1.044336] NET: Registered protocol family 10
[    1.052991] Segment Routing with IPv6
[    1.053505] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.055807] NET: Registered protocol family 17
[    1.056958] 9pnet: Installing 9P2000 support
[    1.057390] Key type dns_resolver registered
[    1.062574] registered taskstats version 1
[    1.074242] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    1.077550] hctosys: unable to open rtc device (rtc0)
[    1.078285] ALSA device list:
[    1.078406]   No soundcards found.
[    1.081875] uart-pl011 9000000.pl011: no DMA platform data
[    1.126376] Freeing unused kernel memory: 1024K

INIT: version 2.88 booting

Starting udev
[    2.000391] udevd[1103]: starting version 3.2
[    2.005220] random: udevd: uninitialized urandom read (16 bytes read)
[    2.008505] random: udevd: uninitialized urandom read (16 bytes read)
[    2.009439] random: udevd: uninitialized urandom read (16 bytes read)
[    2.009853] random: udevd: uninitialized urandom read (16 bytes read)
[    2.060209] udevd[1104]: starting eudev-3.2
Populating dev cache

[    6.536891] random: dd: uninitialized urandom read (512 bytes read)
hwclock: can't open '/dev/misc/rtc': No such file or directory

Fri Apr  7 14:24:30 UTC 2017
hwclock: can't open '/dev/misc/rtc': No such file or directory

INIT: Entering runlevel: 1

Unmounting remote filesystems...

OpenEmbedded nodistro.0 qemuarm64 /dev/ttyAMA0

qemuarm64 login: 
INIT: Id "hvc0" respawning too fast: disabled for 5 minutes

OpenEmbedded nodistro.0 qemuarm64 /dev/ttyAMA0

qemuarm64 login: root
login[1320]: root login on 'ttyAMA0'

root at qemuarm64:~# uname -a
Linux qemuarm64 4.11.0-rc3 #2 SMP Mon Apr 10 17:28:44 EEST 2017 aarch64_be GNU/Linux
root at qemuarm64:~# 
