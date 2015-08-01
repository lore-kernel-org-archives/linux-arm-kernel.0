From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 31 Jul 2015 18:17:45 -0700
Subject: [PATCH v4 4/4] ARM: dts: brcmstb: add BCM7445 GPIO nodes
In-Reply-To: <1438391865-7862-1-git-send-email-gregory.0xf0@gmail.com>
References: <1438391865-7862-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1438391865-7862-5-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need the aon_pm_l2_intc and irq0_aon_intc descriptions, so included
those as well.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
New in v4.

 arch/arm/boot/dts/bcm7445.dtsi | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 58dcd66..3b6b175 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -109,6 +109,20 @@
 			brcm,int-fwd-mask = <0x70000>;
 		};
 
+		irq0_aon_intc: interrupt-controller at 417280 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x417280 0x8>;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 0x46 0x0>,
+				     <GIC_SPI 0x44 0x0>,
+				     <GIC_SPI 0x49 0x0>;
+			brcm,int-map-mask = <0x1e3 0x18000000 0x100000>;
+			brcm,int-fwd-mask = <0x0>;
+			brcm,irq-can-wake;
+		};
+
 		hif_intr2_intc: interrupt-controller at 3e1000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x3e1000 0x30>;
@@ -119,6 +133,16 @@
 			interrupt-names = "hif";
 		};
 
+                aon_pm_l2_intc: interrupt-controller at 410640 {
+			compatible = "brcm,l2-intc";
+			reg = <0x410640 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 0x40 0x0>;
+			interrupt-parent = <&gic>;
+			brcm,irq-can-wake;
+		};
+
 		nand: nand at 3e2800 {
 			status = "disabled";
 			#address-cells = <1>;
@@ -167,6 +191,32 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		upg_gio: gpio at 40a700 {
+			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+			reg = <0x40a700 0x80>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 24>;
+		};
+
+		upg_gio_aon: gpio at 4172c0 {
+			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+			reg = <0x4172c0 0x40>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupts-extended = <&irq0_aon_intc 0x6>,
+					      <&aon_pm_l2_intc 0x5>;
+			wakeup-source;
+			brcm,gpio-bank-widths = <18 4>;
+		};
+
 	};
 
 	smpboot {
-- 
1.9.1
