From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 11 Jan 2018 11:28:52 +0530
Subject: [PATCH 2/3] arm: spear13xx: Fix dmas cells
In-Reply-To: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
Message-ID: <6183c13fd3abcb2a6834a537a4809b6527204f10.1515650104.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "dmas" cells for the designware DMA controller need to have only 3
properties apart from the phandle: request line, src master and
destination master. But the commit 6e8887f60f60 updated it incorrectly
while moving from platform code to DT. Fix it.

Cc: stable at vger.kernel.org # v3.10+
Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/dma/snps-dma.txt | 2 +-
 arch/arm/boot/dts/spear1340.dtsi                   | 4 ++--
 arch/arm/boot/dts/spear13xx.dtsi                   | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt b/Documentation/devicetree/bindings/dma/snps-dma.txt
index a122723907ac..99acc712f83a 100644
--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
@@ -64,6 +64,6 @@ described in the dma.txt file, using a four-cell specifier for each channel.
 		reg = <0xe0000000 0x1000>;
 		interrupts = <0 35 0x4>;
 		dmas = <&dmahost 12 0 1>,
-			<&dmahost 13 0 1 0>;
+			<&dmahost 13 1 0>;
 		dma-names = "rx", "rx";
 	};
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 5f347054527d..d4dbc4098653 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -142,8 +142,8 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x600 0 0 1>, /* 0xC << 11 */
-					<&dwdma0 0x680 0 1 0>; /* 0xD << 7 */
+				dmas = <&dwdma0 12 0 1>,
+					<&dwdma0 13 1 0>;
 				dma-names = "tx", "rx";
 			};
 
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 17ea0abcdbd7..086b4b333249 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -100,7 +100,7 @@
 			reg = <0xb2800000 0x1000>;
 			interrupts = <0 29 0x4>;
 			status = "disabled";
-			dmas = <&dwdma0 0 0 0 0>;
+			dmas = <&dwdma0 0 0 0>;
 			dma-names = "data";
 		};
 
@@ -290,8 +290,8 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x2000 0 0 0>, /* 0x4 << 11 */
-					<&dwdma0 0x0280 0 0 0>;  /* 0x5 << 7 */
+				dmas = <&dwdma0 4 0 0>,
+					<&dwdma0 5 0 0>;
 				dma-names = "tx", "rx";
 			};
 
-- 
2.15.0.194.g9af6a3dea062
