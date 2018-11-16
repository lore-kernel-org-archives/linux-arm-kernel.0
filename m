From: anton@picapica.im (Anton)
Date: Fri, 16 Nov 2018 14:32:36 +0100
Subject: [BUG] Is "mem=" kernel command line parameter broken on ARM?
Message-ID: <20181116133236.GA27819@picapica.im>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello


I am trying to boot Linux on a custom board having SAMA5D21 chip.
It has 64MiB of DRAM. So I thought it was a good idea to pass amount
of physical memory available through command line parameter "mem=64M".
At least there are such examples in some at91bootstrap bootloader
configurations, like this one:

https://github.com/linux4sam/at91bootstrap/blob/8b9064beb6169f2c3be089fa99c5080b2182639f/board/at91sam9261ek/Config.in.linux_arg#L2

But it fails to boot for some reasons, so I decided to test on the
devboard sama5d2_xplained. I tried to add "mem=64M" to the kernel
command line and discovered that it makes kernel crash. Basically
every value that I tried (64M, 128M, 256M) makes kernel crash, except
when it is set to "mem=512M" which equals to board's actual DRAM size.

I tried kernel versions "linux4sam_5.7", "linux4sam_5.8", 
"linux4sam_6.0", master branch from 
https://github.com/linux4sam/linux-at91,
mainline kernel 4.19.2 from kernel.org.
In every tested case result is same, kernel crashes.
In all tests above "sama5_defconfig" was used.

Please take a look at this forum post for more details

http://at91.com/viewtopic.php?f=12&t=28044

I've also tried to test if this issue is specific for Atmel's SoCs or
affects other ARM platfoms too. I've discovered that adding "mem=" 
option crahes kernel on Raspberry Pi 3 and Beaglebone Black, both having
kernels based on 4.9 version.

I expect this feature should work as described in

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n2343

or at least print some meaningful error message, or documentation has to
be updated.

Anton


======
?RomBOOTg... reboot: Restarting system


AT91Bootstrap 3.8.9 (???? ?????? 10 20:22:33 +04 2018)

EEPROM: Loading AT24xx information ...
EEPROM: BoardName | [Revid] | VendorName
  #0  SAMA5D2-XULT [AB1]      ATMEL-RF0

EEPROM: Board sn: 0xd300000 revision: 0x400000

SD/MMC: Image: Read file u-boot.bin to 0x26f00000
SD: Card Capacity: High or Extended
SD: Specification Version 3.0X
SD/MMC: Done to load image
<debug_uart>

U-Boot 2017.03-linux4sam_5.7 (Jul 10 2018 - 20:22:40 +0400)

CPU: SAMA5D27-CU
Crystal frequency:       12 MHz
CPU clock        :      498 MHz
Master clock     :      166 MHz
DRAM:  512 MiB
MMC:   sdio-host at a0000000: 0, sdio-host at b0000000: 1
reading uboot.env
In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet at f8008000
Hit any key to stop autoboot:  0
=> printenv
arch=arm
baudrate=115200
board=sama5d2_xplained
board_name=sama5d2_xplained
bootargs=console=ttyS0,115200 earlyprintk root=/dev/mmcblk1p2 rw rootwait
bootcmd=fatload mmc 1:1 0x21000000 at91-sama5d2_xplained_at86rf230.dtb; fatload mmc 1:1 0x22000000 zImage; bootz 0x22000000 - 0x21000000
bootdelay=3
cpu=armv7
ethaddr=fc:c2:3d:02:f6:ea
fdtcontroladdr=3fb63578
fileaddr=22000000
filesize=3a6a80
soc=at91
vendor=atmel

Environment size: 444/16380 bytes
=> setenv bootargs mem=64M console=ttyS0,115200 earlyprintk root=/dev/mmcblk1p2 rw rootwait
=> boot
reading at91-sama5d2_xplained_at86rf230.dtb
29351 bytes read in 22 ms (1.3 MiB/s)
reading zImage
4320368 bytes read in 277 ms (14.9 MiB/s)
## Flattened Device Tree blob at 21000000
   Booting using the fdt blob at 0x21000000
   Loading Device Tree to 3fb57000, end 3fb612a6 ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 4.19.2 (user at gentoo) (gcc version 7.3.0 (Buildroot 2018.02-rc1-00043-g06197ed294)) #1 Wed Nov 14 22:29:10 +04 2018
CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: Atmel SAMA5D2 Xplained
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
Unable to handle kernel paging request at virtual address dfb57000
pgd = (ptrval)
[dfb57000] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.2 #1
Hardware name: Atmel SAMA5
PC is at fdt_check_header+0x0/0x74
LR is at __unflatten_device_tree+0x20/0x10c
pc : [<c06ed600>]    lr : [<c052e6b4>]    psr: a00000d3
sp : c0b01f30  ip : 00000000  fp : fffff000
r10: 00000000  r9 : 20000000  r8 : c0a1ee5c
r7 : 00000000  r6 : dfb57000  r5 : c0b54f10  r4 : c0a1ee5c
r3 : c0a1ee5c  r2 : c0b54f10  r1 : 00000000  r0 : dfb57000
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: 20004059  DAC: 00000051
Process swapper (pid: 0, stack limit = 0x(ptrval))
Stack: (0xc0b01f30 to 0xc0b02000)
1f20:                                     c0a1ee5c c3ffcf80 c0b06b48 23ffffff
1f40: c0b46b28 20000000 c09550b8 c0a1fccc 00000000 c011ae08 c0a2d504 c0a046ac
1f60: ffffffff 10c53c7d c0b03008 c08e5e9c 410fc051 c0b03008 00000000 c0144938
1f80: c08e4380 00000000 c0b03008 00000000 c0b3ba40 c0b03000 ffffffff 3fb57000
1fa0: c0b03008 c0b03008 00000000 c0a0095c 00000000 00000000 00000000 00000000
1fc0: 00000000 c0a2ea2c 00000000 00000000 00000000 c0a00330 00000051 10c03c7d
1fe0: 00000000 3fb57000 410fc051 10c53c7d 00000000 00000000 00000000 00000000
[<c06ed600>] (fdt_check_header) from [<c052e6b4>] (__unflatten_device_tree+0x20/0x10c)
[<c052e6b4>] (__unflatten_device_tree) from [<c0a1fccc>] (unflatten_device_tree+0x34/0x44)
[<c0a1fccc>] (unflatten_device_tree) from [<c0a046ac>] (setup_arch+0x870/0xac0)
[<c0a046ac>] (setup_arch) from [<c0a0095c>] (start_kernel+0x74/0x3dc)
[<c0a0095c>] (start_kernel) from [<00000000>] (  (null))
Code: e1a0000c ebf0f882 e28dd014 e49df004 (e5903000)
random: get_random_bytes called from print_oops_end_marker+0x40/0x54 with crng_init=0
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

======
