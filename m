From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 12 Dec 2012 16:51:49 +0100
Subject: ARM: mach-moxart: platform port for MOXA ART SoC
Message-ID: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

I ask for your feedback on the following patches for a new ARM SoC platform
port. This is regarding a "MOXA ART" SoC port I started from scratch and is
now in a state where the essentials work. The reason I am doing this? Make
it run something newer than 2.6.9 and reap rewards, to name a few: NPTL,
EABI, modern glibc and crosstool-NG toolchain.

My goal is to follow guidelines of mainline ARM (I know
"arch/arm/boot/compressed/head.S" and "arch/arm/tools/mach-types" do not).
I'm new at kernel code / interacting with the community, please point out
any mistake, or what I should do next to get this reviewed.

Git mirrors starting from 2.6.32.60 and a commit containing everything up
to date (
http://repo.or.cz/w/linux-2.6.32.60-moxart.git/commitdiff/9bbaddcd844cb2323e637a177ff64804df153c41)
:
http://repo.or.cz/w/linux-2.6.32.60-moxart.git
http://code.google.com/p/linux-moxart/


Working:

* Boot code for ARCH_MOXART (selects CPU_FA526)
* TIMER: 100Hz interrupt timer
* UART for kernel boot and debug
* MTD map driver
* MOXART CPU RTL8201CP Ethernet driver

Not yet ported:

* MMC
* MOXA Smartio/Industio family multiport serial driver (port for embedded)
* RTC
* Watchdog


A search for "MOXA ART" does not yield much in terms of specifications or
data sheets, so far I have gotten by reading and comparing two existing
kernel trees by MOXA:

UC-7112-LX with MMU based on 2.6.9:
http://repo.or.cz/w/linux-2.6.9-moxart.git
https://code.google.com/p/linux-2-6-9-moxart/

UC-7110-LX MMU-less based on 2.6.19:
http://repo.or.cz/w/linux-2.6.19-moxart.git
https://code.google.com/p/linux-2-6-19-moxart/


Questions:

I think this is close to something that can be ported beyond 2.6, I have
tried for 3.6.7 but there is a problem. Nothing is printed to UART after
"Uncompressing Linux... done, booting the kernel.", any ideas why? config @
https://code.google.com/p/linux-3-6-7-moxart/source/browse/arch/arm/configs/moxart_uc7112lx_defconfigfull
source @
http://repo.or.cz/w/linux-3.6.7-moxart.git or
https://code.google.com/p/linux-3-6-7-moxart/

Can the timer be improved? I have not found anything in the code or
otherwise indicating availability of a HPET; and if I understand things
correctly, 100 Hz interrupt should give an accuracy of around 10 ms?
ARCH_GEMINI is one of few that select CPU_FA526 and this is where I found
the timer implementation. Considering a change from CONFIG_HZ=100 to
CONFIG_HZ=1000, would it be a good idea?


Other:

Pictures of UC-7112-LX, two PCBs back/front with visible chip manufacturer
IDs:
https://picasaweb.google.com/103371465418643926605/MOXAUC7112LX?authuser=0&feat=directlink

That's it for now, thank you for reading, I'm ending with the printout from
bootloader and kernel:

----------------------------------------------------------------------------
  Moxa Technologies Co., Ltd Version 1.2.0.0
  Module Name : UC-7112-LX-Plus (MOXART)     Serial No. : 576
  MAC0 : 00:90:e8:1b:e2:39  MAC1 : 00:90:e8:1b:e2:3a
----------------------------------------------------------------------------
( 1) BIOS Upgrade                     ( 2) Kernel Upgrade
( 3) User Disk Upgrade                ( 4) Default Upgrade
( 5) Image Upgrade                    ( 6) SDRAM Test
( 7) Flashrom Test                    ( 8) UART Test
( 9) Ethernet Test                    (10) RTC Test
(11) SD Test                          (12) Buzzer Test
(13) Jumper & SW Button Test          (14) LED Test
(15) Jump to Go                       (16) Reboot
(17) Set Serial No. & MAC Addr.       (18) Set/Clean Flag
(19) TFTP Config                      (20) Debug
(21) WT Test
---------------------------------------------------------------------------
Uncompressing
Linux.....................................................................................
done, booting the kernel.
[    0.000000] Linux version 2.6.32.60 (i at Ildjarn) (gcc version 4.6.3
(crosstool-NG 1.16.0) ) #1 PREEMPT Tue Dec 4 16:22:57 CET 2012
[    0.000000] CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: MOXA UC-7112-LX
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
 Total pages: 8128
[    0.000000] Kernel command line: console=ttyS0,115200n8
root=/dev/mtdblock2 rootfstype=jffs2 rw
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Memory: 32MB = 32MB total
[    0.000000] Memory: 29592KB available (2356K code, 333K data, 80K init,
0K highmem)
[    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:80
[    0.000000] MOXART CPU IRQ: init_irq finished
[    0.000000] MOXART CPU TIMER: timer count/load set (APB_CLK / HZ) where
APB_CLK=48000000 HZ=100 IRQ=0x13
[    0.000000] Calibrating delay loop... 152.37 BogoMIPS (lpj=761856)
[    0.210000] Mount-cache hash table entries: 512
[    0.210000] CPU: Testing write buffer coherency: ok
[    0.210000] devtmpfs: initialized
[    0.220000] NET: Registered protocol family 16
[    0.300000] bio: create slab <bio-0> at 0
[    0.330000] NET: Registered protocol family 2
[    0.330000] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.340000] TCP established hash table entries: 1024 (order: 1, 8192
bytes)
[    0.340000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.340000] TCP: Hash tables configured (established 1024 bind 1024)
[    0.340000] TCP reno registered
[    0.340000] NET: Registered protocol family 1
[    0.340000] RPC: Registered udp transport module.
[    0.340000] RPC: Registered tcp transport module.
[    0.340000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.360000] JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    0.360000] msgmni has been set to 57
[    0.370000] alg: No test for stdrng (krng)
[    0.700000] io scheduler noop registered
[    0.700000] io scheduler cfq registered (default)
[    0.700000] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.710000] serial8250.0: ttyS0 at MMIO 0x98200000 (irq = 31) is a 16550A
[    0.720000] console [ttyS0] enabled
[    0.730000] MTD: MOXART CPU flash: probing 16-bit flash bus, flash
mapping: 0x1000000 at 0x80000000
[    0.740000] UC-7112-LX-PLUS: Found 1 x16 devices at 0x0 in 16-bit bank
[    0.750000]  Intel/Sharp Extended Query Table at 0x0031
[    0.750000]  Intel/Sharp Extended Query Table at 0x0031
[    0.760000] Using buffer write method
[    0.760000] cfi_cmdset_0001: Erase suspend on write enabled
[    0.770000] MTD: Using static partition definition
[    0.770000] Creating 4 MTD partitions on "UC-7112-LX-PLUS":
[    0.780000] 0x000000000000-0x000000040000 : "Bootloader"
[    0.790000] 0x000000040000-0x000000200000 : "LinuxKernel"
[    0.810000] 0x000000200000-0x000000a00000 : "RootFileSystem"
[    0.820000] 0x000000a00000-0x000001000000 : "UserDisk"
[    0.840000] MOXART Ethernet: finished get_mac_address
dev->base_addr=f9090000
[    0.850000] MOXART Ethernet: finished moxart_update_mac_address
dev->base_addr=f9090000 MAC=90e81be239
[    0.860000] MOXART Ethernet: moxart_mac_get_stats:
[    0.870000] RxDescNow=0, desc phy=0x1c5f000, virt=0xffc01000, buf
phy=0x0, virt=0x0 Now Rx desc des0=0x0, des1=0x0
[    0.880000] RxDescNow=1, desc phy=0x1c5f010, virt=0xffc01010, buf
phy=0x0, virt=0x0 Now Rx desc des0=0x0, des1=0x0 (desc++)
[    0.890000] TX_MCOL_TX_SCOL=0x0 RPF_AEP=0x0 XM_PG=0x0 RUNT_CNT_TLCC=0x0
CRCER_CNT_FTL_CNT=0x0 RLC_RCC=0x0 BROC=0x0 MUCLA=0x0 RP=0x0 XP=0x0
[    0.900000] MOXART Ethernet: finished moxart_mac_probe eth0 IRQ=25
address=00:90:e8:1b:e2:39
[    0.920000] MOXART Ethernet: finished get_mac_address
dev->base_addr=f9200000
[    0.930000] MOXART Ethernet: finished moxart_update_mac_address
dev->base_addr=f9200000 MAC=90e81be23a
[    0.940000] MOXART Ethernet: moxart_mac_get_stats:
[    0.950000] RxDescNow=0, desc phy=0x1ccf000, virt=0xffc35000, buf
phy=0x0, virt=0x0 Now Rx desc des0=0x0, des1=0x0
[    0.960000] RxDescNow=1, desc phy=0x1ccf010, virt=0xffc35010, buf
phy=0x0, virt=0x0 Now Rx desc des0=0x0, des1=0x0 (desc++)
[    0.970000] TX_MCOL_TX_SCOL=0x0 RPF_AEP=0x0 XM_PG=0x0 RUNT_CNT_TLCC=0x0
CRCER_CNT_FTL_CNT=0x0 RLC_RCC=0x0 BROC=0x0 MUCLA=0x0 RP=0x0 XP=0x0
[    0.980000] MOXART Ethernet: finished moxart_mac_probe eth1 IRQ=27
address=00:90:e8:1b:e2:3a
[    0.990000] nf_conntrack version 0.5.0 (462 buckets, 1848 max)

