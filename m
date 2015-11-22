From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 22 Nov 2015 08:53:56 +0100
Subject: [PATCH 10/13] ARM: mvebu: add buffer manager nodes to armada-38x.dtsi
In-Reply-To: <1448178839-3541-1-git-send-email-mw@semihalf.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
Message-ID: <1448178839-3541-11-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 38x network controller supports hardware buffer management (BM).
Since it is now enabled in mvneta driver, appropriate nodes can be added
to armada-38x.dtsi - for the actual common BM unit (bm at c8000) and its
internal SRAM (bm-bppi), which is used for indirect access to buffer
pointer ring residing in DRAM.

Pools - ports mapping, bm-bppi entry in 'soc' node's ranges and optional
parameters are supposed to be set in board files.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index b7868b2..b9f4ce2 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -539,6 +539,14 @@
 				status = "disabled";
 			};
 
+			bm: bm at c8000 {
+				compatible = "marvell,armada-380-neta-bm";
+				reg = <0xc8000 0xac>;
+				clocks = <&gateclk 13>;
+				internal-mem = <&bm_bppi>;
+				status = "disabled";
+			};
+
 			sata at e0000 {
 				compatible = "marvell,armada-380-ahci";
 				reg = <0xe0000 0x2000>;
@@ -617,6 +625,16 @@
 			#size-cells = <1>;
 			ranges = <0 MBUS_ID(0x09, 0x15) 0 0x800>;
 		};
+
+		bm_bppi: bm-bppi {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x0c, 0x04) 0 0x100000>;
+			ranges = <0 MBUS_ID(0x0c, 0x04) 0 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&gateclk 13>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
1.8.3.1
