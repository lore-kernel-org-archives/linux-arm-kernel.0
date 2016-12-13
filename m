From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Dec 2016 18:48:35 +0100
Subject: [PATCH v4 06/12] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Message-ID: <b8acb86f1e7977648977ed5c6b4eb86323e4b777.1481651244.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Marvell Xenon SDHC can support eMMC/SD/SDIO.
Add Xenon-specific properties.
Also add properties for Xenon PHY setting.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 197 +++++++-
 MAINTAINERS                                                   |   1 +-
 2 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
new file mode 100644
index 000000000000..c7589f8d4e3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
@@ -0,0 +1,197 @@
+Marvell Xenon SDHCI Controller device tree bindings
+This file documents differences between the core mmc properties
+described by mmc.txt and the properties used by the Xenon implementation.
+
+Multiple SDHCs might be put into a single Xenon IP, to save size and cost.
+Each SDHC is independent and owns independent resources, such as register sets,
+clock and PHY.
+Each SDHC should have an independent device tree node.
+
+Required Properties:
+- compatible: should be one of the following
+  - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SOC.
+  Must provide a second register area and marvell,pad-type.
+  - "marvell,armada-7000-sdhci": For controllers on Armada 7K/8K SOC.
+
+- clocks:
+  Array of clocks required for SDHC.
+  Require at least input clock for Xenon IP core.
+
+- clock-names:
+  Array of names corresponding to clocks property.
+  The input clock for Xenon IP core should be named as "core".
+
+- reg:
+  * For "marvell,armada-3700-sdhci", two register areas.
+    The first one for Xenon IP register. The second one for the Armada 3700 SOC
+    PHY PAD Voltage Control register.
+    Please follow the examples with compatible "marvell,armada-3700-sdhci"
+    in below.
+    Please also check property marvell,pad-type in below.
+
+  * For other compatible strings, one register area for Xenon IP.
+
+Optional Properties:
+- mmc-card:
+  mmc-card child node must be provided when current SDHC is for eMMC.
+  Xenon SDHC often can support both SD and eMMC. This child node indicates that
+  current SDHC is for eMMC card. Thus Xenon eMMC specific configuration and
+  operations can be enabled prior to eMMC init sequence.
+  Please refer to Documentation/devicetree/bindings/mmc/mmc-card.txt.
+  This child node should not be set if current Xenon SDHC is for SD/SDIO.
+
+- bus-width:
+  When 8-bit data bus width is in use for eMMC, this property should be
+  explicitly provided and set as 8.
+  It is optional when data bus width is 4-bit or 1-bit.
+
+- mmc-ddr-1_8v:
+  Select this property when eMMC HS DDR is supported on SDHC side.
+
+- mmc-hs400-1_8v:
+  Select this property when eMMC HS400 is supported on SDHC side.
+
+- no-1-8-v:
+  Select this property when 1.8V signaling voltage supply is unavailable.
+  When this property is enabled, both mmc-ddr-1_8v and mmc-hs400-1_8v should be
+  cleared.
+
+- marvell,xenon-sdhc-id:
+  Indicate the corresponding bit index of current SDHC in
+  SDHC System Operation Control Register Bit[7:0].
+  Set/clear the corresponding bit to enable/disable current SDHC.
+  If Xenon IP contains only one SDHC, this property is optional.
+
+- marvell,xenon-phy-type:
+  Xenon support mutilple types of PHYs.
+  To select eMMC 5.1 PHY, set:
+  marvell,xenon-phy-type = "emmc 5.1 phy"
+  eMMC 5.1 PHY is the default choice if this property is not provided.
+  To select eMMC 5.0 PHY, set:
+  marvell,xenon-phy-type = "emmc 5.0 phy"
+
+  All those types of PHYs can support eMMC, SD and SDIO.
+  Please note that this property only presents the type of PHY.
+  It doesn't stand for the entire SDHC type or property.
+  For example, "emmc 5.1 phy" doesn't mean that this Xenon SDHC only supports
+  eMMC 5.1.
+
+- marvell,xenon-phy-znr:
+  Set PHY ZNR value.
+  Only available for eMMC PHY 5.1 and eMMC PHY 5.0.
+  Valid range = [0:0x1F].
+  ZNR is set as 0xF by default if this property is not provided.
+
+- marvell,xenon-phy-zpr:
+  Set PHY ZPR value.
+  Only available for eMMC PHY 5.1 and eMMC PHY 5.0.
+  Valid range = [0:0x1F].
+  ZPR is set as 0xF by default if this property is not provided.
+
+- marvell,xenon-phy-nr-success-tun:
+  Set the number of required consecutive successful sampling points used to
+  identify a valid sampling window, in tuning process.
+  Valid range = [1:7].
+  Set as 0x4 by default if this property is not provided.
+
+- marvell,xenon-phy-tun-step-divider:
+  Set the divider for calculating TUN_STEP.
+  Set as 64 by default if this property is not provided.
+
+- marvell,xenon-phy-slow-mode:
+  If this property is selected, transfers will bypass PHY.
+  Only available when bus frequency lower than 55MHz in SDR mde.
+  Disabled by default. Please only try this property if timing issues always
+  occur with PHY enabled in eMMC HS SDR, SD SDR12, SD SDR25, SD SDR50 mode.
+
+- marvell,xenon-tun-count:
+  Xenon SDHC SOC usually doesn't provide re-tuning counter in
+  Capabilities Register 3 Bit[11:8].
+  This property provides the re-tuning counter.
+  If this property is not set, default re-tuning counter will
+  be set as 0x9 in driver.
+
+- marvell,pad-type:
+  Type of Armada 3700 SOC PHY PAD Voltage Controller register.
+  Only valid when "marvell,armada-3700-sdhci" is selected.
+  Two types: "sd" and "fixed-1-8v".
+  If "sd" is slected, SOC PHY PAD is set as 3.3V at the beginning and is
+  switched to 1.8V when SD in UHS-I.
+  If "fixed-1-8v" is slected, SOC PHY PAD is fixed 1.8V, such as for eMMC.
+  Please follow the examples with compatible "marvell,armada-3700-sdhci"
+  in below.
+
+Example:
+- For eMMC:
+
+	sdhci at aa0000 {
+		compatible = "marvell,armada-7000-sdhci";
+		reg = <0xaa0000 0x1000>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
+		clocks = <&emmc_clk>;
+		clock-names = "core";
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		mmc-hs400-1_8v;
+		marvell,xenon-sdhc-id = <0>;
+		marvell,xenon-phy-type = "emmc 5.1 phy";
+		marvell,xenon-tun-count = <11>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mmccard: mmccard at 0 {
+			compatible = "mmc-card";
+			reg = <0>;
+		};
+	};
+
+- For SD/SDIO:
+
+	sdhci at ab0000 {
+		compatible = "marvell,armada-7000-sdhci";
+		reg = <0xab0000 0x1000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
+		vqmmc-supply = <&sd_regulator>;
+		clocks = <&sdclk>;
+		clock-names = "core";
+		bus-width = <4>;
+		marvell,xenon-tun-count = <9>;
+	};
+
+- For eMMC with compatible "marvell,armada-3700-sdhci":
+
+	sdhci at aa0000 {
+		compatible = "marvell,armada-3700-sdhci";
+		reg = <0xaa0000 0x1000>,
+		      <phy_addr 0x4>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
+		clocks = <&emmcclk>;
+		clock-names = "core";
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		mmc-hs400-1_8v;
+
+		marvell,pad-type = "fixed-1-8v";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mmccard: mmccard at 0 {
+			compatible = "mmc-card";
+			reg = <0>;
+		};
+	};
+
+- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
+
+	sdhci at ab0000 {
+		compatible = "marvell,armada-3700-sdhci";
+		reg = <0xab0000 0x1000>,
+		      <phy_addr 0x4>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
+		vqmmc-supply = <&sd_regulator>;
+		clocks = <&sdclk>;
+		clock-names = "core";
+		bus-width = <4>;
+
+		marvell,pad-type = "sd";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a5c4c30ea24..850a0afb0c8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7608,6 +7608,7 @@ MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
 M:	Ziji Hu <huziji@marvell.com>
 L:	linux-mmc at vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev at vger.kernel.org
-- 
git-series 0.9.1
