From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 10 May 2016 14:49:41 -0500
Subject: [PATCH 1/2] ARM: dts: dra7: Add ocmcram nodes
In-Reply-To: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1462909782-14639-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add all ocmcram nodes to dra7.dtsi using the generic mmio-sram driver.
DRA7xx and AM57xx families of SoCs can contain three ocmcram regions of
SRAM, one of 512kb and also an optional two additional of 1Mb each. Mark
the two additional 1MB regions of SRAM as disabled as only ocmcmram1 is
on all variants of the SoCs, then depending on which specific variant
is in use the ocmcram2 and ocmcram3 nodes can be enabled in the board
dts file if the data manual for that part number indicates the ocmcram
region is available.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 13ac88279427..fd6f74856bd3 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -286,6 +286,38 @@
 			};
 		};
 
+		ocmcram1: ocmcram at 40300000 {
+			compatible = "mmio-sram";
+			reg = <0x40300000 0x80000>;
+			ranges = <0x0 0x40300000 0x80000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		/*
+		 * NOTE: ocmcram2 and ocmcram3 are not available on all
+		 * DRA7xx and AM57xx variants. Confirm availability in
+		 * the data manual for the exact part number in use
+		 * before enabling these nodes in the board dts file.
+		 */
+		ocmcram2: ocmcram at 40400000 {
+			status = "disabled";
+			compatible = "mmio-sram";
+			reg = <0x40400000 0x100000>;
+			ranges = <0x0 0x40400000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		ocmcram3: ocmcram at 40500000 {
+			status = "disabled";
+			compatible = "mmio-sram";
+			reg = <0x40500000 0x100000>;
+			ranges = <0x0 0x40500000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		bandgap: bandgap at 4a0021e0 {
 			reg = <0x4a0021e0 0xc
 				0x4a00232c 0xc
-- 
2.7.3
