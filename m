From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Aug 2014 18:03:04 +0100
Subject: [PATCH v3 1/6] usb: host: usb-st-common: Add common code required by
 ohci-st and ehci-st
In-Reply-To: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
References: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1407344589-24863-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch abstracts out some common code required by both the ehci-st
and ohci-st drivers.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/usb/host/usb-st-common.c | 99 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/usb-st-common.h | 34 ++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 drivers/usb/host/usb-st-common.c
 create mode 100644 drivers/usb/host/usb-st-common.h

diff --git a/drivers/usb/host/usb-st-common.c b/drivers/usb/host/usb-st-common.c
new file mode 100644
index 0000000..ddfdbf6
--- /dev/null
+++ b/drivers/usb/host/usb-st-common.c
@@ -0,0 +1,99 @@
+/*
+ * Common code shared between ehci-st.c and ohci-st.c
+ *
+ * Copyright (C) 2014 STMicroelectronics ? All Rights Reserved
+ *
+ * Author: Peter Griffin <peter.griffin@linaro.org>
+ *
+ * Derived from ohci-platform.c and ehci-platform.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/phy/phy.h>
+
+#include "usb-st-common.h"
+
+int st_usb_platform_power_on(struct st_platform_priv *priv)
+{
+	int clk, ret;
+
+	if (priv->pwr) {
+		ret = reset_control_deassert(priv->pwr);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->rst) {
+		ret = reset_control_deassert(priv->rst);
+		if (ret)
+			goto err_assert_power;
+	}
+
+	/* some SoCs don't have a dedicated 48Mhz clock, but those that do
+	   need the rate to be explicitly set */
+	if (priv->clk48) {
+		ret = clk_set_rate(priv->clk48, 48000000);
+		if (ret)
+			goto err_assert_reset;
+	}
+
+	for (clk = 0; clk < USB_MAX_CLKS && priv->clks[clk]; clk++) {
+		ret = clk_prepare_enable(priv->clks[clk]);
+		if (ret)
+			goto err_disable_clks;
+	}
+
+	if (priv->phy) {
+		ret = phy_init(priv->phy);
+		if (ret)
+			goto err_disable_clks;
+
+		ret = phy_power_on(priv->phy);
+		if (ret)
+			goto err_exit_phy;
+	}
+
+	return 0;
+
+err_exit_phy:
+	phy_exit(priv->phy);
+err_disable_clks:
+	while (--clk >= 0)
+		clk_disable_unprepare(priv->clks[clk]);
+err_assert_reset:
+	if (priv->rst)
+		ret = reset_control_assert(priv->rst);
+err_assert_power:
+	if (priv->pwr)
+		ret = reset_control_assert(priv->pwr);
+
+	return ret;
+}
+EXPORT_SYMBOL(st_usb_platform_power_on);
+
+void st_usb_platform_power_off(struct st_platform_priv *priv)
+{
+	int clk;
+
+	if (priv->pwr)
+		reset_control_assert(priv->pwr);
+
+	if (priv->rst)
+		reset_control_assert(priv->rst);
+
+	if (priv->phy) {
+		phy_power_off(priv->phy);
+		phy_exit(priv->phy);
+	}
+
+	for (clk = USB_MAX_CLKS - 1; clk >= 0; clk--)
+		if (priv->clks[clk])
+			clk_disable_unprepare(priv->clks[clk]);
+
+}
+EXPORT_SYMBOL(st_usb_platform_power_off);
diff --git a/drivers/usb/host/usb-st-common.h b/drivers/usb/host/usb-st-common.h
new file mode 100644
index 0000000..5ee7fb0
--- /dev/null
+++ b/drivers/usb/host/usb-st-common.h
@@ -0,0 +1,34 @@
+/*
+ * ST ehci / ohci common header file
+ *
+ * Copyright (C) 2014 STMicroelectronics ? All Rights Reserved
+ *
+ * Author: Peter Griffin <peter.griffin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __USB_ST_COMMON_H
+#define __USB_ST_COMMON_H
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/phy/phy.h>
+
+#define USB_MAX_CLKS 3
+
+struct st_platform_priv {
+	struct clk *clks[USB_MAX_CLKS];
+	struct clk *clk48;
+	struct reset_control *rst;
+	struct reset_control *pwr;
+	struct phy *phy;
+};
+
+int st_usb_platform_power_on(struct st_platform_priv *priv);
+void st_usb_platform_power_off(struct st_platform_priv *priv);
+
+#endif /* __USB_ST_COMMON_H */
-- 
1.9.1
