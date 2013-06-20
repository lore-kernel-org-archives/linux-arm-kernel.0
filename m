From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 13:39:48 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <51C2E917.9000708@pengutronix.de>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
 <51C2D5EF.3040803@pengutronix.de> <20130620102856.GC18536@arm.com>
 <20130620111255.GD18536@arm.com> <51C2E917.9000708@pengutronix.de>
Message-ID: <51C2EA04.4060701@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 01:35 PM, Marc Kleine-Budde wrote:
> On 06/20/2013 01:12 PM, Catalin Marinas wrote:
>> On Thu, Jun 20, 2013 at 11:28:56AM +0100, Catalin Marinas wrote:
>>> We may need to place the preempt disable/enable at a higher level in the
>>> scheduler. My theory is that we have a context switch from prev to next.
>>> We get preempted just before finish_arch_post_lock_switch(), so the MMU
>>> hasn't been switched yet. The new switch during preemption happens to a
>>> thread with the same next mm, so the scheduler no longer switch_mm() and
>>> the TIF_SWITCH_MM isn't set for the new thread.
>>>
>>> I'll come back with another patch shortly.
>>
>> Here's another attempt (as before, only compile-tested):
> 
> booting kernel from /image
> zImage: concatenated oftree detected
> booting Linux kernel with devicetree
> 
> ...dead...
> 
> Does every process have a "mm"? Even Kernel threads?

early printk gives us:

