Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF616C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDEC213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rPmaj8bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDEC213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SU8whBPmm4nHV/bf8sGh0TLSJn7U7OPsnVJHfTGvT4s=; b=rPmaj8botdWR+x
	ldZcfcfsXWKAA0WaFQOOhj5CTqKSghFebsPSRbPDse2O5RwVUzQofeVBZ3htEtGDQi8OjCG0o2iE/
	TiPScmsJc9fKi9ro4APIZo2zw3iB6KRd6LY/2o+5LQwoTK9SwhQD4EibsiwSdy8PMUK1iF3Ujul8z
	s0+84l/geIXYtuQCjR3bNyl+P10iR6ud1/uSA7sJkKtz5BZZNymaFFILBtJcMRyN6vQeErUoIUv/c
	x9UwXN4QrzdKUwrPyEvONvJjBIiIXkl0i6HJDl4r8ALSnP/dYTSggFa69vP3u1u5eGUDWY++8U9Ag
	Y2gSC0HR66fkQ3jqt3aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy6zm-0008Bb-HV; Mon, 25 Feb 2019 03:31:58 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy6zC-0007ap-Ow
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 03:31:25 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 4E62A5FE0C; Mon, 25 Feb 2019 11:31:16 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 4/9] power: supply: axp20x_usb_power: use polling to detect
 vbus status change
Date: Mon, 25 Feb 2019 11:31:02 +0800
Message-Id: <20190225033107.17326-5-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225033107.17326-1-wens@csie.org>
References: <20190225033107.17326-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_193123_090924_ED596F4F 
X-CRM114-Status: GOOD (  16.09  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>,
 linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On AXP221 and later AXP PMICs that have the N_VBUSEN pin, when this pin
is high, either due to the PMIC driving it high or as an input, the VBUS
detection related interrupt mechanisms are disabled.

Previously this was worked around in the phy-sun4i-usb driver, which
needed to sense VBUS changes and report them to the musb driver in a
timely matter. However this workaround was only for the A31 and A33 type
USB PHYs. To support newer platforms we would have to enable it for
almost all the post-A31 SoCs.

However, since this is actually the result of the PMIC's behavior, the
workaround would be better if done in the PMIC driver, in this case the
VBUS power supply driver.

Add the same workqueue-based polling to the VBUS power supply driver.
The polling interval is chosen to be the debounce interval from the USB
PHY driver, as this short interval is needed in some cases, but the
power supply driver would not know when.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index e2f353906bb1..ac061bcdc056 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -24,6 +24,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/iio/consumer.h>
+#include <linux/workqueue.h>
 
 #define DRVNAME "axp20x-usb-power-supply"
 
@@ -46,6 +47,12 @@
 
 #define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
 
+/*
+ * Note do not raise the debounce time, we must report Vusb high within
+ * 100ms otherwise we get Vbus errors in musb.
+ */
+#define DEBOUNCE_TIME			msecs_to_jiffies(50)
+
 struct axp20x_usb_power {
 	struct device_node *np;
 	struct regmap *regmap;
@@ -53,6 +60,8 @@ struct axp20x_usb_power {
 	enum axp20x_variants axp20x_id;
 	struct iio_channel *vbus_v;
 	struct iio_channel *vbus_i;
+	struct delayed_work vbus_detect;
+	unsigned int old_status;
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -64,6 +73,35 @@ static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static void axp20x_usb_power_poll_vbus(struct work_struct *work)
+{
+	struct axp20x_usb_power *power =
+		container_of(work, struct axp20x_usb_power, vbus_detect.work);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &val);
+	if (ret)
+		goto out;
+
+	val &= (AXP20X_PWR_STATUS_VBUS_PRESENT | AXP20X_PWR_STATUS_VBUS_USED);
+	if (val != power->old_status)
+		power_supply_changed(power->supply);
+
+	power->old_status = val;
+
+out:
+	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+}
+
+static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
+{
+	if (power->axp20x_id >= AXP221_ID)
+		return true;
+
+	return false;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -362,6 +400,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (!power)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, power);
 	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
 								&pdev->dev);
 
@@ -420,6 +459,19 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 				 irq_names[i], ret);
 	}
 
+	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
+	if (axp20x_usb_vbus_needs_polling(power))
+		queue_delayed_work(system_wq, &power->vbus_detect, 0);
+
+	return 0;
+}
+
+static int axp20x_usb_power_remove(struct platform_device *pdev)
+{
+	struct axp20x_usb_power *power = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&power->vbus_detect);
+
 	return 0;
 }
 
@@ -439,6 +491,7 @@ MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
 
 static struct platform_driver axp20x_usb_power_driver = {
 	.probe = axp20x_usb_power_probe,
+	.remove = axp20x_usb_power_remove,
 	.driver = {
 		.name = DRVNAME,
 		.of_match_table = axp20x_usb_power_match,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
