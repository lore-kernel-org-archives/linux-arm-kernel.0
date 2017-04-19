From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 19 Apr 2017 16:42:57 +0200
Subject: [PATCH 4.9 41/69] irqchip/irq-imx-gpcv2: Fix spinlock initialization
In-Reply-To: <20170419141616.919951169@linuxfoundation.org>
References: <20170419141616.919951169@linuxfoundation.org>
Message-ID: <20170419141618.632255623@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyler Baker <tyler.baker@linaro.org>

commit 75eb5e1e7b4edbc8e8f930de59004d21cb46961f upstream.

The raw_spinlock in the IMX GPCV2 interupt chip is not initialized before
usage. That results in a lockdep splat:

  INFO: trying to register non-static key.
  the code is fine but needs lockdep annotation.
  turning off the locking correctness validator.

Add the missing raw_spin_lock_init() to the setup code.

Fixes: e324c4dc4a59 ("irqchip/imx-gpcv2: IMX GPCv2 driver for wakeup sources")
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Cc: jason at lakedaemon.net
Cc: marc.zyngier at arm.com
Cc: shawnguo at kernel.org
Cc: andrew.smirnov at gmail.com
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/20170413222731.5917-1-tyler.baker at linaro.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-imx-gpcv2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -230,6 +230,8 @@ static int __init imx_gpcv2_irqchip_init
 		return -ENOMEM;
 	}
 
+	raw_spin_lock_init(&cd->rlock);
+
 	cd->gpc_base = of_iomap(node, 0);
 	if (!cd->gpc_base) {
 		pr_err("fsl-gpcv2: unable to map gpc registers\n");
