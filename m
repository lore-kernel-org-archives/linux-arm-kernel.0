From: julien.boibessot@free.fr (julien.boibessot at free.fr)
Date: Sat, 13 Oct 2012 19:25:43 +0200
Subject: [PATCH] ARM: mxs: Add support for the Armadeus Systems APF28 module
Message-ID: <1350149143-9684-1-git-send-email-julien.boibessot@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Boibessot <julien.boibessot@armadeus.com>

Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28.dts |   79 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c      |    7 +++
 2 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-apf28.dts

diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
new file mode 100644
index 0000000..83e37c1
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -0,0 +1,79 @@
+/*
+ * Copyright 2012 Armadeus Systems - <support@armadeus.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx28.dtsi"
+
+/ {
+	model = "Armadeus Systems APF28 module";
+	compatible = "armadeus,imx28-apf28", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+				status = "okay";
+
+				partition at 0 {
+					label = "u-boot";
+					reg = <0x0 0x300000>;
+				};
+				partition at 1 {
+					label = "env";
+					reg = <0x300000 0x80000>;
+				};
+				partition at 2 {
+					label = "env2";
+					reg = <0x380000 0x80000>;
+				};
+				partition at 3 {
+					label = "dtb";
+					reg = <0x400000 0x80000>;
+				};
+				partition at 4 {
+					label = "splash";
+					reg = <0x480000 0x80000>;
+				};
+				partition at 5 {
+					label = "kernel";
+					reg = <0x500000 0x800000>;
+				};
+				partition at 6 {
+					label = "rootfs";
+					reg = <0xd00000 0xf300000>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			phy-reset-gpios = <&gpio4 13 0>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index caf11db..93bc53d 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -357,6 +357,11 @@ static void __init tx28_post_init(void)
 	pinctrl_put(pctl);
 }
 
+static void __init apf28_init(void)
+{
+	enable_clk_enet_out();
+}
+
 static void __init mxs_machine_init(void)
 {
 	if (of_machine_is_compatible("fsl,imx28-evk"))
@@ -367,6 +372,8 @@ static void __init mxs_machine_init(void)
 		m28evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
 		apx4devkit_init();
+	else if (of_machine_is_compatible("armadeus,imx28-apf28"))
+		apf28_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mxs_auxdata_lookup, NULL);
-- 
1.7.5.4
