From: jm@lentin.co.uk (Jamie Lentin)
Date: Tue, 27 Mar 2012 22:54:13 +0100
Subject: [PATCH V3 3/5] ARM: kirkwood: Allow nand to be configured via.
 devicetree
In-Reply-To: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1332885255-8304-4-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add default configuration for NAND, to be enabled in your board config. Ensure
clock gating is set appropriately when the NAND is enabled.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood.dtsi |   15 ++++++++++++++-
 arch/arm/mach-kirkwood/common.c |   12 ++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 3474ef8..6b80374 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -5,7 +5,7 @@
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
-		ranges = <0 0xf1000000 0x1000000>;
+		ranges = <0 0xf1000000 0x4000000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -32,5 +32,18 @@
 			reg = <0x10300 0x20>;
 			interrupts = <53>;
 		};
+
+		nand at 3000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cle = <0>;
+			ale = <1>;
+			bank-width = <8>;
+			compatible = "mrvl,orion-nand";
+			reg = <0x3000000 0x400>;
+			chip-delay = <25>;
+			/* set partition map and/or chip-delay in board dts */
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index a02cae8..3ad0373 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -15,6 +15,7 @@
 #include <linux/ata_platform.h>
 #include <linux/mtd/nand.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -482,6 +483,9 @@ static int __init kirkwood_clock_gate(void)
 	unsigned int curr = readl(CLOCK_GATING_CTRL);
 	u32 dev, rev;
 
+#ifdef CONFIG_OF
+	struct device_node *np;
+#endif
 	kirkwood_pcie_id(&dev, &rev);
 	printk(KERN_DEBUG "Gating clock of unused units\n");
 	printk(KERN_DEBUG "before: 0x%08x\n", curr);
@@ -489,6 +493,14 @@ static int __init kirkwood_clock_gate(void)
 	/* Make sure those units are accessible */
 	writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0 | CGC_PEX1, CLOCK_GATING_CTRL);
 
+#ifdef CONFIG_OF
+	np = of_find_compatible_node(NULL, NULL, "mrvl,orion-nand");
+	if (np && of_device_is_available(np)) {
+		kirkwood_clk_ctrl |= CGC_RUNIT;
+		of_node_put(np);
+	}
+#endif
+
 	/* For SATA: first shutdown the phy */
 	if (!(kirkwood_clk_ctrl & CGC_SATA0)) {
 		/* Disable PLL and IVREF */
-- 
1.7.9.1
