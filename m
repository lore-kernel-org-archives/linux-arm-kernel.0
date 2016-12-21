From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Dec 2016 11:26:56 +0100
Subject: [PATCHv2 2/3] clk: mvebu: adjust clock handling for the CP110 system
 controller
In-Reply-To: <1482316017-22154-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482316017-22154-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1482316017-22154-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit:

 - makes the GOP_DP (bit 9) gatable clock a child clock of the
   SD_MMC_GOP (bit 18) clock, as it should have been. The clock for bit
   18 was just named SD_MMC, but since it also covers the GOP block, it
   is renamed SD_MMC_GOP.

 - makes the MG (bit 5) gatable clock a child clock of the MG_CORE
   clock (bit 6)

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/cp110-system-controller.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index f2303da..8038b93 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -64,8 +64,11 @@ enum {
 #define CP110_GATE_NAND			2
 #define CP110_GATE_PPV2			3
 #define CP110_GATE_SDIO			4
+#define CP110_GATE_MG			5
+#define CP110_GATE_MG_CORE		6
 #define CP110_GATE_XOR1			7
 #define CP110_GATE_XOR0			8
+#define CP110_GATE_GOP_DP		9
 #define CP110_GATE_PCIE_X1_0		11
 #define CP110_GATE_PCIE_X1_1		12
 #define CP110_GATE_PCIE_X4		13
@@ -73,7 +76,7 @@ enum {
 #define CP110_GATE_SATA			15
 #define CP110_GATE_SATA_USB		16
 #define CP110_GATE_MAIN			17
-#define CP110_GATE_SDMMC		18
+#define CP110_GATE_SDMMC_GOP		18
 #define CP110_GATE_SLOW_IO		21
 #define CP110_GATE_USB3H0		22
 #define CP110_GATE_USB3H1		23
@@ -302,6 +305,11 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 						      "gate-clock-output-names",
 						      CP110_GATE_MAIN, &parent);
 			break;
+		case CP110_GATE_MG:
+			of_property_read_string_index(np,
+						      "gate-clock-output-names",
+						      CP110_GATE_MG_CORE, &parent);
+			break;
 		case CP110_GATE_NAND:
 			parent = nand_name;
 			break;
@@ -309,9 +317,10 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 			parent = ppv2_name;
 			break;
 		case CP110_GATE_SDIO:
+		case CP110_GATE_GOP_DP:
 			of_property_read_string_index(np,
 						      "gate-clock-output-names",
-						      CP110_GATE_SDMMC, &parent);
+						      CP110_GATE_SDMMC_GOP, &parent);
 			break;
 		case CP110_GATE_XOR1:
 		case CP110_GATE_XOR0:
-- 
2.7.4
