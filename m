From: eric@anholt.net (Eric Anholt)
Date: Mon, 27 Apr 2015 16:14:08 -0700
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1430176449-12322-1-git-send-email-eric@anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
Message-ID: <1430176449-12322-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gives us a function for making mailbox property channel requests
of the firmware, and uses it to control the 3 power domains provided
by the firmware.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/mach-bcm/Kconfig                          |   2 +
 arch/arm/mach-bcm/Makefile                         |   1 +
 arch/arm/mach-bcm/raspberrypi-firmware.c           | 285 +++++++++++++++++++++
 .../dt-bindings/arm/raspberrypi-firmware-power.h   |  16 ++
 include/soc/bcm2835/raspberrypi-mailbox-property.h | 110 ++++++++
 5 files changed, 414 insertions(+)
 create mode 100644 arch/arm/mach-bcm/raspberrypi-firmware.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-firmware-power.h
 create mode 100644 include/soc/bcm2835/raspberrypi-mailbox-property.h

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8b11f44..a907bf4 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -116,6 +116,8 @@ config ARCH_BCM2835
 	select CLKSRC_OF
 	select PINCTRL
 	select PINCTRL_BCM2835
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM
 	help
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  used in the Raspberry Pi and Roku 2 devices.
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 4c38674..bbdde34 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -33,6 +33,7 @@ endif
 
 # BCM2835
 obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
+obj-$(CONFIG_BCM2835_MBOX)	+= raspberrypi-firmware.o
 
 # BCM5301X
 obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
