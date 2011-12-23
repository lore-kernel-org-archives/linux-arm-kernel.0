From: phil@ultimate.com (Phil Budne)
Date: Thu, 22 Dec 2011 22:18:53 -0500
Subject: Atmel at91x40 ("EB01" eval board) resurected
Message-ID: <CALz2mmXcAk9ZOsAzKMbKVVJ2+Et02+Gxj_z6xSgukC5LjgJTLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm new here, so please excuse any protocol violations!

I decided to see if I could bring up current kernel sources under
skyeye  (at91x40 simulation).
I've also been working on a port to the more modern AT91SAM7SE using QEMU.

Attached are:

diffs from sources from git://github.com/at91linux/linux-at91.git
 master branch (current as of 12/21/11)
 many of the changes are in generic arch/arm files.

Tested on Simulated at91x40xxx "EB01" board
kernel built using attached defconfig file.
4M of RAM at 0x1000000
XIP kernel loaded in 4M (of "flash") at 0x1400000
root filesystem is a compiled in initramfs
  too much pain to build ROMfs and map;
   (drivers/mtd/maps/uclinux.c requires rootfs appended after kernel
    "uClinux" 11/11/11 dist uclinux.c allows rootfs image at fixed location)


new file attached: mach/arm/mach-at91/at91x40_devices.c

Runs on locally modified skyeye
 based on skyeye-v1.2_Rel.tar (had trouble building latest release)
 adds interrupt driven UART output
 tweaked for programmed I/O UART input
 fix for loading XIP data section (load at physical, not virtual address)

Problems:
 repeated "free" commands show loss of 12K each time (see atached typescript)
 same sh binary (from skyeye test suite)
   does not exhibit this on 2.6 and 2.4 kernels (from the skyeye test suite).
 breakpointing sys_munmap shows len==0 (could it be an ABI issue?)
-------------- next part --------------
Script started on Wed 21 Dec 2011 06:04:55 PM EST
phil at phil-laptop:~/arm/git/linux-at91$ head -5 Makefile
VERSION = 3
PATCHLEVEL = 2
SUBLEVEL = 0
EXTRAVERSION = -rc3
NAME = Saber-toothed Squirrel
phil at phil-laptop:~/arm/git/linux-at91$ size x40/vmlinux
   text	   data	    bss	    dec	    hex	filename
 827292	 171320	  25280	1023892	  f9f94	x40/vmlinux
phil at phil-laptop:~/arm/git/linux-at91$ ./skyeye -e x40/vmlinux
arch: arm
cpu info: armv3, arm7tdmi, 41007700, fff8ff00, 0 
mach info: name at91, mach_init addr 0x8057760
SKYEYE: use arm7100 mmu ops
exec file "x40/vmlinux"'s format is elf32-little.
load section .head.text: addr = 0x01400000  size = 0x0000005c.
load section .text: addr = 0x01400060  size = 0x000a0000.
load section .rodata: addr = 0x014a1000  size = 0x0001e780.
load section __param: addr = 0x014bf780  size = 0x00000080.
not load section __modver: addr = 0x014bf800  size = 0x00000800 .
load section .init.text: addr = 0x014c0000  size = 0x0000b534.
load section .init.proc.info: addr = 0x014cb534  size = 0x0000016c.
load section .init.arch.info: addr = 0x014cb6a0  size = 0x0000003c.
load section .init.tagtable: addr = 0x014cb6dc  size = 0x00000040.
load section .init.data: addr = 0x014cb71c  size = 0x0001a538.
load section .data: lma = 0x014e6000 (vma = 0x01008000)  size = 0x0000f800.
load section .notes: addr = 0x01017800  size = 0x00000024.
not load section .bss: addr = 0x01017840  size = 0x00005ac0 .
not load section .comment: addr = 0x00000000  size = 0x0000002a .
not load section .ARM.attributes: addr = 0x00000000  size = 0x0000002a .
not load section .debug_line: addr = 0x00000000  size = 0x0007e2af .
not load section .debug_info: addr = 0x00000000  size = 0x0063a524 .
not load section .debug_abbrev: addr = 0x00000000  size = 0x0004afc4 .
not load section .debug_aranges: addr = 0x00000000  size = 0x000033c0 .
not load section .debug_ranges: addr = 0x00000000  size = 0x0001d7c8 .
not load section .debug_pubnames: addr = 0x00000000  size = 0x000122dd .
not load section .debug_pubtypes: addr = 0x00000000  size = 0x000a9c57 .
not load section .debug_str: addr = 0x00000000  size = 0x00036622 .
not load section .debug_frame: addr = 0x00000000  size = 0x00029b90 .
not load section .debug_loc: addr = 0x00000000  size = 0x0010e6e5 .
start addr is set to 0x01400000 by exec file.
Linux version 3.2.0-rc3-12776-g401d006-dirty (phil at phil-laptop) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #63 Wed Dec 21 18:01:29 EST 2011
CPU: ARM7TDMI [41807700] revision 0 (ARMv4T), cr=00000000
CPU: VIVT data cache, VIVT instruction cache
Machine: Atmel AT91 EB01
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 1016
Kernel command line: 
PID hash table entries: 16 (order: -6, 64 bytes)
Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 4MB = 4MB total
Memory: 3924k/3924k available, 172k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0x00000000 - 0x00001000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
    lowmem  : 0x01000000 - 0x01400000   (   4 MB)
    modules : 0x01000000 - 0x01400000   (   4 MB)
      .text : 0x01400000 - 0x014c0000   ( 768 kB)
      .init : 0x0100a000 - 0x0100d000   (  12 kB)
      .data : 0x01008000 - 0x01017800   (  62 kB)
       .bss : 0x01017824 - 0x0101d300   (  23 kB)
