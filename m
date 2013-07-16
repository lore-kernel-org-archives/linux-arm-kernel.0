From: dsd@laptop.org (Daniel Drake)
Date: Tue, 16 Jul 2013 14:06:25 -0400 (EDT)
Subject: [PATCH RESEND 2/2] ARM: mmp: irq: Improve DT layout
Message-ID: <20130716180625.E0AF1FAAF3@dev.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the mmp2 device tree, the interrupt mux nodes were peers of the
interrupt controller, yet they mapped registers in conflict with the
interrupt controller's register block. Furthermore, the reg properties of
the muxes disagreed with the unit address specified after the node's @-sign.

Move the interrupt mux nodes underneath the interrupt controller node,
because the registers are subordinate to the interrupt controller device,
and update the documentation accordingly.

In the platform code, avoid using of_address_to_resource(). Treating a
reg value of 0x150 as a resource effectively is mapping to memory
location 0x150, which is not what's happening here. Use of_get_address()
instead, to better reflect that we're dealing with an address offset
being read from the device tree.

This adds support for the device tree shipped in the OLPC XO-4 and
additionally these code changes do not break compatibility with the
old DT layout.

Based on work by Mitch Bradley.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 .../devicetree/bindings/arm/mrvl/intc.txt          |  41 ++++---
 arch/arm/boot/dts/mmp2.dtsi                        | 128 ++++++++++-----------
 arch/arm/mach-mmp/irq.c                            |  16 +--
 3 files changed, 95 insertions(+), 90 deletions(-)

Resending after 1 month with no response.

diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
index 3554fb9..0c020ff 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
+++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
@@ -2,21 +2,24 @@
 
 Required properties:
 - compatible : One of: mrvl,mmp-intc mrvl,mmp2-intc mrvl,mmp3-intc
-  mrvl,mmp2-mux-intc
-- reg : Address and length of the register set of the interrupt controller.
-  If the interrupt controller is intc, address and length means the range
-  of the whold interrupt controller. If the interrupt controller is mux-intc,
-  address and length means one register. Since address of mux-intc is in the
-  range of intc. mux-intc is secondary interrupt controller.
-- reg-names : Name of the register set of the interrupt controller. It's
-  only required in mux-intc interrupt controller.
-- interrupts : Should be the port interrupt shared by mux interrupts. It's
-  only required in mux-intc interrupt controller.
+- reg : Address and length of the register set of the whole interrupt
+  controller.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.
 - mrvl,intc-nr-irqs : Specifies the number of interrupts in the interrupt
   controller.
+
+* Marvell MMP Secondary Interrupt controller (mux)
+
+Required properties:
+ - compatible : Shall be mrvl,mmp2-mux-intc
+  Address and length of one register offset into the register address space of
+  the parent interrupt controller node.
+- reg-names : Name of the register set of the interrupt controller.
+- interrupts : Should be the port interrupt shared by mux interrupts.
+- mrvl,intc-nr-irqs : Specifies the number of interrupts in the interrupt
+  controller.
 - mrvl,clr-mfp-irq : Specifies the interrupt that needs to clear MFP edge
   detection first.
 
@@ -27,16 +30,16 @@ Example:
 		#interrupt-cells = <1>;
 		reg = <0xd4282000 0x1000>;
 		mrvl,intc-nr-irqs = <64>;
-	};
 
-	intcmux4 at d4282150 {
-		compatible = "mrvl,mmp2-mux-intc";
-		interrupts = <4>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		reg = <0x150 0x4>, <0x168 0x4>;
-		reg-names = "mux status", "mux mask";
-		mrvl,intc-nr-irqs = <2>;
+		intcmux4 at 150 {
+			compatible = "mrvl,mmp2-mux-intc";
+			interrupts = <4>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x150 0x4>, <0x168 0x4>;
+			reg-names = "mux status", "mux mask";
+			mrvl,intc-nr-irqs = <2>;
+		};
 	};
 
 * Marvell Orion Interrupt controller
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 4e8b08c..1f63c8f 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -44,77 +44,77 @@
 				#interrupt-cells = <1>;
 				reg = <0xd4282000 0x1000>;
 				mrvl,intc-nr-irqs = <64>;
-			};
 
-			intcmux4: interrupt-controller at d4282150 {
-				compatible = "mrvl,mmp2-mux-intc";
-				interrupts = <4>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0x150 0x4>, <0x168 0x4>;
-				reg-names = "mux status", "mux mask";
-				mrvl,intc-nr-irqs = <2>;
-			};
+				intcmux4: interrupt-controller at 150 {
+					compatible = "mrvl,mmp2-mux-intc";
+					interrupts = <4>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reg = <0x150 0x4>, <0x168 0x4>;
+					reg-names = "mux status", "mux mask";
+					mrvl,intc-nr-irqs = <2>;
+				};
 
-			intcmux5: interrupt-controller at d4282154 {
-				compatible = "mrvl,mmp2-mux-intc";
-				interrupts = <5>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0x154 0x4>, <0x16c 0x4>;
-				reg-names = "mux status", "mux mask";
-				mrvl,intc-nr-irqs = <2>;
-				mrvl,clr-mfp-irq = <1>;
-			};
+				intcmux5: interrupt-controller at 154 {
+					compatible = "mrvl,mmp2-mux-intc";
+					interrupts = <5>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reg = <0x154 0x4>, <0x16c 0x4>;
+					reg-names = "mux status", "mux mask";
+					mrvl,intc-nr-irqs = <2>;
+					mrvl,clr-mfp-irq = <1>;
+				};
 
