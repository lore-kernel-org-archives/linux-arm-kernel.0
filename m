From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 19 Jun 2017 05:40:21 +0200
Subject: [PATCH v5 21/26] soc: actions: Add Owl SPS
In-Reply-To: <20170606005426.26446-24-afaerber@suse.de>
References: <20170606005426.26446-24-afaerber@suse.de>
Message-ID: <20170619034021.5762-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement S500 Smart Power System power-gating.
For now flag PD_CPU2 and PD_CPU3 as always-on.

Based on LeMaker linux-actions tree.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4 -> v5:
 * Updated for header file rename
 
 v3 -> v4:
 * Added genpd_flags field and set GENPD_FLAG_ALWAYS_ON for CPU2/CPU3
 * Added debug output
 
 v3: new
 
 drivers/soc/Kconfig           |   1 +
 drivers/soc/Makefile          |   1 +
 drivers/soc/actions/Kconfig   |  12 ++
 drivers/soc/actions/Makefile  |   1 +
 drivers/soc/actions/owl-sps.c | 252 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 267 insertions(+)
 create mode 100644 drivers/soc/actions/Kconfig
 create mode 100644 drivers/soc/actions/Makefile
 create mode 100644 drivers/soc/actions/owl-sps.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index f8c0286f8a65..07fc0ac51c52 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/actions/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index c0b2a610efcd..9241125416ba 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
