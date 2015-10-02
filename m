From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:26:46 +0530
Subject: [PATCH 5/5] arm64: dts: Add BRCM IPROC NAND DT node for NS2
In-Reply-To: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
References: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808606-21203-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller on NS2 SoC is compatible with existing
BRCM IPROC NAND driver so let's enable it in NS2 DT and
NS2 SVK DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index e5950d5..a754160 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -63,5 +63,17 @@
 		uart3: serial at 66130000 {
 			status = "ok";
 		};
+
+		nand: nand at 66460000 {
+			nandcs at 0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-ecc-mode = "hw";
+				nand-ecc-strength = <8>;
+				nand-ecc-step-size = <512>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index f603277..55c3c5a 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -212,5 +212,20 @@
 			compatible = "brcm,iproc-rng200";
 			reg = <0x66220000 0x28>;
 		};
+
+		nand: nand at 66460000 {
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
+			reg = <0x66460000 0x600>,
+			      <0x67015408 0x600>,
+			      <0x66460f00 0x20>;
+			reg-names = "nand", "iproc-idm", "iproc-ext";
+			interrupts = <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			brcm,nand-iproc-reset;
+			brcm,nand-has-wp;
+		};
 	};
 };
-- 
1.9.1
