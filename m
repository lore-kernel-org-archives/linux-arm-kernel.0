From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Sep 2012 11:36:18 +0200
Subject: [PATCH] ARM: dts: cfa10049: Add FEC to the CFA-10049 expansion board
Message-ID: <1348824978-25340-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   11 +++++++++++
 arch/arm/mach-mxs/mach-mxs.c         |   14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index d91d16c..97ee098 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -102,4 +102,15 @@
 			gpio = <&gpio0 7 1>;
 		};
 	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-duration = <100>;
+			status = "okay";
+		};
+	};
 };
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8dabfe8..65b8fbb 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -157,6 +157,7 @@ static struct sys_timer imx28_timer = {
 enum mac_oui {
 	OUI_FSL,
 	OUI_DENX,
+	OUI_CRYSTALFONTZ,
 };
 
 static void __init update_fec_mac_prop(enum mac_oui oui)
@@ -202,6 +203,11 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 			macaddr[1] = 0xe5;
 			macaddr[2] = 0x4e;
 			break;
+		case OUI_CRYSTALFONTZ:
+			macaddr[0] = 0x58;
+			macaddr[1] = 0xb9;
+			macaddr[2] = 0xe1;
+			break;
 		}
 		val = ocotp[i];
 		macaddr[3] = (val >> 16) & 0xff;
@@ -270,6 +276,12 @@ static void __init apx4devkit_init(void)
 	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
 }
 
+static void __init cfa10049_init(void)
+{
+	enable_clk_enet_out();
+	update_fec_mac_prop(OUI_CRYSTALFONTZ);
+}
+
 static void __init mxs_machine_init(void)
 {
 	if (of_machine_is_compatible("fsl,imx28-evk"))
@@ -280,6 +292,8 @@ static void __init mxs_machine_init(void)
 		m28evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
 		apx4devkit_init();
+	else if (of_machine_is_compatible("crystalfontz,cfa10049"))
+		cfa10049_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mxs_auxdata_lookup, NULL);
-- 
1.7.9.5
