From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 22 Nov 2012 17:00:12 +0900
Subject: [PATCH v5 15/15] ARM: shmobile: sh73a0: Use DT for GIC
In-Reply-To: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <1353571213-26006-16-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Horman <horms@verge.net.au>

Cc: Magnus Damm <damm@opensource.se>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/intc-sh73a0.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index c9f6441..f4076e2 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -429,12 +429,9 @@ static irqreturn_t sh73a0_pint1_demux(int irq, void *dev_id)
 
 static void __init sh73a0_init_intc(resource_size_t intcs0_start)
 {
-	int k, n;
-	void __iomem *intevtsa;
-
-	intevtsa = ioremap_nocache(intcs0_start + 0x100, PAGE_SIZE);
+	void __iomem *intevtsa =
+			ioremap_nocache(intcs0_start + 0x100, PAGE_SIZE);
 	
-	/* demux using INTEVTSA */
 	sh73a0_intcs_cascade.name = "INTCS cascade";
 	sh73a0_intcs_cascade.handler = sh73a0_intcs_demux;
 	sh73a0_intcs_cascade.dev_id = intevtsa;
@@ -500,6 +497,7 @@ static int __init intc_of_init(struct device_node *np,
 }
 
 static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, }
 	{ .compatible = "renesas,sh_intc", .data = intc_of_init },
 	{ /*sentinel*/ }
 };
@@ -514,10 +512,8 @@ void __init sh73a0_init_irq_of(void)
 
 void __init sh73a0_init_irq(void)
 {
-	void __iomem *gic_dist_base = IOMEM(0xf0001000);
-	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+	gic_init(0, 29, IOMEM(0xf0001000), IOMEM(0xf0000100));
 	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
 
 	register_intc_controller(&intcs_desc);
-- 
1.7.10.4
