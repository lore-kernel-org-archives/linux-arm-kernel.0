From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 17 Jun 2015 15:35:13 -0500
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <CAMuHMdUXCy+87-pwLiJ7ynaM1AeFq0f7R3sJ4prdE3QN09z++w@mail.gmail.com>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <CAMuHMdX=T3CsLTT95H_07Si6Kd8SRraBfxADpn+VtAF4GmZ=mw@mail.gmail.com>
 <CAMuHMdUQkm_9PhSdGS8j85Uodm-o0jiki=Xh4h59PBShB=rCXw@mail.gmail.com>
 <20150601105319.GQ2067@n2100.arm.linux.org.uk>
 <CAMuHMdUXCy+87-pwLiJ7ynaM1AeFq0f7R3sJ4prdE3QN09z++w@mail.gmail.com>
Message-ID: <CADhT+wdJX7jMO3_rafrZMeA5ZVMaA6b2U4zkksfJcUjh41mH9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 6:50 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Russell,
>
> On Mon, Jun 1, 2015 at 12:53 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Jun 01, 2015 at 12:41:01PM +0200, Geert Uytterhoeven wrote:
>>> FWIW, I have the feeling this has a slight influence on boot reliability on
>>> two of my boards:
>>>   - r8a7740/armadillo, which is known to suffer from a cache-related bug in
>>>     its bootloader, seems to have a higher change of booting successfully on
>>>     cold boot,
>>>   - sh73a0/kzm9g, which has known cache-issues with secondary CPU boot up,
>>>     seems to have a lower chance of booting successfully.
>>>
>>> No time to spend all week turning this into a statistical significant test
>>> project... The reset button is my friend...
>>
>> Damn it, you sent this right after I merged and pushed out this change in
>> my for-arm-soc branch, and was just about to send it to the arm-soc people.
>> What excellent timing you have. :)
>
> Don't worry, I didn't send that email to make you postpone this change.
> Giving the fuzziness of reproduction, and the flakiness (esp. on Armadillo)
> of the boot loader, and these are old SoCs, please go ahead.
>
>> What happens on the kzm9g if you revert the mach-shmobile changes?
>
> Seems to make no difference.
>
>> For armadillo, do you use the decompressor?  That should be doing all the
>> cache cleaning already, prior to the kernel being entered.
>
> I think so.
>
> Corruption pattern ranges from lock up, over "Error: unrecognized/unsupported
> machine ID", to booting almost completely, but lacking a few devices due to
> a corrupted DTB. Been like that as long as I remember, i.e. since I got the
> board ca. 1 year ago. Boots fine (100%) with kexec.
>

It seems like this patch is causing the SoCFPGA to not boot with SMP
reliably. About 1 out of every 10 reboots, I'm seeing the boot failure
below. The error seems to only happen when I do a cold or warm reboot,
but never occurs during a power-up. If I revert this patch, or put
back the call to v7_invalidate_l1 in socfpga_secondary_startup , then
its able to boot 100% of the time.

Just wondering if anyone else is seeing something similar?

I am testing this on both linux-next and arm-soc/rmk/for-arm-soc. When
the failure happens, here's the log:

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpuset
Linux version 4.1.0-rc8-next-20150617-00002-gdd1f624
(dinguyen at linux-builds1) (gcc version 4.7.3 20130226 (prerelease)
(crosstool-NG linaro-1.13.1-4.7-2013.03-20130313 - Linaro GCC 2013.03)
) #1 SMP Wed Jun 17 14:22:59 CDT 2015
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Altera SOCFPGA Cyclone V SoC Development Kit
Truncating RAM at 0x00000000-0x40000000 to -0x2f800000
Memory policy: Data cache writealloc
On node 0 totalpages: 194560
free_area_init_node: node 0, pgdat c0692640, node_mem_map ef20b000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
PERCPU: Embedded 12 pages/cpu @ef1e1000 s19648 r8192 d21312 u49152
pcpu-alloc: s19648 r8192 d21312 u49152 alloc=12*4096
pcpu-alloc: [0] 0 [0] 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193040
Kernel command line: console=ttyS0,115200 root=/dev/mmcblk0p2 rw
rootwait ip=dhcp earlyprintk
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 764288K/778240K available (4782K kernel code, 286K rwdata,
1344K rodata, 304K init, 135K bss, 13952K reserved, 0K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc0603e78   (6128 kB)
      .init : 0xc0604000 - 0xc0650000   ( 304 kB)
      .data : 0xc0650000 - 0xc0697920   ( 287 kB)
       .bss : 0xc0697920 - 0xc06b976c   ( 136 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
    Additional per-CPU info printed with stalls.
    Build-time adjustment of leaf fanout to 32.
NR_IRQS:16 nr_irqs:16 16
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 8 ways, 512 kB
L2C-310: CACHE_ID 0x410030c9, AUX_CTRL 0x46060001
clocksource: timer1: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604467 ns
sched_clock: 32 bits at 100MHz, resolution 10ns, wraps every 21474836475ns
Console: colour dummy device 80x30
Calibrating delay loop... 1836.64 BogoMIPS (lpj=9183232)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x8280 - 0x82d8
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted
4.1.0-rc8-next-20150617-00002-gdd1f624 #1
Hardware name: Altera SOCFPGA
task: eecaeac0 ti: eecce000 task.ti: eecce000
PC is at vfp_notifier+0x58/0x12c
LR is at notifier_call_chain+0x44/0x84
pc : [<c000a6bc>]    lr : [<c003d134>]    psr: 80000193
sp : eeccff48  ip : c06563c8  fp : eeccffd4
r10: eecaef80  r9 : ef1f1300  r8 : 00000002
r7 : eecd0000  r6 : c0656bc0  r5 : 00000000  r4 : eecd0000
r3 : c000a664  r2 : eecd0000  r1 : 00000002  r0 : c06563c8
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 0000404a  DAC: 00000015
Process swapper/1 (pid: 0, stack limit = 0xeecce218)
Stack: (0xeeccff48 to 0xeecd0000)
ff40:                   c000a664 ffffffff 00000000 c003d134 eecd0018 eecaeac0
ff60: c06648e0 0b52d2f9 c048cfa8 c003d18c 00000000 f0002100 00000001 c003d1ac
ff80: 00000000 eecaeac0 c064f300 c001369c c064b304 c0013140 00000000 ef1ed328
ffa0: eeccffe8 c001e760 c0486ec4 2eba2000 c06957c0 c06524dc 00000015 c06957c0
ffc0: c048c778 c064b304 c06957c0 00000000 eeccffdc c0486ec4 eeccffe4 c0487138
ffe0: 00000001 c00544e8 c0009494 c0697bc0 00000000 000094ac 7ef5bffd 3f39b3f8
[<c000a6bc>] (vfp_notifier) from [<c003d134>] (notifier_call_chain+0x44/0x84)
[<c003d134>] (notifier_call_chain) from [<c003d18c>]
(__atomic_notifier_call_chain+0x18/0x20)
[<c003d18c>] (__atomic_notifier_call_chain) from [<c003d1ac>]
(atomic_notifier_call_chain+0x18/0x20)
[<c003d1ac>] (atomic_notifier_call_chain) from [<c001369c>]
(__switch_to+0x34/0x58)
Code: e3a03002 e5843208 e3a00000 e8bd8038 (eef85a10)
---[ end trace 9eaea9661b3b550a ]---
Kernel panic - not syncing: Attempted to kill the idle task!
SMP: failed to stop secondary CPUs
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

Dinh
