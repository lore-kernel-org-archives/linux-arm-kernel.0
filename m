From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu,  9 Dec 2010 18:39:21 +0200
Subject: [PATCH 5/8] arm: omap: sdram-nokia: improve error handling
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1291912764-12823-6-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually check for errors: print an error log and return NULL.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 1171451..863586b 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -223,10 +223,14 @@ struct omap_sdrc_params *nokia_get_sdram_timings(void)
 	int err = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(nokia_timings); i++)
+	for (i = 0; i < ARRAY_SIZE(nokia_timings); i++) {
 		err |= sdrc_timings(i, nokia_timings[i].rate,
 				       nokia_timings[i].data);
+		if (err)
+			pr_err("%s: error with rate %ld: %d\n", __func__,
+			       nokia_timings[i].rate, err);
+	}
 
-	return &nokia_sdrc_params[0];
+	return err ? NULL : nokia_sdrc_params;
 }
 
-- 
1.5.6.5
