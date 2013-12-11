From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 11 Dec 2013 19:28:39 -0300
Subject: [PATCH] ARM: mvebu: Enable NAND controller in A370 Reference Design
 board
Message-ID: <1386800920-7096-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell's Armada 370 Reference Design has a NAND flash, so enable it in
the devicetree and add the partitions as prepared in the factory images.

In order to skip the driver's custom device detection and use only ONFI
detection, the "marvell,keep-config" parameter is used. This is needed
because we have no support for setting the timings parameters yet.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index f81810a..abbb807 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -104,6 +104,27 @@
 					gpios = <&gpio0 6 1>;
 				};
 			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+
+				partition at 0 {
+					label = "U-Boot";
+					reg = <0 0x800000>;
+				};
+				partition at 800000 {
+					label = "Linux";
+					reg = <0x800000 0x800000>;
+				};
+				partition at 1000000 {
+					label = "Filesystem";
+					reg = <0x1000000 0x3f000000>;
+				};
+			};
 		};
 	};
  };
-- 
1.8.1.5
