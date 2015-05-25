From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:07 +0200
Subject: [PATCH 03/21] ARM: tegra: Register drivers before devices
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So devices can be probed on demand, we need to have the drivers already
registered as we don't have enough information to register a driver on
demand.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/mach-tegra/tegra.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 861d884..2874425 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -55,6 +55,8 @@
 #include "reset.h"
 #include "sleep.h"
 
+static struct soc_device *soc_dev;
+
 /*
  * Storage for debug-macro.S's state.
  *
@@ -87,12 +89,10 @@ static void __init tegra_dt_init_irq(void)
 static void __init tegra_dt_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
-	struct device *parent = NULL;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
-		goto out;
+		return;
 
 	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Tegra");
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d",
@@ -105,17 +105,7 @@ static void __init tegra_dt_init(void)
 		kfree(soc_dev_attr->revision);
 		kfree(soc_dev_attr->soc_id);
 		kfree(soc_dev_attr);
-		goto out;
 	}
-
-	parent = soc_device_to_device(soc_dev);
-
-	/*
-	 * Finished with the static registrations now; fill in the missing
-	 * devices
-	 */
-out:
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 }
 
 static void __init paz00_init(void)
@@ -133,8 +123,13 @@ static struct {
 
 static void __init tegra_dt_init_late(void)
 {
+	struct device *parent = NULL;
 	int i;
 
+	parent = soc_device_to_device(soc_dev);
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+
 	tegra_init_suspend();
 	tegra_cpuidle_init();
 
-- 
2.4.1
