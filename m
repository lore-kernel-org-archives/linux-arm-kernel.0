From: simon@sequanux.org (Simon Guinot)
Date: Thu,  7 Oct 2010 16:35:40 +0200
Subject: [PATCH] leds: leds-ns2: fix private driver data storage
Message-ID: <1286462140-16253-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

dev_set_drvdata() can't be used to set the driver private data pointer.
This would overwrite the led classdev object previously registered by
led_classdev_register().

Note that despite this mistake, the driver work fine because led_dat and
led_dat->cdev are at the same memory address.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 drivers/leds/leds-ns2.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index 350eb34..f77d48d 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -141,10 +141,12 @@ static ssize_t ns2_led_sata_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buff, size_t count)
 {
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct ns2_led_data *led_dat =
+		container_of(led_cdev, struct ns2_led_data, cdev);
 	int ret;
 	unsigned long enable;
 	enum ns2_led_modes mode;
-	struct ns2_led_data *led_dat = dev_get_drvdata(dev);
 
 	ret = strict_strtoul(buff, 10, &enable);
 	if (ret < 0)
@@ -172,7 +174,9 @@ static ssize_t ns2_led_sata_store(struct device *dev,
 static ssize_t ns2_led_sata_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct ns2_led_data *led_dat = dev_get_drvdata(dev);
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct ns2_led_data *led_dat =
+		container_of(led_cdev, struct ns2_led_data, cdev);
 
 	return sprintf(buf, "%d\n", led_dat->sata);
 }
@@ -234,7 +238,6 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	if (ret < 0)
 		goto err_free_slow;
 
-	dev_set_drvdata(led_dat->cdev.dev, led_dat);
 	ret = device_create_file(led_dat->cdev.dev, &dev_attr_sata);
 	if (ret < 0)
 		goto err_free_cdev;
-- 
1.6.3.1
