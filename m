From: linux.melwyn@gmail.com (melwyn lobo)
Date: Sun, 15 Sep 2013 22:40:57 +0900
Subject: Vexpress config
In-Reply-To: <CAHSGOuusvazUFFAAraCZmQgXr8LvwdV4zess=KsEMsCtbg0y2A@mail.gmail.com>
References: <CAHSGOuusvazUFFAAraCZmQgXr8LvwdV4zess=KsEMsCtbg0y2A@mail.gmail.com>
Message-ID: <CAHSGOus7VsJh+-mpxOWeeyqfsB4jNYiG-vwRirFaJh39c3Heww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To better clarify the issue. When I boot a single core Cortex-A9 RTSM
with vexpress_defconfig compiled kernel and kernel command line as
1.  "earlyprintk console=ttyAMA0,38400n8 mem=512M maxcpus=1"
2.  "earlyprintk console=ttyAMA0,38400n8 mem=512M maxcpus=0"
3.  "earlyprintk console=ttyAMA0,38400n8 mem=512M nosmp"
4.  "earlyprintk console=ttyAMA0,38400n8 mem=512M"
the kernel throws an OOPS error:

Uncompressing Linux... done, booting the kernel.

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpuset
Linux version 3.10.9 (m.lobo at mcbdhost-Dataserver) (gcc version 4.7.3
(Sourcery CodeBench Lite 2013.05-24) ) #8 Fri Sep 13 10:43:53 KST 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ARM-Versatile Express
Truncating memory at 0x80000000 to fit in 32-bit physical address space

bootconsole [earlycon0] enabled

Memory policy: ECC disabled, Data cache writeback

CPU: All CPU(s) started in SVC mode.
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms

Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: earlyprintk console=ttyAMA0,38400n8 mem=512M

PID hash table entries: 2048 (order: 1, 8192 bytes)

Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)

Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

Memory: 512MB = 512MB total
Memory: 507668k/507668k available, 16620k reserved, 0K highmem

Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)

    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
    lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x80453bd0   (4399 kB)
      .init : 0x80454000 - 0x8047bafc   ( 159 kB)
      .data : 0x8047c000 - 0x804a45e0   ( 162 kB)
       .bss : 0x804a45e0 - 0x804c4b10   ( 130 kB)

SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1

NR_IRQS:16 nr_irqs:16 16

Unhandled fault: external abort on non-linefetch (0x1008) at 0xf8201004

Internal error: : 1008 [#1] ARM
Modules lin
ked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.9 #8
task: 804862b8 ti: 8047c000 task.ti: 8047c000
PC is at gic_init_bases+0x98/0x320
LR is at 0xffffffff
pc : []    lr : []    psr: 000001d3
sp : 8047df88  ip : 804843b0  fp : 00000000
r10: 00000000  r9 : 413fc090  r8 : 00000010
r7 : f8200100  r6 : 00000000  r5 : 00000010  r4 : f8201000
r3 : 00000000  r2 : f820
1000  r1 : 0000001d  r0 : 00000000
Flags: nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 80004059  DAC: 00000015
Process swapper (pid: 0, stack limit = 0x8047c230)
Stack: (0x8047df88 to 0x8047e000)
df80:                   8045acb0 9f804780 f8201000 80473300 ffffffff 808c60c0
dfa0: 80004059 8045acd0 00000000 00000000 804a4600 8045a808 8045a7f0 804563c8
dfc0: 00000000 804548cc ffffffff ffffffff 804544f0 00000000 00000000 80473300
dfe0: 00000000 10c5
3c7d 80484028 804732fc 8048705c 80008070 00000000 00000000
[] (gic_init_bases+0x98/0x320) from [] (ct_ca9x4_init_irq+0x54/0x5c)[]
(ct_ca9x4_init_irq+0x54/0x5c) from [] (v2m_init_irq+0x18/0x1c)
[] (v2m_init_irq+0x18/0x1c) from [] (init_IRQ+0x28/0x2c)
[] (init_IRQ+0x28/0x2c) from [] (start_kernel+0x1a4/0x2ec)
[] (start_kernel+0x1a4/0x2ec) from [] (0x80008070)

Code: 13c5501f 13a08010 10855008 03a08010 (e5942004)

---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Attempted to kill the idle task!


Appreciate any pointers.
Thanks

On Sat, Sep 14, 2013 at 8:15 PM, melwyn lobo <linux.melwyn@gmail.com> wrote:
> Hi,
> I need to compile a kernel for ARM RTSM based on Cortex-A9 (single
> core), RTSM_VE_Cortex-A9x1, device.  Which defconfig should I use ?
> I think that vexpress_defconfig is for A quad core A9 based Vexpress platform.
>
> Thanks
