From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 12 Jan 2015 15:14:05 +0800
Subject: [PATCH v3] mtd: hisilicon: add device tree node for NAND controller
Message-ID: <1421046845-25814-1-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add dts support for NAND flash controller of Hisilicon Soc Hip04

I resend this patch with new E-mail address in signed-off-by.

Changes in v3:
- Change E-mail address in signed-off-by to "wangzhou1 at hisilicon.com"
Changes in v2:
- Base on v3.19-rc1
- Use nand-ecc-strength, nand-ecc-step-size to replace hisi,nand-ecc-bits
Changes in v1:
- Move partition and other board related information into board dts file:
  hip04-d01.dts

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm/boot/dts/hip04-d01.dts | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/hip04.dtsi    |  7 +++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
index 40a9e33..ba04dd5 100644
--- a/arch/arm/boot/dts/hip04-d01.dts
+++ b/arch/arm/boot/dts/hip04-d01.dts
@@ -28,5 +28,32 @@
 		uart0: uart at 4007000 {
 			status = "ok";
 		};
+
+		nand: nand at 4020000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <16>;
+			nand-ecc-step-size = <1024>;
+
+			partition at 0 {
+				label = "nand_text";
+				reg = <0x00000000 0x00400000>;
+			};
+
+			partition at 00400000 {
+				label = "nand_monitor";
+				reg = <0x00400000 0x00400000>;
+			};
+
+			partition at 00800000 {
+				label = "nand_kernel";
+				reg = <0x00800000 0x00800000>;
+			};
+
+			partition at 01000000 {
+				label = "nand_fs";
+				reg = <0x01000000 0x1f000000>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 2388145..ac32fce 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -269,6 +269,13 @@
 			interrupts = <0 372 4>;
 		};
 
+		nand: nand at 4020000 {
+			compatible = "hisilicon,504-nfc";
+			reg = <0x4020000 0x10000>, <0x5000000 0x1000>;
+			interrupts = <0 379 4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 
 	etb at 0,e3c42000 {
-- 
1.9.1
