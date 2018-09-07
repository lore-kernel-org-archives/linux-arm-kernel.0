From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Fri, 7 Sep 2018 18:57:10 +0800
Subject: [RFC PATCH v3 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
In-Reply-To: <1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com>
References: <1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <1536317831-58056-2-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Yang <liang.yang@amlogic.com>

Add Amlogic NAND controller dt-bindings for Meson SoC,
Current this driver support GXBB/GXL/AXG platform.

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
new file mode 100644
index 0000000..655a778
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -0,0 +1,91 @@
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
+- pins     : Select pins which NFC need.
+- nand_pins: Detail NAND pins information.
+- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
+				controller port C
+
+Optional children nodes:
+Children nodes represent the available nand chips.
+
+
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
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <8>;
+			nand-ecc-step-size = <1024>;
+
+			amlogic,nand-enable-scrambler;
+
+			partition at 0 {
+				label = "boot";
+				reg = <0x00000000 0x00200000>;
+				read-only;
+			};
+			partition at 200000 {
+				label = "env";
+				reg = <0x00200000 0x00400000>;
+			};
+			partition at 600000 {
+				label = "system";
+				reg = <0x00600000 0x00a00000>;
+			};
+			partition at 1000000 {
+				label = "rootfs";
+				reg = <0x01000000 0x03000000>;
+			};
+			partition at 4000000 {
+				label = "media";
+				reg = <0x04000000 0x8000000>;
+			};
+		};
+	};
-- 
1.9.1
