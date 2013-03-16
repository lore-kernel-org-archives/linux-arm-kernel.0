From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Sat, 16 Mar 2013 11:46:48 +0530
Subject: [PATCH V2 8/8] memory: emif: Load the correct custom config values
 from dt
In-Reply-To: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
References: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1363414608-7448-9-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_get_property returns value in Big Endian format.
Before using this value it should be converted to little endian
using be32_to_cpup().
Custom configs of emif are read from dt using of_get_property,
but these are not converted to litte endian format.
Correcting the same here.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Changes since V1: No changes

 drivers/memory/emif.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 9b27c2b..475174a 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1263,7 +1263,7 @@ static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
 {
 	struct emif_custom_configs	*cust_cfgs = NULL;
 	int				len;
-	const int			*lpmode, *poll_intvl;
+	const __be32			*lpmode, *poll_intvl;
 
 	lpmode = of_get_property(np_emif, "low-power-mode", &len);
 	poll_intvl = of_get_property(np_emif, "temp-alert-poll-interval", &len);
@@ -1277,7 +1277,7 @@ static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
 
 	if (lpmode) {
 		cust_cfgs->mask |= EMIF_CUSTOM_CONFIG_LPMODE;
-		cust_cfgs->lpmode = *lpmode;
+		cust_cfgs->lpmode = be32_to_cpup(lpmode);
 		of_property_read_u32(np_emif,
 				"low-power-mode-timeout-performance",
 				&cust_cfgs->lpmode_timeout_performance);
@@ -1292,7 +1292,8 @@ static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
 	if (poll_intvl) {
 		cust_cfgs->mask |=
 				EMIF_CUSTOM_CONFIG_TEMP_ALERT_POLL_INTERVAL;
-		cust_cfgs->temp_alert_poll_interval_ms = *poll_intvl;
+		cust_cfgs->temp_alert_poll_interval_ms =
+						be32_to_cpup(poll_intvl);
 	}
 
 	if (of_find_property(np_emif, "extended-temp-part", &len))
-- 
1.7.9.5
