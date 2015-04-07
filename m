From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 7 Apr 2015 09:54:36 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx6: factor out pinmux for edm1 module
In-Reply-To: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <CAOMZO5BG-9O949dXpp+MaR3ezgWmVxesz4mXWknbyHvGakxavA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sun, Mar 8, 2015 at 1:25 PM, Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
> Thw Wandboard is using the EDM1-CF-IMX6 module which is
> defined under the edm standard.
>
> http://www.edm-standard.org/
>
> As this module is used on more boards this patch moves the default
> pinmux settings into the special file imx6qdl-edm1.dtsi.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Sorry for the delay in testing your patch.

Wandboard does not seem very happy about it:

[    7.372909] turning off the locking correctness validator.
[    7.378430] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
4.0.0-rc3-10351-g94a600d-dirty #6
[    7.386460] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    7.393011] Backtrace:
[    7.395554] [<80011f0c>] (dump_backtrace) from [<800120a8>]
(show_stack+0x18/0x1c)
[    7.403150]  r6:812a8bac r5:00000000 r4:00000000 r3:00000000
[    7.408983] [<80012090>] (show_stack) from [<80731764>]
(dump_stack+0x88/0xa4)
[    7.416256] [<807316dc>] (dump_stack) from [<80062094>]
(__lock_acquire+0x1858/0x1b84)
[    7.424198]  r5:00000000 r4:ee0a7e48
[    7.427870] [<8006083c>] (__lock_acquire) from [<800628ac>]
(lock_acquire+0x74/0x94)
[    7.435631]  r10:8007aa28 r9:00000000 r8:00000000 r7:00000001
r6:8007aa28 r5:60000113
[    7.443574]  r4:00000000
[    7.446153] [<80062838>] (lock_acquire) from [<8007aa90>]
(call_timer_fn+0x68/0xfc)
[    7.453818]  r7:00000100 r6:00000000 r5:00000001 r4:ee0a7e48
[    7.459578] [<8007aa28>] (call_timer_fn) from [<8007b3ec>]
(run_timer_softirq+0x1c4/0x264)
[    7.467850]  r10:80a5a100 r8:00000000 r7:00000000 r6:ee0a7e88
r5:ee02e000 r4:ed8b0894
[    7.475806] [<8007b228>] (run_timer_softirq) from [<8002d97c>]
(__do_softirq+0x138/0x2c4)
[    7.483991]  r10:80a5a080 r9:00000100 r8:00000001 r7:80a5a080
r6:00000001 r5:80a5a084
[    7.491932]  r4:000000a0
[    7.494499] [<8002d844>] (__do_softirq) from [<8002de50>]
(irq_exit+0xc4/0x138)
[    7.501816]  r10:ee008000 r9:80a5a9c8 r8:00000001 r7:00000000
r6:80a54d7c r5:80a5aaf8
[    7.509758]  r4:00000000
[    7.512330] [<8002dd8c>] (irq_exit) from [<8006c920>]
(__handle_domain_irq+0x74/0xe4)
[    7.520168]  r4:00000000 r3:00000133
[    7.523800] [<8006c8ac>] (__handle_domain_irq) from [<80008798>]
(gic_handle_irq+0x28/0x68)
[    7.532159]  r10:8073d49c r8:f4000100 r7:80a5ac6c r6:ee0a7f70
r5:0000000d r4:f400010c
[    7.540109] [<80008770>] (gic_handle_irq) from [<80012be4>]
(__irq_svc+0x44/0x5c)
[    7.547604] Exception stack(0xee0a7f70 to 0xee0a7fb8)
[    7.552671] 7f60:                                     00000001
00000001 00000000 80020720
[    7.560862] 7f80: 00000000 80a5a97c 80ab9671 00000001 80ab9671
80a5a9c8 8073d49c ee0a7fc4
[    7.569052] 7fa0: ee0a7f88 ee0a7fb8 800631a4 8000f8e0 20000113 ffffffff
[    7.575674]  r8:80ab9671 r7:ee0a7fa4 r6:ffffffff r5:20000113
r4:8000f8e0 r3:ee076b40
[    7.583544] [<8000f8b8>] (arch_cpu_idle) from [<8005c524>]
(cpu_startup_entry+0x154/0x1b8)
[    7.591829] [<8005c3d0>] (cpu_startup_entry) from [<80014d94>]
(secondary_start_kernel+0x120/0x13c)
[    7.600882]  r7:80ab9c20 r3:ee076b40
[    7.604516] [<80014c74>] (secondary_start_kernel) from [<10008864>]
(0x10008864)
[    7.611921]  r5:00000015 r4:7e08806a
[    7.615577] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    7.623703] pgd = 80004000
[    7.626441] [00000000] *pgd=00000000
[    7.630072] Internal error: Oops: 80000005 [#1] SMP ARM
[    7.632780] brcmfmac: _brcmf_set_multicast_list: Setting
BRCMF_C_SET_PROMISC failed, -52
[    7.634175] brcmfmac: _brcmf_set_multicast_list: Setting
BRCMF_C_SET_PROMISC failed, -52
[    7.651495] Sending DHCP requests .
[    7.654993] Modules linked in:
[    7.658060] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
4.0.0-rc3-10351-g94a600d-dirty #6
[    7.666071] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    7.672607] task: ee076b40 ti: ee0a6000 task.ti: ee0a6000
[    7.678013] PC is at 0x0
[    7.680559] LR is at call_timer_fn+0x70/0xfc
[    7.684839] pc : [<00000000>]    lr : [<8007aa98>]    psr: 60000113
[    7.684839] sp : ee0a7e38  ip : ee0a7c4c  fp : ee0a7e7c
[    7.696324] r10: 8007aa28  r9 : 00000000  r8 : 00000000
[    7.701557] r7 : 00000100  r6 : 00000000  r5 : 00000001  r4 : ee0a7e48
[    7.708092] r3 : ee076b40  r2 : ee0a7e00  r1 : ee0a7bbc  r0 : 00000000
[    7.714630] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    7.721946] Control: 10c5387d  Table: 1000404a  DAC: 00000015
[    7.727699] Process swapper/3 (pid: 0, stack limit = 0xee0a6210)

With your patch removed these issues do not happen.

Regards,

Fabio Estevam
