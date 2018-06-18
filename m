From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jun 2018 09:45:55 +0200
Subject: [PATCH 4/5] RFC: bus: 96boards Low-Speed Connector
In-Reply-To: <20180618074556.6944-1-linus.walleij@linaro.org>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
Message-ID: <20180618074556.6944-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This illustrates my idea for using a small connector driver to
plug in "mezzanine boards" on the 96boards low-speed connector.

These "mezzanine boards" are no different than "capes", "logic
modules", etc. This thing, a non-discoverable connector where
a user can plug in a few peripherals has been reinvented a few
times.

As a proof-of-concept we add the Secure96, a quite minimal
mezzanine board.

Users can register their boards in a simple way. Either just
add their compatible-string in the device tree:

board {
        compatible = "96boards,secure96";
};

And if they can't even change three lines in their device tree,
or if they at runtime decide to plug in some board and test it,
they can use sysfs, as exemplified by plugging in the secure96
security board at runtime:

> cd /sys/devices/platform/connector
> echo 1 > secure96
[   61.014629] lscon connector: called mezzanine_store on secure96
[   61.020530] lscon connector: populate secure96
[   61.027081] at24 1-0050: 2048 byte 24c128 EEPROM, writable, 128 bytes/write
[   61.053569] atmel-ecc 1-0060: configuration zone is unlocked
[   61.502535] tpm_tis_spi spi0.0: 2.0 TPM (device-id 0x1B, rev-id 16)
(...)

The plug-in board can be removed from sysfs and added back
again multiple times like this with the devices being runtime
added and removed by two writes to sysfs.

> echo 0 > secure96
> echo 1 > secure96
> echo 0 > secure96
(...)

I certainly see some scalability problems with this particular
code for example, but the fact is: it pretty much works. The
devices need hooks in I2C and SPI, and need to be able to accept
initialized GPIO descriptors passed in as platform data.

Any discussions related to the concept compared to doing
device tree overlays/fragments etc: please discuss in patch
0 (the cover letter).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../96boards-ls-connector.c                   | 307 ++++++++++++++++++
 .../96boards-mezzanines/96boards-mezzanines.h |  46 +++
 .../96boards-mezzanines/96boards-secure96.c   | 249 ++++++++++++++
 drivers/bus/96boards-mezzanines/Kconfig       |  36 ++
 drivers/bus/96boards-mezzanines/Makefile      |   6 +
 drivers/bus/Kconfig                           |   2 +
 drivers/bus/Makefile                          |   4 +-
 7 files changed, 649 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/96boards-mezzanines/96boards-ls-connector.c
 create mode 100644 drivers/bus/96boards-mezzanines/96boards-mezzanines.h
 create mode 100644 drivers/bus/96boards-mezzanines/96boards-secure96.c
 create mode 100644 drivers/bus/96boards-mezzanines/Kconfig
 create mode 100644 drivers/bus/96boards-mezzanines/Makefile

