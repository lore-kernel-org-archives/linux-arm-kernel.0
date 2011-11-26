From: ming.lei@canonical.com (ming.lei at canonical.com)
Date: Sat, 26 Nov 2011 10:53:47 +0800
Subject: [PATCH v6 1/3] arm: omap4: create pmu device via hwmod
In-Reply-To: <1322276029-3701-1-git-send-email-ming.lei@canonical.com>
References: <1322276029-3701-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1322276029-3701-2-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <ming.lei@canonical.com>

The following modules is required to be enabled before configuring
cross trigger interface for enabling pmu irq:

        l3_instr, l3_main_3, debugss

so build the arm-pmu device via the three hwmods.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/devices.c |   61 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 0f8e0eb..6e16274 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -384,14 +384,67 @@ static struct platform_device omap_pmu_device = {
 	.num_resources	= 1,
 };
 
-static void omap_init_pmu(void)
+static struct arm_pmu_platdata omap4_pmu_data;
+static struct omap_device_pm_latency omap_pmu_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static struct platform_device* __init omap4_init_pmu(void)
 {
-	if (cpu_is_omap24xx())
+	int id = -1;
+	const char *hw;
+	struct platform_device *pd;
+	struct omap_hwmod* oh[3];
+	char *dev_name = "arm-pmu";
+
+	hw = "l3_main_3";
+	oh[0] = omap_hwmod_lookup(hw);
+	if (!oh[0]) {
+		pr_err("Could not look up %s hwmod\n", hw);
+		return NULL;
+	}
+	hw = "l3_instr";
+	oh[1] = omap_hwmod_lookup(hw);
+	if (!oh[1]) {
+		pr_err("Could not look up %s hwmod\n", hw);
+		return NULL;
+	}
+	hw = "debugss";
+	oh[2] = omap_hwmod_lookup(hw);
+	if (!oh[2]) {
+		pr_err("Could not look up %s hwmod\n", hw);
+		return NULL;
+	}
+
+	pd = omap_device_build_ss(dev_name, id, oh, 3, &omap4_pmu_data,
+				sizeof(omap4_pmu_data),
+				omap_pmu_latency,
+				ARRAY_SIZE(omap_pmu_latency), 0);
+	WARN(IS_ERR(pd), "Can't build omap_device for %s.\n",
+				dev_name);
+	return pd;
+}
+static void __init omap_init_pmu(void)
+{
+	if (cpu_is_omap24xx()) {
 		omap_pmu_device.resource = &omap2_pmu_resource;
-	else if (cpu_is_omap34xx())
+	} else if (cpu_is_omap34xx()) {
 		omap_pmu_device.resource = &omap3_pmu_resource;
-	else
+	} else if (cpu_is_omap44xx()) {
+		struct platform_device *pd;
+
+		pd = omap4_init_pmu();
+		if (!pd)
+			return;
+		omap_device_enable(pd);
+		return;
+	} else {
 		return;
+	}
 
 	platform_device_register(&omap_pmu_device);
 }
-- 
1.7.5.4
