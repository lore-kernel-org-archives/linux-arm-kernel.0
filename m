From: tony@atomide.com (Tony Lindgren)
Date: Wed,  3 Jun 2015 09:23:12 -0700
Subject: [PATCH 03/12] ARM: OMAP2+: Add minimal clockdomains for dm814x
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Message-ID: <1433348601-8966-4-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, let's just add the ones shared with dm816x.
The dm814x specific ones can be added as they are tested.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomain.h           |  3 ++-
 arch/arm/mach-omap2/clockdomains81xx_data.c | 23 ++++++++++++++++++++---
 arch/arm/mach-omap2/io.c                    |  4 ++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 77bab5f..2c398ce 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -216,7 +216,8 @@ extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
 extern void __init am33xx_clockdomains_init(void);
-extern void __init ti81xx_clockdomains_init(void);
+extern void __init ti814x_clockdomains_init(void);
+extern void __init ti816x_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 extern void __init omap54xx_clockdomains_init(void);
 extern void __init dra7xx_clockdomains_init(void);
diff --git a/arch/arm/mach-omap2/clockdomains81xx_data.c b/arch/arm/mach-omap2/clockdomains81xx_data.c
index ce2a820..53442c8 100644
--- a/arch/arm/mach-omap2/clockdomains81xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains81xx_data.c
@@ -165,7 +165,24 @@ static struct clockdomain default_l3_slow_816x_clkdm = {
 	.flags		= CLKDM_CAN_SWSUP,
 };
 
-static struct clockdomain *clockdomains_ti81xx[] __initdata = {
+static struct clockdomain *clockdomains_ti814x[] __initdata = {
+	&alwon_l3_slow_81xx_clkdm,
+	&alwon_l3_med_81xx_clkdm,
+	&alwon_l3_fast_81xx_clkdm,
+	&alwon_ethernet_81xx_clkdm,
+	&mmu_81xx_clkdm,
+	&mmu_cfg_81xx_clkdm,
+	NULL,
+};
+
+void __init ti814x_clockdomains_init(void)
+{
+	clkdm_register_platform_funcs(&am33xx_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_ti814x);
+	clkdm_complete_init();
+}
+
+static struct clockdomain *clockdomains_ti816x[] __initdata = {
 	&alwon_mpu_816x_clkdm,
 	&alwon_l3_slow_81xx_clkdm,
 	&alwon_l3_med_81xx_clkdm,
@@ -185,10 +202,10 @@ static struct clockdomain *clockdomains_ti81xx[] __initdata = {
 	NULL,
 };
 
-void __init ti81xx_clockdomains_init(void)
+void __init ti816x_clockdomains_init(void)
 {
 	clkdm_register_platform_funcs(&am33xx_clkdm_operations);
-	clkdm_register_clkdms(clockdomains_ti81xx);
+	clkdm_register_clkdms(clockdomains_ti816x);
 	clkdm_complete_init();
 }
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 820dde8..6779a9f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -554,7 +554,7 @@ void __init ti814x_init_early(void)
 	omap2_prcm_base_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
-	ti81xx_clockdomains_init();
+	ti814x_clockdomains_init();
 	ti81xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
@@ -571,7 +571,7 @@ void __init ti816x_init_early(void)
 	omap2_prcm_base_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
-	ti81xx_clockdomains_init();
+	ti816x_clockdomains_init();
 	ti81xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
-- 
2.1.4
