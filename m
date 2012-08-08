From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  8 Aug 2012 12:11:32 +0300
Subject: [PATCH 02/11] ARM: OMAP2+: McBSP: Do not create legacy devices when
 booting with DT data
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1344417101-5015-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only create the devices in a legacy way if we do not have the DT data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index ebc801e..57bd7ef 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -187,7 +188,8 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 
 static int __init omap2_mcbsp_init(void)
 {
-	omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
+	if (!of_have_populated_dt())
+		omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
 
 	return 0;
 }
-- 
1.7.8.6
