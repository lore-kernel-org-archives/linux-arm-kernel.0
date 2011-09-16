From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 15 Sep 2011 19:16:28 -0700
Subject: [PATCH v2] ARM: CSR: call l2x0_of_init to init L2 cache of SiRFprimaII
Message-ID: <1316139388-18833-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <robherring2@gmail.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
-v2:
add specific "compatible" string of the l2x0 device node, and making sure
that we have something specific to prima2 in it.

Note: This patch depends on[1][2]
[1]Rob Herring
ARM: 7009/1: l2x0: Add OF based initialization
http://www.spinics.net/lists/arm-kernel/msg131123.html
it has been in rmk/for-next

[2]Barry Song
ARM: 7009/1: CACHE-L2X0: filter start address can be 0 and is often 0
http://www.spinics.net/lists/arm-kernel/msg140126.html
it has been in rmk/for-next

 arch/arm/boot/dts/prima2-cb.dts |    5 +++-
 arch/arm/mach-prima2/l2x0.c     |   46 +++++++-------------------------------
 2 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
index 6fecc88..9d6167c 100644
--- a/arch/arm/boot/dts/prima2-cb.dts
+++ b/arch/arm/boot/dts/prima2-cb.dts
@@ -39,9 +39,12 @@
 		ranges = <0x40000000 0x40000000 0x80000000>;
 
 		l2-cache-controller at 80040000 {
-			compatible = "arm,pl310-cache";
+			compatible = "arm,pl310-cache", "sirf,prima2-pl310-cache";
 			reg = <0x80040000 0x1000>;
 			interrupts = <59>;
+			arm,tag-latency = <1 1 1>;
+			arm,data-latency = <1 1 1>;
+			arm,filter-ranges = <0 0x40000000>;
 		};
 
 		intc: interrupt-controller at 80020000 {
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index 9cda205..c998377 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -8,52 +8,24 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/errno.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <mach/memory.h>
 
-#define L2X0_ADDR_FILTERING_START       0xC00
-#define L2X0_ADDR_FILTERING_END         0xC04
-
-static struct of_device_id l2x_ids[]  = {
-	{ .compatible = "arm,pl310-cache" },
+static struct of_device_id prima2_l2x0_ids[]  = {
+	{ .compatible = "sirf,prima2-pl310-cache" },
+	{},
 };
 
-static int __init sirfsoc_of_l2x_init(void)
+static int __init sirfsoc_l2x0_init(void)
 {
 	struct device_node *np;
-	void __iomem *sirfsoc_l2x_base;
-
-	np = of_find_matching_node(NULL, l2x_ids);
-	if (!np)
-		panic("unable to find compatible l2x node in dtb\n");
-
-	sirfsoc_l2x_base = of_iomap(np, 0);
-	if (!sirfsoc_l2x_base)
-		panic("unable to map l2x cpu registers\n");
-
-	of_node_put(np);
-
-	if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
-		/*
-		 * set the physical memory windows L2 cache will cover
-		 */
-		writel_relaxed(PLAT_PHYS_OFFSET + 1024 * 1024 * 1024,
-			sirfsoc_l2x_base + L2X0_ADDR_FILTERING_END);
-		writel_relaxed(PLAT_PHYS_OFFSET | 0x1,
-			sirfsoc_l2x_base + L2X0_ADDR_FILTERING_START);
 
-		writel_relaxed(0,
-			sirfsoc_l2x_base + L2X0_TAG_LATENCY_CTRL);
-		writel_relaxed(0,
-			sirfsoc_l2x_base + L2X0_DATA_LATENCY_CTRL);
+	np = of_find_matching_node(NULL, prima2_l2x0_ids);
+	if (np) {
+		pr_info("Initializing prima2 L2 cache\n");
+		return l2x0_of_init(0x40000, 0);
 	}
-	l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
-		0x00000000);
 
 	return 0;
 }
-early_initcall(sirfsoc_of_l2x_init);
+early_initcall(sirfsoc_l2x0_init);
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
