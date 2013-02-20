From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 20:48:47 +0530
Subject: [PATCH 9/9] ARM: OMAP4: PM: Now remove L4 per clockdomain static
 depedency with MPU
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361373527-21695-10-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART driver slave idle issue has been taken care by driver using hwmod
framework.

So we can now ger rid off the L4 per clockdomain static dependency with
MPU which was used to wrok around UART wakeup and console sluggishnesh issue
on OMAP4 SOCs.

Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 1fd9662..1d03110 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -134,7 +134,7 @@ int __init omap4_pm_init(void)
 {
 	int ret;
 	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
-	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
+	struct clockdomain *ducati_clkdm, *l3_2_clkdm;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
@@ -159,16 +159,14 @@ int __init omap4_pm_init(void)
 	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
 	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
 	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
-	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
 	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
-		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
+		(!l3_2_clkdm) || (!ducati_clkdm))
 		goto err2;
 
 	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
-	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
-- 
1.7.9.5