[    1.000000] ip_tables: (C) 2000-2006 Netfilter Core Team

[    1.010000] TCP cubic registered

[    1.010000] NET: Registered protocol family 17
[    1.060000] VFS: Mounted root (jffs2 filesystem) on device 31:2.
[    1.070000] devtmpfs: mounted
[    1.070000] Freeing init memory: 80K
init started: BusyBox v1.20.2 (2012-11-28 09:59:44 CET)
starting pid 118, tty '': '/etc/init.d/start'
[    2.300000] MOXART Ethernet: moxart_mac_get_stats:
[    2.300000] RxDescNow=0, desc phy=0x1c5f000, virt=0xffc01000, buf
phy=0x0, virt=0x0 Now Rx desc des0=0x0, des1=0x0
[    2.310000] RxDescNow=1, desc phy=0x1c5f010, virt=0xffc01010, buf
phy=0x0, virt=0x0 Now Rx desc des0=0x0, des1=0x0 (desc++)
[    2.320000] TX_MCOL_TX_SCOL=0x0 RPF_AEP=0x0 XM_PG=0x0 RUNT_CNT_TLCC=0x0
CRCER_CNT_FTL_CNT=0x0 RLC_RCC=0x0 BROC=0x0 MUCLA=0x0 RP=0x0 XP=0x0
[    2.330000] MOXART Ethernet: finished moxart_mac_reset
dev->base_addr=f9090000
[    2.330000] MOXART Ethernet: finished moxart_update_mac_address
dev->base_addr=f9090000 MAC=90e81be239
[    2.340000] MOXART Ethernet: finished moxart_mac_setup_desc_ring
dev->base_addr=f9090000 Tx/Rx desc phy=0x1c5e000,0x1c5f000,
virt=0xffc00000,0xffc01000 set
Tx desc base address=0x1c5e000, Rx=0x1c5f000
[    2.350000] MOXART Ethernet: finished moxart_mac_enable
dev->base=f9090000
[    2.360000] MOXART Ethernet: finished moxart_mac_open IMR=0x1,
MACCR=0x2c923
[    2.370000] MOXART Ethernet: moxart_mac_get_stats:
[    2.370000] RxDescNow=0, desc phy=0x1c5f000, virt=0xffc01000, buf
phy=0x1d00000, virt=0xffc1b000 Now Rx desc des0=0x80000000, des1=0x640
[    2.380000] RxDescNow=1, desc phy=0x1c5f010, virt=0xffc01010, buf
phy=0x1d00640, virt=0xffc1b640 Now Rx desc des0=0x80000000, des1=0x640
(desc++)
[    2.390000] TX_MCOL_TX_SCOL=0x0 RPF_AEP=0x0 XM_PG=0x0 RUNT_CNT_TLCC=0x0
CRCER_CNT_FTL_CNT=0x0 RLC_RCC=0x0 BROC=0x0 MUCLA=0x0 RP=0x0 XP=0x0
PING 10.0.1.200 (10.0.1.200): 56[    2.510000] MOXART Ethernet: transmit
data pointer = 0xc1cf9e02
 data bytes
[    2.510000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=0 ttl=64 time=20.000 ms
[    3.500000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=1 ttl=64 time=0.000 ms
[    4.500000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=2 ttl=64 time=0.000 ms
[    5.500000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=3 ttl=64 time=0.000 ms
[    6.500000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=4 ttl=64 time=0.000 ms
[    7.500000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=5 ttl=64 time=0.000 ms
[    8.500000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=6 ttl=64 time=0.000 ms
[    9.500000] MOXART Ethernet: transmit data pointer = 0xc1d3cc02
64 bytes from 10.0.1.200: seq=7 ttl=64 time=0.000 ms
[   10.240000] SysRq : Terminate All Tasks
starting pid 123, tty '': '/bin/cttyhack /bin/sh'


Best regards
Jonas Jensen
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/c4ee5d17/attachment-0001.html>
