From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:59 +0000
Subject: [PATCH 28/35] mfd: ab8500-debug: Add ADC input channel usb_id in
 debugfs
In-Reply-To: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360933026-30325-29-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang QU <yang.qu@stericsson.com>

Signed-off-by: Yang QU <yang.qu@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Alexandre BOURDIOL <alexandre.bourdiol@stericsson.com>
Reviewed-by: Philippe LANGLAIS <philippe.langlais@stericsson.com>
Reviewed-by: Mattias WALLIN <mattias.wallin@stericsson.com>
---
 drivers/mfd/ab8500-debugfs.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index a301f10..ae8660a 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1705,6 +1705,35 @@ static const struct file_operations ab8500_gpadc_die_temp_fops = {
 	.owner = THIS_MODULE,
 };
 
+static int ab8500_gpadc_usb_id_print(struct seq_file *s, void *p)
+{
+	int usb_id_raw;
+	int usb_id_convert;
+	struct ab8500_gpadc *gpadc;
+
+	gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
+	usb_id_raw = ab8500_gpadc_read_raw(gpadc, USB_ID,
+		avg_sample, trig_edge, trig_timer, conv_type);
+	usb_id_convert = ab8500_gpadc_ad_to_voltage(gpadc, USB_ID,
+		usb_id_raw);
+
+	return seq_printf(s, "%d,0x%X\n",
+			usb_id_convert, usb_id_raw);
+}
+
+static int ab8500_gpadc_usb_id_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ab8500_gpadc_usb_id_print, inode->i_private);
+}
+
+static const struct file_operations ab8500_gpadc_usb_id_fops = {
+	.open = ab8500_gpadc_usb_id_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static int ab8540_gpadc_xtal_temp_print(struct seq_file *s, void *p)
 {
 	int xtal_temp_raw;
@@ -2711,6 +2740,12 @@ static int ab8500_debug_probe(struct platform_device *plf)
 	    ab8500_gpadc_dir, &plf->dev, &ab8500_gpadc_die_temp_fops);
 	if (!file)
 		goto err;
+
+	file = debugfs_create_file("usb_id", (S_IRUGO | S_IWUGO),
+	    ab8500_gpadc_dir, &plf->dev, &ab8500_gpadc_usb_id_fops);
+	if (!file)
+		goto err;
+
 	if (is_ab8540(ab8500)) {
 		file = debugfs_create_file("xtal_temp", (S_IRUGO | S_IWUGO),
 		    ab8500_gpadc_dir, &plf->dev, &ab8540_gpadc_xtal_temp_fops);
-- 
1.7.10.4
