From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu,  9 Dec 2010 18:39:20 +0200
Subject: [PATCH 4/8] arm: omap: sdram-nokia: use array to list timings
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1291912764-12823-5-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use an array to make it easier to add new values.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 97d1673..1171451 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -44,8 +44,6 @@ struct sdram_timings {
 	u32 tWTR;
 };
 
-static struct omap_sdrc_params nokia_sdrc_params[4];
-
 static const struct sdram_timings nokia_166mhz_timings[] = {
 	{
 		.casl = 3,
@@ -67,6 +65,16 @@ static const struct sdram_timings nokia_166mhz_timings[] = {
 	},
 };
 
+static const struct {
+	long rate;
+	struct sdram_timings const *data;
+} nokia_timings[] = {
+	{ 41500000, nokia_166mhz_timings },
+	{ 83000000, nokia_166mhz_timings },
+	{ 166000000, nokia_166mhz_timings },
+};
+static struct omap_sdrc_params nokia_sdrc_params[ARRAY_SIZE(nokia_timings) + 1];
+
 static unsigned long sdrc_get_fclk_period(long rate)
 {
 	/* In picoseconds */
@@ -212,11 +220,12 @@ static int sdrc_timings(int id, long rate,
 
 struct omap_sdrc_params *nokia_get_sdram_timings(void)
 {
-	int err;
+	int err = 0;
+	int i;
 
-	err = sdrc_timings(0, 41500000, nokia_166mhz_timings);
-	err |= sdrc_timings(1, 83000000, nokia_166mhz_timings);
-	err |= sdrc_timings(2, 166000000, nokia_166mhz_timings);
+	for (i = 0; i < ARRAY_SIZE(nokia_timings); i++)
+		err |= sdrc_timings(i, nokia_timings[i].rate,
+				       nokia_timings[i].data);
 
 	return &nokia_sdrc_params[0];
 }
-- 
1.5.6.5
