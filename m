From: eyalr@ti.com (Reizer, Eyal)
Date: Wed, 23 Dec 2015 11:38:29 +0000
Subject: [PATCH 1/3] ti-st: use device handles and add device tree binding
In-Reply-To: <1450870253-8694-1-git-send-email-eyalr@ti.com>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B23759A5B@DFRE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add support for getting the platform data which includes the uart
  used and gpio pin used for enable from device tree.

- Fix the implementation for using device handle for the uart and
  gpiod for the enable pin, instead of device name (as string) used
  for the uart and pio number which are both bad practice.

Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
 Documentation/devicetree/bindings/misc/ti-st.txt |   42 ++++++
 arch/arm/mach-omap2/pdata-quirks.c               |   16 ++-
 drivers/misc/ti-st/st_kim.c                      |  159 ++++++++++++++++------
 drivers/misc/ti-st/st_ll.c                       |   16 ++-
 include/linux/ti_wilink_st.h                     |   13 +-
 5 files changed, 190 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/ti-st.txt

diff --git a/Documentation/devicetree/bindings/misc/ti-st.txt b/Documentation/devicetree/bindings/misc/ti-st.txt
new file mode 100644
index 0000000..4490da6
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ti-st.txt
@@ -0,0 +1,42 @@
+TI Wilink 6/7/8 (wl12xx/wl18xx) Shared transport driver
+
+TI?s Wireless Connectivity chips support Bluetooth (BT), WiFi, and GPS
+technology cores in a single die.
+
+Such a multi-core combo chip will be interfaced to the application processor
+using a single physical port (like UART).
+
+Shared Transport (ST) software enables BT and GPS protocols or software
+components to interact with their respective cores over single physical port.
+ST uses logical channels, over physical transport, to communicate with
+individual cores.
+
+Logical channels 1, 2, 3, and 4 are used for BT packets, channel 8 for FM,
+channel 9 for GPS and channels 30, 31, 32, and 33 are used for Chip Power
+Management (PM).
+
+This node provides properties for passing parameters to the ti shared
+transport driver.
+
+Required properties:
+ - compatible: should be the following:
+    * "kim" - ti-st parameters
+
+Optional properties:
+ - nshutdown-gpios : specifies attributes for gpio ping used for enabling
+	the bluetooth,gps and FM sub systems
+ - serial-device : the phandle for the phisical uart used for interacting
+ 	with the wilink device
+ - flow_cntrl : Indicates if uart flow control is used
+ - flow_cntrl : uart baud rate in BPS
+
+Example:
+
+kim {
+	compatible = "kim";
+	nshutdown-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+	serial-device = <&uart1>;
+	flow_cntrl = <1>;
+	flow_cntrl = <3000000>;
+};
+
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 5814477..b516fdc 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/davinci_emac.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
@@ -135,11 +136,18 @@ static void __init omap3_sbc_t3530_legacy_init(void)
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 }
 
