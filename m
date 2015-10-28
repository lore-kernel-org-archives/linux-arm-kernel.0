From: alex.aring@gmail.com (Alexander Aring)
Date: Wed, 28 Oct 2015 21:40:10 +0100
Subject: [RFC] rpi: add support to enable usb power domain
Message-ID: <1446064810-5064-1-git-send-email-alex.aring@gmail.com>
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
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
First:
I cc'ed Andy Whitcroft and Joe Perches here, because this patch will
generate a false positive for checkpatch and checkpatch told me to
cc checkpatch maintainers if this occurs:

ERROR: Macros with complex values should be enclosed in parentheses
#191: FILE: drivers/firmware/raspberrypi.c:26:
+#define RPI_POWER_DOMAIN(_domain, _name)			\
+	[_domain] =						\
+	{							\
...

Second:
This patch based on linus/master and requires the rpi-firmware patch.

Third:
The barebox regulator doesn't support right now to enable/disable
regulators at runtime but I want to bring this mainline in the next
days. So you can't check yourself if the above scripts working right
now. I describe it here to show you what exactly I tested.

changes since Eric Anholts "power domain" patch:
 - add for me all known power domains of the RPi, it contains the domains
   0 - 9.
 - Add devicetree documentation.
 - move implementation to drivers/firmware/... (also Kconfig dependencies)
 - add macro RPI_POWER_DOMAIN.
 - add function "raspberrypi_firmware_power_is_on" to get the initial value
   for a "power domain", which can be assign over the "is_off" parameter,
   while power domain init.
 - Put generic_pm_domain on the heap with amount of entries which
   comes from ARRAY_SIZE(rpi_power_domains). So we don't need to care
   about both arrays anymore. But only works so far rpi_power_domains has
   not empty entries in the middle. I added a note about that, if it's
   too ugly I will remove it or accept other solutions. Maybe make
   rpi_power_domains as double pointer (and care about NULL entries, anyway.
   It should working and I think there are no other domains and if there are
   other domains and we have missing entries then something is wrong.

Notes:

I wonder myself when I disable domain 0 (SDHC) I can still access the card,
as well uart is also still working after turn off power.

 .../arm/bcm/raspberrypi,bcm2835-firmware.txt       |  15 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   6 +
 arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
 drivers/firmware/Kconfig                           |   2 +
 drivers/firmware/raspberrypi.c                     | 133 +++++++++++++++++++++
 .../dt-bindings/arm/raspberrypi-firmware-power.h   |  23 ++++
 6 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/arm/raspberrypi-firmware-power.h

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
index 6824b31..2727ca16 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
@@ -5,10 +5,25 @@ Required properties:
 - compatible:		Should be "raspberrypi,bcm2835-firmware"
 - mboxes:		Phandle to the firmware device's Mailbox.
 			  (See: ../mailbox/mailbox.txt for more information)
+- #power-domain-cells:	Should be <1>, we providing multiple power domains.
+
+The valid defines for power domain are:
+
+ RPI_POWER_DOMAIN_SDCARD, RPI_POWER_DOMAIN_UART0, RPI_POWER_DOMAIN_UART1,
+ RPI_POWER_DOMAIN_USB, RPI_POWER_DOMAIN_I2C0, RPI_POWER_DOMAIN_I2C1,
+ RPI_POWER_DOMAIN_I2C2, RPI_POWER_DOMAIN_SPI, RPI_POWER_DOMAIN_CCP2TX,
+ RPI_POWER_DOMAIN_DSI
 
 Example:
 
 firmware {
 	compatible = "raspberrypi,bcm2835-firmware";
 	mboxes = <&mailbox>;
+	#power-domain-cells = <1>;
+};
+
+Example for using power domain:
+
+&usb {
+       power-domains = <&firmware RPI_POWER_DOMAIN_USB>;
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ab5474e..7f19352 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/arm/raspberrypi-firmware-power.h>
 #include "bcm2835.dtsi"
 
 / {
@@ -19,6 +20,7 @@
 		firmware: firmware {
 			compatible = "raspberrypi,bcm2835-firmware";
 			mboxes = <&mailbox>;
+			#power-domain-cells = <1>;
 		};
 	};
 };
@@ -56,3 +58,7 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&usb {
+	power-domains = <&firmware RPI_POWER_DOMAIN_USB>;
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
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 7181126..8981599 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -150,6 +150,8 @@ config QCOM_SCM_64
 config RASPBERRYPI_FIRMWARE
 	tristate "Raspberry Pi Firmware Driver"
 	depends on BCM2835_MBOX
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM
 	help
 	  This option enables support for communicating with the firmware on the
 	  Raspberry Pi.
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index dd506cd3..e8db75e 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/arm/raspberrypi-firmware-power.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
@@ -21,7 +23,19 @@
 #define MBOX_DATA28(msg)		((msg) & ~0xf)
 #define MBOX_CHAN_PROPERTY		8
 
+#define RPI_POWER_DOMAIN(_domain, _name)			\
+	[_domain] =						\
+	{							\
+		.domain = _domain,				\
+		.base = {					\
+			.name = _name,				\
+			.power_off = raspberrypi_domain_off,	\
+			.power_on = raspberrypi_domain_on,	\
+		},						\
+	}
+
 struct rpi_firmware {
+	struct genpd_onecell_data genpd_xlate;
 	struct mbox_client cl;
 	struct mbox_chan *chan; /* The property channel. */
 	struct completion c;
@@ -30,6 +44,17 @@ struct rpi_firmware {
 
 static DEFINE_MUTEX(transaction_lock);
 
+struct raspberrypi_power_domain {
+	struct rpi_firmware *fw;
+	u32 domain;
+	struct generic_pm_domain base;
+};
+
+struct rpi_power_domain_packet {
+	u32 domain;
+	u32 on;
+} __packet;
+
 static void response_callback(struct mbox_client *cl, void *msg)
 {
 	struct rpi_firmware *fw = container_of(cl, struct rpi_firmware, cl);
@@ -183,10 +208,84 @@ rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
 	}
 }
 
+/*
+ * Asks the firmware to enable or disable power on a specific power
+ * domain.
+ */
+static int raspberrypi_firmware_set_power(struct rpi_firmware *fw,
+					  u32 domain, bool on)
+{
+	struct rpi_power_domain_packet packet;
+	int ret;
+
+	packet.domain = domain;
+	packet.on = on;
+	ret = rpi_firmware_property(fw, RPI_FIRMWARE_SET_POWER_STATE, &packet,
+				    sizeof(packet));
+	if (!ret && !packet.on)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+/* Asks the firmware to if power is on for a specific power domain. */
+static int raspberrypi_firmware_power_is_on(struct rpi_firmware *fw,
+					    u32 domain)
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
+	return raspberrypi_firmware_set_power(raspberrpi_domain->fw,
+					      raspberrpi_domain->domain, false);
+}
+
+static int raspberrypi_domain_on(struct generic_pm_domain *domain)
+{
+	struct raspberrypi_power_domain *raspberrpi_domain =
+		container_of(domain, struct raspberrypi_power_domain, base);
+
+	return raspberrypi_firmware_set_power(raspberrpi_domain->fw,
+					      raspberrpi_domain->domain, true);
+}
+
+/*
+ * IMPORTANT: be sure this array has no entries which are not specified
+ * between others by RPI_POWER_DOMAIN, otherwise mapping between
+ * generic_pm_domain array doesn't work anymore.
+ */
+static struct raspberrypi_power_domain rpi_power_domains[] = {
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_SDCARD, "SDCARD"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_UART0, "UART0"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_UART1, "UART1"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_USB, "USB"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_I2C0, "I2C0"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_I2C1, "I2C1"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_I2C2, "I2C2"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_SPI, "SPI"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_CCP2TX, "CCP2TX"),
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_DSI, "DSI"),
+};
+
 static int rpi_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *fw;
+	struct generic_pm_domain **power_domains;
+	int i, ret, num_domains = ARRAY_SIZE(rpi_power_domains);
 
 	fw = devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);
 	if (!fw)
@@ -196,6 +295,11 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 	fw->cl.rx_callback = response_callback;
 	fw->cl.tx_block = true;
 
+	power_domains = devm_kzalloc(dev, sizeof(*power_domains) * num_domains,
+				     GFP_KERNEL);
+	if (!power_domains)
+		return -ENOMEM;
+
 	fw->chan = mbox_request_channel(&fw->cl, 0);
 	if (IS_ERR(fw->chan)) {
 		int ret = PTR_ERR(fw->chan);
@@ -208,15 +312,44 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fw);
 
+	fw->genpd_xlate.domains = power_domains;
+	fw->genpd_xlate.num_domains = num_domains;
+
+	for (i = 0; i < num_domains; i++) {
+		bool is_off;
+
+		rpi_power_domains[i].fw = fw;
+		power_domains[i] = &rpi_power_domains[i].base;
+
+		/* get the initial state */
+		ret = raspberrypi_firmware_power_is_on(fw, i);
+		if (ret < 0)
+			goto mbox;
+
+		/* pm_genpd_init needs is_off, invert the logic here */
+		is_off = !ret;
+		pm_genpd_init(power_domains[i], NULL, is_off);
+	}
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, &fw->genpd_xlate);
+	if (ret < 0)
+		goto mbox;
+
 	rpi_firmware_print_firmware_revision(fw);
 
 	return 0;
