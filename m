From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat,  5 Mar 2016 18:16:53 +0100
Subject: [PATCH v3 net-next 1/9] ARM: dts: armada-38x: add buffer manager nodes
In-Reply-To: <1457198221-21752-1-git-send-email-gregory.clement@free-electrons.com>
References: <1457198221-21752-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1457198221-21752-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>

Armada 38x network controller supports hardware buffer management (BM).
Since it is now enabled in mvneta driver, appropriate nodes can be added
to armada-38x.dtsi - for the actual common BM unit (bm at c8000) and its
internal SRAM (bm-bppi), which is used for indirect access to buffer
pointer ring residing in DRAM.

Pools - ports mapping, bm-bppi entry in 'soc' node's ranges and optional
parameters are supposed to be set in board files.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index e8b7f6726772..1b7d690d8e10 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -540,6 +540,14 @@
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
@@ -618,6 +626,16 @@
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
2.5.0
