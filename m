From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 28 Mar 2016 10:18:30 +0530
Subject: [PATCH v2 5/5] arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for
 NS2
In-Reply-To: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1459140510-5317-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have one dual-port SATA3 AHCI controller present in
NS2 SoC.

This patch enables SATA3 AHCI controller and SATA3 PHY
for NS2 SoC in NS2 DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 12 +++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 43 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index ce0ab84..06cf9c5 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -72,6 +72,18 @@
 	status = "ok";
 };
 
+&sata_phy0 {
+	status = "ok";
+};
+
+&sata_phy1 {
+	status = "ok";
+};
+
+&sata {
+	status = "ok";
+};
+
 &sdio0 {
 	status = "ok";
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 6f81c9d..c8dccf8 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -413,6 +413,49 @@
 			reg = <0x66220000 0x28>;
 		};
 
+		sata_phy: sata_phy at 663f0100 {
+			compatible = "brcm,iproc-ns2-sata-phy";
+			reg = <0x663f0100 0x1f00>,
+			      <0x663f004c 0x10>;
+			reg-names = "phy", "phy-ctrl";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			sata_phy1: sata-phy at 1 {
+				reg = <1>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		sata: ahci at 663f2000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x663f2000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+				phy-names = "sata-phy";
+			};
+
+			sata1: sata-port at 1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+				phy-names = "sata-phy";
+			};
+		};
+
 		sdio0: sdhci at 66420000 {
 			compatible = "brcm,sdhci-iproc-cygnus";
 			reg = <0x66420000 0x100>;
-- 
1.9.1
