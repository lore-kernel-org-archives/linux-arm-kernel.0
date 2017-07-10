From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 10 Jul 2017 09:56:20 +0200
Subject: [PATCH 1/2] ARM64: dts: meson-gx: Add PWR and CRT/RTC nodes and
 adresses
In-Reply-To: <1499673381-21039-1-git-send-email-narmstrong@baylibre.com>
References: <1499673381-21039-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1499673381-21039-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AO 32KHz generation registers are split among multiple registers :
 - The CRT Control
 - The RTC Clock Control
 - The AO Domain PWR Control

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 35b8c88..91a57d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -367,11 +367,20 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
+			pwr_AO: power-control at 00c {
+				compatible = "amlogic,gx-pwr-ctrl", "syscon";
+				reg = <0x0 0x0000c 0x0 0x8>;
+			};
+
 			clkc_AO: clock-controller at 040 {
 				compatible = "amlogic,gx-aoclkc", "amlogic,gxbb-aoclkc";
-				reg = <0x0 0x00040 0x0 0x4>;
+				reg = <0x0 0x00040 0x0 0x4>,
+				      <0x0 0x00068 0x0 0x4>,
+				      <0x0 0x00094 0x0 0x8>;
+				reg-names = "aoclk", "aocrt", "aortc";
 				#clock-cells = <1>;
 				#reset-cells = <1>;
+				amlogic,pwr-ctrl = <&pwr_AO>;
 			};
 
 			uart_AO: serial at 4c0 {
-- 
1.9.1