+struct gpiod_lookup_table bt_gpios_table = {
+	.dev_id = "kim",
+		.table = {
+		GPIO_LOOKUP("gpio4", 9, "nshutdown", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct ti_st_plat_data wilink_pdata = {
-	.nshutdown_gpio = 137,
-	.dev_name = "/dev/ttyO1",
+	.dev_addr = 0x48022000, /* uart1 */
 	.flow_cntrl = 1,
-	.baud_rate = 300000,
+	.baud_rate = 3000000,
 };
 
 static struct platform_device wl18xx_device = {
@@ -157,12 +165,14 @@ static struct platform_device btwilink_device = {
 
 static void __init omap3_igep0020_rev_f_legacy_init(void)
 {
+	gpiod_add_lookup_table(&bt_gpios_table);
 	platform_device_register(&wl18xx_device);
 	platform_device_register(&btwilink_device);
 }
 
 static void __init omap3_igep0030_rev_g_legacy_init(void)
 {
+	gpiod_add_lookup_table(&bt_gpios_table);
 	platform_device_register(&wl18xx_device);
 	platform_device_register(&btwilink_device);
 }
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 71b6455..61d4f054 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -36,6 +36,8 @@
 #include <linux/skbuff.h>
 #include <linux/ti_wilink_st.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #define MAX_ST_DEVICES	3	/* Imagine 1 on each UART for now */
 static struct platform_device *st_kim_devices[MAX_ST_DEVICES];
@@ -43,6 +45,9 @@ static struct platform_device *st_kim_devices[MAX_ST_DEVICES];
 /**********************************************************************/
 /* internal functions */
 
+struct ti_st_plat_data	*dt_pdata;
+static struct ti_st_plat_data *get_platform_data(struct device *dev);
+
 /**
  * st_get_plat_device -
  *	function which returns the reference to the platform device
@@ -464,7 +469,12 @@ long st_kim_start(void *kim_data)
 	struct kim_data_s	*kim_gdata = (struct kim_data_s *)kim_data;
 
 	pr_info(" %s", __func__);
-	pdata = kim_gdata->kim_pdev->dev.platform_data;
+	if (kim_gdata->kim_pdev->dev.of_node) {
+		pr_debug("use device tree data");
+		pdata = dt_pdata;
+	} else {
+		pdata = kim_gdata->kim_pdev->dev.platform_data;
+	}
 
 	do {
 		/* platform specific enabling code here */
@@ -472,9 +482,9 @@ long st_kim_start(void *kim_data)
 			pdata->chip_enable(kim_gdata);
 
 		/* Configure BT nShutdown to HIGH state */
-		gpio_set_value_cansleep(kim_gdata->nshutdown, GPIO_LOW);
+		gpiod_set_value_cansleep(kim_gdata->nshutdown, GPIO_LOW);
 		mdelay(5);	/* FIXME: a proper toggle */
-		gpio_set_value_cansleep(kim_gdata->nshutdown, GPIO_HIGH);
+		gpiod_set_value_cansleep(kim_gdata->nshutdown, GPIO_HIGH);
 		mdelay(100);
 		/* re-initialize the completion */
 		reinit_completion(&kim_gdata->ldisc_installed);
@@ -524,11 +534,15 @@ long st_kim_stop(void *kim_data)
 {
 	long err = 0;
 	struct kim_data_s	*kim_gdata = (struct kim_data_s *)kim_data;
-	struct ti_st_plat_data	*pdata =
-		kim_gdata->kim_pdev->dev.platform_data;
+	struct ti_st_plat_data	*pdata;
 	struct tty_struct	*tty = kim_gdata->core_data->tty;
 
 	reinit_completion(&kim_gdata->ldisc_installed);
+	if (kim_gdata->kim_pdev->dev.of_node) {
+		pr_debug("use device tree data");
+		pdata = dt_pdata;
+	} else
+		pdata = kim_gdata->kim_pdev->dev.platform_data;
 
 	if (tty) {	/* can be called before ldisc is installed */
 		/* Flush any pending characters in the driver and discipline. */
@@ -550,11 +564,11 @@ long st_kim_stop(void *kim_data)
 	}
 
 	/* By default configure BT nShutdown to LOW state */
-	gpio_set_value_cansleep(kim_gdata->nshutdown, GPIO_LOW);
+	gpiod_set_value_cansleep(kim_gdata->nshutdown, GPIO_LOW);
 	mdelay(1);
-	gpio_set_value_cansleep(kim_gdata->nshutdown, GPIO_HIGH);
+	gpiod_set_value_cansleep(kim_gdata->nshutdown, GPIO_HIGH);
 	mdelay(1);
-	gpio_set_value_cansleep(kim_gdata->nshutdown, GPIO_LOW);
+	gpiod_set_value_cansleep(kim_gdata->nshutdown, GPIO_LOW);
 
 	/* platform specific disable */
 	if (pdata->chip_disable)
@@ -590,32 +604,43 @@ static ssize_t show_install(struct device *dev,
 }
 
 #ifdef DEBUG
-static ssize_t store_dev_name(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t store_dev_addr(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
+	int rc;
+
 	struct kim_data_s *kim_data = dev_get_drvdata(dev);
-	pr_debug("storing dev name >%s<", buf);
-	strncpy(kim_data->dev_name, buf, count);
-	pr_debug("stored dev name >%s<", kim_data->dev_name);
+	pr_debug("storing dev address >%s<", buf);
+	rc = kstrtou32(buf, 0, &kim_data->dev_addr);
+	if (rc)
+		return rc;
+
+	pr_debug("stored dev address >%x<", kim_data->dev_addr);
 	return count;
 }
 
 static ssize_t store_baud_rate(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
+	int rc;
+
 	struct kim_data_s *kim_data = dev_get_drvdata(dev);
 	pr_debug("storing baud rate >%s<", buf);
-	sscanf(buf, "%ld", &kim_data->baud_rate);
-	pr_debug("stored baud rate >%ld<", kim_data->baud_rate);
+	rc = kstrtou32(buf, 0, &kim_data->baud_rate);
+	if (rc)
+		return rc;
+
+	pr_debug("stored baud rate >%x<", kim_data->baud_rate);
 	return count;
 }
 #endif	/* if DEBUG */
 
-static ssize_t show_dev_name(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t show_dev_addr(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct kim_data_s *kim_data = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", kim_data->dev_name);
+	return sprintf(buf, "%x\n", kim_data->dev_addr);
 }
 
 static ssize_t show_baud_rate(struct device *dev,
@@ -636,11 +661,11 @@ static ssize_t show_flow_cntrl(struct device *dev,
 static struct kobj_attribute ldisc_install =
 __ATTR(install, 0444, (void *)show_install, NULL);
 
-static struct kobj_attribute uart_dev_name =
+static struct kobj_attribute uart_dev_addr =
 #ifdef DEBUG	/* TODO: move this to debug-fs if possible */
-__ATTR(dev_name, 0644, (void *)show_dev_name, (void *)store_dev_name);
+__ATTR(dev_addr, 0644, (void *)show_dev_addr, (void *)store_dev_addr);
 #else
-__ATTR(dev_name, 0444, (void *)show_dev_name, NULL);
+__ATTR(dev_addr, 0444, (void *)show_dev_addr, NULL);
 #endif
 
 static struct kobj_attribute uart_baud_rate =
@@ -655,7 +680,7 @@ __ATTR(flow_cntrl, 0444, (void *)show_flow_cntrl, NULL);
 
 static struct attribute *uim_attrs[] = {
 	&ldisc_install.attr,
-	&uart_dev_name.attr,
+	&uart_dev_addr.attr,
 	&uart_baud_rate.attr,
 	&uart_flow_cntrl.attr,
 	NULL,
@@ -721,13 +746,54 @@ static const struct file_operations list_debugfs_fops = {
  * board-*.c file
  */
 
+static const struct of_device_id kim_of_match[] = {
+{
+	.compatible = "kim",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, kim_of_match);
+
+static struct ti_st_plat_data *get_platform_data(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *serial_node;
+
+	dt_pdata = kzalloc(sizeof(*dt_pdata), GFP_KERNEL);
+	if (!dt_pdata)
+		return NULL;
+
+	serial_node = of_parse_phandle(np, "serial-device", 0);
+	if (serial_node) {
+		pr_info("using serial device %s\n", serial_node->full_name);
+		of_property_read_u32(serial_node, "reg", &dt_pdata->dev_addr);
+	} else {
+		dev_err(dev, "Serial device missing");
+	}
+
+	of_property_read_u32(np, "flow_cntrl", &dt_pdata->flow_cntrl);
+	of_property_read_u32(np, "baud_rate", &dt_pdata->baud_rate);
+
+	return dt_pdata;
+}
+
 static struct dentry *kim_debugfs_dir;
 static int kim_probe(struct platform_device *pdev)
 {
 	struct kim_data_s	*kim_gdata;
-	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
+	struct ti_st_plat_data	*pdata;
 	int err;
 
+	if (pdev->dev.of_node)
+		pdata = get_platform_data(&pdev->dev);
+	else
+		pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Platform Data is missing\n");
+		return -ENXIO;
+	}
+
 	if ((pdev->id != -1) && (pdev->id < MAX_ST_DEVICES)) {
 		/* multiple devices could exist */
 		st_kim_devices[pdev->id] = pdev;
@@ -735,7 +801,6 @@ static int kim_probe(struct platform_device *pdev)
 		/* platform's sure about existence of 1 device */
 		st_kim_devices[0] = pdev;
 	}
-
 	kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_ATOMIC);
 	if (!kim_gdata) {
 		pr_err("no mem to allocate");
@@ -753,19 +818,14 @@ static int kim_probe(struct platform_device *pdev)
 	kim_gdata->core_data->kim_data = kim_gdata;
 
 	/* Claim the chip enable nShutdown gpio from the system */
-	kim_gdata->nshutdown = pdata->nshutdown_gpio;
-	err = gpio_request(kim_gdata->nshutdown, "kim");
-	if (unlikely(err)) {
-		pr_err(" gpio %d request failed ", kim_gdata->nshutdown);
-		return err;
+	kim_gdata->nshutdown = devm_gpiod_get(&pdev->dev, "nshutdown",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(kim_gdata->nshutdown)) {
+		err = PTR_ERR(kim_gdata->nshutdown);
+		dev_err(&pdev->dev, "unable to claim gpio \"nshutdown\"\n");
+		goto err_core_init;
 	}
 
-	/* Configure nShutdown GPIO as output=0 */
-	err = gpio_direction_output(kim_gdata->nshutdown, 0);
-	if (unlikely(err)) {
-		pr_err(" unable to configure gpio %d", kim_gdata->nshutdown);
-		return err;
-	}
 	/* get reference of pdev for request_firmware
 	 */
 	kim_gdata->kim_pdev = pdev;
@@ -779,7 +839,7 @@ static int kim_probe(struct platform_device *pdev)
 	}
 
 	/* copying platform data */
-	strncpy(kim_gdata->dev_name, pdata->dev_name, UART_DEV_NAME_LEN);
+	kim_gdata->dev_addr = pdata->dev_addr;
 	kim_gdata->flow_cntrl = pdata->flow_cntrl;
 	kim_gdata->baud_rate = pdata->baud_rate;
 	pr_info("sysfs entries created\n");
@@ -808,16 +868,17 @@ err_core_init:
 static int kim_remove(struct platform_device *pdev)
 {
 	/* free the GPIOs requested */
-	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
+	struct ti_st_plat_data	*pdata;
 	struct kim_data_s	*kim_gdata;
 
-	kim_gdata = platform_get_drvdata(pdev);
+	if (pdev->dev.of_node) {
+		pr_debug("use device tree data");
+		pdata = dt_pdata;
+	} else {
+		pdata = pdev->dev.platform_data;
+	}
 
-	/* Free the Bluetooth/FM/GPIO
-	 * nShutdown gpio from the system
-	 */
-	gpio_free(pdata->nshutdown_gpio);
-	pr_info("nshutdown GPIO Freed");
+	kim_gdata = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(kim_debugfs_dir);
 	sysfs_remove_group(&pdev->dev.kobj, &uim_attr_grp);
@@ -828,12 +889,21 @@ static int kim_remove(struct platform_device *pdev)
 
 	kfree(kim_gdata);
 	kim_gdata = NULL;
+	kfree(dt_pdata);
+	dt_pdata = NULL;
 	return 0;
 }
 
 static int kim_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
+	struct ti_st_plat_data	*pdata;
+
+	if (pdev->dev.of_node) {
+		pr_debug("use device tree data");
+		pdata = dt_pdata;
+	} else {
+		pdata = pdev->dev.platform_data;
+	}
 
 	if (pdata->suspend)
 		return pdata->suspend(pdev, state);
@@ -860,6 +930,7 @@ static struct platform_driver kim_platform_driver = {
 	.resume = kim_resume,
 	.driver = {
 		.name = "kim",
+		.of_match_table = of_match_ptr(kim_of_match),
 	},
 };
 
diff --git a/drivers/misc/ti-st/st_ll.c b/drivers/misc/ti-st/st_ll.c
index 93b4d67..d68b427 100644
--- a/drivers/misc/ti-st/st_ll.c
+++ b/drivers/misc/ti-st/st_ll.c
@@ -53,7 +53,13 @@ static void ll_device_want_to_sleep(struct st_data_s *st_data)
 
 	/* communicate to platform about chip asleep */
 	kim_data = st_data->kim_data;
-	pdata = kim_data->kim_pdev->dev.platform_data;
+	if (kim_data->kim_pdev->dev.of_node) {
+		pr_debug("use device tree data");
+		pdata = dt_pdata;
+	} else {
+		pdata = kim_data->kim_pdev->dev.platform_data;
+	}
+
 	if (pdata->chip_asleep)
 		pdata->chip_asleep(NULL);
 }
@@ -86,7 +92,13 @@ static void ll_device_want_to_wakeup(struct st_data_s *st_data)
 
 	/* communicate to platform about chip wakeup */
 	kim_data = st_data->kim_data;
-	pdata = kim_data->kim_pdev->dev.platform_data;
+	if (kim_data->kim_pdev->dev.of_node) {
+		pr_debug("use device tree data");
+		pdata = dt_pdata;
+	} else {
+		pdata = kim_data->kim_pdev->dev.platform_data;
+	}
+
 	if (pdata->chip_awake)
 		pdata->chip_awake(NULL);
 }
diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index 0a0d568..e01e530 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -86,6 +86,7 @@ struct st_proto_s {
 extern long st_register(struct st_proto_s *);
 extern long st_unregister(struct st_proto_s *);
 
+extern struct ti_st_plat_data   *dt_pdata;
 
 /*
  * header information used by st_core.c
@@ -206,7 +207,7 @@ void gps_chrdrv_stub_init(void);
 /* time in msec to wait for
  * line discipline to be installed
  */
-#define LDISC_TIME	1000
+#define LDISC_TIME	1500
 #define CMD_RESP_TIME	800
 #define CMD_WR_TIME	5000
 #define MAKEWORD(a, b)  ((unsigned short)(((unsigned char)(a)) \
@@ -231,7 +232,6 @@ struct chip_version {
 	unsigned short maj_ver;
 };
 
-#define UART_DEV_NAME_LEN 32
 /**
  * struct kim_data_s - the KIM internal data, embedded as the
  *	platform's drv data. One for each ST device in the system.
@@ -262,14 +262,14 @@ struct kim_data_s {
 	struct completion kim_rcvd, ldisc_installed;
 	char resp_buffer[30];
 	const struct firmware *fw_entry;
-	unsigned nshutdown;
+	struct gpio_desc *nshutdown;
 	unsigned long rx_state;
 	unsigned long rx_count;
 	struct sk_buff *rx_skb;
 	struct st_data_s *core_data;
 	struct chip_version version;
 	unsigned char ldisc_install;
-	unsigned char dev_name[UART_DEV_NAME_LEN + 1];
+	unsigned dev_addr;
 	unsigned flow_cntrl;
 	unsigned baud_rate;
 };
@@ -418,7 +418,7 @@ struct gps_event_hdr {
  * struct ti_st_plat_data - platform data shared between ST driver and
  *	platform specific board file which adds the ST device.
  * @nshutdown_gpio: Host's GPIO line to which chip's BT_EN is connected.
- * @dev_name: The UART/TTY name to which chip is interfaced. (eg: /dev/ttyS1)
+ * @dev_addr: Memory address of UART peripheral to which chip is interfaced
  * @flow_cntrl: Should always be 1, since UART's CTS/RTS is used for PM
  *	purposes.
  * @baud_rate: The baud rate supported by the Host UART controller, this will
@@ -437,8 +437,7 @@ struct gps_event_hdr {
  *
  */
 struct ti_st_plat_data {
-	u32 nshutdown_gpio;
-	unsigned char dev_name[UART_DEV_NAME_LEN]; /* uart name */
+	u32 dev_addr; /* uart address */
 	u32 flow_cntrl; /* flow control flag */
 	u32 baud_rate;
 	int (*suspend)(struct platform_device *, pm_message_t);
-- 
1.7.9.5
