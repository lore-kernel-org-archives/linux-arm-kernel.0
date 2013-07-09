From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Tue, 09 Jul 2013 11:34:45 +0800
Subject: v3.10 - big endian core support
In-Reply-To: <51DB64FB.8030208@gmail.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
 <20130708084911.GA22057@mudshark.cambridge.arm.com>
 <51DA8BBF.7080104@gmail.com>
 <20130708110202.GD22057@mudshark.cambridge.arm.com>
 <20130708170352.GA24361@mudshark.cambridge.arm.com>
 <51DB64FB.8030208@gmail.com>
Message-ID: <51DB84D5.3000700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 09:18 AM, jgq516 at gmail.com wrote:
> On 07/09/2013 01:03 AM, Will Deacon wrote:
>> On Mon, Jul 08, 2013 at 12:02:02PM +0100, Will Deacon wrote:
>>> On Mon, Jul 08, 2013 at 10:51:59AM +0100, jgq516 at gmail.com wrote:
>>>> The printascii can output before "b __enable_mmu", after move it to
>>>> __mmap_switched, nothing can be printed. But if disable LPAE, 
>>>> printascii
>>>> works again in __mmap_switched.
>>> Ok, so the page tables are broken. The code is there to swap the two 
>>> words,
>>> but perhaps something ends up being off-by-4 or the like. I'll try 
>>> and take
>>> a look.
>> Right, I managed to have a quick play with a 3.10 kernel and the good 
>> news
>> is that the page tables are fine. The bad part is that using
>> CONFIG_ARM_ATAG_DTB_COMPAT to get my command-line from ATAGs into the 
>> FDT
>> results in a NULL command line, so I don't see any output. If I 
>> hardcode the
>> command line in the kernel image, things work fine.
>>
Hi Will,

Which kernel tree are you used? I tried latest mainline kernel (used 
vexpress_defconfig
and vexpress-v2p-ca15_a7.dtb) without any modification, but it hangs as 
follows.

## Booting kernel from Legacy Image at 80000000 ...
    Image Name:   Linux-3.10.0+
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2857168 Bytes = 2.7 MiB
    Load Address: 60008000
    Entry Point:  60008000
    Verifying Checksum ... OK
## Flattened Device Tree blob at 81f00000
    Booting using the fdt blob at 0x81f00000
    Loading Kernel Image ... OK
OK
    reserving fdt memory region: addr=ff000000 size=1000000
    Loading Device Tree to 9fee9000, end 9feee0a9 ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpuset
Linux version 3.10.0+ (gjiang at gjiang-desktop) (gcc version 4.6.3 
(Sourcery CodeBench Lite 2012.03-57) ) #1 SMP Tue Jul 9 11:18:52 CST 2013
CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine: ARM-Versatile Express, model: V2P-CA15_CA7
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writealloc
------------[ cut here ]------------
WARNING: at arch/arm/kernel/devtree.c:147 arm_dt_init_cpu_maps+0x134/0x1bc()
DT /cpu 5 nodes greater than max cores 4, capping them
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.0+ #1
[<80015b0c>] (unwind_backtrace+0x0/0xf8) from [<80011f20>] 
(show_stack+0x10/0x14)
[<80011f20>] (show_stack+0x10/0x14) from [<803a9c08>] (dump_stack+0x70/0x88)
[<803a9c08>] (dump_stack+0x70/0x88) from [<80021c10>] 
(warn_slowpath_common+0x54/0x68)
[<80021c10>] (warn_slowpath_common+0x54/0x68) from [<80021cb8>] 
(warn_slowpath_fmt+0x30/0x40)
[<80021cb8>] (warn_slowpath_fmt+0x30/0x40) from [<804d0cac>] 
(arm_dt_init_cpu_maps+0x134/0x1bc)
[<804d0cac>] (arm_dt_init_cpu_maps+0x134/0x1bc) from [<804cfd1c>] 
(setup_arch+0x680/0x898)
[<804cfd1c>] (setup_arch+0x680/0x898) from [<804cd640>] 
(start_kernel+0x90/0x310)
[<804cd640>] (start_kernel+0x90/0x310) from [<80008074>] (0x80008074)
---[ end trace 1b75b31a2719ed1c ]---
SMP: 5 cores greater than maximum (4), clipping
PERCPU: Embedded 7 pages/cpu @80d56000 s7296 r8192 d13184 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/nfs console=ttyAMA0,38400n8 rw 
init=/linuxrc nfsroot=128.224.163.23:/home/gjiang/work/a15fs ip=dhcp 
earlyprintk
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033984K/1048576K available (3867K kernel code, 166K rwdata, 
1012K rodata, 199K init, 137K bss, 14592K reserved)
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
     modules : 0x7f000000 - 0x80000000   (  16 MB)
       .text : 0x80008000 - 0x804cc208   (4881 kB)
       .init : 0x804cd000 - 0x804fec80   ( 200 kB)
       .data : 0x80500000 - 0x80529a60   ( 167 kB)
        .bss : 0x80529a60 - 0x8054c0bc   ( 138 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
Failed to obtain parent clocks for SP810!
sp804: arm,sp804 clock not found: -2
sp804: clock not found: -2
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
Console: colour dummy device 80x30
Calibrating delay loop...

Thanks,
Xiao
>> What kernel are you using, and how are you passing your command line?
> 3.4 kernel and command line is passed from uboot, I will try 3.10 
> kernel, then cherry pick
> some related patches from 3.10 if 3.10 works.
>
> Thanks,
> Xiao
>> Will
>
