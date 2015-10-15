From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 15 Oct 2015 10:27:09 +0200
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <20151014174503.GQ32532@n2100.arm.linux.org.uk>
References: <561E6407.6000002@sigmadesigns.com>
 <20151014174503.GQ32532@n2100.arm.linux.org.uk>
Message-ID: <561F635D.6070008@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2015 19:45, Russell King - ARM Linux wrote:

> Now, you've quoted one line from the oops, and a load of information that
> we already know (because we have access to the manuals).  You've omitted
> the rest of the oops, which is information we don't know, and is information
> that we, as kernel developers, have decided that the kernel should print
> to allow _us_, on the receiving end of an oops, to be able to diagnose
> what happened and why.
> 
> Please, if you get an oops, include the _full_ dump when reporting
> problems, even if you've diagnosed it already.  Not only does it help to
> confirm the diagnosis, but it also serves as a source of documentation
> if/when we commit a change to solve it.

Here are the relevant parts of the boot log.

old_aux = 0x62460801
L2C-310 enabling early BRESP for Cortex-A9
L2C-310: enabling full line of zeros but not enabled in Cortex-A9
reg=0x104 val=0x66460801
reg=0x100 val=0x1
L2C-310 I prefetch enabled, offset 1 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0+ #259
Hardware name: Sigma Tango DT
task: c035ff28 ti: c035c000 task.ti: c035c000
PC is at l2c310_enable+0x1cc/0x21c
LR is at console_unlock+0x25c/0x554
pc : [<c0339258>]    lr : [<c00606b8>]    psr: 200000d3
sp : c035deb8  ip : c035dda8  fp : c035dee4
r10: c0371694  r9 : 00000000  r8 : 00000000
r7 : c0371694  r6 : e8806000  r5 : 00000008  r4 : 62460801
r3 : 0000004f  r2 : 00000001  r1 : 600000d3  r0 : 0000003a
Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8000404a  DAC: 00000015
Process swapper/0 (pid: 0, stack limit = 0xc035c218)
Stack: (0xc035deb8 to 0xc035e000)
dea0:                                                       00000000 00000008
dec0: 00000048 c0371694 c0355c28 410000c8 62460801 00000008 c035df4c c035dee8
dee0: c0339be8 c0339098 e7af5cf4 00000000 c033900c c035df1c c0339810 c0023578
df00: c00235ec c0023640 c00240b8 c0023870 c0023694 c0024038 c0024430 00000000
df20: 00000000 c0371694 e7af5cf4 62460801 c0355c28 c0371280 c03535e0 e7af5100
df40: c035df94 c035df50 c0339ee4 c0339a2c ffffffff 00000000 00000002 20100000
df60: 20100fff e7af5d4c 00000200 00000000 00000000 00000000 c03535d0 c0371280
df80: c035e400 ffffffff c035dfac c035df98 c0334910 c0339ce8 00000000 c0371280
dfa0: c035dff4 c035dfb0 c0333bd8 c03348ac ffffffff ffffffff 00000000 c03336d8
dfc0: 00000000 c03535e0 00000000 c0371514 c035e480 c03535dc c0360fec 8000406a
dfe0: 413fc090 00000000 00000000 c035dff8 8000807c c0333964 00000000 00000000
Backtrace: 
[<c033908c>] (l2c310_enable) from [<c0339be8>] (__l2c_init+0x1c8/0x248)
 r8:00000008 r7:62460801 r6:410000c8 r5:c0355c28 r4:c0371694
[<c0339a20>] (__l2c_init) from [<c0339ee4>] (l2x0_of_init+0x208/0x218)
 r10:e7af5100 r9:c03535e0 r8:c0371280 r7:c0355c28 r6:62460801 r5:e7af5cf4
 r4:c0371694
[<c0339cdc>] (l2x0_of_init) from [<c0334910>] (init_IRQ+0x70/0x88)
 r7:ffffffff r6:c035e400 r5:c0371280 r4:c03535d0
[<c03348a0>] (init_IRQ) from [<c0333bd8>] (start_kernel+0x280/0x368)
 r5:c0371280 r4:00000000
[<c0333958>] (start_kernel) from [<8000807c>] (0x8000807c)
 r10:00000000 r9:413fc090 r8:8000406a r7:c0360fec r6:c03535dc r5:c035e480
 r4:c0371514
Code: e3140001 0a000012 ee113f30 e383300e (ee013f30) 
---[ end trace cb88537fdc8fa200 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!


And here's the relevant objdump:

c0339220:       e31c0002        tst     ip, #2
c0339224:       e34c2031        movt    r2, #49201      ; 0xc031
c0339228:       e34c302f        movt    r3, #49199      ; 0xc02f
c033922c:       e30e00b8        movw    r0, #57528      ; 0xe0b8
c0339230:       11a01002        movne   r1, r2
c0339234:       01a01003        moveq   r1, r3
c0339238:       e31c0001        tst     ip, #1
c033923c:       e34c002f        movt    r0, #49199      ; 0xc02f
c0339240:       01a02003        moveq   r2, r3
c0339244:       ebfcf72d        bl      c0276f00 <printk>
c0339248:       e3140001        tst     r4, #1
c033924c:       0a000012        beq     c033929c <l2c310_enable+0x210>
c0339250:       ee113f30        mrc     15, 0, r3, cr1, cr0, {1}
c0339254:       e383300e        orr     r3, r3, #14
c0339258:       ee013f30        mcr     15, 0, r3, cr1, cr0, {1}
c033925c:       f57ff06f        isb     sy
c0339260:       e59f003c        ldr     r0, [pc, #60]   ; c03392a4 <l2c310_enable+0x218>
c0339264:       ebfcf241        bl      c0275b70 <register_cpu_notifier>
c0339268:       ea00000b        b       c033929c <l2c310_enable+0x210>

Regards.
