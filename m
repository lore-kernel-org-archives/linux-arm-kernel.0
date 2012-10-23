From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:54 +0800
Subject: [PATCH 05/10] ARM: imx: mask gpc interrupts initially
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mask gpc interrupts initially to avoid suspicious interrupts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/gpc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index c75842d..be9a6cb 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -102,6 +102,7 @@ static void imx_gpc_irq_mask(struct irq_data *d)
 void __init imx_gpc_init(void)
 {
 	struct device_node *np;
+	int i;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
 	gpc_base = of_iomap(np, 0);
@@ -110,6 +111,10 @@ void __init imx_gpc_init(void)
 	/* Initialize cpu power up counters to minimize the latency */
 	writel_relaxed(0x101, gpc_base + GPC_PGC_CPU_PUPSCR);
 
+	/* Initially mask all interrupts */
+	for (i = 0; i < IMR_NUM; i++)
+		writel_relaxed(~0, gpc_base + GPC_IMR1 + i * 4);
+
 	/* Register GPC as the secondary interrupt controller behind GIC */
 	gic_arch_extn.irq_mask = imx_gpc_irq_mask;
 	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
-- 
1.7.9.5
