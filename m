From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Feb 2018 09:20:36 -0800
Subject: [PATCH] bus: ti-sysc: Fix checking of no-reset-on-init quirk
Message-ID: <20180215172036.31938-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are currently only checking for the first entry in the table while
we should check them all. Usual no-idle-on-init is together with
no-reset-on-init, so this has gone unnoticed.

Fixes: 566a9b05e1fa ("bus: ti-sysc: Handle module quirks based dts
configuration")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -630,7 +630,7 @@ static int sysc_init_dts_quirks(struct sysc *ddata)
 	for (i = 0; i < ARRAY_SIZE(sysc_dts_quirks); i++) {
 		prop = of_get_property(np, sysc_dts_quirks[i].name, &len);
 		if (!prop)
-			break;
+			continue;
 
 		ddata->cfg.quirks |= sysc_dts_quirks[i].mask;
 	}
-- 
2.16.1
