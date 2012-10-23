From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:53 +0800
Subject: [PATCH 04/10] ARM: imx: initialize cpu power up counters
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default values of cpu power up counters are unnecessarily large.
Initialize them to small ones for minimizing the power up latency.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/gpc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index e1537f9..c75842d 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -19,6 +19,7 @@
 
 #define GPC_IMR1		0x008
 #define GPC_PGC_CPU_PDN		0x2a0
+#define GPC_PGC_CPU_PUPSCR	0x2a4
 
 #define IMR_NUM			4
 
@@ -106,6 +107,9 @@ void __init imx_gpc_init(void)
 	gpc_base = of_iomap(np, 0);
 	WARN_ON(!gpc_base);
 
+	/* Initialize cpu power up counters to minimize the latency */
+	writel_relaxed(0x101, gpc_base + GPC_PGC_CPU_PUPSCR);
+
 	/* Register GPC as the secondary interrupt controller behind GIC */
 	gic_arch_extn.irq_mask = imx_gpc_irq_mask;
 	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
-- 
1.7.9.5