-			intcmux9: interrupt-controller at d4282180 {
-				compatible = "mrvl,mmp2-mux-intc";
-				interrupts = <9>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0x180 0x4>, <0x17c 0x4>;
-				reg-names = "mux status", "mux mask";
-				mrvl,intc-nr-irqs = <3>;
-			};
+				intcmux9: interrupt-controller at 180 {
+					compatible = "mrvl,mmp2-mux-intc";
+					interrupts = <9>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reg = <0x180 0x4>, <0x17c 0x4>;
+					reg-names = "mux status", "mux mask";
+					mrvl,intc-nr-irqs = <3>;
+				};
 
-			intcmux17: interrupt-controller at d4282158 {
-				compatible = "mrvl,mmp2-mux-intc";
-				interrupts = <17>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0x158 0x4>, <0x170 0x4>;
-				reg-names = "mux status", "mux mask";
-				mrvl,intc-nr-irqs = <5>;
-			};
+				intcmux17: interrupt-controller at 158 {
+					compatible = "mrvl,mmp2-mux-intc";
+					interrupts = <17>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reg = <0x158 0x4>, <0x170 0x4>;
+					reg-names = "mux status", "mux mask";
+					mrvl,intc-nr-irqs = <5>;
+				};
 
-			intcmux35: interrupt-controller at d428215c {
-				compatible = "mrvl,mmp2-mux-intc";
-				interrupts = <35>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0x15c 0x4>, <0x174 0x4>;
-				reg-names = "mux status", "mux mask";
-				mrvl,intc-nr-irqs = <15>;
-			};
+				intcmux35: interrupt-controller at 15c {
+					compatible = "mrvl,mmp2-mux-intc";
+					interrupts = <35>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reg = <0x15c 0x4>, <0x174 0x4>;
+					reg-names = "mux status", "mux mask";
+					mrvl,intc-nr-irqs = <15>;
+				};
 
-			intcmux51: interrupt-controller at d4282160 {
-				compatible = "mrvl,mmp2-mux-intc";
-				interrupts = <51>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0x160 0x4>, <0x178 0x4>;
-				reg-names = "mux status", "mux mask";
-				mrvl,intc-nr-irqs = <2>;
-			};
+				intcmux51: interrupt-controller at 160 {
+					compatible = "mrvl,mmp2-mux-intc";
+					interrupts = <51>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reg = <0x160 0x4>, <0x178 0x4>;
+					reg-names = "mux status", "mux mask";
+					mrvl,intc-nr-irqs = <2>;
+				};
 
-			intcmux55: interrupt-controller at d4282188 {
-				compatible = "mrvl,mmp2-mux-intc";
-				interrupts = <55>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				reg = <0x188 0x4>, <0x184 0x4>;
-				reg-names = "mux status", "mux mask";
-				mrvl,intc-nr-irqs = <2>;
+				intcmux55: interrupt-controller at 188 {
+					compatible = "mrvl,mmp2-mux-intc";
+					interrupts = <55>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reg = <0x188 0x4>, <0x184 0x4>;
+					reg-names = "mux status", "mux mask";
+					mrvl,intc-nr-irqs = <2>;
+				};
 			};
 		};
 
diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
index d60b85a..ac92433 100644
--- a/arch/arm/mach-mmp/irq.c
+++ b/arch/arm/mach-mmp/irq.c
@@ -342,7 +342,9 @@ int __init mmp2_mux_init(struct device_node *parent)
 {
 	struct device_node *node;
 	const struct of_device_id *of_id;
-	struct resource res;
+	const __be32    *addrp;
+	u64		size;
+	unsigned int	flags;
 	int i, irq_base, ret, irq;
 	u32 nr_irqs, mfp_irq;
 
@@ -360,20 +362,20 @@ int __init mmp2_mux_init(struct device_node *parent)
 			ret = -EINVAL;
 			goto err;
 		}
-		ret = of_address_to_resource(node, 0, &res);
-		if (ret < 0) {
+		addrp = of_get_address(node, 0, &size, &flags);
+		if (addrp == NULL) {
 			pr_err("Not found reg property\n");
 			ret = -EINVAL;
 			goto err;
 		}
-		icu_data[i].reg_status = mmp_icu_base + res.start;
-		ret = of_address_to_resource(node, 1, &res);
-		if (ret < 0) {
+		icu_data[i].reg_status = mmp_icu_base + of_read_ulong(addrp, 1);
+		addrp = of_get_address(node, 1, &size, &flags);
+		if (addrp == NULL) {
 			pr_err("Not found reg property\n");
 			ret = -EINVAL;
 			goto err;
 		}
-		icu_data[i].reg_mask = mmp_icu_base + res.start;
+		icu_data[i].reg_mask = mmp_icu_base + of_read_ulong(addrp, 1);
 		icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
 		if (!icu_data[i].cascade_irq) {
 			ret = -EINVAL;
-- 
1.8.1.4
