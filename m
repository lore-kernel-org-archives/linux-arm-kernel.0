From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Jul 2012 04:28:58 -0300
Subject: [PATCH] ARM: mxs: Adjust of_find_property()
Message-ID: <1343028538-13891-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 475d00 (of: Improve prom_update_property() function) prom_update_property requires
two arguments.

Fix this in order to get rid of the following build error:

arch/arm/mach-mxs/mach-mxs.c:175:4: error: too many arguments to function 'prom_update_property'

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mach-mxs.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 648bdd0..b70011d 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -162,7 +162,7 @@ enum mac_oui {
 static void __init update_fec_mac_prop(enum mac_oui oui)
 {
 	struct device_node *np, *from = NULL;
-	struct property *oldmac, *newmac;
+	struct property *newmac;
 	const u32 *ocotp = mxs_get_ocotp();
 	u8 *macaddr;
 	u32 val;
@@ -208,11 +208,7 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 		macaddr[4] = (val >> 8) & 0xff;
 		macaddr[5] = (val >> 0) & 0xff;
 
-		oldmac = of_find_property(np, newmac->name, NULL);
-		if (oldmac)
-			prom_update_property(np, newmac, oldmac);
-		else
-			prom_add_property(np, newmac);
+		prom_add_property(np, newmac);
 	}
 }
 
-- 
1.7.1
