From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Fri, 24 Jun 2011 20:17:38 -0500
Subject: [RFC PATCH 2/7] OMAP2+: devices: get the number of supported mailboxes
In-Reply-To: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
References: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1308964663-5669-3-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use hwmod data attributes to get the defined number of mailboxes on
our current chip, and pass it through platform data.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/devices.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5b8ca68..e1110f2 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -25,6 +25,7 @@
 
 #include <plat/tc.h>
 #include <plat/board.h>
+#include <plat/mailbox.h>
 #include <plat/mcbsp.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
@@ -274,6 +275,8 @@ static inline void omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
 	struct omap_device *od;
+	struct omap_mailbox_dev_attr *mb_attr;
+	struct omap_mailbox_platform_data pdata;
 
 	oh = omap_hwmod_lookup("mailbox");
 	if (!oh) {
@@ -281,7 +284,10 @@ static inline void omap_init_mbox(void)
 		return;
 	}
 
-	od = omap_device_build("omap-mailbox", -1, oh, NULL, 0,
+	mb_attr = oh->dev_attr;
+	pdata.nr_mbox = mb_attr->nr_mbox;
+
+	od = omap_device_build("omap-mailbox", -1, oh, &pdata, sizeof(pdata),
 				mbox_latencies, ARRAY_SIZE(mbox_latencies), 0);
 	WARN(IS_ERR(od), "%s: could not build device, err %ld\n",
 						__func__, PTR_ERR(od));
-- 
1.7.0.4
