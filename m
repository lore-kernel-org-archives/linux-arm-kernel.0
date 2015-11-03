From: alex.aring@gmail.com (Alexander Aring)
Date: Tue,  3 Nov 2015 23:45:11 +0100
Subject: [RFCv2 2/2] rpi: add support to enable usb power domain
In-Reply-To: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
Message-ID: <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for RPi several Power Domains and enable support
to enable the USB Power Domain when it's not enabled before.

This patch based on Eric Anholt's patch to support Power Domains. He had
an issue about -EPROBE_DEFER inside the power domain subsystem, this
issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
if we fail to init or turn-on domain").

It was tested with barebox and the following scripts before booting
linux:

/env/a_off:

 # cat /env/a_off
 #turn off which are enabled by default
 regulator -n bcm2835_mci0 -s disable
 regulator -n uart0-pl0110 -s disable

/env/a_on:

 # cat /env/a_on
 #turn off which are enabled by default
 regulator -n bcm2835_mci0 -s disable
 regulator -n uart0-pl0110 -s disable

 regulator -n bcm2835_mci0 -s enable
 regulator -n uart0-pl0110 -s enable
 regulator -n uart0-pl0111 -s enable
 regulator -n bcm2835_usb -s enable
 regulator -n bcm2835_i2c0 -s enable
 regulator -n bcm2835_i2c1 -s enable
 regulator -n bcm2835_i2c2 -s enable
 regulator -n bcm2835_spi -s enable
 regulator -n bcm2835_ccp2tx -s enable
 regulator -n bcm2835_dsi -s enable

/env/b:

 # cat /env/b
 sh /env/a_on

 regulator -n bcm2835_mci0 -s disable
 regulator -n uart0-pl0110 -s disable
 regulator -n uart0-pl0111 -s disable
 regulator -n bcm2835_usb -s disable
 regulator -n bcm2835_i2c0 -s disable
 regulator -n bcm2835_i2c1 -s disable
 regulator -n bcm2835_i2c2 -s disable
 regulator -n bcm2835_spi -s disable
 regulator -n bcm2835_ccp2tx -s disable
 regulator -n bcm2835_dsi -s disable

/env/c:

 # cat /env/c
 sh ./env/b

 regulator -n bcm2835_mci0 -s enable
 regulator -n uart0-pl0110 -s enable
 regulator -n uart0-pl0111 -s enable
 regulator -n bcm2835_usb -s enable
 regulator -n bcm2835_i2c0 -s enable
 regulator -n bcm2835_i2c1 -s enable
 regulator -n bcm2835_i2c2 -s enable
 regulator -n bcm2835_spi -s enable
 regulator -n bcm2835_ccp2tx -s enable
 regulator -n bcm2835_dsi -s enable

These scripts enables/disable all regulators inside the bootloader. It
was running with a "hard" and "soft" reset without any issues. These
testcases should fit to Stephen Warren suggestions:

"(a) before having explicitly turned the power domain on or off at all (b)
after having turned it on (c) after having turned it off, and for all
power domains."

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
changes since v2:
 - add pm_genpd_uninit to handle probing failure.
 - move power domain drive to his own driver in arch/arm/mach-bcm/
   Also add own devicetree node for this driver, "raspberrypi,bcm2835-power".
 - Removing all power domains which might exists for the firmware API but
   we currently have no use-case for it. I tried to keep the same domain
   numbering in generic power domains subsystem like they are offered from
   the firmware API. This works, all power_domains which are NULL inside
   the array of genpd_onecell_data.domains[#] will be ignored.
 - Adding Eric Anholt and me to the authors.
 - Creating devicetree documentation for the power domain driver.
 - fix error handling in raspberrypi_firmware_set_power.
 - Remove comment about mapping between power domains array, this is not
   necessary anymore. I add a "enabled" attribute to raspberrypi_power_domain
   which indicates if a domain should be registered or not (zeroed values
   does not indicate such handling, but enabled is false then).
 - remove "goto mbox" not necessary anymore because an own driver
   implementation.
 - Update devicetrees for changes in v2.

 .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  25 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 ++
 arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
 arch/arm/mach-bcm/Kconfig                          |  10 ++
 arch/arm/mach-bcm/Makefile                         |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c              | 180 +++++++++++++++++++++
 include/dt-bindings/arm/raspberrypi-power.h        |  14 ++
 7 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
new file mode 100644
index 0000000..c3abc24
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
@@ -0,0 +1,25 @@
+Raspberry Pi power domain driver
+
+Required properties:
+
+- compatible:		Should be "raspberrypi,bcm2835-power".
+- firmware:		Reference to the RPi firmware device node.
+- #power-domain-cells:	Should be <1>, we providing multiple power domains.
+
+The valid defines for power domain are:
+
+ RPI_POWER_DOMAIN_USB
+
+Example:
+
+power: power {
+	compatible = "raspberrypi,bcm2835-power";
+	firmware = <&firmware>;
+	#power-domain-cells = <1>;
+};
+
+Example for using power domain:
+
+&usb {
+       power-domains = <&power RPI_POWER_DOMAIN_USB>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ab5474e..d9b16d1 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/arm/raspberrypi-power.h>
 #include "bcm2835.dtsi"
 
 / {
@@ -20,6 +21,12 @@
 			compatible = "raspberrypi,bcm2835-firmware";
 			mboxes = <&mailbox>;
 		};
+
+		power: power {
+			compatible = "raspberrypi,bcm2835-power";
+			firmware = <&firmware>;
+			#power-domain-cells = <1>;
+		};
 	};
 };
 
