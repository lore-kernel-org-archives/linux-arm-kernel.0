From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 13 Apr 2017 15:27:31 -0700
Subject: [PATCH] irqchip/irq-imx-gpcv2: fix spinlock initialization
Message-ID: <20170413222731.5917-1-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call raw_spin_lock_init() before the spinlocks are used to prevent a
lockdep splat.

Fixes the following trace:

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
Hardware name: Freescale i.MX7 Dual (Device Tree)
Backtrace:
[<c010c364>] (dump_backtrace) from [<c010c610>] (show_stack+0x18/0x1c)
  r7:00000000 r6:600000d3 r5:00000000 r4:c0e273dc
[<c010c5f8>] (show_stack) from [<c04070a4>] (dump_stack+0xb4/0xe8)
[<c0406ff0>] (dump_stack) from [<c0169e04>] (register_lock_class+0x208/0x5ec)
 r9:ef00d010 r8:ef00d010 r7:c1606448 r6:00000000 r5:00000000 r4:ffffe000
[<c0169bfc>] (register_lock_class) from [<c016da48>]
(__lock_acquire+0x7c/0x18d0)
 r10:c0e0af40 r9:ef00d010 r8:c0e274cc r7:00000001 r6:600000d3 r5:c1606448
 r4:ffffe000
[<c016d9cc>] (__lock_acquire) from [<c016fa4c>] (lock_acquire+0x70/0x90)
 r10:00000000 r9:ef007e38 r8:00000001 r7:00000001 r6:600000d3 r5:00000000
 r4:ffffe000
[<c016f9dc>] (lock_acquire) from [<c09accc8>] (_raw_spin_lock+0x30/0x40)
 r8:600000d3 r7:ef007e10 r6:00000001 r5:ef007e10 r4:ef00d000
[<c09acc98>] (_raw_spin_lock) from [<c04403a4>] (imx_gpcv2_irq_unmask+0x1c/0x5c)
 r4:ef00d000
[<c0440388>] (imx_gpcv2_irq_unmask) from [<c017e838>] (irq_enable+0x38/0x4c)
 r5:00000000 r4:ef007e00
[<c017e800>] (irq_enable) from [<c017e8d0>] (irq_startup+0x84/0x88)
 r5:00000000 r4:ef007e00
[<c017e84c>] (irq_startup) from [<c017cd7c>] (__setup_irq+0x538/0x5f4)
 r7:ef007e60 r6:00000015 r5:ef007e00 r4:ef007d00
[<c017c844>] (__setup_irq) from [<c017ce98>] (setup_irq+0x60/0xd0)
 r10:c0d5fa48 r9:efffcbc0 r8:ef007d00 r7:00000015 r6:ef007e10 r5:00000000
 r4:ef007e00
[<c017ce38>] (setup_irq) from [<c0d4dfdc>] (_mxc_timer_init+0x1f8/0x248)
 r9:efffcbc0 r8:00000003 r7:016e3600 r6:c0c69bbc r5:ef007c40 r4:ef007c00
[<c0d4dde4>] (_mxc_timer_init) from [<c0d4e0dc>] (mxc_timer_init_dt+0xb0/0xf8)
 r7:00000000 r6:c1669e48 r5:ef7ebf7c r4:ef007c00
[<c0d4e02c>] (mxc_timer_init_dt) from [<c0d4e168>]
(imx6dl_timer_init_dt+0x14/0x18)
 r9:efffcbc0 r8:c0e7b000 r7:c0c695c0 r6:c0d6fe18 r5:00000001 r4:ef7ebf7c
[<c0d4e154>] (imx6dl_timer_init_dt) from [<c0d4d158>]
(clocksource_probe+0x54/0xb0)
[<c0d4d104>] (clocksource_probe) from [<c0d04a2c>] (time_init+0x30/0x38)
 r7:c0e07900 r6:c0e7b000 r5:ffffffff r4:00000000
[<c0d049fc>] (time_init) from [<c0d00bc8>] (start_kernel+0x220/0x3a0)
[<c0d009a8>] (start_kernel) from [<8000807c>] (0x8000807c)
 r10:00000000 r9:410fc075 r8:8000406a r7:c0e0c958 r6:c0d5fa44 r5:c0e07918
 r4:c0e7b294

Verified the fix on a imx7d-cl-som with CONFIG_IMX_GPCV2 set.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
Reported-by: Tyler Baker <tyler.baker@linaro.org>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Issue reported in this thread: https://lkml.org/lkml/2017/4/13/646

 drivers/irqchip/irq-imx-gpcv2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index e13236f..9463f35 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -230,6 +230,8 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	raw_spin_lock_init(&cd->rlock);
+
 	cd->gpc_base = of_iomap(node, 0);
 	if (!cd->gpc_base) {
 		pr_err("fsl-gpcv2: unable to map gpc registers\n");
-- 
2.9.3
