From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Dec 2016 13:41:19 +0100
Subject: [PATCH 2/3] clk: mvebu: adjust clock handling for the CP110 system
 controller
In-Reply-To: <1481632880-9198-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1481632880-9198-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1481632880-9198-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for the GOP_DP gatable clock found in the
CP110 system controller. This clock is controlled by bit 9, and has
clock 18 as its parent. Therefore, clock 18 is in fact not only
controlling SD/MMC, but also GOP, but it is renamed as SD_MMC_GOP
accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/cp110-system-controller.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index f2303da..3c91cab 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -66,6 +66,7 @@ enum {
 #define CP110_GATE_SDIO			4
 #define CP110_GATE_XOR1			7
 #define CP110_GATE_XOR0			8
+#define CP110_GATE_GOP_DP		9
 #define CP110_GATE_PCIE_X1_0		11
 #define CP110_GATE_PCIE_X1_1		12
 #define CP110_GATE_PCIE_X4		13
@@ -73,7 +74,7 @@ enum {
 #define CP110_GATE_SATA			15
 #define CP110_GATE_SATA_USB		16
 #define CP110_GATE_MAIN			17
-#define CP110_GATE_SDMMC		18
+#define CP110_GATE_SDMMC_GOP		18
 #define CP110_GATE_SLOW_IO		21
 #define CP110_GATE_USB3H0		22
 #define CP110_GATE_USB3H1		23
@@ -309,9 +310,10 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
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
