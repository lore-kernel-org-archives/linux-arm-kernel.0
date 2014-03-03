From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon,  3 Mar 2014 17:02:10 +0100
Subject: [PATCH v2 05/11] ARM: s3c64xx: pm: Add always_on field to
 s3c64xx_pm_domain struct
In-Reply-To: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1393862536-9842-6-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds always_on field to s3c64xx_pm_domain struct to allow
handling registration of all domains in the same way, without the need
to have separate arrays for normal and always on domains.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/pm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index df4b7b2..c930245 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -36,6 +36,7 @@
 #include "regs-syscon-power.h"
 
 struct s3c64xx_pm_domain {
+	bool always_on;
 	u32 ena;
 	u32 pwr_stat;
 	struct generic_pm_domain pd;
@@ -85,6 +86,7 @@ static int s3c64xx_pd_on(struct generic_pm_domain *domain)
 }
 
 static struct s3c64xx_pm_domain s3c64xx_pm_irom = {
+	.always_on = true,
 	.ena = S3C64XX_NORMALCFG_IROM_ON,
 	.pd = {
 		.name = "IROM",
@@ -162,11 +164,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_v = {
 	},
 };
 
-static struct s3c64xx_pm_domain *s3c64xx_always_on_pm_domains[] = {
-	&s3c64xx_pm_irom,
-};
-
 static struct s3c64xx_pm_domain *s3c64xx_pm_domains[] = {
+	&s3c64xx_pm_irom,
 	&s3c64xx_pm_etm,
 	&s3c64xx_pm_g,
 	&s3c64xx_pm_v,
@@ -312,12 +311,16 @@ int __init s3c64xx_pm_init(void)
 
 	s3c_pm_init();
 
-	for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
-		pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
-			      &pm_domain_always_on_gov, false);
 
-	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
-		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
+	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++) {
+		struct s3c64xx_pm_domain *pd = s3c64xx_pm_domains[i];
+		struct dev_power_governor *gov = NULL;
+
+		if (pd->always_on)
+			gov = &pm_domain_always_on_gov;
+
+		pm_genpd_init(&pd->pd, gov, false);
+	}
 
 #ifdef CONFIG_S3C_DEV_FB
 	if (dev_get_platdata(&s3c_device_fb.dev))
-- 
1.9.0
