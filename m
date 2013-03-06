From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 17:59:57 +0100
Subject: [PATCH 02/10] arm: plat-orion: use mv_mbus_dram_info() in PCIe code
In-Reply-To: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362589205-4726-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe code was directly accessing the orion_mbus_dram_info
structure to get access to a description of the SDRAM chip selects in
order to configure the PCIe -> SDRAM address decoding
windows.

However, with the introduction of the orion-mbus driver, we are going
to remove this global structure and instead leave only the exported
mv_mbus_dram_info() function to access this description of the SDRAM
chip selects. Therefore, we simply switch to using this API.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/pcie.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
index f20a321..8b8c06d 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/plat-orion/pcie.c
@@ -120,12 +120,14 @@ void __init orion_pcie_reset(void __iomem *base)
  * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
  * WIN[0-3] -> DRAM bank[0-3]
  */
-static void __init orion_pcie_setup_wins(void __iomem *base,
-					 struct mbus_dram_target_info *dram)
+static void __init orion_pcie_setup_wins(void __iomem *base)
 {
+	const struct mbus_dram_target_info *dram;
 	u32 size;
 	int i;
 
+	dram = mv_mbus_dram_info();
+
 	/*
 	 * First, disable and clear BARs and windows.
 	 */
@@ -150,7 +152,7 @@ static void __init orion_pcie_setup_wins(void __iomem *base,
 	 */
 	size = 0;
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 
 		writel(cs->base & 0xffff0000, base + PCIE_WIN04_BASE_OFF(i));
 		writel(0, base + PCIE_WIN04_REMAP_OFF(i));
@@ -184,7 +186,7 @@ void __init orion_pcie_setup(void __iomem *base)
 	/*
 	 * Point PCIe unit MBUS decode windows to DRAM space.
 	 */
-	orion_pcie_setup_wins(base, &orion_mbus_dram_info);
+	orion_pcie_setup_wins(base);
 
 	/*
 	 * Master + slave enable.
-- 
1.7.9.5
