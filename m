From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Sat, 29 Jul 2017 10:12:26 +0530
Subject: [PATCH 4/7] arm64: dts: Add DT node to enable BGMAC driver on Stingray
In-Reply-To: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
References: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <1501303349-30007-5-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT node to enable BGMAC driver on Stingray

Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Oza Oza <oza.oza@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts      |  4 ++++
 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts      |  4 ++++
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi       |  9 +++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index 5dca7d1..cacc25e 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -72,6 +72,14 @@
 	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
 };
 
+&mdio_mux_iproc {
+	mdio at 10 {
+		gphy0: eth-phy at 10 {
+			reg = <0x10>;
+		};
+	};
+};
+
 &uart1 {
 	status = "okay";
 };
@@ -102,6 +110,12 @@
 	};
 };
 
+&enet {
+	phy-mode = "rgmii-id";
+	phy-handle = <&gphy0>;
+	status = "okay";
+};
+
 &nand {
 	status = "ok";
 	nandcs at 0 {
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
index 5671669..eb6f08c 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
@@ -39,6 +39,10 @@
 	model = "Stingray Combo SVK (BCM958742K)";
 };
 
+&gphy0 {
+	enet-phy-lane-swap;
+};
+
 &uart2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
index 6ebe399..5084b03 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
@@ -38,3 +38,7 @@
 	compatible = "brcm,bcm958742t", "brcm,stingray";
 	model = "Stingray SST100 (BCM958742T)";
 };
+
+&gphy0 {
+	enet-phy-lane-swap;
+};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 19ad887..1c6cc2d 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -548,6 +548,15 @@
 			iommus = <&smmu 0x6000 0x0000>;
 		};
 
+		enet: ethernet at 00340000{
+			compatible = "brcm,amac";
+			reg = <0x00340000 0x1000>;
+			reg-names = "amac_base";
+			dma-coherent;
+			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+			status= "disabled";
+		};
+
 		nand: nand at 00360000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x00360000 0x600>,
-- 
2.7.4