@@ -56,3 +63,7 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&usb {
+	power-domains = <&power RPI_POWER_DOMAIN_USB>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..3c899b3 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -149,7 +149,7 @@
 			status = "disabled";
 		};
 
-		usb at 7e980000 {
+		usb: usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 1319c3c..244475e5 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -120,6 +120,16 @@ config ARCH_BCM2835
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  used in the Raspberry Pi and Roku 2 devices.
 
+config RASPBERRY_POWER
+	bool "Raspberry Pi power domain driver"
+	depends on ARCH_BCM2835
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
index 1780a3f..283295e 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -33,6 +33,7 @@ endif
 
 # BCM2835
 obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
+obj-$(CONFIG_RASPBERRY_POWER)	+= raspberrypi-power.o
 
 # BCM5301X
 obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
diff --git a/arch/arm/mach-bcm/raspberrypi-power.c b/arch/arm/mach-bcm/raspberrypi-power.c
new file mode 100644
index 0000000..531300f
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
+#include <linux/pm_domain.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/arm/raspberrypi-power.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define RPI_POWER_DOMAIN(_domain, _name)			\
+	[_domain] = {						\
+		.domain = _domain,				\
+		.enabled = true,				\
+		.base = {					\
+			.name = _name,				\
+			.power_off = raspberrypi_domain_off,	\
+			.power_on = raspberrypi_domain_on,	\
+		},						\
+	}
+
+struct raspberrypi_power_domain {
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
+static int raspberrypi_firmware_set_power(u32 domain, bool on)
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
+static int raspberrypi_firmware_power_is_on(u32 domain)
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
+static int raspberrypi_domain_off(struct generic_pm_domain *domain)
+{
+	struct raspberrypi_power_domain *raspberrpi_domain =
+		container_of(domain, struct raspberrypi_power_domain, base);
+
+	return raspberrypi_firmware_set_power(raspberrpi_domain->domain, false);
+}
+
+static int raspberrypi_domain_on(struct generic_pm_domain *domain)
+{
+	struct raspberrypi_power_domain *raspberrpi_domain =
+		container_of(domain, struct raspberrypi_power_domain, base);
+
+	return raspberrypi_firmware_set_power(raspberrpi_domain->domain, true);
+}
+
+static struct raspberrypi_power_domain rpi_power_domains[] = {
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
+		ret = raspberrypi_firmware_power_is_on(rpi_power_domains[i].domain);
+		if (ret < 0)
+			goto uninit_pm;
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
+		goto uninit_pm;
+
+	return 0;
+
+uninit_pm:
+	for (i = 0; i < num_domains; i++)
+		pm_genpd_uninit(power_domains[i]);
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
+		pm_genpd_uninit(rpi_genpd_xlate.domains[i]);
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
index 0000000..51f0772
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
+#ifndef _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H
+#define _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H
+
+#define RPI_POWER_DOMAIN_USB	3
+
+#endif /* _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H */
-- 
2.6.1
