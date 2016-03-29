From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 29 Mar 2016 12:57:34 +0530
Subject: [PATCH 4/4] arm64: dts: Add ARM PL022 SPI DT nodes for NS2
In-Reply-To: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
References: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1459236454-26285-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have two ARM PL022 SPI instances in NS2 SoC. On NS2 SVK,
one of the ARM PL022 SPI host has Silabs si3226x slic connected
to chip-select #0 whereas second ARM PL022 SPI host has Atmel
AT25 EEPROM connected to chip-select #0.

This patch adds ARM PL022, Silabs si3226x, and Atmel AT25
DT nodes in NS2 DT and NS2 SVK DT respectively.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 45 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 22 ++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index ce0ab84..54ca40c 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -72,6 +72,51 @@
 	status = "ok";
 };
 
+&ssp0 {
+	status = "ok";
+
+	slic at 0 {
+		compatible = "silabs,si3226x";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		spi-cpha = <1>;
+		spi-cpol = <1>;
+		pl022,hierarchy = <0>;
+		pl022,interface = <0>;
+		pl022,slave-tx-disable = <0>;
+		pl022,com-mode = <0>;
+		pl022,rx-level-trig = <1>;
+		pl022,tx-level-trig = <1>;
+		pl022,ctrl-len = <11>;
+		pl022,wait-state = <0>;
+		pl022,duplex = <0>;
+	};
+};
+
+&ssp1 {
+	status = "ok";
+
+	at25 at 0 {
+		compatible = "atmel,at25";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		at25,byte-len = <0x8000>;
+		at25,addr-mode = <2>;
+		at25,page-size = <64>;
+		spi-cpha = <1>;
+		spi-cpol = <1>;
+		pl022,hierarchy = <0>;
+		pl022,interface = <0>;
+		pl022,slave-tx-disable = <0>;
+		pl022,com-mode = <0>;
+		pl022,rx-level-trig = <1>;
+		pl022,tx-level-trig = <1>;
+		pl022,ctrl-len = <11>;
+		pl022,wait-state = <0>;
+		pl022,duplex = <0>;
+	};
+};
+
 &sdio0 {
 	status = "ok";
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 0a92a68..123cd9c 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -354,6 +354,28 @@
 			status = "disabled";
 		};
 
+		ssp0: ssp at 66180000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x66180000 0x1000>;
+			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&iprocslow>, <&iprocslow>;
+			clock-names = "spiclk", "apb_pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		ssp1: ssp at 66190000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x66190000 0x1000>;
+			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&iprocslow>, <&iprocslow>;
+			clock-names = "spiclk", "apb_pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		hwrng: hwrng at 66220000 {
 			compatible = "brcm,iproc-rng200";
 			reg = <0x66220000 0x28>;
-- 
1.9.1
