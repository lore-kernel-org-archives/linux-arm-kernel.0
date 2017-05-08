From: ayaka@soulik.info (Randy Li)
Date: Tue,  9 May 2017 00:34:17 +0800
Subject: [PATCH] soc: rockchip: power-domain: export idle request
Message-ID: <20170508163417.15017-1-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to put the power status of HEVC/RKVDEC IP into IDLE
unless we can't reset that IP or the SoC would crash down.
rockchip_pmu_idle_request(dev, true)---> enter idle
rockchip_pmu_idle_request(dev, false)---> exit idle

Only the video codec drivers of rockchip platform would
request this patch currently.

I am not sure whether it is necessary to add a new function
at generic power domain. I want someone give me some advises
here.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/soc/rockchip/pm_domains.c | 24 ++++++++++++++++++++++++
 include/linux/rockchip_pmu.h      | 15 +++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/linux/rockchip_pmu.h

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 796c46a..c1bff1c 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <linux/rockchip_pmu.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
 #include <dt-bindings/power/rk3368-power.h>
@@ -179,6 +180,29 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 	return 0;
 }
 
+int rockchip_pmu_idle_request(struct device *dev, bool idle)
+{
+	struct generic_pm_domain *genpd;
+	struct rockchip_pm_domain *pd;
+	int ret;
+
+	if (IS_ERR_OR_NULL(dev))
+		return -EINVAL;
+
+	if (IS_ERR_OR_NULL(dev->pm_domain))
+		return -EINVAL;
+
+	genpd = pd_to_genpd(dev->pm_domain);
+	pd = to_rockchip_pd(genpd);
+
+	mutex_lock(&pd->pmu->mutex);
+	ret = rockchip_pmu_set_idle_request(pd, idle);
+	mutex_unlock(&pd->pmu->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(rockchip_pmu_idle_request);
+
 static int rockchip_pmu_save_qos(struct rockchip_pm_domain *pd)
 {
 	int i;
diff --git a/include/linux/rockchip_pmu.h b/include/linux/rockchip_pmu.h
new file mode 100644
index 0000000..720b331
--- /dev/null
+++ b/include/linux/rockchip_pmu.h
@@ -0,0 +1,15 @@
+/*
+ * pm_domain.h - Definitions and headers related to device power domains.
+ *
+ * Copyright (C) 2017 Randy Li <ayaka@soulik.info>.
+ *
+ * This file is released under the GPLv2.
+ */
+
+#ifndef _LINUX_ROCKCHIP_PM_H
+#define _LINUX_ROCKCHIP_PM_H
+#include <linux/device.h>
+
+int rockchip_pmu_idle_request(struct device *dev, bool idle);
+
+#endif /* _LINUX_ROCKCHIP_PM_H */
-- 
2.9.3
