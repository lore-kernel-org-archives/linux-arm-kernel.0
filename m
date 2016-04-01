From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Fri,  1 Apr 2016 23:49:05 +0800
Subject: [PATCH v10 07/17] Xen: ARM: Add support for mapping AMBA device mmio
In-Reply-To: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1459525755-36968-8-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a bus_notifier for AMBA bus device in order to map the device
mmio regions when DOM0 booting with ACPI.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/arm-device.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/xen/arm-device.c b/drivers/xen/arm-device.c
index 76e26e5..3854043 100644
--- a/drivers/xen/arm-device.c
+++ b/drivers/xen/arm-device.c
@@ -139,3 +139,46 @@ static int __init register_xen_platform_notifier(void)
 }
 
 arch_initcall(register_xen_platform_notifier);
+
+#ifdef CONFIG_ARM_AMBA
+#include <linux/amba/bus.h>
+
+static int xen_amba_notifier(struct notifier_block *nb,
+			     unsigned long action, void *data)
+{
+	struct amba_device *adev = to_amba_device(data);
+	int r = 0;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		r = xen_map_device_mmio(&adev->res, 1);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		r = xen_unmap_device_mmio(&adev->res, 1);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+	if (r)
+		dev_err(&adev->dev, "AMBA: Failed to %s device %s MMIO!\n",
+			action == BUS_NOTIFY_ADD_DEVICE ? "map" :
+			(action == BUS_NOTIFY_DEL_DEVICE ? "unmap" : "?"),
+			adev->dev.init_name);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block amba_device_nb = {
+	.notifier_call = xen_amba_notifier,
+};
+
+static int __init register_xen_amba_notifier(void)
+{
+	if (!xen_initial_domain() || acpi_disabled)
+		return 0;
+
+	return bus_register_notifier(&amba_bustype, &amba_device_nb);
+}
+
+arch_initcall(register_xen_amba_notifier);
+#endif
-- 
2.1.4
