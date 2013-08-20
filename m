From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 20 Aug 2013 13:02:45 +0530
Subject: [PATCH 2/3] ARM: OMAP2+: Add new bindings for OMAP
In-Reply-To: <1376983966-16490-1-git-send-email-rnayak@ti.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com>
Message-ID: <1376983966-16490-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP we have co-processor IPs, memory controllers,
GPIOs which control regulators and power switches to
PMIC, and SoC internal Bus IPs, some or most of which
should either not be reset or idled or both. Have a
way to pass this information from DT.
(In some cases there are erratas which prevent an IPs
from being reset)

Also update omap_hwmod to extract this from DT.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 ++-
 arch/arm/mach-omap2/omap_hwmod.c                   |   22 +++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 6d498c7..a08647e 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -21,7 +21,8 @@ Required properties:
 Optional properties:
 - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
   during suspend.
-
+- ti,no-reset: When present, the module should not be reset
+- ti,no-idle: When present, the module should not be idled
 
 Example:
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7f4db12..4c66a5e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2361,11 +2361,11 @@ static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
  * are part of the device's address space can be ioremapped properly.
  * No return value.
  */
-static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
+static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
+				     struct device_node *np)
 {
 	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start = NULL;
-	struct device_node *np;
 
 	if (!oh)
 		return;
@@ -2381,12 +2381,10 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 			 oh->name);
 
 		/* Extract the IO space from device tree blob */
-		if (!of_have_populated_dt())
+		if (!np)
 			return;
 
-		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
-		if (np)
-			va_start = of_iomap(np, oh->mpu_rt_idx);
+		va_start = of_iomap(np, oh->mpu_rt_idx);
 	} else {
 		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	}
@@ -2418,12 +2416,16 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 static int __init _init(struct omap_hwmod *oh, void *data)
 {
 	int r;
+	struct device_node *np = NULL;
 
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
+	if (of_have_populated_dt())
+		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
+
 	if (oh->class->sysc)
-		_init_mpu_rt_base(oh, NULL);
+		_init_mpu_rt_base(oh, NULL, np);
 
 	r = _init_clocks(oh, NULL);
 	if (r < 0) {
@@ -2431,6 +2433,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		return -EINVAL;
 	}
 
+	if (np)
+		if (of_find_property(np, "ti,no-reset", NULL))
+			oh->flags |= HWMOD_INIT_NO_RESET;
+		if (of_find_property(np, "ti,no-idle", NULL))
+			oh->flags |= HWMOD_INIT_NO_IDLE;
+
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
 	return 0;
-- 
1.7.9.5
