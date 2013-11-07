From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:35 -0300
Subject: [PATCH v4 31/31] ARM: mvebu: Enable NAND controller in Armada 370
 Mirabox
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-32-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 Mirabox has a NAND flash, so enable it in the devicetree
and add the partitions as prepared in the factory images.

In order to skip the driver's custom device detection and use only
ONFI detection, the "marvell,keep-config" parameter is used.
This is needed because we have no support for setting the timings parameters yet.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 2471d9d..1e73017 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -139,6 +139,27 @@
 					reg = <0x25>;
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
+					reg = <0 0x400000>;
+				};
+				partition at 400000 {
+					label = "Linux";
+					reg = <0x400000 0x400000>;
+				};
+				partition at 800000 {
+					label = "Filesystem";
+					reg = <0x800000 0x3f800000>;
+				};
+			};
 		};
 	};
 };
-- 
1.8.1.5
