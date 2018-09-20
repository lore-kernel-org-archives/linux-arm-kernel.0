From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Thu, 20 Sep 2018 16:50:48 +0800
Subject: [PATCH v4 1/2] dt-bindings: nand: meson: add Amlogic NAND controller
 driver
In-Reply-To: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <1537433449-65213-2-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Yang <liang.yang@amlogic.com>

Add Amlogic NAND controller dt-bindings for Meson SoC,
Current this driver support GXBB/GXL/AXG platform.

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
new file mode 100644
index 0000000..803df2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -0,0 +1,60 @@
+Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
+
+This file documents the properties in addition to those available in
+the MTD NAND bindings.
+
+Required properties:
+- compatible : contains one of:
+  - "amlogic,meson-gxl-nfc"
+  - "amlogic,meson-axg-nfc"
+- clocks     :
+	A list of phandle + clock-specifier pairs for the clocks listed
+	in clock-names.
+
+- clock-names: Should contain the following:
+	"core" - NFC module gate clock
+	"device" - device clock from eMMC sub clock controller
+
+- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
+				controller port C
+
+Optional children nodes:
+Children nodes represent the available nand chips.
+
+Other properties:
+see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
+
+Example demonstrate on AXG SoC:
+
+	sd_emmc_c_clkc: mmc at 7000 {
+		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
+		reg = <0x0 0x7000 0x0 0x800>;
+		status = "okay";
+	};
+
+	nand: nfc at 7800 {
+		compatible = "amlogic,meson-axg-nfc";
+		reg = <0x0 0x7800 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
+
+		clocks = <&clkc CLKID_SD_EMMC_C>,
+			<&sd_emmc_c_clkc CLKID_MMC_DIV>;
+		clock-names = "core", "device";
+		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
+
+		status = "okay";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nand_pins>;
+
+		nand at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nand-on-flash-bbt;
+		};
+	};
-- 
1.9.1
