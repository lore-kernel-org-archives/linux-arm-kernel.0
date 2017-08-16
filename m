From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 16 Aug 2017 15:52:24 +0800
Subject: [RFC PATCH 3/3] arm64: dts: rockchip: Handle pcie wake in pcie driver
 for Gru
In-Reply-To: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
References: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
Message-ID: <20170816075224.31734-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are handling pcie wake irq in mrvl wifi driver.
Move it to rockchip pcie driver for Gru boards.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index d48e98b62d09..7a5e1517a496 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -712,11 +712,21 @@ ap_i2c_audio: &i2c8 {
 
 	ep-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wifi_perst_l>;
+	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wlan_host_wake_l>, <&wifi_perst_l>;
+
+	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "sys", "legacy", "client", "wake";
+	/delete-property/ interrupts;
+
 	vpcie3v3-supply = <&pp3300_wifi_bt>;
 	vpcie1v8-supply = <&wlan_pd_n>; /* HACK: see &wlan_pd_n */
 	vpcie0v9-supply = <&pp900_pcie>;
 
+	wakeup-source;
+
 	pci_rootport: pcie at 0,0 {
 		reg = <0x83000000 0x0 0x00000000 0x0 0x00000000>;
 		#address-cells = <3>;
@@ -727,11 +737,6 @@ ap_i2c_audio: &i2c8 {
 			compatible = "pci1b4b,2b42";
 			reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
 			       0x83010000 0x0 0x00100000 0x0 0x00100000>;
-			interrupt-parent = <&gpio0>;
-			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_host_wake_l>;
-			wakeup-source;
 		};
 	};
 };
-- 
2.11.0
