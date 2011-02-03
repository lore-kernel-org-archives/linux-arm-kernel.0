From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 3 Feb 2011 10:11:19 +0100
Subject: [PATCH] u300: use mmci driver for GPIO card detect
Message-ID: <1296724279-7064-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmci driver can handle a GPIO pin for card detect, using
IRQs and all just fine, so switch to using that. Delete the
old bogus input device hack, if userspace need to detect
MMC cards it should use udev like everyone else.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/mmc.c |  148 ++++------------------------------------------
 1 files changed, 13 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index de1ac9a..8bb4ef4 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -13,11 +13,6 @@
 #include <linux/device.h>
 #include <linux/amba/bus.h>
 #include <linux/mmc/host.h>
-#include <linux/input.h>
-#include <linux/workqueue.h>
-#include <linux/delay.h>
-#include <linux/regulator/consumer.h>
-#include <linux/regulator/machine.h>
 #include <linux/gpio.h>
 #include <linux/amba/mmci.h>
 #include <linux/slab.h>
@@ -25,137 +20,27 @@
 #include "mmc.h"
 #include "padmux.h"
 
-struct mmci_card_event {
-	struct input_dev *mmc_input;
-	int mmc_inserted;
-	struct work_struct workq;
-	struct mmci_platform_data mmc0_plat_data;
+static struct mmci_platform_data mmc0_plat_data = {
+	/*
+	 * Do not set ocr_mask or voltage translation function,
+	 * we have a regulator we can control instead.
+	 */
+	/* Nominally 2.85V on our platform */
+	.f_max = 24000000,
+	.gpio_wp = -1,
+	.gpio_cd = U300_GPIO_PIN_MMC_CD,
+	.cd_invert = true,
+	.capabilities = MMC_CAP_MMC_HIGHSPEED |
+	MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 };
 
-static unsigned int mmc_status(struct device *dev)
-{
-	struct mmci_card_event *mmci_card = container_of(
-		dev->platform_data,
-		struct mmci_card_event, mmc0_plat_data);
-
-	return mmci_card->mmc_inserted;
-}
-
-static int mmci_callback(void *data)
-{
-	struct mmci_card_event *mmci_card = data;
-
-	disable_irq_on_gpio_pin(U300_GPIO_PIN_MMC_CD);
-	schedule_work(&mmci_card->workq);
-
-	return 0;
-}
-
-
-static ssize_t gpio_show(struct device *dev, struct device_attribute *attr,
-		  char *buf)
-{
-	struct mmci_card_event *mmci_card = container_of(
-		dev->platform_data,
-		struct mmci_card_event, mmc0_plat_data);
-
-
-	return sprintf(buf, "%d\n", !mmci_card->mmc_inserted);
-}
-
-static DEVICE_ATTR(mmc_inserted, S_IRUGO, gpio_show, NULL);
-
-static void _mmci_callback(struct work_struct *ws)
-{
-
-	struct mmci_card_event *mmci_card = container_of(
-		ws,
-		struct mmci_card_event, workq);
-
-	mdelay(20);
-
-	mmci_card->mmc_inserted = !gpio_get_value(U300_GPIO_PIN_MMC_CD);
-
-	input_report_switch(mmci_card->mmc_input, KEY_INSERT,
-			    mmci_card->mmc_inserted);
-	input_sync(mmci_card->mmc_input);
-
-	pr_debug("MMC/SD card was %s\n",
-		 mmci_card->mmc_inserted ? "inserted" : "removed");
-
-	enable_irq_on_gpio_pin(U300_GPIO_PIN_MMC_CD, mmci_card->mmc_inserted);
-}
-
 int __devinit mmc_init(struct amba_device *adev)
 {
-	struct mmci_card_event *mmci_card;
 	struct device *mmcsd_device = &adev->dev;
 	struct pmx *pmx;
 	int ret = 0;
 
-	mmci_card = kzalloc(sizeof(struct mmci_card_event), GFP_KERNEL);
-	if (!mmci_card)
-		return -ENOMEM;
-
-	/*
-	 * Do not set ocr_mask or voltage translation function,
-	 * we have a regulator we can control instead.
-	 */
-	/* Nominally 2.85V on our platform */
-	mmci_card->mmc0_plat_data.f_max = 24000000;
-	mmci_card->mmc0_plat_data.status = mmc_status;
-	mmci_card->mmc0_plat_data.gpio_wp = -1;
-	mmci_card->mmc0_plat_data.gpio_cd = -1;
-	mmci_card->mmc0_plat_data.capabilities = MMC_CAP_MMC_HIGHSPEED |
-		MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-
-	mmcsd_device->platform_data = (void *) &mmci_card->mmc0_plat_data;
-
-	INIT_WORK(&mmci_card->workq, _mmci_callback);
-
-	ret = gpio_request(U300_GPIO_PIN_MMC_CD, "MMC card detection");
-	if (ret) {
-		printk(KERN_CRIT "Could not allocate MMC card detection " \
-		       "GPIO pin\n");
-		goto out;
-	}
-
-	ret = gpio_direction_input(U300_GPIO_PIN_MMC_CD);
-	if (ret) {
-		printk(KERN_CRIT "Invalid GPIO pin requested\n");
-		goto out;
-	}
-
-	ret = sysfs_create_file(&mmcsd_device->kobj,
-			       &dev_attr_mmc_inserted.attr);
-	if (ret)
-		goto out;
-
-	mmci_card->mmc_input = input_allocate_device();
-	if (!mmci_card->mmc_input) {
-		printk(KERN_CRIT "Could not allocate MMC input device\n");
-		return -ENOMEM;
-	}
-
-	mmci_card->mmc_input->name = "MMC insert notification";
-	mmci_card->mmc_input->id.bustype = BUS_HOST;
-	mmci_card->mmc_input->id.vendor = 0;
-	mmci_card->mmc_input->id.product = 0;
-	mmci_card->mmc_input->id.version = 0x0100;
-	mmci_card->mmc_input->dev.parent = mmcsd_device;
-	input_set_capability(mmci_card->mmc_input, EV_SW, KEY_INSERT);
-
-	/*
-	 * Since this must always be compiled into the kernel, this input
-	 * is never unregistered or free:ed.
-	 */
-	ret = input_register_device(mmci_card->mmc_input);
-	if (ret) {
-		input_free_device(mmci_card->mmc_input);
-		goto out;
-	}
-
-	input_set_drvdata(mmci_card->mmc_input, mmci_card);
+	mmcsd_device->platform_data = &mmc0_plat_data;
 
 	/*
 	 * Setup padmuxing for MMC. Since this must always be
@@ -171,12 +56,5 @@ int __devinit mmc_init(struct amba_device *adev)
 			pr_warning("Could not activate padmuxing\n");
 	}
 
-	ret = gpio_register_callback(U300_GPIO_PIN_MMC_CD, mmci_callback,
-				     mmci_card);
-
-	schedule_work(&mmci_card->workq);
-
-	printk(KERN_INFO "Registered MMC insert/remove notification\n");
-out:
 	return ret;
 }
-- 
1.7.3.2
