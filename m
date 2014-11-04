From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:59 +0900
Subject: [PATCH 11/11] ARM: shmobile: r8a7740: Add A3SM pm domain support
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <dc4470e177973feedd82596969d86468a1695b1e.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A3SM power domain, and hook it up as a subdomain of
A4S.

This domain contains the System CPU (Cortex-A9) hardware block. Hence
move the special CPU handling from A4S to A3SM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 27117a8..ac2eecd 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -14,10 +14,10 @@
 #include "pm-rmobile.h"
 
 #if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
-static int r8a7740_pd_a4s_suspend(void)
+static int r8a7740_pd_a3sm_suspend(void)
 {
 	/*
-	 * The A4S domain contains the CPU core and therefore it should
+	 * The A3SM domain contains the CPU core and therefore it should
 	 * only be turned off if the CPU is not in use.
 	 */
 	return -EBUSY;
@@ -63,9 +63,7 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	}, {
 		.genpd.name	= "A4S",
 		.bit_shift	= 10,
-		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
-		.suspend	= r8a7740_pd_a4s_suspend,
 	}, {
 		.genpd.name	= "A3SP",
 		.bit_shift	= 11,
@@ -73,6 +71,11 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a3sp_suspend,
 	}, {
+		.genpd.name	= "A3SM",
+		.bit_shift	= 12,
+		.gov		= &pm_domain_always_on_gov,
+		.suspend	= r8a7740_pd_a3sm_suspend,
+	}, {
 		.genpd.name	= "A3SG",
 		.bit_shift	= 13,
 	}, {
@@ -86,6 +89,7 @@ void __init r8a7740_init_pm_domains(void)
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4R", "A3RV");
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
+	pm_genpd_add_subdomain_names("A4S", "A3SM");
 	pm_genpd_add_subdomain_names("A4S", "A3SG");
 }
 #endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
-- 
2.1.1
