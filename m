From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 26 Sep 2013 17:42:53 +0200
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <21060.15934.600859.167074@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
Message-ID: <524455FD.7070808@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 04:01 PM, =?utf-8?Q?Lothar_Wa=C3=9Fmann?= wrote:
> Hi,
> 
> when enabling the can interface with 'ifconfig can0 up' (after
> configuring the bitrate with canconfig) on an i.MX6Q board (TX6) I'm
> getting the following kernel dump:
> 
> |flexcan 2094000.flexcan can0: writing ctrl=0x0a212003
> |flexcan 2094000.flexcan can0: flexcan_set_bittiming: mcr=0x5980000f ctrl=0x0a212003
> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing mcr=0x79a2020f
> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing ctrl=0x0a21ac53
> |Unhandled fault: imprecise external abort (0x1c06) at 0x00057adc

Looks like a NULL pointer deref to me. But it doesn't make any sense,
because the offset is way beyond the length of the struct flexcan_regs.

> |Internal error: : 1c06 [#1] SMP ARM
> |Modules linked in: flexcan can_dev
> |CPU: 2 PID: 1215 Comm: ifconfig Not tainted 3.12.0-rc1-next-20130919-karo+ #91
> |task: beac3000 ti: be1fc000 task.ti: be1fc000
> |PC is at flexcan_chip_start+0x200/0x344 [flexcan]
> |LR is at flexcan_chip_start+0x1d4/0x344 [flexcan]
> |pc : [<7f007560>]    lr : [<7f007534>]    psr: 80000013
> |sp : be1fde40  ip : c0a1808c  fp : 00000001
> |r10: 00000000  r9 : 00008914  r8 : 7e894c38
> |r7 : 04000000  r6 : c0a18088  r5 : be168000  r4 : c0a18000
> |r3 : 00000001  r2 : c0a18090  r1 : 00000000  r0 : 00000000
> |Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> |Control: 10c5387d  Table: 4e28804a  DAC: 00000015
> |Process ifconfig (pid: 1215, stack limit = 0xbe1fc240)
> |Stack: (0xbe1fde40 to 0xbe1fe000)
> |de40: 0a21ac53 0a212003 be8f0d00 be168000 00000000 be821580 be16802c 7f008170
> |de60: be168000 be168000 be168000 000000c1 7f008678 80357868 803577ec be168000
> |de80: 000000c1 00000001 00040080 80357aa0 beac3000 be168000 00040080 be9fd800
> |dea0: be168000 80357ba0 00000000 be9fd80c be9fd800 803a1b68 00000000 01894c38
> |dec0: 306e6163 00000000 00000000 00000000 000000c1 76f4f4d0 7e894f01 000566ce
> |dee0: 00000080 00008914 be1a8e40 7e894c38 00008914 00000003 be1fc000 7e894c38
> |df00: be500020 80343350 7e894c38 be1a8e40 00000003 800bb464 7e894c38 800bbfa8
> |df20: bea8df80 00000003 8041e680 800add4c 00000020 00000003 805ccff8 be1fdf60
> |df40: 00000003 800ade08 805c6bf8 805ccff8 be500000 00000000 00000002 80342b0c
> |df60: be880e50 7e894c38 be1a8e40 00000000 00008914 00000003 be1fc000 00000000
> |df80: 00000000 800bc030 00000003 00000000 0005868f 00000004 00054f14 00000036
> |dfa0: 8000e7e4 8000e660 0005868f 00000004 00000003 00008914 7e894c38 0005868f
> |dfc0: 0005868f 00000004 00054f14 00000036 00000000 00000000 7e894f0f 00000000
> |dfe0: 00000000 7e894c20 0000cad4 76e1a87c 20000010 00000003 4eff1811 4eff1c11
> |[<7f007560>] (flexcan_chip_start+0x200/0x344 [flexcan]) from [<7f008170>] (flexcan_open+0x74/0x118 [flexcan])
> |[<7f008170>] (flexcan_open+0x74/0x118 [flexcan]) from [<80357868>] (__dev_open+0x7c/0xfc)
> |[<80357868>] (__dev_open+0x7c/0xfc) from [<80357aa0>] (__dev_change_flags+0x8c/0x118)
> |[<80357aa0>] (__dev_change_flags+0x8c/0x118) from [<80357ba0>] (dev_change_flags+0x10/0x44)
> |[<80357ba0>] (dev_change_flags+0x10/0x44) from [<803a1b68>] (devinet_ioctl+0x2a4/0x62c)
> |[<803a1b68>] (devinet_ioctl+0x2a4/0x62c) from [<80343350>] (sock_ioctl+0x220/0x274)
> |[<80343350>] (sock_ioctl+0x220/0x274) from [<800bb464>] (vfs_ioctl+0x28/0x3c)
> |[<800bb464>] (vfs_ioctl+0x28/0x3c) from [<800bbfa8>] (do_vfs_ioctl+0x53c/0x590)
> |[<800bbfa8>] (do_vfs_ioctl+0x53c/0x590) from [<800bc030>] (SyS_ioctl+0x34/0x58)
> |[<800bc030>] (SyS_ioctl+0x34/0x58) from [<8000e660>] (ret_fast_syscall+0x0/0x30)
> |Code: f57ff04e e3a01000 e5820000 f57ff04e (e5820004) 
> |---[ end trace 49ef25cc4eb56f2d ]---
> |Kernel panic - not syncing: Fatal exception
> |CPU1: stopping
> |CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D      3.12.0-rc1-next-20130919-karo+ #91
> |[<8001416c>] (unwind_backtrace+0x0/0x11c) from [<800112f0>] (show_stack+0x10/0x14)
> |[<800112f0>] (show_stack+0x10/0x14) from [<803de8a4>] (dump_stack+0x68/0x84)
> |[<803de8a4>] (dump_stack+0x68/0x84) from [<80012fe8>] (handle_IPI+0xc0/0x124)
> |[<80012fe8>] (handle_IPI+0xc0/0x124) from [<80008530>] (gic_handle_irq+0x58/0x60)
> |[<80008530>] (gic_handle_irq+0x58/0x60) from [<80011d80>] (__irq_svc+0x40/0x50)
> |Exception stack(0xbe8b7f58 to 0xbe8b7fa0)
> |7f40:                                                       be8b7fa0 00000024
> |7f60: 7aa8d094 00000024 7a434975 00000024 80e73d50 00000001 805cff2c 412fc09a
> |7f80: 805cff88 00000000 00000005 be8b7fa0 80057dc0 80328354 60000013 ffffffff
> |[<80011d80>] (__irq_svc+0x40/0x50) from [<80328354>] (cpuidle_enter_state+0x54/0xf0)
> |[<80328354>] (cpuidle_enter_state+0x54/0xf0) from [<803284cc>] (cpuidle_idle_call+0xdc/0x144)
> |[<803284cc>] (cpuidle_idle_call+0xdc/0x144) from [<8000f1f4>] (arch_cpu_idle+0x8/0x38)
> |[<8000f1f4>] (arch_cpu_idle+0x8/0x38) from [<80050dbc>] (cpu_startup_entry+0xb0/0x114)
> |[<80050dbc>] (cpu_startup_entry+0xb0/0x114) from [<100085c4>] (0x100085c4)
> |CPU0: stopping
> |CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D      3.12.0-rc1-next-20130919-karo+ #91
> |[<8001416c>] (unwind_backtrace+0x0/0x11c) from [<800112f0>] (show_stack+0x10/0x14)
> |[<800112f0>] (show_stack+0x10/0x14) from [<803de8a4>] (dump_stack+0x68/0x84)
> |[<803de8a4>] (dump_stack+0x68/0x84) from [<80012fe8>] (handle_IPI+0xc0/0x124)
> |[<80012fe8>] (handle_IPI+0xc0/0x124) from [<80008530>] (gic_handle_irq+0x58/0x60)
> |[<80008530>] (gic_handle_irq+0x58/0x60) from [<80011d80>] (__irq_svc+0x40/0x50)
> |Exception stack(0x805c5f28 to 0x805c5f70)
> |5f20:                   805c5f70 00000024 7aa8d168 00000024 7a43d873 00000024
> |5f40: 80e6bd50 00000001 805cff2c 412fc09a 805cff88 00000000 00000005 805c5f70
> |5f60: 80057dc0 80328354 60000013 ffffffff
> |[<80011d80>] (__irq_svc+0x40/0x50) from [<80328354>] (cpuidle_enter_state+0x54/0xf0)
> |[<80328354>] (cpuidle_enter_state+0x54/0xf0) from [<803284cc>] (cpuidle_idle_call+0xdc/0x144)
> |[<803284cc>] (cpuidle_idle_call+0xdc/0x144) from [<8000f1f4>] (arch_cpu_idle+0x8/0x38)
> |[<8000f1f4>] (arch_cpu_idle+0x8/0x38) from [<80050dbc>] (cpu_startup_entry+0xb0/0x114)
> |[<80050dbc>] (cpu_startup_entry+0xb0/0x114) from [<805909d8>] (start_kernel+0x268/0x2ac)
> |CPU3: stopping
> |CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D      3.12.0-rc1-next-20130919-karo+ #91
> |[<8001416c>] (unwind_backtrace+0x0/0x11c) from [<800112f0>] (show_stack+0x10/0x14)
> |[<800112f0>] (show_stack+0x10/0x14) from [<803de8a4>] (dump_stack+0x68/0x84)
> |[<803de8a4>] (dump_stack+0x68/0x84) from [<80012fe8>] (handle_IPI+0xc0/0x124)
> |[<80012fe8>] (handle_IPI+0xc0/0x124) from [<80008530>] (gic_handle_irq+0x58/0x60)
> |[<80008530>] (gic_handle_irq+0x58/0x60) from [<80011d80>] (__irq_svc+0x40/0x50)
> |Exception stack(0xbe8bbf58 to 0xbe8bbfa0)
> |bf40:                                                       be8bbfa0 00000024
> |bf60: 7aa8d039 00000024 787aa018 00000024 80e83d50 00000000 805cff2c 412fc09a
> |bf80: 805cff3c 00000000 00000005 be8bbfa0 80057dc0 80328354 60000013 ffffffff
> |[<80011d80>] (__irq_svc+0x40/0x50) from [<80328354>] (cpuidle_enter_state+0x54/0xf0)
> |[<80328354>] (cpuidle_enter_state+0x54/0xf0) from [<803284cc>] (cpuidle_idle_call+0xdc/0x144)
> |[<803284cc>] (cpuidle_idle_call+0xdc/0x144) from [<8000f1f4>] (arch_cpu_idle+0x8/0x38)
> |[<8000f1f4>] (arch_cpu_idle+0x8/0x38) from [<80050dbc>] (cpu_startup_entry+0xb0/0x114)
> |[<80050dbc>] (cpu_startup_entry+0xb0/0x114) from [<100085c4>] (0x100085c4)
> 
> The same kernel/driver works perfectly well on an i.MX53 based board.

Just to be sure, can you boot with one CPU only.

> The data abort happens upon writing to can_ctrl in the second run of
> this loop in flexcan_chip_start():
> |	for (i = 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
> |		flexcan_write(0, &regs->cantxfg[i].can_ctrl);
> ----------------^ crashes here with i = 1

Can you instrument flexcan_write().

> |
> |		flexcan_write(0, &regs->cantxfg[i].can_id);
> |		flexcan_write(0, &regs->cantxfg[i].data[0]);
> |		flexcan_write(0, &regs->cantxfg[i].data[1]);
> |
> |		/* put MB into rx queue */
> |		flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
> |			&regs->cantxfg[i].can_ctrl);
> |	}
> 
> Does anyone have any clue how this can happen?
> 
> Can anyone reproduce this on another machine?
> 
> The same hardware works well with a 3.0.35 Freescale kernel.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130926/3a772918/attachment-0001.sig>
