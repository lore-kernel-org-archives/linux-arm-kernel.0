From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:55:19 +0200
Subject: [PATCH 1/7] clk: mvebu: cp110 fix name of the GOP gate clock
In-Reply-To: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <062f869fb140c2626efadef80f325d9f03c330f6.1495208533.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually the GOP clock (bit 18) is not at all used for emmc but only
for GOP: let's fix the name.

Changing the name in the device tree is not an issue because the name
itself is not used to reference the clock. Thanks to this the ABI remains
backward compatible.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt | 6 +++---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi                       | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi                        | 2 +-
 drivers/clk/mvebu/cp110-system-controller.c                                | 5 +++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
index 07dbb358182c..eb6cf44caa0f 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
@@ -45,7 +45,7 @@ The following clocks are available:
    - 1 15	SATA
    - 1 16	SATA USB
    - 1 17	Main
-   - 1 18	SD/MMC/GOP
+   - 1 18	GOP
    - 1 21	Slow IO (SPI, NOR, BootROM, I2C, UART)
    - 1 22	USB3H0
    - 1 23	USB3H1
@@ -65,7 +65,7 @@ Required properties:
 	"cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
 	"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "none",
 	"cpm-pcie_x10", "cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata",
-	"cpm-sata-usb", "cpm-main", "cpm-sd-mmc-gop", "none", "none", "cpm-slow-io",
+	"cpm-sata-usb", "cpm-main", "cpm-gop", "none", "none", "cpm-slow-io",
 	"cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 
 Example:
@@ -78,6 +78,6 @@ Example:
 		gate-clock-output-names = "cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
 			"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "none",
 			"cpm-pcie_x10", "cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata",
-			"cpm-sata-usb", "cpm-main", "cpm-sd-mmc-gop", "none", "none", "cpm-slow-io",
+			"cpm-sata-usb", "cpm-main", "cpm-gop", "none", "none", "cpm-slow-io",
 			"cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 	};
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
