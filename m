From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 24 Oct 2014 13:51:34 -0400
Subject: [PATCH 3/4] ARM: keystone: dts: add DT bindings for PCI controller
 for port 0
In-Reply-To: <1414173095-32511-1-git-send-email-m-karicheri2@ti.com>
References: <1414173095-32511-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1414173095-32511-4-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add common DT bindings to support Port 0 Root Complex on all of the
K2 SoCs that has Synopsis Designware based pcie h/w.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
CC : Santosh Shilimkar <santosh.shilimkar@gmail.com>
CC : Rob Herring <robh+dt@kernel.org>
CC : Pawel Moll <pawel.moll@arm.com>
CC : Mark Rutland <mark.rutland@arm.com>
CC : Ian Campbell <ijc+devicetree@hellion.org.uk>
CC : Kumar Gala <galak@codeaurora.org>
CC : Russell King <linux@arm.linux.org.uk>
CC : devicetree at vger.kernel.org
---
 arch/arm/boot/dts/keystone.dtsi |   45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 5d3e83f..87b2daa 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -285,5 +285,50 @@
 			#interrupt-cells = <1>;
 			ti,syscon-dev = <&devctrl 0x2a0>;
 		};
+
+		pcie at 21800000 {
+			compatible = "ti,keystone-pcie", "snps,dw-pcie";
+			clocks = <&clkpcie>;
+			clock-names = "pcie";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg =  <0x21801000 0x2000>, <0x21800000 0x1000>, <0x02620128 4>;
+			ranges = <0x81000000 0 0 0x23250000 0 0x4000
+				0x82000000 0 0x50000000 0x50000000 0 0x10000000>;
+
+			device_type = "pci";
+			num-lanes = <2>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>, // INT A
+					<0 0 0 2 &pcie_intc0 1>, // INT B
+					<0 0 0 3 &pcie_intc0 2>, // INT C
+					<0 0 0 4 &pcie_intc0 3>; // INT D
+
+			pcie_msi_intc0: msi-interrupt-controller {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 32 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 33 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
+			};
+
+			pcie_intc0: legacy-interrupt-controller {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 27 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