+
+mbox:
+	mbox_free_channel(fw->chan);
+	return ret;
 }
 
 static int rpi_firmware_remove(struct platform_device *pdev)
 {
 	struct rpi_firmware *fw = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
 
+	of_genpd_del_provider(dev->of_node);
 	mbox_free_channel(fw->chan);
 
 	return 0;
diff --git a/include/dt-bindings/arm/raspberrypi-firmware-power.h b/include/dt-bindings/arm/raspberrypi-firmware-power.h
new file mode 100644
index 0000000..c363a1f
--- /dev/null
+++ b/include/dt-bindings/arm/raspberrypi-firmware-power.h
@@ -0,0 +1,23 @@
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
+#define RPI_POWER_DOMAIN_SDCARD	0
+#define RPI_POWER_DOMAIN_UART0	1
+#define RPI_POWER_DOMAIN_UART1	2
+#define RPI_POWER_DOMAIN_USB	3
+#define RPI_POWER_DOMAIN_I2C0	4
+#define RPI_POWER_DOMAIN_I2C1	5
+#define RPI_POWER_DOMAIN_I2C2	6
+#define RPI_POWER_DOMAIN_SPI	7
+#define RPI_POWER_DOMAIN_CCP2TX	8
+#define RPI_POWER_DOMAIN_DSI	9
+
+#endif /* _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H */
-- 
2.6.1
