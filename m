From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  4 Dec 2012 22:55:13 +0800
Subject: [PATCH v2 2/4] ARM: imx: mask gpc interrupts initially
In-Reply-To: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
References: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1354632915-27134-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mask gpc interrupts initially to avoid suspicious interrupts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/gpc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index e1537f9..722e5df 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -101,11 +101,16 @@ static void imx_gpc_irq_mask(struct irq_data *d)
 void __init imx_gpc_init(void)
 {
 	struct device_node *np;
+	int i;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
 	gpc_base = of_iomap(np, 0);
 	WARN_ON(!gpc_base);
 
+	/* Initially mask all interrupts */
+	for (i = 0; i < IMR_NUM; i++)
+		writel_relaxed(~0, gpc_base + GPC_IMR1 + i * 4);
+
 	/* Register GPC as the secondary interrupt controller behind GIC */
 	gic_arch_extn.irq_mask = imx_gpc_irq_mask;
 	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
-- 
1.7.9.5
