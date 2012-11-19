From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 14:13:27 +0900
Subject: [RFC 15/15] ARM: shmobile: sh73a0: Use DT for GIC
In-Reply-To: <1353302007-31045-1-git-send-email-horms@verge.net.au>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
Message-ID: <1353302007-31045-16-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Magnus Damm <damm@opensource.se>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/intc-sh73a0.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index ee62349..e9b5419 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -151,6 +151,7 @@ error:
 }
 
 static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
 	{ .compatible = "renesas,sh_intcs", .data = sh73a0_intcs_of_init },
 	{ .compatible = "renesas,sh_intca_irq_pins",
 		.data = sh73a0_intca_pins_of_init },
@@ -559,18 +560,18 @@ static irqreturn_t sh73a0_pint1_demux(int irq, void *dev_id)
 
 static void __init sh73a0_init_irq__(bool of)
 {
-	void __iomem *gic_dist_base = IOMEM(0xf0001000);
-	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 	void __iomem *intevtsa;
 	int k, n;
 
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
-
 #ifdef CONFIG_OF
 	if (of)
 		of_irq_init(irq_of_match);
+	else
 #endif
+	{
+		gic_init(0, 29, IOMEM(0xf0001000), IOMEM(0xf0000100));
+		gic_arch_extn.irq_set_wake = sh73a0_set_wake;
+	}
 
 	register_intc_controller(&intcs_desc);
 	register_intc_controller(&intca_irq_pins_desc);
-- 
1.7.10.4
