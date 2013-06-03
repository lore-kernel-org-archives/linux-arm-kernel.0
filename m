From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 03 Jun 2013 18:12:52 +0900
Subject: mvebu: 3.10-rc1 and fixes branch doesn't boot on OpenBlocks AX3
Message-ID: <51AC5E14.1050207@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've tried 3.10-rc1 and
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes branch on my
OpenBlocks AX3-4 and failed to boot both kernel
as below.

---
Loading file "uImage" from ide device 0:1 (hda1)
2486993 bytes read
Loading file "uInitrd" from ide device 0:1 (hda1)
1851769 bytes read
## Booting kernel from Legacy Image at 02000000 ...
   Image Name:   Linux-marvell
   Created:      2013-05-27   3:43:33 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2486929 Bytes =  2.4 MB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 01100000 ...
   Image Name:   Linux-initrd
   Created:      2013-05-27   7:42:37 UTC
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    1851705 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.10.0-rc2-00054-gf4ae176 (mhiramat at mhiramat-M0-7522) (gcc version
4.6.3 20120624 (prerelease) (Ubuntu/Linaro 4.6.3-8ubuntu1) ) #99 SMP Mon May 27
12:43:19 JST 2013
CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine: Marvell Armada 370/XP (Device Tree), model: PlatHome OpenBlocks AX3-4 board
bootconsole [earlycon0] enabled
debug: skip boot console de-registration.
INITRD: 0x01100040+0x001c4139 is not a memory region - disabling initrd
Memory policy: ECC disabled, Data cache writealloc
Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.0-rc2-00054-gf4ae176 #99
Backtrace: invalid frame pointer 0xc0661eb4
---

It seems that newer mvebu kernel has a corrupt description in device tree
or should I run mkimage with different parameters for making uInitrd?

I'm using mkimage with parameters below for uimage

  scripts/mkuboot.sh -A arm -O linux -T kernel -C none \
  -a 0x8000 -e 0x8000 -n "Linux-marvell" -d zImage uImage

and

  mkimage -A arm -O linux -T ramdisk -C none -a 0x0000 -e 0x0000 \
  -n "Linux-initrd" -d /boot/initrd.img-$KVER /boot/uInitrd-$KVER

for uinitrd.
And boot the image from sata by uboot as below:
---
ide reset
ext2load ide 0:1 0x2000000 uImage
ext2load ide 0:1 0x1100000 uInitrd
setenv bootargs console=ttyS0,115200 earlyprintk=ttyS0 root=/dev/sda3
rootflags=subvol=@ ro keep_bootcon=1
bootm 0x2000000 0x1100000
---

BTW, should I enable CONFIG_ARM_LPAE even if the board has only
3GB memory?

Thank you,


-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
