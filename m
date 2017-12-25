From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 25 Dec 2017 19:47:42 +0800
Subject: [RFC PATCH v11 5/5] arm64: dts: rockchip: Move PCIe WAKE# irq to pcie
 port for Gru
In-Reply-To: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
Message-ID: <20171225114742.18920-6-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are handling PCIe WAKE# irq in mrvl wifi driver.

Move it to rockchip pcie port since we are going to handle it in the
pci core.

Also avoid this irq been considered as the PCI interrupt pin in the
of_irq_parse_pci().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v11:
Move to pcie port as Brian suggested.

Changes in v10: None
Changes in v9:
Rewrite the commit message.

Changes in v8:
Rewrite the commit message.

Changes in v7: None
Changes in v6: None
Changes in v5:
Use "wakeup" instead of "wake"

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 03f195025390..be41d363efd8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -719,15 +719,16 @@ ap_i2c_audio: &i2c8 {
 		#size-cells = <2>;
 		ranges;
 
+		interrupts-extended = <&pcie0 1>, <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "pci", "wakeup";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_host_wake_l>;
+		wakeup-source;
+
 		mvl_wifi: wifi at 0,0 {
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
