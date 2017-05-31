From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 31 May 2017 15:41:46 +0200
Subject: [PATCH v2 02/11] clk: mvebu: cp110 fix name of the GOP gate clock
In-Reply-To: <cover.d3a417499f4e5f039deaa27832bf6eccdd090a6f.1496237893.git-series.gregory.clement@free-electrons.com>
References: <cover.d3a417499f4e5f039deaa27832bf6eccdd090a6f.1496237893.git-series.gregory.clement@free-electrons.com>
Message-ID: <edce259fb331015346d9af3a13dee39ef4c99dc0.1496237893.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually the GOP clock (bit 18) is not at all used for emmc but only
for GOP: let's fix the name.

Changing the name in the device tree is not an issue because the name
itself is not used to reference the clock. Thanks to this the ABI remains
backward compatible.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 drivers/clk/mvebu/cp110-system-controller.c          | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index ac8df5201cd6..59259270964c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -111,7 +111,7 @@
 					"cpm-gop-dp", "none", "cpm-pcie_x10",
 					"cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor",
 					"cpm-sata", "cpm-sata-usb", "cpm-main",
-					"cpm-sd-mmc-gop", "none", "none",
+					"cpm-gop", "none", "none",
 					"cpm-slow-io", "cpm-usb3h0", "cpm-usb3h1",
 					"cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 			};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 7740a75a8230..046d3fe53cda 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -118,7 +118,7 @@
 					"cps-gop-dp", "none", "cps-pcie_x10",
 					"cps-pcie_x11", "cps-pcie_x4", "cps-pcie-xor",
 					"cps-sata", "cps-sata-usb", "cps-main",
-					"cps-sd-mmc-gop", "none", "none",
+					"cps-gop", "none", "none",
 					"cps-slow-io", "cps-usb3h0", "cps-usb3h1",
 					"cps-usb3dev", "cps-eip150", "cps-eip197";
 			};
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 6b11d7b3e0e0..8f315c74997e 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -76,7 +76,7 @@ enum {
 #define CP110_GATE_SATA			15
 #define CP110_GATE_SATA_USB		16
 #define CP110_GATE_MAIN			17
-#define CP110_GATE_SDMMC_GOP		18
+#define CP110_GATE_GOP			18
 #define CP110_GATE_SLOW_IO		21
 #define CP110_GATE_USB3H0		22
 #define CP110_GATE_USB3H1		23
@@ -314,7 +314,8 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
 		case CP110_GATE_GOP_DP:
 			of_property_read_string_index(np,
 						      "gate-clock-output-names",
-						      CP110_GATE_SDMMC_GOP, &parent);
+						      CP110_GATE_GOP, &parent);
+
 			break;
 		case CP110_GATE_XOR1:
 		case CP110_GATE_XOR0:
-- 
git-series 0.9.1
