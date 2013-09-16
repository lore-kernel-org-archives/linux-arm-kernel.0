From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 16 Sep 2013 16:47:43 -0600
Subject: [PATCH] arm: Kirkwood - Remove kirkwood_setup_wins and rely on the
 DT binding
Message-ID: <20130916224743.GA18349@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kirkwood_setup_wins is the last manual caller of mbus in kirkwood, don't
call it for DT boards and rely on the board having a mbus node with
a proper ranges property to setup these windows.

This makes the DT self consistent, since the physical address of the
NAND and CRYPTO are both referenced internally. The arbitary Linux
constants KIRKWOOD_NAND_MEM_PHYS_BASE and KIRKWOOD_SRAM_PHYS_BASE
no longer have to match the DT values.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/boot/dts/kirkwood-db-88f6281.dts              | 5 ++++-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts              | 5 ++++-
 arch/arm/boot/dts/kirkwood-iconnect.dts                | 5 ++++-
 arch/arm/boot/dts/kirkwood-mplcec4.dts                 | 5 ++++-
 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 5 ++++-
 arch/arm/boot/dts/kirkwood-nsa310.dts                  | 5 ++++-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts              | 5 ++++-
 arch/arm/mach-kirkwood/board-dt.c                      | 1 -
 8 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
index 72c4b0a..0806ae6 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6281.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
@@ -19,7 +19,10 @@
 	compatible = "marvell,db-88f6281-bp", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	mbus {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
+			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
+			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
+			  >;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
index 36c411d..8ecf3c4 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6282.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
@@ -19,7 +19,10 @@
 	compatible = "marvell,db-88f6282-bp", "marvell,kirkwood-88f6282", "marvell,kirkwood";
 
 	mbus {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
+			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
+			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
+			  >;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 0323f01..2631733 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -19,7 +19,10 @@
 	};
 
 	mbus {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
+			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
+			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
+			  >;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index ce2b94b..fe445174 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -17,7 +17,10 @@
         };
 
 	mbus {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
+			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
+			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
+			  >;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 874857e..37706f2 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -17,7 +17,10 @@
 	};
 
 	mbus {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
+			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
+			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
+			  >;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 7aeae0c..c6d1edc 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -15,7 +15,10 @@
 	};
 
 	mbus {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
+			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
+			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
+			  >;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index 9efcd2d..94b82f9 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -6,7 +6,10 @@
 
 / {
 	mbus {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000	/* internal-regs */
+			  MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000	/* nand flash */
+			  MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000	/* crypto sram */
+			  >;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index afc058b..41c8580 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -94,7 +94,6 @@ static void __init kirkwood_dt_init(void)
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
 	BUG_ON(mvebu_mbus_dt_init());
-	kirkwood_setup_wins();
 
 	kirkwood_l2_init();
 
-- 
1.8.1.2
