From: jean-michel.hautbois@veo-labs.com (Jean-Michel Hautbois)
Date: Thu, 11 Jun 2015 10:48:31 +0200
Subject: i.MX6 cpufreq : rcu_sched kthread starved
Message-ID: <CAH-u=80WPfFmb4e3F=_mz1W-f3=sz2cY7D92USOCKCwcp5Es2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a custom board, on which imx6q_cpufreq fails.
I am using 4.0.5 stable kernel with some custom parts, but nothing
modifies the DT in this specific part.
When activating anatop regulator and imx6q_cpufreq modules, after a
while, I get the following panic :

[  388.902571] INFO: rcu_sched detected stalls on CPUs/tasks: { 1}
(detected by 0, t=2102 jiffies, g=7088, c=7087, q=34)
[  388.913334] Task dump for CPU 1:
[  388.916588] irq/298-IC PP   R running      0    46      2 0x00000002
[  388.923016] Backtrace:
[  388.925541] [<8000cbc0>] (vfp_double_ftoui) from [<807fd2c8>]
(schedule+0x4c/0xa4)
[  388.933151] [<807fd27c>] (schedule) from [<80080d68>] (irq_thread+0xdc/0x1e4)
[  388.940307]  r4:a609e000 r3:00000001
[  388.943974] [<80080c8c>] (irq_thread) from [<8004d3a8>] (kthread+0xf0/0x110)
[  388.951043]  r10:00000000 r9:00000000 r8:00000000 r7:80080c8c
r6:a6ef1f40 r5:a6ef1f80
[  388.959028]  r4:00000000
[  388.961622] [<8004d2b8>] (kthread) from [<8000fc98>]
(ret_from_fork+0x14/0x3c)
[  388.968864]  r7:00000000 r6:00000000 r5:8004d2b8 r4:a6ef1f80
[  388.974652] rcu_sched kthread starved for 2093 jiffies!
[  392.056054] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
[kworker/0:1:25]
[  392.063652] Modules linked in: imx6q_cpufreq anatop_regulator
snd_soc_adv76xx snd_soc_vbx3_fpga vbx3_fpga_vswitch smsc95xx usbnet
adv7604 pfuze100_regulator vbx3_fpga snd_soc_sgt
l5000 lmh0395 imx_ipu_scaler imx_ipu mx6_hdmi(C) mx6_camera(C)
mx6_display(C) snd_soc_vbx3sdi vbx3_sdi [last unloaded: imx_thermal]
[  392.091501] irq event stamp: 1284
[  392.094835] hardirqs last  enabled at (1283): [<80802e6c>]
_raw_spin_unlock_irq+0x34/0x54
[  392.103078] hardirqs last disabled at (1284): [<80802c18>]
_raw_spin_lock_irq+0x28/0xa0
[  392.111135] softirqs last  enabled at (714): [<806e5810>]
addrconf_verify_rtnl+0x1cc/0x4c0
[  392.119459] softirqs last disabled at (708): [<806e5668>]
addrconf_verify_rtnl+0x24/0x4c0
[  392.127701] CPU: 0 PID: 25 Comm: kworker/0:1 Tainted: G    B    C
   4.0.5 #49
[  392.135118] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  392.141678] Workqueue: events od_dbs_timer
[  392.145823] task: a6ec0ec0 ti: a6ed2000 task.ti: a6ed2000
[  392.151256] PC is at generic_exec_single+0x118/0x20c
[  392.156250] LR is at trace_hardirqs_on_caller+0x1c/0x200
[  392.161589] pc : [<800a95c0>]    lr : [<80070118>]    psr: 200f0013
[  392.161589] sp : a6ed3ae8  ip : 80e4f2c8  fp : a6ed3b1c
[  392.173092] r10: a6ed3c64  r9 : a6ed3c5c  r8 : 00000000
[  392.178339] r7 : 80e4ea7c  r6 : 00000001  r5 : a6ed3af0  r4 : 00000000
[  392.184889] r3 : 00000003  r2 : 00000000  r1 : 80802e0c  r0 : 80070310
[  392.191441] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[  392.198774] Control: 10c5387d  Table: 3528004a  DAC: 00000015
[  392.204547] CPU: 0 PID: 25 Comm: kworker/0:1 Tainted: G    B    C
   4.0.5 #49