diff --git a/drivers/bus/96boards-mezzanines/96boards-ls-connector.c b/drivers/bus/96boards-mezzanines/96boards-ls-connector.c
new file mode 100644
index 000000000000..1a012b0cd457
--- /dev/null
+++ b/drivers/bus/96boards-mezzanines/96boards-ls-connector.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 96boards Low-speed Connector driver
+ * (C) 2018 Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#include <linux/init.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include "96boards-mezzanines.h"
+
+/**
+ * struct mezzanine - daughter boards (mezzanines) data
+ * Having dynamic data here means that we can only plug ONE board
+ * of each type. Stacking two different boards is fine. This
+ * should be fixed using a linked list of mezzanines if we
+ * go for this solution.
+ */
+struct mezzanine {
+	const char *compatible;
+	const char *sysfs_name;
+	struct dev_ext_attribute ext_attr;
+	void * (*populate) (struct lscon *ls);
+	void (*depopulate) (void *data);
+	void *data;
+};
+
+static struct mezzanine mezzanines[] = {
+#if IS_ENABLED(96BOARDS_SECURE96)
+	{
+		.compatible = "96boards,secure96",
+		.sysfs_name = "secure96",
+		.populate = secure96_populate,
+		.depopulate = secure96_depopulate,
+	},
+#endif
+	/* Add any other mezzanines here */
+};
+
+struct gpio_desc *mezzanine_ls_get_gpiod(struct lscon *ls,
+					 enum mezzanine_ls_gpio pin,
+					 const char *consumer_name,
+					 enum gpiod_flags flags)
+{
+	struct gpio_desc *retdesc;
+
+	/*
+	 * TODO: get all the LS GPIOs as an array on probe() then
+	 * the consumers can skip error handling of IS_ERR() descriptors
+	 * and this need only set the consumer name.
+	 */
+	retdesc = devm_gpiod_get_index(ls->dev, NULL, pin, flags);
+	if (!IS_ERR(retdesc) && consumer_name)
+		gpiod_set_consumer_name(retdesc, consumer_name);
+
+	return retdesc;
+}
+EXPORT_SYMBOL_GPL(mezzanine_ls_get_gpiod);
+
+/*
+ * Mezzanine boards will call this to orderly remove their claimed
+ * gpio descriptors, since we acquired them all with devm_gpiod_get()
+ * they will eventually be released once this connector device
+ * disappears if the board do not release them in order.
+ */
+void mezzanine_ls_put_gpiod(struct lscon *ls, struct gpio_desc *gpiod)
+{
+	devm_gpiod_put(ls->dev, gpiod);
+}
+EXPORT_SYMBOL_GPL(mezzanine_ls_put_gpiod);
+
+static ssize_t mezzanine_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct lscon *ls = dev_get_drvdata(dev);
+	struct dev_ext_attribute *d = container_of(attr,
+						   struct dev_ext_attribute,
+						   attr);
+	struct mezzanine *mez = d->var;
+
+	dev_info(ls->dev, "called %s on %s\n", __func__, mez->sysfs_name);
+	return 0;
+}
+
+static ssize_t mezzanine_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct lscon *ls = dev_get_drvdata(dev);
+	struct dev_ext_attribute *d = container_of(attr,
+						   struct dev_ext_attribute,
+						   attr);
+	struct mezzanine *mez = d->var;
+	unsigned long state;
+	int ret;
+
+	dev_info(ls->dev, "called %s on %s\n", __func__, mez->sysfs_name);
+
+	ret = kstrtoul(buf, 0, &state);
+	if (ret)
+		return ret;
+
+	if (state == 1) {
+		void *data;
+
+		/* Already populated */
+		if (mez->data)
+			return count;
+
+		data = mez->populate(ls);
+		if (IS_ERR(data))
+			return PTR_ERR(data);
+		mez->data = data;
+		return count;
+	}
+
+	if (state == 0) {
+		/* Not populated so nothing to do here */
+		if (!mez->data)
+			return count;
+		mez->depopulate(mez->data);
+		mez->data = NULL;
+		return count;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * This adds one sysfs file per mezzanine board that we support, so they
+ * can be probed and added from userspace.
+ */
+static int lscon_add_sysfs_mezzanines(struct lscon *ls)
+{
+	struct mezzanine *mez;
+	struct dev_ext_attribute *ext_attr;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mezzanines); i++) {
+		mez = &mezzanines[i];
+		ext_attr = &mez->ext_attr;
+
+		ext_attr->var = mez;
+		ext_attr->attr.attr.name = mez->sysfs_name;
+		ext_attr->attr.attr.mode = VERIFY_OCTAL_PERMISSIONS(0644);
+		ext_attr->attr.show = mezzanine_show;
+		ext_attr->attr.store = mezzanine_store;
+		ret = device_create_file(ls->dev, &ext_attr->attr);
+		if (ret)
+			dev_err(ls->dev, "unable to create sysfs entries\n");
+
+	}
+
+	return 0;
+}
+
+static int lscon_probe_of_mezzanine(struct lscon *ls, struct device_node *np)
+{
+	struct mezzanine *mez;
+	void *data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mezzanines); i++) {
+		mez = &mezzanines[i];
+		if (of_device_is_compatible(np, mez->compatible)) {
+			dev_info(ls->dev, "found %s\n", mez->compatible);
+			data = mez->populate(ls);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
+			mez->data = data;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+static int lscon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	struct spi_controller *spi;
+	struct mezzanine *mez;
+	struct lscon *ls;
+	int ret;
+	int i;
+
+	ls = devm_kzalloc(dev, sizeof(*ls), GFP_KERNEL);
+	if (!ls)
+		return -ENOMEM;
+	ls->dev = dev;
+
+	/* Bridge I2C busses */
+	child = of_parse_phandle(np, "i2c0", 0);
+	if (!child) {
+		dev_err(dev, "no i2c0 phandle\n");
+		return -ENODEV;
+	}
+	ls->i2c0 = of_get_i2c_adapter_by_node(child);
+	if (!ls->i2c0) {
+		dev_err(dev, "no i2c0 adapter, deferring\n");
+		return -EPROBE_DEFER;
+	}
+
+	child = of_parse_phandle(np, "i2c1", 0);
+	if (!child) {
+		dev_err(dev, "no i2c1 phandle\n");
+		ret = -ENODEV;
+		goto out_put_i2c0;
+	}
+	ls->i2c1 = of_get_i2c_adapter_by_node(child);
+	if (!ls->i2c1) {
+		dev_err(dev, "no i2c0 adapter, deferring\n");
+		ret = -EPROBE_DEFER;
+		goto out_put_i2c0;
+	}
+
+	/* Bride SPI bus */
+	child = of_parse_phandle(np, "spi", 0);
+	if (!child) {
+		dev_err(dev, "no spi phandle\n");
+		ret = -ENODEV;
+		goto out_put_i2c1;
+	}
+	spi = of_find_spi_controller_by_node(child);
+	if (!spi) {
+		dev_err(dev, "no spi controller, deferring\n");
+		ret = -EPROBE_DEFER;
+		goto out_put_i2c1;
+	}
+	ls->spi = spi_controller_get(spi);
+	if (!ls->spi) {
+		dev_err(dev, "no spi reference\n");
+		ret = -ENODEV;
+		goto out_put_i2c1;
+	}
+
+	platform_set_drvdata(pdev, ls);
+
+	/* Get the mezzanine boards, stacking possible */
+	for_each_available_child_of_node(np, child)
+		lscon_probe_of_mezzanine(ls, child);
+
+	ret = lscon_add_sysfs_mezzanines(ls);
+	if (ret)
+		goto out_remove_mezzanines;
+
+	return 0;
+
+out_remove_mezzanines:
+	/* Depopulate any populated boards */
+	for (i = 0; i < ARRAY_SIZE(mezzanines); i++) {
+		mez = &mezzanines[i];
+		if (mez->data)
+			mez->depopulate(mez->data);
+		mez->data = NULL;
+	}
+out_put_i2c1:
+	i2c_put_adapter(ls->i2c1);
+out_put_i2c0:
+	i2c_put_adapter(ls->i2c0);
+	return ret;
+}
+
+static int lscon_remove(struct platform_device *pdev)
+{
+	struct lscon *ls = platform_get_drvdata(pdev);
+	struct mezzanine *mez;
+	int i;
+
+	/* Depopulate any populated boards */
+	for (i = 0; i < ARRAY_SIZE(mezzanines); i++) {
+		mez = &mezzanines[i];
+		if (mez->data)
+			mez->depopulate(mez->data);
+		mez->data = NULL;
+	}
+
+	spi_controller_put(ls->spi);
+	i2c_put_adapter(ls->i2c1);
+	i2c_put_adapter(ls->i2c0);
+
+	return 0;
+}
+
+static const struct of_device_id lscon_of_match[] = {
+	{
+		.compatible = "96boards,low-speed-connector",
+	},
+};
+
+static struct platform_driver lscon_driver = {
+	.driver = {
+		.name = "lscon",
+		.of_match_table = of_match_ptr(lscon_of_match),
+	},
+	.probe  = lscon_probe,
+	.remove = lscon_remove,
+};
+builtin_platform_driver(lscon_driver);
diff --git a/drivers/bus/96boards-mezzanines/96boards-mezzanines.h b/drivers/bus/96boards-mezzanines/96boards-mezzanines.h
new file mode 100644
index 000000000000..f6a460766ff3
--- /dev/null
+++ b/drivers/bus/96boards-mezzanines/96boards-mezzanines.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+
+/**
+ * enum mezzanine_ls_gpio - the GPIO lines on the low-speed connector
+ */
+enum mezzanine_ls_gpio {
+	MEZZANINE_LS_GPIO_A = 0,
+	MEZZANINE_LS_GPIO_B,
+	MEZZANINE_LS_GPIO_C,
+	MEZZANINE_LS_GPIO_D,
+	MEZZANINE_LS_GPIO_E,
+	MEZZANINE_LS_GPIO_F,
+	MEZZANINE_LS_GPIO_G,
+	MEZZANINE_LS_GPIO_H,
+	MEZZANINE_LS_GPIO_I,
+	MEZZANINE_LS_GPIO_J,
+	MEZZANINE_LS_GPIO_K,
+	MEZZANINE_LS_GPIO_L,
+};
+
+/**
+ * struct lscon - low speed connector state container
+ * @dev: containing device for this instance
+ */
+struct lscon {
+	struct device *dev;
+	struct i2c_adapter *i2c0;
+	struct i2c_adapter *i2c1;
+	struct spi_controller *spi;
+};
+
+struct gpio_desc *mezzanine_ls_get_gpiod(struct lscon *ls,
+					 enum mezzanine_ls_gpio pin,
+					 const char *consumer_name,
+					 enum gpiod_flags flags);
+void mezzanine_ls_put_gpiod(struct lscon *ls, struct gpio_desc *gpiod);
+
+#if IS_ENABLED(96BOARDS_SECURE96)
+void *secure96_populate(struct lscon *ls);
+void secure96_depopulate(void *data);
+#endif
+/* Add any other mezzanine population calls here */
diff --git a/drivers/bus/96boards-mezzanines/96boards-secure96.c b/drivers/bus/96boards-mezzanines/96boards-secure96.c
new file mode 100644
index 000000000000..6c44a699d2e0
--- /dev/null
+++ b/drivers/bus/96boards-mezzanines/96boards-secure96.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 96boards Secure96 mezzanine board driver
+ * (C) 2018 Linus Walleij <linus.walleij@linaro.org>
+ */
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <linux/sizes.h>
+#include <linux/platform_data/at24.h>
+#include <linux/delay.h>
+
+#include "96boards-mezzanines.h"
+
+struct secure96 {
+	struct device *dev;
+	struct lscon *ls;
+	struct platform_device *leds_device;
+	struct gpio_led *secure96_leds;
+	struct i2c_client *eeprom;
+	struct i2c_client *crypto;
+	struct i2c_client *hash;
+	struct gpio_desc *tpm_reset;
+	struct gpio_desc *tpm_irq;
+	struct spi_device *tpm;
+};
+
+struct secure96_ledinfo {
+	enum mezzanine_ls_gpio pin;
+	const char *ledname;
+};
+
+/*
+ * GPIO-F, G, H and I are connected to LEDs, two red and two green
+ */
+static const struct secure96_ledinfo ledinfos[] = {
+	{
+		.pin = MEZZANINE_LS_GPIO_F,
+		.ledname = "secure96:red:0",
+	},
+	{
+		.pin = MEZZANINE_LS_GPIO_G,
+		.ledname = "secure96:red:1",
+	},
+	{
+		.pin = MEZZANINE_LS_GPIO_H,
+		.ledname = "secure96:green:0",
+	},
+	{
+		.pin = MEZZANINE_LS_GPIO_I,
+		.ledname = "secure96:green:1",
+	},
+};
+
+/*
+ * The On Semiconductor CAT21M01 is 131072bits i.e. 16KB. This should be
+ * mostly compatible to 24c128 so we register that with special pdata so
+ * that we can fill in the GPIO descriptor for write protect.
+ */
+static struct at24_platform_data secure96_eeprom_pdata = {
+	.byte_len = SZ_16K / 8,
+	.page_size = 256,
+	.flags = AT24_FLAG_ADDR16,
+};
+
+static const struct i2c_board_info secure96_eeprom = {
+	I2C_BOARD_INFO("24c128", 0x50),
+	.platform_data  = &secure96_eeprom_pdata,
+};
+
+/* Crypto chip */
+static const struct i2c_board_info secure96_crypto = {
+	I2C_BOARD_INFO("atecc508a", 0x60),
+};
+
+/* SHA hash chip */
+static const struct i2c_board_info secure96_hash = {
+	I2C_BOARD_INFO("atsha204a", 0x64),
+};
+
+/* Infineon SLB9670 TPM 2.0 chip */
+static struct spi_board_info secure96_tpm = {
+	.modalias = "tpm_tis_spi",
+	/* The manual says 22.5MHz for 1.8V supply */
+	.max_speed_hz = 22500000,
+	.chip_select = 0,
+};
+
+void *secure96_populate(struct lscon *ls)
+{
+	struct device *dev = ls->dev;
+	struct secure96 *sec;
+	struct gpio_desc *gpiod;
+	struct gpio_led_platform_data secure96_leds_pdata;
+	int ret;
+	int i;
+
+	/* TODO: create a struct device for secure96? */
+
+	sec = devm_kzalloc(dev, sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return ERR_PTR(-ENOMEM);
+	sec->dev = dev;
+	sec->ls = ls;
+
+	sec->secure96_leds = devm_kzalloc(dev,
+			ARRAY_SIZE(ledinfos) * sizeof(*sec->secure96_leds),
+			GFP_KERNEL);
+	if (!sec->secure96_leds)
+		return ERR_PTR(-ENOMEM);
+
+	dev_info(ls->dev, "populate secure96\n");
+
+	/* Populate the four LEDs */
+	for (i = 0; i < ARRAY_SIZE(ledinfos); i++) {
+		const struct secure96_ledinfo *linfo;
+
+		linfo = &ledinfos[i];
+
+		gpiod = mezzanine_ls_get_gpiod(ls, linfo->pin, linfo->ledname,
+					       GPIOD_OUT_LOW);
+		if (IS_ERR(gpiod)) {
+			dev_err(dev, "failed to get GPIO line %d\n",
+				linfo->pin);
+			return ERR_PTR(-ENODEV);
+		}
+		sec->secure96_leds[i].gpiod = gpiod;
+		sec->secure96_leds[i].name = linfo->ledname;
+		/* Heartbeat on first LED */
+		if (i == 0)
+			sec->secure96_leds[i].default_trigger = "heartbeat";
+	}
+
+	secure96_leds_pdata.num_leds = ARRAY_SIZE(ledinfos);
+	secure96_leds_pdata.leds = sec->secure96_leds;
+
+	sec->leds_device = platform_device_register_data(dev,
+					"leds-gpio",
+					PLATFORM_DEVID_AUTO,
+					&secure96_leds_pdata,
+					sizeof(secure96_leds_pdata));
+	if (IS_ERR(sec->leds_device)) {
+		dev_err(dev, "failed to populate LEDs device\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	/* Populate the three I2C0 devices */
+	gpiod = mezzanine_ls_get_gpiod(ls, MEZZANINE_LS_GPIO_B, "cat21m01-wp",
+				       GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		dev_err(dev, "no CAT21M01 write-protect GPIO\n");
+	else
+		secure96_eeprom_pdata.wp_gpiod = gpiod;
+	sec->eeprom = i2c_new_device(ls->i2c0, &secure96_eeprom);
+	if (!sec->eeprom) {
+		dev_err(dev, "failed to populate EEPROM\n");
+		ret = -ENODEV;
+		goto out_unreg_leds;
+	}
+
+	sec->crypto = i2c_new_device(ls->i2c0, &secure96_crypto);
+	if (!sec->eeprom) {
+		dev_err(dev, "failed to populate crypto device\n");
+		ret = -ENODEV;
+		goto out_remove_eeprom;
+	}
+
+	sec->hash = i2c_new_device(ls->i2c0, &secure96_hash);
+	if (!sec->eeprom) {
+		dev_err(dev, "failed to populate hash device\n");
+		ret = -ENODEV;
+		goto out_remove_crypto;
+	}
+
+	/* Populate the SPI TPM device */
+	gpiod = mezzanine_ls_get_gpiod(ls, MEZZANINE_LS_GPIO_D,
+				       "tpm-slb9670-rst",
+				       GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		dev_err(dev, "failed to get TPM RESET\n");
+		ret = -ENODEV;
+		goto out_remove_hash;
+	}
+	udelay(80);
+	/* Deassert RST */
+	gpiod_set_value(gpiod, 1);
+	sec->tpm_reset = gpiod;
+
+	gpiod = mezzanine_ls_get_gpiod(ls, MEZZANINE_LS_GPIO_C,
+				       "tpm-slb9670-irq",
+				       GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		dev_err(dev, "failed to get TPM IRQ GPIO\n");
+		ret = -ENODEV;
+		goto out_remove_tpm_reset;
+	}
+	sec->tpm_irq = gpiod;
+	secure96_tpm.irq = gpiod_to_irq(gpiod);
+	sec->tpm = spi_new_device(ls->spi, &secure96_tpm);
+	if (!sec->tpm) {
+		dev_err(dev, "failed to populate TPM device\n");
+		ret = -ENODEV;
+		goto out_remove_tpm_irq;
+	}
+
+	return sec;
+
+out_remove_tpm_irq:
+	mezzanine_ls_put_gpiod(ls, sec->tpm_irq);
+out_remove_tpm_reset:
+	mezzanine_ls_put_gpiod(ls, sec->tpm_reset);
+out_remove_hash:
+	i2c_unregister_device(sec->hash);
+out_remove_crypto:
+	i2c_unregister_device(sec->crypto);
+out_remove_eeprom:
+	i2c_unregister_device(sec->eeprom);
+	if (secure96_eeprom_pdata.wp_gpiod)
+		mezzanine_ls_put_gpiod(ls, secure96_eeprom_pdata.wp_gpiod);
+out_unreg_leds:
+	platform_device_unregister(sec->leds_device);
+	for (i = 0; i < ARRAY_SIZE(ledinfos); i++) {
+		mezzanine_ls_put_gpiod(ls, sec->secure96_leds[i].gpiod);
+	};
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(secure96_populate);
+
+void secure96_depopulate(void *data)
+{
+	struct secure96 *sec = data;
+	int i;
+
+	spi_unregister_device(sec->tpm);
+	mezzanine_ls_put_gpiod(sec->ls, sec->tpm_irq);
+	mezzanine_ls_put_gpiod(sec->ls, sec->tpm_reset);
+	i2c_unregister_device(sec->hash);
+	i2c_unregister_device(sec->crypto);
+	i2c_unregister_device(sec->eeprom);
+	if (secure96_eeprom_pdata.wp_gpiod)
+		mezzanine_ls_put_gpiod(sec->ls, secure96_eeprom_pdata.wp_gpiod);
+	platform_device_unregister(sec->leds_device);
+	for (i = 0; i < ARRAY_SIZE(ledinfos); i++) {
+		mezzanine_ls_put_gpiod(sec->ls, sec->secure96_leds[i].gpiod);
+	};
+}
+EXPORT_SYMBOL_GPL(secure96_depopulate);
diff --git a/drivers/bus/96boards-mezzanines/Kconfig b/drivers/bus/96boards-mezzanines/Kconfig
new file mode 100644
index 000000000000..18f94e9ec0f8
--- /dev/null
+++ b/drivers/bus/96boards-mezzanines/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# 96boards mezzanine connectors and drivers
+
+menuconfig 96BOARDS_MEZZANINES
+	bool "96boards mezzanine boards"
+
+if 96BOARDS_MEZZANINES
+
+config 96BOARDS_LS_CONNECTOR
+	bool "96boards low speed connector driver"
+	depends on OF
+	depends on I2C
+	depends on SPI_MASTER
+	depends on GPIOLIB
+	help
+	 Driver for the 96boards low speed connector
+
+config 96BOARDS_SECURE96
+	bool "96boards Secure96 board driver"
+	depends on 96BOARDS_LS_CONNECTOR
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_GPIO
+	select EEPROM_AT24
+	select CRYPTO_HW
+	select CRYPTO_DEV_ATMEL_ECC
+	select HW_RANDOM
+	select TCG_TPM
+	select HW_RANDOM_TPM
+	select TCG_TIS
+	select TCG_TIS_SPI
+	help
+	 Driver for the 96boards Secure96 mezzanine
+
+endif
diff --git a/drivers/bus/96boards-mezzanines/Makefile b/drivers/bus/96boards-mezzanines/Makefile
new file mode 100644
index 000000000000..a6e1f3507672
--- /dev/null
+++ b/drivers/bus/96boards-mezzanines/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the 96boards mezzanines
+#
+obj-$(CONFIG_96BOARDS_LS_CONNECTOR)	+= 96boards-ls-connector.o
+obj-$(CONFIG_96BOARDS_SECURE96)		+= 96boards-secure96.o
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d1c0b60e9326..46f7785f27e9 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -173,4 +173,6 @@ config DA8XX_MSTPRI
 
 source "drivers/bus/fsl-mc/Kconfig"
 
+source "drivers/bus/96boards-mezzanines/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index b8f036cca7ff..f6d080a63bd7 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -29,5 +29,7 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
-
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
+
+# 96boards mezzanines
+obj-$(CONFIG_96BOARDS_MEZZANINES)	+= 96boards-mezzanines/
-- 
2.17.0