NR_IRQS:192
AT91: 0 gpio irqs in 0 banks
Calibrating delay loop... 15.79 BogoMIPS (lpj=78976)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
atmel_usart.1: ttyS0 at MMIO 0xfffd0000 (irq = 2) is a ATMEL_SERIAL
console [ttyS0] enabled
atmel_usart.2: ttyS1 at MMIO 0xfffcc000 (irq = 3) is a ATMEL_SERIAL
Freeing init memory: 12K
Shell invoked to run file: /etc/rc
Command: 
Command: hostname skyeye
Command: mount -t proc proc /proc
Command: mkdir /var/lock /var/log /var/run /var/tmp
Command: cat /etc/motd
Welcome to
          ____ _  _
         /  __| ||_|                 
    _   _| |  | | _ ____  _   _  _  _ 
   | | | | |  | || |  _ \| | | |\ \/ /
   | |_| | |__| || | | | | |_| |/    \
   |  ___\____|_||_|_| |_|\____|\_/\_/
   | |
   |_|

For further information check:
http://www.uclinux.org/

Execution Finished, Exiting

Sash command shell (version 1.1.1)
/> free
MemTotal:           3936 kB
MemFree:            3308 kB
Buffers:               0 kB
/> free
MemTotal:           3936 kB
MemFree:            3296 kB
Buffers:               0 kB
/> free
MemTotal:           3936 kB
MemFree:            3284 kB
Buffers:               0 kB
/> ls -l /*

/bin:
-rwxr-xr-x  1 1000     1000        32152  Dec 20 2011  init
-rwxr-xr-x  1 1000     1000        70264  Dec 20 2011  sh

/dev:
crw-------  1 1000     0          5,   1  Jan  1 00:00 console
crw-------  1 1000     0          5,  64  Dec 21 2011  cua0
crw-------  1 1000     0          5,  65  Dec 21 2011  cua1
crw-------  1 1000     0          1,   2  Dec 21 2011  kmem
crw-------  1 1000     0          1,   1  Dec 21 2011  mem
crw-------  1 1000     0          1,   3  Dec 21 2011  null
crw-------  1 1000     0          1,   8  Dec 21 2011  random
crw-------  1 1000     0          5,   0  Dec 21 2011  tty
crw-------  1 1000     0          4,   0  Dec 21 2011  tty0
crw-------  1 1000     0          4,   1  Dec 21 2011  tty1
crw-------  1 1000     0          4,   2  Dec 21 2011  tty2
crw-------  1 1000     0          4,   3  Dec 21 2011  tty3
crw-------  1 1000     0          4,  64  Dec 21 2011  ttyS0
crw-------  1 1000     0          4,  65  Dec 21 2011  ttyS1
crw-------  1 1000     0          4,  66  Dec 21 2011  ttyS2
crw-------  1 1000     0          4,  67  Dec 21 2011  ttyS3
crw-------  1 1000     0          1,   9  Dec 21 2011  urandom
crw-------  1 1000     0          1,   5  Dec 21 2011  zero

/etc:
-rw-r--r--  1 1000     1000           49  Dec 21 2011  inittab
-rw-r--r--  1 1000     1000          296  Dec 11 2011  motd
-rw-r--r--  1 1000     1000           21  Dec 11 2011  passwd
-rwxr-xr-x  1 1000     1000          134  Dec 20 2011  rc
lrwxrwxrwx  1 1000     1000            8  Dec 21 2011  /init -> bin/init

/proc:
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 1
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 10
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 11
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 13
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 2
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 3
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 4
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 5
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 6
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 7
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 8
dr-xr-xr-x  6 0        0               0  Jan  1 00:00 9
-r--r--r--  1 0        0               0  Jan  1 00:00 buddyinfo
dr-xr-xr-x  2 0        0               0  Jan  1 00:00 bus
-r--r--r--  1 0        0               0  Jan  1 00:00 cmdline
-r--r--r--  1 0        0               0  Jan  1 00:00 consoles
-r--r--r--  1 0        0               0  Jan  1 00:00 cpuinfo
-r--r--r--  1 0        0               0  Jan  1 00:00 devices
dr-xr-xr-x  2 0        0               0  Jan  1 00:00 driver
-r--r--r--  1 0        0               0  Jan  1 00:00 execdomains
-r--r--r--  1 0        0               0  Jan  1 00:00 filesystems
dr-xr-xr-x  3 0        0               0  Jan  1 00:00 fs
-r--r--r--  1 0        0               0  Jan  1 00:00 interrupts
-r--r--r--  1 0        0               0  Jan  1 00:00 iomem
-r--r--r--  1 0        0               0  Jan  1 00:00 ioports
dr-xr-xr-x 34 0        0               0  Jan  1 00:00 irq
-r--r--r--  1 0        0               0  Jan  1 00:00 kallsyms
-r--------  1 0        0               0  Jan  1 00:00 kmsg
-r--r--r--  1 0        0               0  Jan  1 00:00 loadavg
-r--r--r--  1 0        0               0  Jan  1 00:00 locks
-r--r--r--  1 0        0               0  Jan  1 00:00 maps
-r--r--r--  1 0        0               0  Jan  1 00:00 meminfo
-r--r--r--  1 0        0               0  Jan  1 00:00 misc
lrwxrwxrwx  1 0        0              11  Jan  1 00:00 mounts
-r--r--r--  1 0        0               0  Jan  1 00:00 pagetypeinfo
lrwxrwxrwx  1 0        0              64  Jan  1 00:00 self
-r--r--r--  1 0        0               0  Jan  1 00:00 softirqs
-r--r--r--  1 0        0               0  Jan  1 00:00 stat
dr-xr-xr-x  1 0        0               0  Jan  1 00:00 sys
-r--r--r--  1 0        0               0  Jan  1 00:00 timer_list
dr-xr-xr-x  4 0        0               0  Jan  1 00:00 tty
-r--r--r--  1 0        0               0  Jan  1 00:00 uptime
-r--r--r--  1 0        0               0  Jan  1 00:00 version
-r--r--r--  1 0        0               0  Jan  1 00:00 vmstat
-r--r--r--  1 0        0               0  Jan  1 00:00 zoneinfo
lrwxrwxrwx  1 1000     1000            4  Dec 21 2011  /sbin -> /bin
lrwxrwxrwx  1 1000     1000            8  Dec 21 2011  /tmp -> /var/tmp

/var:
drwxr-xr-x  2 0        0               0  Jan  1 00:00 lock
drwxr-xr-x  2 0        0               0  Jan  1 00:00 log
drwxr-xr-x  2 0        0               0  Jan  1 00:00 run
drwxr-xr-x  2 0        0               0  Jan  1 00:00 tmp
/> cat /etc/inittab 
# inet:unknown:/bin/inetd
# boa:unknown:/bin/boa
/> cat /etc/rc
#!/bin/sh

hostname skyeye
mount -t proc proc /proc
#mount -t tmpfs tmp /var
mkdir /var/lock /var/log /var/run /var/tmp
cat /etc/motd

/> ^C
phil at phil-laptop:~/arm/git/linux-at91$ exit

Script done on Wed 21 Dec 2011 06:07:20 PM EST

-------------- next part --------------
A non-text attachment was scrubbed...
Name: diff
Type: application/octet-stream
Size: 6118 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111222/f072d61d/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: defconfig
Type: application/octet-stream
Size: 1557 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111222/f072d61d/attachment-0003.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: at91x40_devices.c
Type: text/x-csrc
Size: 3814 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111222/f072d61d/attachment-0001.bin>
