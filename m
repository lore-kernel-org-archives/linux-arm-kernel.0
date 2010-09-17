From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:28 +0200
Subject: [PATCH 10/16] ARM: mx5: add spi_imx device registration
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/devices-imx51.h            |   18 ++++++++++++++++++
 arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 ++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/devices-imx51.h

diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
new file mode 100644
index 0000000..fe6c987
--- /dev/null
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx51.h>
+#include <mach/devices-common.h>
+
+extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
+#define imx51_add_cspi(pdata)      \
+	imx_add_spi_imx(&imx51_cspi_data, pdata)
+
+extern struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
+#define imx51_add_ecspi(id, pdata) \
+	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index bd30d4b..e48340e 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -68,6 +68,18 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_ARCH_MX35 */
 
+#ifdef CONFIG_ARCH_MX51
+const struct imx_spi_imx_data imx51_cspi_data __initconst =
+	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 0, , SZ_4K);
+
+const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
+#define imx51_ecspi_data_entry(_id, _hwid)				\
+	imx_spi_imx_data_entry(MX51, ECSPI, "imx51-ecspi", _id, _hwid, SZ_4K)
+	imx51_ecspi_data_entry(0, 1),
+	imx51_ecspi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata)
-- 
1.7.2.3
