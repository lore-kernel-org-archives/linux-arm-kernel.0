From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 17 Jul 2012 10:36:00 +0300
Subject: [PATCH for 3.6] ARM: mxs: fix the changed OF interface in MAC update
 function
Message-ID: <1342510560-24584-1-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 475d009429 "of: Improve prom_update_property() function" changes
the usage of prom_update_property function. Fix compiler error and start
to use the new improved interface.

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---

Linux-next is broken becase of prom_update_property interface change.

 arch/arm/mach-mxs/mach-mxs.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 648bdd0..8dabfe8 100644
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
+		prom_update_property(np, newmac);
 	}
 }
 
-- 
1.7.9.5
