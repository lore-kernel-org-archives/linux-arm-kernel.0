From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 26 Oct 2017 21:28:36 +0800
Subject: [RFC PATCH v8 3/7] arm64: dts: rockchip: Handle PCIe WAKE# signal in
 pcie driver for Gru
In-Reply-To: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
Message-ID: <20171026132840.20946-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are handling PCIe WAKE# signal in mrvl wifi driver.
Move it to rockchip pcie driver for Gru boards.

Also avoid this irq been considered as the PCI interrupt pin in the
of_irq_parse_pci().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v8:
Rewrite the commit message.

Changes in v7: None
Changes in v6: None
Changes in v5:
Use "wakeup" instead of "wake"

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 5772c52fbfd3..8e37da69f693 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -708,7 +708,15 @@ ap_i2c_audio: &i2c8 {
 
 	ep-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wifi_perst_l>;
+	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wlan_host_wake_l>, <&wifi_perst_l>;
+
+	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "sys", "legacy", "client", "wakeup";
+	/delete-property/ interrupts;
+
 	vpcie3v3-supply = <&pp3300_wifi_bt>;
 	vpcie1v8-supply = <&wlan_pd_n>; /* HACK: see &wlan_pd_n */
 	vpcie0v9-supply = <&pp900_pcie>;
@@ -723,11 +731,6 @@ ap_i2c_audio: &i2c8 {
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