new file mode 100644
index 000000000000..bdf827d5ce78
--- /dev/null
+++ b/drivers/soc/actions/Kconfig
@@ -0,0 +1,12 @@
+if ARCH_ACTIONS || COMPILE_TEST
+
+config OWL_PM_DOMAINS
+	bool "Actions Semi SPS power domains"
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say 'y' here to enable support for Smart Power System (SPS)
+	  power-gating on Actions Semiconductor S500 SoC.
+	  If unsure, say 'n'.
+
+endif
diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
new file mode 100644
index 000000000000..720c34ed16e4
--- /dev/null
+++ b/drivers/soc/actions/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
new file mode 100644
index 000000000000..8abb72f01929
--- /dev/null
+++ b/drivers/soc/actions/owl-sps.c
@@ -0,0 +1,252 @@
+/*
+ * Actions Semi Owl Smart Power System (SPS)
+ *
+ * Copyright 2012 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/power/owl-s500-powergate.h>
+
+#define OWL_SPS_PG_CTL	0x0
+
+struct owl_sps_domain_info {
+	const char *name;
+	int pwr_bit;
+	int ack_bit;
+	unsigned int genpd_flags;
+};
+
+struct owl_sps_info {
+	unsigned num_domains;
+	const struct owl_sps_domain_info *domains;
+};
+
+struct owl_sps {
+	struct device *dev;
+	const struct owl_sps_info *info;
+	void __iomem *base;
+	struct genpd_onecell_data genpd_data;
+	struct generic_pm_domain *domains[];
+};
+
+#define to_owl_pd(gpd) container_of(gpd, struct owl_sps_domain, genpd)
+
+struct owl_sps_domain {
+	struct generic_pm_domain genpd;
+	const struct owl_sps_domain_info *info;
+	struct owl_sps *sps;
+};
+
+static int owl_sps_set_power(struct owl_sps_domain *pd, bool enable)
+{
+	u32 val, pwr_mask, ack_mask;
+	int timeout;
+	bool ack;
+
+	ack_mask = BIT(pd->info->ack_bit);
+	pwr_mask = BIT(pd->info->pwr_bit);
+	val = readl(pd->sps->base + OWL_SPS_PG_CTL);
+	ack = val & ack_mask;
+
+	if (ack == enable)
+		return 0;
+
+	if (enable)
+		val |= pwr_mask;
+	else
+		val &= ~pwr_mask;
+
+	writel(val, pd->sps->base + OWL_SPS_PG_CTL);
+
+	for (timeout = 5000; timeout > 0; timeout -= 50) {
+		val = readl(pd->sps->base + OWL_SPS_PG_CTL);
+		if ((val & ack_mask) == (enable ? ack_mask : 0))
+			break;
+		udelay(50);
+	}
+	if (timeout <= 0)
+		return -ETIMEDOUT;
+
+	udelay(10);
+
+	return 0;
+}
+
+static int owl_sps_power_on(struct generic_pm_domain *domain)
+{
+	struct owl_sps_domain *pd = to_owl_pd(domain);
+
+	dev_dbg(pd->sps->dev, "%s power on", pd->info->name);
+
+	return owl_sps_set_power(pd, true);
+}
+
+static int owl_sps_power_off(struct generic_pm_domain *domain)
+{
+	struct owl_sps_domain *pd = to_owl_pd(domain);
+
+	dev_dbg(pd->sps->dev, "%s power off", pd->info->name);
+
+	return owl_sps_set_power(pd, false);
+}
+
+static int owl_sps_init_domain(struct owl_sps *sps, int index)
+{
+	struct owl_sps_domain *pd;
+
+	pd = devm_kzalloc(sps->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->info = &sps->info->domains[index];
+	pd->sps = sps;
+
+	pd->genpd.name = pd->info->name;
+	pd->genpd.power_on = owl_sps_power_on;
+	pd->genpd.power_off = owl_sps_power_off;
+	pd->genpd.flags = pd->info->genpd_flags;
+	pm_genpd_init(&pd->genpd, NULL, false);
+
+	sps->genpd_data.domains[index] = &pd->genpd;
+
+	return 0;
+}
+
+static int owl_sps_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	const struct owl_sps_info *sps_info;
+	struct owl_sps *sps;
+	int i, ret;
+
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "no device node\n");
+		return -ENODEV;
+	}
+
+	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
+	if (!match || !match->data) {
+		dev_err(&pdev->dev, "unknown compatible or missing data\n");
+		return -EINVAL;
+	}
+
+	sps_info = match->data;
+
+	sps = devm_kzalloc(&pdev->dev, sizeof(*sps) +
+			   sps_info->num_domains * sizeof(sps->domains[0]),
+			   GFP_KERNEL);
+	if (!sps)
+		return -ENOMEM;
+
+	sps->base = of_io_request_and_map(pdev->dev.of_node, 0, "owl-sps");
+	if (IS_ERR(sps->base)) {
+		dev_err(&pdev->dev, "failed to map sps registers\n");
+		return PTR_ERR(sps->base);
+	}
+
+	sps->dev = &pdev->dev;
+	sps->info = sps_info;
+	sps->genpd_data.domains = sps->domains;
+	sps->genpd_data.num_domains = sps_info->num_domains;
+
+	for (i = 0; i < sps_info->num_domains; i++) {
+		ret = owl_sps_init_domain(sps, i);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, &sps->genpd_data);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add provider (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct owl_sps_domain_info s500_sps_domains[] = {
+	[S500_PD_VDE] = {
+		.name = "VDE",
+		.pwr_bit = 0,
+		.ack_bit = 16,
+	},
+	[S500_PD_VCE_SI] = {
+		.name = "VCE_SI",
+		.pwr_bit = 1,
+		.ack_bit = 17,
+	},
+	[S500_PD_USB2_1] = {
+		.name = "USB2_1",
+		.pwr_bit = 2,
+		.ack_bit = 18,
+	},
+	[S500_PD_CPU2] = {
+		.name = "CPU2",
+		.pwr_bit = 5,
+		.ack_bit = 21,
+		.genpd_flags = GENPD_FLAG_ALWAYS_ON,
+	},
+	[S500_PD_CPU3] = {
+		.name = "CPU3",
+		.pwr_bit = 6,
+		.ack_bit = 22,
+		.genpd_flags = GENPD_FLAG_ALWAYS_ON,
+	},
+	[S500_PD_DMA] = {
+		.name = "DMA",
+		.pwr_bit = 8,
+		.ack_bit = 12,
+	},
+	[S500_PD_DS] = {
+		.name = "DS",
+		.pwr_bit = 9,
+		.ack_bit = 13,
+	},
+	[S500_PD_USB3] = {
+		.name = "USB3",
+		.pwr_bit = 10,
+		.ack_bit = 14,
+	},
+	[S500_PD_USB2_0] = {
+		.name = "USB2_0",
+		.pwr_bit = 11,
+		.ack_bit = 15,
+	},
+};
+
+static const struct owl_sps_info s500_sps_info = {
+	.num_domains = ARRAY_SIZE(s500_sps_domains),
+	.domains = s500_sps_domains,
+};
+
+static const struct of_device_id owl_sps_of_matches[] = {
+	{ .compatible = "actions,s500-sps", .data = &s500_sps_info },
+	{ }
+};
+
+static struct platform_driver owl_sps_platform_driver = {
+	.probe = owl_sps_probe,
+	.driver = {
+		.name = "owl-sps",
+		.of_match_table = owl_sps_of_matches,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init owl_sps_init(void)
+{
+	return platform_driver_register(&owl_sps_platform_driver);
+}
+postcore_initcall(owl_sps_init);
-- 
2.12.3