[    0.153207] CPU: Testing write buffer coherency: ok
[    0.161494] Unable to handle kernel NULL pointer dereference at virtual address 000001a4
[    0.170030] Unable to handle kernel NULL pointer dereference at virtual address 000001a4
[    0.178363] pgd = c0004000
[    0.181377] Unable to handle kernel NULL pointer dereference at virtual address 000001a4
[    0.189713] pgd = c0004000
[    0.192676] [000001a4] *pgd=00000000
[    0.196447] Internal error: Oops: 5 [#1] PREEMPT ARM
[    0.201594] Modules linked in:
[    0.204820] CPU: 0 PID: 2 Comm: swapper Not tainted 3.10.0-rc6-00085-g1c69299 #25
[    0.212524] task: c78408a0 ti: c7848000 task.ti: c7848000
[    0.218142] PC is at finish_task_switch.constprop.89+0x88/0x140
[    0.224279] LR is at _raw_spin_unlock_irq+0x38/0x58
[    0.229342] pc : [<c0047218>]    lr : [<c04554b8>]    psr: 60000053
[    0.229342] sp : c7849c58  ip : 600000d3  fp : c7849c84
[    0.241191] r10: 00000000  r9 : c0650088  r8 : c7840000
[    0.246599] r7 : c065e118  r6 : c7848000  r5 : 00000000  r4 : 00000000
[    0.253328] r3 : c78408a0  r2 : c7849c50  r1 : 00000001  r0 : 40000001
[    0.260059] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.267671] Control: 0005317f  Table: 40004000  DAC: 00000017
[    0.273607] Process swapper (pid: 2, stack limit = 0xc78481b8)
[    0.279631] Stack: (0xc7849c58 to 0xc784a000)
[    0.284163] 9c40:                                                       00000002 00000000
[    0.292587] 9c60: c00471d4 00000017 c78408a0 c7840000 c0658610 c7848000 c0658610 c065e118
[    0.301011] 9c80: c7849d14 c0453cbc 00000002 c7848000 c06ae110 c06ae310 c7849c98 c7849c98
[    0.309430] 9ca0: 0a217bcd 00000000 00000100 c002368c c78408a0 00000000 00000001 00000008
[    0.317852] 9cc0: c068a5c4 c0023894 c78408a0 c7804c00 00000100 00000004 00000000 c7848000
[    0.326274] 9ce0: c78408a0 c0454458 00000001 c000e9a4 c7848000 c7848000 20000053 ffffffff
[    0.334695] 9d00: c7849d5c c000e9a4 c7848000 00000006 c7849d24 c0454468 c78408a0 c001e2b0
[    0.343115] 9d20: 00000000 c000e9bc 00000001 00000001 00000000 c78408a0 0000004c c0654f08
[    0.351537] 9d40: c068c9e0 00000000 00000001 60000053 00000006 00000000 c78408a0 c7849d70
[    0.359956] 9d60: c005e134 c001e2b0 20000053 ffffffff 00000000 00000000 00000000 00000000
[    0.368378] 9d80: c068d2ca 0000004c 60000053 c0011f18 00000001 00000000 00000000 00000000
[    0.376795] 9da0: c0653df8 000001a4 00000000 00000005 c7849f28 000001a4 00000000 c78408a0
[    0.385216] 9dc0: 00000028 c044d514 c055b878 c7849de4 00000000 c7849de4 00000028 c044d2b0
[    0.393637] 9de0: c055b878 c055b84c 000001a4 c055b84c 00000000 c0016144 c06594f8 00000000
[    0.402053] 9e00: c7848000 c005b9ec 00000001 c7840ba0 00000000 00000000 c06578b4 c066a370
[    0.410474] 9e20: c7848000 00000000 00000001 c7840ba0 00000006 00000000 00086006 00000000
[    0.418895] 9e40: 60000093 c02575f0 c7848000 00000000 c7848000 c06578b4 00000000 00000000
[    0.427317] 9e60: 00000000 00000005 c001629c c06547b0 000001a4 c7849f28 00000000 00000000
[    0.435736] 9e80: c7849f9c c00085c4 c0658620 c066a3b8 c0659538 00000000 00000009 c005ba58
[    0.444156] 9ea0: 00000000 c06539e0 c7926000 c0650088 c06578b4 c0042a28 c7848000 00000000
[    0.452579] 9ec0: 00000001 c7840ba0 00000009 00000000 c78408a0 00000017 c7848000 c06585d0
[    0.460998] 9ee0: c065e0d8 c0042a58 00000000 c0650088 c065e0d8 c000ed14 40000013 00000000
[    0.469422] 9f00: c7848000 00000000 c7848000 c0658620 c0047218 40000053 ffffffff c7849f5c
[    0.477840] 9f20: c06528b8 c000e91c 00000000 00000001 c7849f68 c78408a0 00000000 00000000
[    0.486264] 9f40: c7848000 c065e118 c06528b8 00000000 00000000 c7849f9c 600000d3 c7849f70
[    0.494684] 9f60: c04554b8 c0047218 40000053 ffffffff 00000002 00000000 c00471d4 00000001
[    0.503105] 9f80: 00000000 c003da70 00000000 00000000 00000000 00000000 c7849fac c0047de0
[    0.511525] 9fa0: 00000000 c003da70 00000000 c000ee10 00000000 00000000 00000000 00000000
[    0.519943] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.528361] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 55575557 75557153
[    0.536811] [<c0047218>] (finish_task_switch.constprop.89+0x88/0x140) from [<c0453cbc>] (__schedule+0x204/0x600)
[    0.547275] [<c0453cbc>] (__schedule+0x204/0x600) from [<c0454468>] (preempt_schedule_irq+0x48/0x74)
[    0.556685] [<c0454468>] (preempt_schedule_irq+0x48/0x74) from [<c000e9bc>] (svc_preempt+0x8/0x18)
[    0.565914] [<c000e9bc>] (svc_preempt+0x8/0x18) from [<c001e2b0>] (vprintk_emit+0x190/0x53c)
[    0.574625] [<c001e2b0>] (vprintk_emit+0x190/0x53c) from [<c044d514>] (printk+0x30/0x40)
[    0.582975] [<c044d514>] (printk+0x30/0x40) from [<c044d2b0>] (__do_kernel_fault.part.9+0x38/0x74)
[    0.592208] [<c044d2b0>] (__do_kernel_fault.part.9+0x38/0x74) from [<c0016144>] (do_page_fault+0x2b8/0x388)
[    0.602224] [<c0016144>] (do_page_fault+0x2b8/0x388) from [<c00085c4>] (do_DataAbort+0x34/0x98)
[    0.611180] [<c00085c4>] (do_DataAbort+0x34/0x98) from [<c000e91c>] (__dabt_svc+0x3c/0x60)
[    0.619670] Exception stack(0xc7849f28 to 0xc7849f70)
[    0.624914] 9f20:                   00000000 00000001 c7849f68 c78408a0 00000000 00000000
[    0.633334] 9f40: c7848000 c065e118 c06528b8 00000000 00000000 c7849f9c 600000d3 c7849f70
[    0.641746] 9f60: c04554b8 c0047218 40000053 ffffffff
[    0.647009] [<c000e91c>] (__dabt_svc+0x3c/0x60) from [<c0047218>] (finish_task_switch.constprop.89+0x88/0x140)
[    0.657294] [<c0047218>] (finish_task_switch.constprop.89+0x88/0x140) from [<c0047de0>] (schedule_tail+0xc/0x5c)
[    0.667756] [<c0047de0>] (schedule_tail+0xc/0x5c) from [<c000ee10>] (ret_from_fork+0x4/0x34)
[    0.676442] Code: e59f00b0 eb10389b e596300c e59350e0 (e59531a4)
[    0.682941] ---[ end trace 1b75b31a2719ed1c ]---

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/92b4f37c/attachment.sig>
