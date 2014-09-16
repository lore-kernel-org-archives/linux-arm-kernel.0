From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 16 Sep 2014 20:48:54 +0200
Subject: [PATCH/RFC v2 07/12] ARM: shmobile: R-Mobile: Use
 generic_pm_domain.attach_dev() for pm_clk setup
In-Reply-To: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
References: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1410893339-6361-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the just introduced genpd attach/detach callbacks to register the
devices' module clocks, instead of doing it directly, to make it
DT-proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New
---
 arch/arm/mach-shmobile/pm-rmobile.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 717e6413d29cb998..4c8e47179fdd333b 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -101,6 +101,22 @@ static bool rmobile_pd_active_wakeup(struct device *dev)
 	return true;
 }
 
+static int rmobile_pd_attach_dev(struct generic_pm_domain *genpd,
+				 struct device *dev)
+{
+	if (pm_clk_no_clocks(dev))
+		pm_clk_add(dev, NULL);
+
+	return 0;
+}
+
+static int rmobile_pd_detach_dev(struct generic_pm_domain *genpd,
+				 struct device *dev)
+{
+	pm_clk_remove(dev, NULL);
+	return 0;
+}
+
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
@@ -112,6 +128,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
+	genpd->attach_dev		= rmobile_pd_attach_dev;
+	genpd->detach_dev		= rmobile_pd_detach_dev;
 	__rmobile_pd_power_up(rmobile_pd, false);
 }
 
@@ -130,8 +148,6 @@ void rmobile_add_device_to_domain_td(const char *domain_name,
 	struct device *dev = &pdev->dev;
 
 	__pm_genpd_name_add_device(domain_name, dev, td);
-	if (pm_clk_no_clocks(dev))
-		pm_clk_add(dev, NULL);
 }
 
 void rmobile_add_devices_to_domains(struct pm_domain_device data[],
-- 
1.9.1
