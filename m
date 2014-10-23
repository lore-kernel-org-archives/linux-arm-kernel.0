From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 23 Oct 2014 13:18:56 +0200
Subject: [PATCH v3 06/11] ARM: shmobile: r8a7740: Add A3SG pm domain support
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1414063141-8856-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A3SG power domain, and hook it up as a subdomain of
A4S.
This domain contains the SGX540 hardware block, which is currently not
used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - No changes.
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 1d916038660d4b8a..932c2a621e81ac26 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -51,6 +51,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a3sp_suspend,
+	}, {
+		.genpd.name	= "A3SG",
+		.bit_shift	= 13,
 	},
 };
 
@@ -58,6 +61,7 @@ void __init r8a7740_init_pm_domains(void)
 {
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
+	pm_genpd_add_subdomain_names("A4S", "A3SG");
 }
 #endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
 
-- 
1.9.1