[  392.211963] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  392.218516] Workqueue: events od_dbs_timer
[  392.222653] Backtrace:
[  392.225170] [<80013de0>] (dump_backtrace) from [<80014058>]
(show_stack+0x20/0x24)
[  392.232760]  r6:80e87c1c r5:00000000 r4:00000000 r3:00000000
[  392.238571] [<80014038>] (show_stack) from [<807fabd0>]
(dump_stack+0x98/0xc8)
[  392.245832] [<807fab38>] (dump_stack) from [<80010c74>] (show_regs+0x1c/0x20)
[  392.252988]  r6:00000017 r5:80e4eb70 r4:00000019 r3:00000000
[  392.258800] [<80010c58>] (show_regs) from [<800b88bc>]
(watchdog_timer_fn+0x228/0x2b4)
[  392.266767] [<800b8694>] (watchdog_timer_fn) from [<80093178>]
(__run_hrtimer+0xe4/0x2ac)
[  392.274964]  r10:800b8694 r9:80ecfcf4 r8:a7288388 r7:a72883e8
r6:80ecfce0 r5:0000005b
[  392.282950]  r4:a7288838
[  392.285544] [<80093094>] (__run_hrtimer) from [<80093dd8>]
(hrtimer_interrupt+0x11c/0x2b4)
[  392.293827]  r10:00000001 r9:a7288388 r8:a7288388 r7:00000000
r6:a7288388 r5:0000005b
[  392.301811]  r4:47abd89a r3:00000000
[  392.305478] [<80093cbc>] (hrtimer_interrupt) from [<80018604>]
(twd_handler+0x3c/0x50)
[  392.313414]  r10:80e87fac r9:80ecf95c r8:a6c8f000 r7:a728e540
r6:00000010 r5:a6c8df00
[  392.321399]  r4:00000001
[  392.323995] [<800185c8>] (twd_handler) from [<80083820>]
(handle_percpu_devid_irq+0xd8/0x1ec)
[  392.332539]  r4:00006b22 r3:800185c8
[  392.336200] [<80083748>] (handle_percpu_devid_irq) from
[<8007f130>] (generic_handle_irq+0x38/0x4c)
[  392.345264]  r10:a6ed3c64 r9:a6c38000 r8:00000001 r7:00000000
r6:80e4f578 r5:00000010
[  392.353247]  r4:00000010 r3:80083748
[  392.356905] [<8007f0f8>] (generic_handle_irq) from [<8007f484>]
(__handle_domain_irq+0x74/0xf0)
[  392.365623]  r4:80e47e6c r3:00000135
[  392.369281] [<8007f410>] (__handle_domain_irq) from [<8000880c>]
(gic_handle_irq+0x30/0x70)
[  392.377651]  r9:a6ed3c5c r8:00000000 r7:f4000100 r6:80e4f6f8
r5:a6ed3aa0 r4:f400010c
[  392.385559] [<800087dc>] (gic_handle_irq) from [<80014c24>]
(__irq_svc+0x44/0x5c)
[  392.393064] Exception stack(0xa6ed3aa0 to 0xa6ed3ae8)
[  392.398147] 3aa0: 80070310 80802e0c 00000000 00000003 00000000
a6ed3af0 00000001 80e4ea7c
[  392.406356] 3ac0: 00000000 a6ed3c5c a6ed3c64 a6ed3b1c 80e4f2c8
a6ed3ae8 80070118 800a95c0
[  392.414554] 3ae0: 200f0013 ffffffff
[  392.418062]  r7:a6ed3ad4 r6:ffffffff r5:200f0013 r4:800a95c0
[  392.423866] [<800a94a8>] (generic_exec_single) from [<800a9764>]
(smp_call_function_single+0xb0/0x104)
[  392.433191]  r6:a6ed3c64 r5:80018274 r4:00000001
[  392.437921] [<800a96b4>] (smp_call_function_single) from
[<800a9bb0>] (smp_call_function_many+0x260/0x2cc)
[  392.447592]  r7:80e4ea7c r6:80e4ea7c r5:00000001 r4:80e4eb50
[  392.453390] [<800a9950>] (smp_call_function_many) from [<800a9c6c>]
(smp_call_function+0x50/0x74)
[  392.462281]  r10:00000002 r9:a6ed3c5c r8:00000000 r7:a6ed3c64
r6:80018274 r5:a6ed3c5c
[  392.470267]  r4:a6ed3c64
[  392.472856] [<800a9c1c>] (smp_call_function) from [<800a9cc8>]
(on_each_cpu+0x38/0x8c)
[  392.480791]  r4:00000000 r3:a6ed2000
[  392.484452] [<800a9c90>] (on_each_cpu) from [<8001864c>]
(twd_rate_change+0x34/0x40)
[  392.492213]  r7:ffffffff r6:00000002 r5:a6ed3c5c r4:00000000
[  392.498023] [<80018618>] (twd_rate_change) from [<8004e488>]
(notifier_call_chain+0x54/0x94)
[  392.506502] [<8004e434>] (notifier_call_chain) from [<8004e9d4>]
(__srcu_notifier_call_chain+0x80/0xb4)
[  392.515913]  r8:ffffffff r7:00000000 r6:a6d49b10 r5:a6d49a58
r4:a6d49a04 r3:ffffffff
[  392.523829] [<8004e954>] (__srcu_notifier_call_chain) from
[<8004ea30>] (srcu_notifier_call_chain+0x28/0x30)
[  392.533676]  r10:001312d0 r9:a5eaa880 r8:a6c3c900 r7:00000002
r6:a6c3e980 r5:80eb45c0
[  392.541661]  r4:a6d49a00
[  392.544268] [<8004ea08>] (srcu_notifier_call_chain) from
[<805e627c>] (__clk_notify+0x7c/0x84)
[  392.552916] [<805e6200>] (__clk_notify) from [<805e632c>]
(__clk_recalc_rates+0xa8/0xac)
[  392.561025]  r7:00000001 r6:179a7b00 r5:00000002 r4:a6c3e980
[  392.566824] [<805e6284>] (__clk_recalc_rates) from [<805e6300>]
(__clk_recalc_rates+0x7c/0xac)
[  392.575455]  r6:2f34f600 r5:00000002 r4:a6c3e980 r3:00000000
[  392.581254] [<805e6284>] (__clk_recalc_rates) from [<805e6300>]
(__clk_recalc_rates+0x7c/0xac)
[  392.589885]  r6:2f34f600 r5:00000002 r4:a6c87c80 r3:00000000
[  392.595685] [<805e6284>] (__clk_recalc_rates) from [<805e867c>]
(clk_core_set_parent+0xf0/0x1ec)
[  392.604489]  r6:a6c3ed00 r5:00000000 r4:a6c3ed80 r3:00000001
[  392.610285] [<805e858c>] (clk_core_set_parent) from [<805e87a4>]
(clk_set_parent+0x2c/0x30)
[  392.618654]  r8:000f32a0 r7:00000002 r6:3b5dc100 r5:000c15c0 r4:7f0cd1dc
[  392.625529] [<805e8778>] (clk_set_parent) from [<7f0cc23c>]
(imx6q_set_target+0x1a0/0x4c8 [imx6q_cpufreq])
[  392.635235] [<7f0cc09c>] (imx6q_set_target [imx6q_cpufreq]) from
[<805a8330>] (__cpufreq_driver_target+0x1e0/0x39c)
[  392.645691]  r10:a6ed3d98 r9:8172c1cc r8:00000002 r7:80edde20
r6:00000000 r5:a50b1f18
[  392.653675]  r4:a30d5a00
[  392.656268] [<805a8150>] (__cpufreq_driver_target) from
[<805acb6c>] (od_check_cpu+0xb8/0xcc)
[  392.664811]  r10:a728af28 r9:0001b595 r8:a73f6f28 r7:80e4eb50
r6:00000001 r5:51eb851f
[  392.672796]  r4:a30d5a00
[  392.675393] [<805acab4>] (od_check_cpu) from [<805ae9c0>]
(dbs_check_cpu+0x1a0/0x1f0)
[  392.683242]  r6:a31c6980 r5:0000005e r4:00000004 r3:805acab4
[  392.689040] [<805ae820>] (dbs_check_cpu) from [<805ad040>]
(od_dbs_timer+0x84/0x148)
[  392.696802]  r10:00000000 r9:a50b1c00 r8:a728afb4 r7:a728af50
r6:a31c6980 r5:00000000
[  392.704785]  r4:a728af28
[  392.707387] [<805acfbc>] (od_dbs_timer) from [<80047710>]
(process_one_work+0x1f8/0x56c)
[  392.715499]  r10:80ecf998 r9:80ecf998 r8:00000000 r7:a728ea00
r6:a728b340 r5:a6eab380
[  392.723482]  r4:a728af50 r3:a6ed2000
[  392.727142] [<80047518>] (process_one_work) from [<8004840c>]
(worker_thread+0x40/0x4dc)
[  392.735251]  r10:a6eab380 r9:00000000 r8:80048464 r7:00000008
r6:a728b378 r5:a6eab398
[  392.743235]  r4:a728b340
[  392.745823] [<800483cc>] (worker_thread) from [<8004d3a8>]
(kthread+0xf0/0x110)
[  392.753152]  r10:00000000 r9:00000000 r8:00000000 r7:800483cc
r6:a6eab380 r5:a6ead400
[  392.761134]  r4:00000000
[  392.763727] [<8004d2b8>] (kthread) from [<8000fc98>]
(ret_from_fork+0x14/0x3c)
[  392.770968]  r7:00000000 r6:00000000 r5:8004d2b8 r4:a6ead400
[  392.776757] Kernel panic - not syncing: softlockup: hung tasks
[  394.017107] SMP: failed to stop secondary CPUs
[  394.021590] ---[ end Kernel panic - not syncing: softlockup: hung tasks

I don't know if this could be related to the patch intergrated in 4.1-rc :
b923ff6af0d5a806a3996dac6d4393cd9792d0f4 ARM: imx6: convert GPC to
stacked domains

Thanks !
JM
