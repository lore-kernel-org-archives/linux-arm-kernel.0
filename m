From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Fri, 16 May 2014 10:49:01 +0200
Subject: [PATCH v2 1/3] ARM: dts: kirkwood: resynch 98dx4122 dtsi
In-Reply-To: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
References: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <1400230143-15620-2-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX4122 dtsi file lacks the defintion of the PCIe controller which
is present on this SoC.

The SATA phys must also be explicitely disabled since they are not
present on this SoC. If they remain enabled, a hardlock occures when
their clock gates are enabled.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---

Changes in v2: None

 arch/arm/boot/dts/kirkwood-98dx4122.dtsi | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index 2e8e412..9e1f741 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -1,4 +1,39 @@
 / {
+	mbus {
+		pciec: pcie-controller {
+			compatible = "marvell,kirkwood-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
+				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
+				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */>;
+
+			pcie0: pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
+					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 9>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,98dx4122-pinctrl";
@@ -6,3 +41,11 @@
 		};
 	};
 };
+
+&sata_phy0 {
+	status = "disabled";
+};
+
+&sata_phy1 {
+	status = "disabled";
+};
-- 
1.8.0.1
