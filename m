Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95935C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606512087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LEBZdmgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606512087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IJzWYdRihbcvsEcfpJrUIrqUO7PR6puXo7vqQ65v+Uw=; b=LEBZdmgFc5b6Cm
	WpFKgUZdhJ9Hs/7tFdJsgNtG//mlzJMhK0wa5PzoY3B7Qsf3ruivQbppmoHs/c2XBvI5QvyQdqhVX
	UEahCCp+YIC08I1y2afS8zT9185CqK4/U8KTYpgI3GaAsi+hXltTTLI4E7NNx+j9DcAWY1gfWTjwq
	WBIeVPi3pa18kyvbIwWjoSfpZIsghqu+7MQFA1mdczYC2fbtAvygwq8GyMkGT3mET0rcptbKFs4sv
	LZzrwUvKOLwvNRCENqDj9BYsLEfntXwyLNCUezCXFsckmnSP8mT+vpGb2qDHfR3ewt64q9w3egFBr
	Dl/ReRn7dXwl/jk43oXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy70G-0000Pu-Br; Mon, 25 Feb 2019 03:32:28 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy6zF-0007cO-Cr
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 03:31:26 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 542F35FE47; Mon, 25 Feb 2019 11:31:16 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 5/9] power: supply: axp20x_usb_power: add function to get
 max current
Date: Mon, 25 Feb 2019 11:31:03 +0800
Message-Id: <20190225033107.17326-6-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225033107.17326-1-wens@csie.org>
References: <20190225033107.17326-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_193125_585877_953FFD50 
X-CRM114-Status: GOOD (  12.97  )
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
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

To prepare for a new PMIC, factor out the code responsible of returning
the maximum current to axp20x_get_current_max.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 52 ++++++++++++++-----------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index ac061bcdc056..90d06027bf98 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -102,6 +102,35 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	return false;
 }
 
+static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
+	case AXP20X_VBUS_CLIMIT_100mA:
+		if (power->axp20x_id == AXP221_ID)
+			*val = -1; /* No 100mA limit */
+		else
+			*val = 100000;
+		break;
+	case AXP20X_VBUS_CLIMIT_500mA:
+		*val = 500000;
+		break;
+	case AXP20X_VBUS_CLIMIT_900mA:
+		*val = 900000;
+		break;
+	case AXP20X_VBUS_CLIMIT_NONE:
+		*val = -1;
+		break;
+	}
+
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -140,28 +169,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
-		if (ret)
-			return ret;
-
-		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-		case AXP20X_VBUS_CLIMIT_100mA:
-			if (power->axp20x_id == AXP221_ID)
-				val->intval = -1; /* No 100mA limit */
-			else
-				val->intval = 100000;
-			break;
-		case AXP20X_VBUS_CLIMIT_500mA:
-			val->intval = 500000;
-			break;
-		case AXP20X_VBUS_CLIMIT_900mA:
-			val->intval = 900000;
-			break;
-		case AXP20X_VBUS_CLIMIT_NONE:
-			val->intval = -1;
-			break;
-		}
-		return 0;
+		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
 			ret = iio_read_channel_processed(power->vbus_i,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