diff --git a/arch/arm/mach-bcm/raspberrypi-firmware.c b/arch/arm/mach-bcm/raspberrypi-firmware.c
new file mode 100644
index 0000000..194f05f
--- /dev/null
+++ b/arch/arm/mach-bcm/raspberrypi-firmware.c
@@ -0,0 +1,285 @@
+/*
+ *  Copyright ? 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Defines interfaces for interacting wtih the Raspberry Pi firmware,
+ * and registers some of those services with the kernel.
+ */
+
+#include <dt-bindings/arm/raspberrypi-firmware-power.h>
+#include <linux/dma-mapping.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <soc/bcm2835/raspberrypi-mailbox-property.h>
+
+#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
+#define MBOX_CHAN(msg)			((msg) & 0xf)
+#define MBOX_DATA28(msg)		((msg) & ~0xf)
+#define MBOX_CHAN_PROPERTY		8
+
+struct raspberrypi_firmware {
+	struct device *dev;
+	struct genpd_onecell_data genpd_xlate;
+	struct mbox_client cl;
+	struct mbox_chan *chan; /* The property channel. */
+	struct completion c;
+	u32 enabled;
+};
+
+static struct raspberrypi_firmware *firmware;
+static DEFINE_MUTEX(transaction_lock);
+
+static void response_callback(struct mbox_client *cl, void *msg)
+{
+	complete(&firmware->c);
+}
+
+/*
+ * Sends a request to the firmware through the BCM2835 mailbox driver,
+ * and synchronously waits for the reply.
+ */
+static int
+raspberrypi_firmware_transaction(u32 chan, u32 data)
+{
+	u32 message = MBOX_MSG(chan, data);
+	int ret;
+
+	WARN_ON(data & 0xf);
+
+	mutex_lock(&transaction_lock);
+	reinit_completion(&firmware->c);
+	ret = mbox_send_message(firmware->chan, &message);
+	if (ret >= 0) {
+		wait_for_completion(&firmware->c);
+		ret = 0;
+	} else {
+		dev_err(firmware->cl.dev, "mbox_send_message returned %d\n",
+			ret);
+	}
+	mutex_unlock(&transaction_lock);
+
+	return ret;
+}
+
+
+/*
+ * Submits a set of concatenated tags to the VPU firmware through the
+ * mailbox property interface.
+ *
+ * The buffer header and the ending tag are added by this function and
+ * don't need to be supplied, just the actual tags for your operation.
+ * See struct raspberrypi_firmware_property_tag_header for the per-tag structure.
+ */
+int raspberrypi_firmware_property(void *data, size_t tag_size)
+{
+	size_t size = tag_size + 12;
+	u32 *buf;
+	dma_addr_t bus_addr;
+	int ret = 0;
+
+	if (!firmware)
+		return -EPROBE_DEFER;
+
+	/* Packets are processed a dword at a time. */
+	if (size & 3)
+		return -EINVAL;
+
+	buf = dma_alloc_coherent(NULL, PAGE_ALIGN(size), &bus_addr, GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+
+	/* The firmware will error out without parsing in this case. */
+	WARN_ON(size >= 1024 * 1024);
+
+	buf[0] = size;
+	buf[1] = raspberrypi_firmware_status_request;
+	memcpy(&buf[2], data, tag_size);
+	buf[size / 4 - 1] = raspberrypi_firmware_property_end;
+	wmb();
+
+	ret = raspberrypi_firmware_transaction(MBOX_CHAN_PROPERTY, bus_addr);
+
+	rmb();
+	memcpy(data, &buf[2], tag_size);
+	if (ret == 0 && buf[1] != raspberrypi_firmware_status_success) {
+		/*
+		 * The tag name here might not be the one causing the
+		 * error, if there were multiple tags in the request.
+		 * But single-tag is the most common, so go with it.
+		 */
+		dev_err(firmware->cl.dev,
+			"Request 0x%08x returned status 0x%08x\n",
+			buf[2], buf[1]);
+		ret = -EINVAL;
+	}
+
+	dma_free_coherent(NULL, PAGE_ALIGN(size), buf, bus_addr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(raspberrypi_firmware_property);
+
+struct raspberrypi_power_domain {
+	u32 domain;
+	struct generic_pm_domain base;
+};
+
+/*
+ * Asks the firmware to enable or disable power on a specific power
+ * domain.
+ */
+static int raspberrypi_firmware_set_power(uint32_t domain, bool on)
+{
+	struct {
+		struct raspberrypi_firmware_property_tag_header header;
+		u32 domain;
+		u32 on;
+	} packet;
+	int ret;
+
+	memset(&packet, 0, sizeof(packet));
+	packet.header.tag = raspberrypi_firmware_set_power_state;
+	packet.header.buf_size = 8;
+	packet.domain = domain;
+	packet.on = on;
+	ret = raspberrypi_firmware_property(&packet, sizeof(packet));
+	if (!ret && !packet.on)
+		ret = -EINVAL;
+	return ret;
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
+struct raspberrypi_power_domain raspberrypi_power_domain_sdcard = {
+	.domain = 0,
+	.base = {
+		.name = "SDCARD",
+		.power_off = raspberrypi_domain_off,
+		.power_on = raspberrypi_domain_on,
+	}
+};
+
+struct raspberrypi_power_domain raspberrypi_power_domain_usb = {
+	.domain = 3,
+	.base = {
+		.name = "USB",
+		.power_off = raspberrypi_domain_off,
+		.power_on = raspberrypi_domain_on,
+	}
+};
+
+struct raspberrypi_power_domain raspberrypi_power_domain_dsi = {
+	.domain = 9,
+	.base = {
+		.name = "DSI",
+		.power_off = raspberrypi_domain_off,
+		.power_on = raspberrypi_domain_on,
+	}
+};
+
+static struct generic_pm_domain *raspberrypi_power_domains[] = {
+	[POWER_DOMAIN_SDCARD] = &raspberrypi_power_domain_sdcard.base,
+	[POWER_DOMAIN_USB] = &raspberrypi_power_domain_usb.base,
+	[POWER_DOMAIN_DSI] = &raspberrypi_power_domain_dsi.base,
+};
+
+static int raspberrypi_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+	int i;
+
+	firmware = devm_kzalloc(dev, sizeof(*firmware), GFP_KERNEL);
+	if (!firmware)
+		return -ENOMEM;
+
+	firmware->cl.dev = dev;
+	firmware->cl.rx_callback = response_callback;
+	firmware->cl.tx_block = true;
+
+	firmware->chan = mbox_request_channel(&firmware->cl, 0);
+	if (IS_ERR(firmware->chan)) {
+		ret = PTR_ERR(firmware->chan);
+		/* An -EBUSY from the core means it couldn't find our
+		 * channel, because the mailbox driver hadn't
+		 * registered yet.
+		 */
+		if (ret == -EBUSY)
+			ret = -EPROBE_DEFER;
+		else
+			dev_err(dev, "Failed to get mbox channel: %d\n", ret);
+		goto fail;
+	}
+
+	init_completion(&firmware->c);
+
+	platform_set_drvdata(pdev, firmware);
+
+	firmware->genpd_xlate.domains =
+		raspberrypi_power_domains;
+	firmware->genpd_xlate.num_domains =
+		ARRAY_SIZE(raspberrypi_power_domains);
+
+	for (i = 0; i < ARRAY_SIZE(raspberrypi_power_domains); i++)
+		pm_genpd_init(raspberrypi_power_domains[i], NULL, true);
+
+	of_genpd_add_provider_onecell(dev->of_node, &firmware->genpd_xlate);
+
+	return 0;
+
+fail:
+	firmware = NULL;
+	return ret;
+}
+
+static int raspberrypi_firmware_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	of_genpd_del_provider(dev->of_node);
+	mbox_free_channel(firmware->chan);
+
+	return 0;
+}
+
+static const struct of_device_id raspberrypi_firmware_of_match[] = {
+	{ .compatible = "raspberrypi,firmware", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, raspberrypi_firmware_of_match);
+
+static struct platform_driver raspberrypi_firmware_driver = {
+	.driver = {
+		.name = "raspberrypi-firmware",
+		.owner = THIS_MODULE,
+		.of_match_table = raspberrypi_firmware_of_match,
+	},
+	.probe		= raspberrypi_firmware_probe,
+	.remove		= raspberrypi_firmware_remove,
+};
+module_platform_driver(raspberrypi_firmware_driver);
+
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_DESCRIPTION("Raspberry Pi firmware driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/arm/raspberrypi-firmware-power.h b/include/dt-bindings/arm/raspberrypi-firmware-power.h
new file mode 100644
index 0000000..1e1ef3b
--- /dev/null
+++ b/include/dt-bindings/arm/raspberrypi-firmware-power.h
@@ -0,0 +1,16 @@
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
+#define POWER_DOMAIN_SDCARD 0
+#define POWER_DOMAIN_USB 1
+#define POWER_DOMAIN_DSI 2
+
+#endif
diff --git a/include/soc/bcm2835/raspberrypi-mailbox-property.h b/include/soc/bcm2835/raspberrypi-mailbox-property.h
new file mode 100644
index 0000000..787bd75
--- /dev/null
+++ b/include/soc/bcm2835/raspberrypi-mailbox-property.h
@@ -0,0 +1,110 @@
+/*
+ *  Copyright ? 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+
+enum raspberrypi_firmware_property_status {
+	raspberrypi_firmware_status_request = 0,
+	raspberrypi_firmware_status_success = 0x80000000,
+	raspberrypi_firmware_status_error =   0x80000001,
+};
+
+struct raspberrypi_firmware_property_tag_header {
+	/* One of enum_mbox_property_tag. */
+	u32 tag;
+
+	/* The number of bytes in the value buffer following this
+	 * struct.
+	 */
+	u32 buf_size;
+
+	/*
+	 * On submit, the length of the request (though it doesn't
+	 * appear to be currently used by the firmware).  On return,
+	 * the length of the response (always 4 byte aligned), with
+	 * the low bit set.
+	 */
+	u32 req_resp_size;
+};
+
+enum raspberrypi_firmware_property_tag {
+	raspberrypi_firmware_property_end = 0,
+	raspberrypi_firmware_get_firmware_revision =                  0x00000001,
+
+	raspberrypi_firmware_set_cursor_info =                        0x00008010,
+	raspberrypi_firmware_set_cursor_state =                       0x00008011,
+
+	raspberrypi_firmware_get_board_model =                        0x00010001,
+	raspberrypi_firmware_get_board_revision =                     0x00010002,
+	raspberrypi_firmware_get_board_mac_address =                  0x00010003,
+	raspberrypi_firmware_get_board_serial =                       0x00010004,
+	raspberrypi_firmware_get_arm_memory =                         0x00010005,
+	raspberrypi_firmware_get_vc_memory =                          0x00010006,
+	raspberrypi_firmware_get_clocks =                             0x00010007,
+	raspberrypi_firmware_get_power_state =                        0x00020001,
+	raspberrypi_firmware_get_timing =                             0x00020002,
+	raspberrypi_firmware_set_power_state =                        0x00028001,
+	raspberrypi_firmware_get_clock_state =                        0x00030001,
+	raspberrypi_firmware_get_clock_rate =                         0x00030002,
+	raspberrypi_firmware_get_voltage =                            0x00030003,
+	raspberrypi_firmware_get_max_clock_rate =                     0x00030004,
+	raspberrypi_firmware_get_max_voltage =                        0x00030005,
+	raspberrypi_firmware_get_temperature =                        0x00030006,
+	raspberrypi_firmware_get_min_clock_rate =                     0x00030007,
+	raspberrypi_firmware_get_min_voltage =                        0x00030008,
+	raspberrypi_firmware_get_turbo =                              0x00030009,
+	raspberrypi_firmware_get_max_temperature =                    0x0003000a,
+	raspberrypi_firmware_allocate_memory =                        0x0003000c,
+	raspberrypi_firmware_lock_memory =                            0x0003000d,
+	raspberrypi_firmware_unlock_memory =                          0x0003000e,
+	raspberrypi_firmware_release_memory =                         0x0003000f,
+	raspberrypi_firmware_execute_code =                           0x00030010,
+	raspberrypi_firmware_execute_qpu =                            0x00030011,
+	raspberrypi_firmware_set_enable_qpu =                         0x00030012,
+	raspberrypi_firmware_get_dispmanx_resource_mem_handle =       0x00030014,
+	raspberrypi_firmware_get_edid_block =                         0x00030020,
+	raspberrypi_firmware_set_clock_state =                        0x00038001,
+	raspberrypi_firmware_set_clock_rate =                         0x00038002,
+	raspberrypi_firmware_set_voltage =                            0x00038003,
+	raspberrypi_firmware_set_turbo =                              0x00038009,
+
+	/* Dispmanx tags */
+	raspberrypi_firmware_framebuffer_allocate =                   0x00040001,
+	raspberrypi_firmware_framebuffer_blank =                      0x00040002,
+	raspberrypi_firmware_framebuffer_get_physical_width_height =  0x00040003,
+	raspberrypi_firmware_framebuffer_get_virtual_width_height =   0x00040004,
+	raspberrypi_firmware_framebuffer_get_depth =                  0x00040005,
+	raspberrypi_firmware_framebuffer_get_pixel_order =            0x00040006,
+	raspberrypi_firmware_framebuffer_get_alpha_mode =             0x00040007,
+	raspberrypi_firmware_framebuffer_get_pitch =                  0x00040008,
+	raspberrypi_firmware_framebuffer_get_virtual_offset =         0x00040009,
+	raspberrypi_firmware_framebuffer_get_overscan =               0x0004000a,
+	raspberrypi_firmware_framebuffer_get_palette =                0x0004000b,
+	raspberrypi_firmware_framebuffer_release =                    0x00048001,
+	raspberrypi_firmware_framebuffer_test_physical_width_height = 0x00044003,
+	raspberrypi_firmware_framebuffer_test_virtual_width_height =  0x00044004,
+	raspberrypi_firmware_framebuffer_test_depth =                 0x00044005,
+	raspberrypi_firmware_framebuffer_test_pixel_order =           0x00044006,
+	raspberrypi_firmware_framebuffer_test_alpha_mode =            0x00044007,
+	raspberrypi_firmware_framebuffer_test_virtual_offset =        0x00044009,
+	raspberrypi_firmware_framebuffer_test_overscan =              0x0004400a,
+	raspberrypi_firmware_framebuffer_test_palette =               0x0004400b,
+	raspberrypi_firmware_framebuffer_set_physical_width_height =  0x00048003,
+	raspberrypi_firmware_framebuffer_set_virtual_width_height =   0x00048004,
+	raspberrypi_firmware_framebuffer_set_depth =                  0x00048005,
+	raspberrypi_firmware_framebuffer_set_pixel_order =            0x00048006,
+	raspberrypi_firmware_framebuffer_set_alpha_mode =             0x00048007,
+	raspberrypi_firmware_framebuffer_set_virtual_offset =         0x00048009,
+	raspberrypi_firmware_framebuffer_set_overscan =               0x0004800a,
+	raspberrypi_firmware_framebuffer_set_palette =                0x0004800b,
+
+	raspberrypi_firmware_get_command_line =                       0x00050001,
+	raspberrypi_firmware_get_dma_channels =                       0x00060001,
+};
+
+int raspberrypi_firmware_property(void *data, size_t tag_size);
-- 
2.1.4
