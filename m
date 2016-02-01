From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 11:38:43 +0100
Subject: [PATCH] PM / Domains: mark genpd_poweron as __maybe_unused
Message-ID: <3864075.BdhPDUQ9fB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rework of the power domain code has made the genpd_poweron()
function local to the file it's defined in, and the only remaining
caller is conditionally compiled based on CONFIG_PM_GENERIC_DOMAINS_OF,
so we get a warning when that is disabled:

drivers/base/power/domain.c:234:12: error: 'genpd_poweron' defined but not used [-Werror=unused-function]

This adds a __maybe_unused annotation to the function so gcc can
figure out by itself that it should silently remove the definition
in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ea823c7cbffa ("PM / Domains: Remove pm_genpd_poweron() API")

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 784dbe897a5e..a14b2f1ae085 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -231,7 +231,7 @@ static int __genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
  * genpd_poweron - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  */
-static int genpd_poweron(struct generic_pm_domain *genpd)
+static int __maybe_unused genpd_poweron(struct generic_pm_domain *genpd)
 {
 	int ret;
 
