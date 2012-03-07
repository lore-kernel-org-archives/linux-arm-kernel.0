From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:51 +0000
Subject: [PATCH 10/14] ARM: kirkwood: mv_cesa devicetree support.
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <4a6df8e03abfa36901103583376b3c33f703559b.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on work by Michael Walle (commit a952154).

Used the crypto portion of the patch, integrated with board-dt.c

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Changes from previous version:

* s/marvell,/mrvl,/g for compatible properties
* split into binding patch and a use patch.
* make sure clock doesn't get disabled when booting fdt

 arch/arm/boot/dts/kirkwood.dtsi   |    7 +++++++
 arch/arm/mach-kirkwood/board-dt.c |    1 -
 arch/arm/mach-kirkwood/common.c   |   14 +++++++++++++-
 arch/arm/mach-kirkwood/common.h   |    1 -
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 5960a8e..a1634ae 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -16,4 +16,11 @@
 		reg = <0xf1010300 0x1f>;
 		interrupts = <53>;
 	};
+
+	crypto at f1030000 {
+		compatible = "mrvl,kirkwood-crypto", "mrvl,orion-crypto";
+		reg = <0xf1030000 0x10000>,
+		      <0xf5000000 0x800>;
+		interrupts = <22>;
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index deea565..638f261 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -184,7 +184,6 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_wdt_init();
 	kirkwood_xor0_init();
 	kirkwood_xor1_init();
-	kirkwood_crypto_init();
 
 #ifdef CONFIG_KEXEC
 	kexec_reinit = kirkwood_enable_pcie;
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index ef45244..154f1cf 100644
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
@@ -267,7 +268,7 @@ void __init kirkwood_uart1_init(void)
 /*****************************************************************************
  * Cryptographic Engines and Security Accelerator (CESA)
  ****************************************************************************/
-void __init kirkwood_crypto_init(void)
+static void __init kirkwood_crypto_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_CRYPTO;
 	orion_crypto_init(CRYPTO_PHYS_BASE, KIRKWOOD_SRAM_PHYS_BASE,
@@ -480,6 +481,9 @@ static int __init kirkwood_clock_gate(void)
 {
 	unsigned int curr = readl(CLOCK_GATING_CTRL);
 	u32 dev, rev;
+#ifdef CONFIG_OF
+	struct device_node *np;
+#endif
 
 	kirkwood_pcie_id(&dev, &rev);
 	printk(KERN_DEBUG "Gating clock of unused units\n");
@@ -488,6 +492,14 @@ static int __init kirkwood_clock_gate(void)
 	/* Make sure those units are accessible */
 	writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0 | CGC_PEX1, CLOCK_GATING_CTRL);
 
+#ifdef CONFIG_OF
+	np = of_find_compatible_node(NULL, NULL, "mrvl,orion-crypto");
+	if (np && of_device_is_available(np)) {
+		kirkwood_clk_ctrl |= CGC_CRYPTO;
+		of_node_put(np);
+	}
+#endif
+
 	/* For SATA: first shutdown the phy */
 	if (!(kirkwood_clk_ctrl & CGC_SATA0)) {
 		/* Disable PLL and IVREF */
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index ca08826..76644e7 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -56,7 +56,6 @@ void kirkwood_l2_init(void);
 void kirkwood_wdt_init(void);
 void kirkwood_xor0_init(void);
 void kirkwood_xor1_init(void);
-void kirkwood_crypto_init(void);
 
 extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
-- 
1.7.3.4
