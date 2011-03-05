From: nm@ti.com (Nishanth Menon)
Date: Sat,  5 Mar 2011 20:59:13 +0530
Subject: [PATCH V3 10/19] OMAP3+: SR: enable/disable SR only on need
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Message-ID: <1299338962-5602-11-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we already know the state of the autocomp enablement, we can
see if the requested state is different from the current state and
enable/disable SR only on the need basis.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f9057ad..2b6fdc7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -806,10 +806,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return -EINVAL;
 	}
 
-	if (!val)
-		sr_stop_vddautocomp(sr_info);
-	else
-		sr_start_vddautocomp(sr_info);
+	/* control enable/disable only if there is a delta in value */
+	if (sr_info->autocomp_active != val) {
+		if (!val)
+			sr_stop_vddautocomp(sr_info);
+		else
+			sr_start_vddautocomp(sr_info);
+	}
 
 	return 0;
 }
-- 
1.7.1
