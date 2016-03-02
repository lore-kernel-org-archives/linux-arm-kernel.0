From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Mar 2016 15:32:00 +0000
Subject: [RESEND 02/11] pwm: sysfs: Add PWM Capture support
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1456932729-9667-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow a user to read PWM Capture results from /sysfs. First,
the user must tell PWM Capture which channel they wish to
read from:

  $ echo 2 > $PWMCHIP/capture

To start a capture and read the result, simply read the file:

  $ cat $PWMCHIP/capture

The output format is left to the device.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9c90886..3572ef4 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -23,6 +23,8 @@
 #include <linux/kdev_t.h>
 #include <linux/pwm.h>
 
+static int capture_channel;
+
 struct pwm_export {
 	struct device child;
 	struct pwm_device *pwm;
@@ -167,16 +169,42 @@ static ssize_t polarity_store(struct device *child,
 	return ret ? : size;
 }
 
+static ssize_t capture_show(struct device *child,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+
+	return pwm_capture(pwm, capture_channel, buf);
+}
+
+static ssize_t capture_store(struct device *child,
+			     struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	capture_channel = val;
+
+	return size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
+static DEVICE_ATTR_RW(capture);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
 	&dev_attr_duty_cycle.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
+	&dev_attr_capture.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
-- 
1.9.1
