From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  9 Aug 2016 16:18:52 +0200
Subject: [PATCH 2/2] ARM: imx6: mark GPC node as not populated after irq init
 to probe pm domain driver
In-Reply-To: <1470752332-14185-1-git-send-email-p.zabel@pengutronix.de>
References: <1470752332-14185-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1470752332-14185-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since IRQCHIP_DECLARE now flags the GPC node as already populated, the
GPC power domain driver is never probed unless we clear the flag again.

Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-imx/gpc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index fd87205..0df062d 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -271,6 +271,12 @@ static int __init imx_gpc_init(struct device_node *node,
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(~0, gpc_base + GPC_IMR1 + i * 4);
 
+	/*
+	 * Clear the OF_POPULATED flag set in of_irq_init so that
+	 * later the GPC power domain driver will not be skipped.
+	 */
+	of_node_clear_flag(node, OF_POPULATED);
+
 	return 0;
 }
 IRQCHIP_DECLARE(imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
-- 
2.8.1
