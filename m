From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  5 Jun 2013 08:40:08 +0200
Subject: [PATCH 4/5] arm: mxs: use the newly introduced of_set_mac_address()
 helper
In-Reply-To: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1370414409-29991-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit refactors the existing mach-mxs code to use the newly
introduced of_set_mac_address() OF helper.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 5b62b64..5cdfa55 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -23,6 +23,7 @@
 #include <linux/irqchip/mxs.h>
 #include <linux/micrel_phy.h>
 #include <linux/of_address.h>
+#include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/pinctrl/consumer.h>
@@ -180,9 +181,8 @@ enum mac_oui {
 static void __init update_fec_mac_prop(enum mac_oui oui)
 {
 	struct device_node *np, *from = NULL;
-	struct property *newmac;
 	const u32 *ocotp = mxs_get_ocotp();
-	u8 *macaddr;
+	u8 macaddr[ETH_ALEN];
 	u32 val;
 	int i;
 
@@ -193,26 +193,10 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 
 		from = np;
 
-		if (of_get_property(np, "local-mac-address", NULL))
-			continue;
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
-			return;
-		}
-
 		/*
 		 * OCOTP only stores the last 4 octets for each mac address,
 		 * so hard-code OUI here.
 		 */
-		macaddr = newmac->value;
 		switch (oui) {
 		case OUI_FSL:
 			macaddr[0] = 0x00;
@@ -235,7 +219,7 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 		macaddr[4] = (val >> 8) & 0xff;
 		macaddr[5] = (val >> 0) & 0xff;
 
-		of_update_property(np, newmac);
+		of_set_mac_address(np, macaddr);
 	}
 }
 
-- 
1.8.1.2
