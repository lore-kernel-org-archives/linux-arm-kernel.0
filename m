From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Aug 2014 15:50:12 +0200
Subject: [PATCH 06/11] ARM: shmobile: r8a7740: Add A3SG pm domain support
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1409320217-13278-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A3SG power domain, and hook it up as a subdomain of
A4S.
This domain contains the SGX540 hardware block, which is currently not
used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7740.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 93a89329d927..84b94d1d96db 100644
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
1.7.9.5
