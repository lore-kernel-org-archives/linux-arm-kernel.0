From: alex.aring@gmail.com (Alexander Aring)
Date: Sun, 29 Nov 2015 17:59:31 +0100
Subject: [PATCHv2 2/4] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
References: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
Message-ID: <1448816373-18235-3-git-send-email-alex.aring@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for RPi several Power Domains and enable support
to enable the USB Power Domain when it's not enabled before.

This patch based on Eric Anholt's patch to support Power Domains. He had
an issue about -EPROBE_DEFER inside the power domain subsystem, this
issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
if we fail to init or turn-on domain").

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/mach-bcm/Kconfig                   |  10 ++
 arch/arm/mach-bcm/Makefile                  |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c       | 180 ++++++++++++++++++++++++++++
 include/dt-bindings/arm/raspberrypi-power.h |  14 +++
 4 files changed, 205 insertions(+)
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8c53c55..0f23bad 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -134,6 +134,16 @@ config ARCH_BCM2835
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  used in the Raspberry Pi and Roku 2 devices.
 
+config RASPBERRYPI_POWER
+	bool "Raspberry Pi power domain driver"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM
+	help
+	  This enables support for the RPi power domains which can be enabled
+	  or disabled via the RPi firmware.
+
 config ARCH_BCM_63XX
 	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
 	depends on MMU
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 892261f..fec2d6b 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -36,6 +36,7 @@ endif
 
 # BCM2835
 obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
+obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
 
 # BCM5301X
 obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
diff --git a/arch/arm/mach-bcm/raspberrypi-power.c b/arch/arm/mach-bcm/raspberrypi-power.c
new file mode 100644
index 0000000..3b61f18
--- /dev/null
+++ b/arch/arm/mach-bcm/raspberrypi-power.c
@@ -0,0 +1,180 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ * (C) 2015 Pengutronix, Alexander Aring <aar@pengutronix.de>
+ * Eric Anholt <eric@anholt.net>
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/arm/raspberrypi-power.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define RPI_POWER_DOMAIN(_domain, _name)			\
+	[_domain] = {						\
+		.domain = _domain,				\
+		.enabled = true,				\
+		.base = {					\
+			.name = _name,				\
+			.power_off = rpi_domain_off,		\
+			.power_on = rpi_domain_on,		\
+		},						\
+	}
+
+struct rpi_power_domain {
+	u32 domain;
+	bool enabled;
+	struct generic_pm_domain base;
+};
+
+struct rpi_power_domain_packet {
+	u32 domain;
+	u32 on;
+} __packet;
+
+static struct rpi_firmware *fw;
+static struct genpd_onecell_data rpi_genpd_xlate;
+
+/*
+ * Asks the firmware to enable or disable power on a specific power
+ * domain.
+ */
+static int rpi_firmware_set_power(u32 domain, bool on)
+{
+	struct rpi_power_domain_packet packet;
+
+	packet.domain = domain;
+	packet.on = on;
+	return rpi_firmware_property(fw, RPI_FIRMWARE_SET_POWER_STATE, &packet,
+				     sizeof(packet));
+}
+
+/* Asks the firmware to if power is on for a specific power domain. */
+static int rpi_firmware_power_is_on(u32 domain)
+{
+	struct rpi_power_domain_packet packet;
+	int ret;
+
+	packet.domain = domain;
+	ret = rpi_firmware_property(fw, RPI_FIRMWARE_GET_POWER_STATE, &packet,
+				    sizeof(packet));
+	if (ret < 0)
+		return ret;
+
+	return packet.on & BIT(0);
+}
+
+static int rpi_domain_off(struct generic_pm_domain *domain)
+{
+	struct rpi_power_domain *rpi_domain =
+		container_of(domain, struct rpi_power_domain, base);
+
+	return rpi_firmware_set_power(rpi_domain->domain, false);
+}
+
+static int rpi_domain_on(struct generic_pm_domain *domain)
+{
+	struct rpi_power_domain *rpi_domain =
+		container_of(domain, struct rpi_power_domain, base);
+
+	return rpi_firmware_set_power(rpi_domain->domain, true);
+}
+
+static struct rpi_power_domain rpi_power_domains[] = {
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_USB, "USB"),
+};
+
+static int rpi_power_probe(struct platform_device *pdev)
+{
+	struct device_node *fw_np;
+	struct device *dev = &pdev->dev;
+	struct generic_pm_domain **power_domains;
+	int i, ret, num_domains = ARRAY_SIZE(rpi_power_domains);
+
+	fw_np = of_parse_phandle(pdev->dev.of_node, "firmware", 0);
+	if (!fw_np) {
+		dev_err(&pdev->dev, "no firmware node\n");
+		return -ENODEV;
+	}
+
+	fw = rpi_firmware_get(fw_np);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	power_domains = devm_kzalloc(dev, sizeof(*power_domains) * num_domains,
+				     GFP_KERNEL);
+	if (!power_domains)
+		return -ENOMEM;
+
+	rpi_genpd_xlate.domains = power_domains;
+	rpi_genpd_xlate.num_domains = num_domains;
+
+	for (i = 0; i < num_domains; i++) {
+		bool is_off;
+
+		if (!rpi_power_domains[i].enabled)
+			continue;
+
+		/* get the initial state */
+		ret = rpi_firmware_power_is_on(rpi_power_domains[i].domain);
+		if (ret < 0)
+			goto exit_pm;
+
+		/* pm_genpd_init needs is_off, invert the logic here */
+		is_off = !ret;
+		pm_genpd_init(&rpi_power_domains[i].base, NULL, is_off);
+		/* let power_domains array know about the registered pm */
+		power_domains[i] = &rpi_power_domains[i].base;
+	}
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, &rpi_genpd_xlate);
+	if (ret < 0)
+		goto exit_pm;
+
+	return 0;
+
+exit_pm:
+	for (i = 0; i < num_domains; i++)
+		pm_genpd_exit(power_domains[i]);
+
+	return ret;
+}
+
+static int rpi_power_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int i;
+
+	for (i = 0; i < rpi_genpd_xlate.num_domains; i++)
+		pm_genpd_exit(rpi_genpd_xlate.domains[i]);
+
+	of_genpd_del_provider(dev->of_node);
+
+	return 0;
+}
+
+static const struct of_device_id rpi_power_of_match[] = {
+	{ .compatible = "raspberrypi,bcm2835-power", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpi_power_of_match);
+
+static struct platform_driver rpi_power_driver = {
+	.driver = {
+		.name = "raspberrypi-power",
+		.of_match_table = rpi_power_of_match,
+	},
+	.probe		= rpi_power_probe,
+	.remove		= rpi_power_remove,
+};
+module_platform_driver(rpi_power_driver);
+
+MODULE_AUTHOR("Alexander Aring <aar@pengutronix.de>");
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_DESCRIPTION("Raspberry Pi power domain driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/arm/raspberrypi-power.h b/include/dt-bindings/arm/raspberrypi-power.h
new file mode 100644
index 0000000..c2ffbebc
--- /dev/null
+++ b/include/dt-bindings/arm/raspberrypi-power.h
@@ -0,0 +1,14 @@
+/*
+ *  Copyright ? 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
+#define _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
+
+#define RPI_POWER_DOMAIN_USB	3
+
+#endif /* _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H */
-- 
2.6.1
