From: linuxzsc@gmail.com (Richard Zhao)
Date: Mon, 25 Jun 2012 18:03:39 +0800
Subject: [PATCH v7 08/14] USB: Chipidea: add ci13xxx device id management
In-Reply-To: <4FE833EB.3050503@pengutronix.de>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-9-git-send-email-richard.zhao@freescale.com>
 <4FE833EB.3050503@pengutronix.de>
Message-ID: <513f64cb-8eac-4e51-81f7-e3824d96d870@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Could you use my USB test branch? 
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Marc Kleine-Budde <mkl@pengutronix.de> wrote:

On 06/25/2012 08:56 AM, Richard Zhao wrote:
> We use ida_simple_get and ida_simple_remove to manage the ids.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Removing the "ci13xxx_imx" module doesn't work as expected:

ci_hdrc ci_hdrc.0: remove, state 1
usb usb1: USB disconnect, device number 1
ci_hdrc ci_hdrc.0: USB bus 1 deregistered
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
pgd = c6bb8000
[0000006c] *pgd=46a7e831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT ARM
Modules linked in: ci13xxx_imx(-) ci_hdrc
CPU: 0 Not tainted (3.5.0-rc4-00055-g35d73a8-dirty #80)
PC is at ida_remove+0xa0/0x110
LR is at ida_simple_remove+0x30/0x60
pc : [<c0154294>] lr : [<c01544f4>] psr: a0000093
sp : c6be3ed0 ip : 80000000 fp : 0092f008
r10: d9a22647 r9 : c6be2000 r8 : 08421085
r7 : 00000001 r6 : 0000034b r5 : bf00a3a8 r4 : 00000000
r3 : c087d6b0 r2 : 001bb89f r1 : 6b6b6b6b r0 : 00000068
Flags: NzCv IRQs off FIQs on Mode SVC_32 ISA ARM Segment user
Control: 0005317f Table: 46bb8000 DAC: 00000015
Process rmmod (pid: 136, stack limit = 0xc6be2270)
Stack: (0xc6be3ed0 to 0xc6be4000)
3ec0: c6be2000 20000013 6b6b6b6b bf00a3a8
3ee0: c6be2000 c0009408 00000000 c01544f4 c6ad5430 c7865980 bf01562c bf01501c
3f00: bf015000 c7865988 bf01562c c018dad8 c018dac4 c018c5e0 bf01562c c7865988
3f20: c78659bc c018cdbc c6b78040 bf015680 bf01562c c0e670d0 0092f0b8 c018c438
3f40: bf015680 c6be2000 00000000 c004c56c c74ca308 33316963 5f787878 00786d69
3f60: 0092f008 c00a5088 c7812138 c6b5b388 00000000 c6b79860 c6b5b388 c0088648
3f80: 00000003 c6b79860 c6be2000 00088730 00002002 00000001 0092f088 be82fe5c
3fa0: 00000081 c0009260 00000001 0092f088 0092f0b8 00000800 b6eb865c be82fc00
3fc0: 00000001 0092f088 be82fe5c 00000081 0092f088 00000000 00000800 0092f008
3fe0: b6e7cbc0 be82fc04 b6ef65f8 b6e7cbcc 60000010 0092f0b8 00000000 00000000
[<c0154294>] (ida_remove+0xa0/0x110) from [<c01544f4>] (ida_simple_remove+0x30/0x60)
[<c01544f4>] (ida_simple_remove+0x30/0x60) from [<bf01501c>] (ci13xxx_imx_remove+0x1c/0x84 [ci13xxx_imx])
[<bf01501c>] (ci13xxx_imx_remove+0x1c/0x84 [ci13xxx_imx]) from [<c018dad8>] (platform_drv_remove+0x14/0x18)
[<c018dad8>] (platform_drv_remove+0x14/0x18) from [<c018c5e0>] (__device_release_driver+0x58/0xa8)
[<c018c5e0>] (__device_release_driver+0x58/0xa8) from [<c018cdbc>] (driver_detach+0xcc/0xd8)
[<c018cdbc>] (driver_detach+0xcc/0xd8) from [<c018c438>] (bus_remove_driver+0x7c/0xc0)
[<c018c438>] (bus_remove_driver+0x7c/0xc0) from [<c004c56c>] (sys_delete_module+0x180/0x23c)
[<c004c56c>] (sys_delete_module+0x180/0x23c) from [<c0009260>] (ret_fast_syscall+0x0/0x2c)
Code: e0416286 e5904004 e1a002c6 e0840100 (e5908004)
---[ end trace 7d882a2086a6a3d8 ]---
note: rmmod[136] exited with preempt_count 1

Marc
-- 
Pengutronix e.K. | Marc Kleine-Budde |
Industrial Linux Solutions | Phone: +49-231-2826-924 |
Vertretung West/Dortmund | Fax: +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686 | http://www.pengutronix.de |

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/8000a16f/attachment-0001.html>
