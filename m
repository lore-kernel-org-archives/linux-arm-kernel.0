From: anton@picapica.im (Anton)
Date: Fri, 16 Nov 2018 15:52:16 +0100
Subject: [BUG] Is "mem=" kernel command line parameter broken on ARM?
In-Reply-To: <20181116140627.GW30658@n2100.armlinux.org.uk>
References: <20181116133236.GA27819@picapica.im>
 <20181116140627.GW30658@n2100.armlinux.org.uk>
Message-ID: <20181116145216.GA3365@picapica.im>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 02:06:27PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 16, 2018 at 02:32:36PM +0100, Anton wrote:
> > Hello
> > 
> > 
> > I am trying to boot Linux on a custom board having SAMA5D21 chip.
> > It has 64MiB of DRAM. So I thought it was a good idea to pass amount
> > of physical memory available through command line parameter "mem=64M".
> 
> mem specifies not only the amount of memory, but also its location.
> mem=64M tells the kernel that there is 64M at physical address zero.
> Your device may not have memory at physical address zero, so that
> will cause the kernel to try to use something that isn't RAM as
> memory.
> 
> My guess is that memory starts at 0x20000000 on your platform based
> on what you've provided in uboot, but I can't be certain.
> 

But this does not explain successful boot with mem=512M.
Yes, physical memory (DRAM mapping) starts at physical address 0x20000000.
0x20000000 = 512M so in this case kernel should try to use address range
from 0 to 0x20000000 and fail, because DRAM is mapped above that range.

mem=64M at 0x20000000 crashes in a same way:

=> setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk1p2 rw rootwait mem=64M at 0x20000000
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
