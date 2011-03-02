From: nm@ti.com (Nishanth Menon)
Date: Wed,  2 Mar 2011 16:25:25 +0530
Subject: [PATCH v2 12/18] omap3+: sr: enable/disable SR only on need
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Message-ID: <1299063331-27968-13-git-send-email-nm@ti.com>
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
index 8cad92d..4fc679e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -819,10 +819,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return -EINVAL;
 	}
 
-	if (!val)
-		sr_stop_vddautocomp(sr_info);
-	else
-		sr_start_vddautocomp(sr_info);
+	/* control enable/disable only if there is a delta in value */
+	if (sr_info->autocomp_active ^ val) {
+		if (!val)
+			sr_stop_vddautocomp(sr_info);
+		else
+			sr_start_vddautocomp(sr_info);
+	}
 
 	return 0;
 }
-- 
1.7.1
