From: peter@turczak.de (Peter Turczak)
Date: Mon, 17 Dec 2012 15:26:02 +0100
Subject: [PATCH/RFC] mxs: mach-mxs: Setup mac address prefix from dt
Message-ID: <C97C836E-18D1-41C5-8DC3-E82BC2019018@turczak.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables setting the the fec ethernet mac address either completely
from dt, take only the prefix from dt and use the remaining device unique bytes 
from the OTP or use OTP uniq bytes and the hardcoded values as before when no
mac address is specified in the dt. So compatibility should be maintained to
devices already shipped.

Currently only Denx or Freescale manufacturer prefixes are guessed from the
selected hardware platform. The suggested patch provides a more elegant
solution because other vendors to just need to adapt their device tree 
description file.

Example:
mac0: ethernet at 800f0000 {
             phy-mode = "rmii";
             pinctrl-names = "default";
             pinctrl-0 = <&mac0_pins_a>;
             phy-supply = <&reg_fec_3v3>;
             phy-reset-gpios = <&gpio2 5 3>;
             phy-reset-duration = <100>;
             local-mac-address = [00 04 1E 5E 1B B9];
             status = "okay";
         };
or
mac0: ethernet at 800f0000 {
             phy-mode = "rmii";
             pinctrl-names = "default";
             pinctrl-0 = <&mac0_pins_a>;
             phy-supply = <&reg_fec_3v3>;
             phy-reset-gpios = <&gpio2 5 3>;
             phy-reset-duration = <100>;
             local-mac-address = [00 04 1E];
             status = "okay";
         };

Signed-off-by: Peter Turczak <peter@turczak.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |   83 +++++++++++++++++++++++++-----------------
 1 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 4748ec5..d7b349a 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -164,54 +164,69 @@ enum mac_oui {
 
 static void __init update_fec_mac_prop(enum mac_oui oui)
 {
-	struct device_node *np, *from = NULL;
-	struct property *newmac;
+	struct device_node *from = NULL;
 	const u32 *ocotp = mxs_get_ocotp();
 	u8 *macaddr;
+	const u8 *maddr = NULL;
+	int len = 0;
 	u32 val;
-	int i;
-
-	for (i = 0; i < 2; i++) {
-		np = of_find_compatible_node(from, NULL, "fsl,imx28-fec");
-		if (!np)
-			return;
-		from = np;
-
-		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
-		if (!newmac)
-			return;
-		newmac->value = newmac + 1;
-		newmac->length = 6;
-
-		newmac->name = kstrdup("local-mac-address", GFP_KERNEL);
-		if (!newmac->name) {
-			kfree(newmac);
+	int i = 0;
+	int tt = 0;
+
+	for_each_compatible_node(from, NULL, "fsl,imx28-fec") {
+		macaddr = kzalloc(6, GFP_KERNEL);
+		if (!macaddr) {
+			pr_err("%s: failed to allocate mem for macaddr\n",
+				__func__);
 			return;
 		}
 
+		/*retrieve MAC from DT*/
+		maddr = of_get_property(from, "local-mac-address", &len);
+		val = ocotp[i];
+		i++;
+
+		if (maddr && (len == 6)) {
+			/*6 bytes MAC defined*/
+			for (tt = 0; tt < 6; tt++)
+				macaddr[tt] = maddr[tt];
+
+			/*overwrite with DT MAC*/
+			val = (macaddr[3] << 16) | (macaddr[4] << 8) |
+			      (macaddr[5] << 0);
+
+			pr_debug("MACH-MXS: %i MAC taken from DT\n", i);
+		} else if (maddr && (len == 3)) {
+			/*only vendor OUI defined in DT*/
+			macaddr[0] = maddr[0];
+			macaddr[1] = maddr[1];
+			macaddr[2] = maddr[2];
+
+			pr_debug("MACH-MXS: %i MAC OUI taken from DT\n", i);
+		} else {
 		/*
 		 * OCOTP only stores the last 4 octets for each mac address,
 		 * so hard-code OUI here.
 		 */
-		macaddr = newmac->value;
-		switch (oui) {
-		case OUI_FSL:
-			macaddr[0] = 0x00;
-			macaddr[1] = 0x04;
-			macaddr[2] = 0x9f;
-			break;
-		case OUI_DENX:
-			macaddr[0] = 0xc0;
-			macaddr[1] = 0xe5;
-			macaddr[2] = 0x4e;
-			break;
+			switch (oui) {
+			case OUI_FSL:
+				macaddr[0] = 0x00;
+				macaddr[1] = 0x04;
+				macaddr[2] = 0x9f;
+				break;
+			case OUI_DENX:
+				macaddr[0] = 0xc0;
+				macaddr[1] = 0xe5;
+				macaddr[2] = 0x4e;
+				break;
+			}
+
+			pr_debug("MACH-MXS: %i hard-coded MAC taken\n", i);
 		}
-		val = ocotp[i];
+
 		macaddr[3] = (val >> 16) & 0xff;
 		macaddr[4] = (val >> 8) & 0xff;
 		macaddr[5] = (val >> 0) & 0xff;
-
-		prom_update_property(np, newmac);
 	}
 }
 
-- 
1.7.0.4
