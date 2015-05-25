From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:09 +0200
Subject: [PATCH 05/21] ARM i.MX6q: Register drivers before devices
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So devices can be probed on demand, we need to have the drivers already
registered as we don't have enough information to register a driver on
demand.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/mach-imx/mach-imx6q.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 3ab6154..88de92c 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -262,21 +262,19 @@ static void __init imx6q_axi_init(void)
 	}
 }
 
+static struct device *soc_dev;
+
 static void __init imx6q_init_machine(void)
 {
-	struct device *parent;
-
 	imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 			      imx_get_soc_revision());
 
-	parent = imx_soc_device_init();
-	if (parent == NULL)
+	soc_dev = imx_soc_device_init();
+	if (soc_dev == NULL)
 		pr_warn("failed to initialize soc device\n");
 
 	imx6q_enet_phy_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
-
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
 	imx6q_1588_init();
@@ -367,6 +365,8 @@ static struct platform_device imx6q_cpufreq_pdev = {
 
 static void __init imx6q_init_late(void)
 {
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+
 	/*
 	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
 	 * to run cpuidle on them.
-- 
2.4.1
