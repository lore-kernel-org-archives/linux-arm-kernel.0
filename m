Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DAFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DCE20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d0qYW/YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DCE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1+g6y33MV5pn2WSg/HO2a1c0KjivJhKqayty/OCtAFc=; b=d0qYW/YUGtjYTO
	wSM1j6LAWjWadlSYf/9Q4Lx7lvEaltwn2q+88m3Z2coWTnh+gueVWvOpTsxvzCoYf1oH/cwKVVqdg
	hloItBLmcSH+flrbmOnYP9NVoA1YhAlu8xPqDIxhVNqLpRglrevSJoAsB/5ZYRigfeVZLITylVwpZ
	Pw74vIXi6n4jRrzCM0xZDl/eCHsviZ72a1scn3aDXewSchazencGo+Fj6gMN0v12rpwWIhyJMWsC7
	AUkKBJ9jMUv8l6vmdQsKhUjcCwMHgmTwClJbi/I5gTi8OgADrdOjd9WNkKm6C4aDiF0w8Yh27Dalx
	Md6i9X42+xYVBKyfzCKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvh4-0002h4-TA; Tue, 08 Jan 2019 18:01:38 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvea-0007Jy-1G
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:59:29 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 3E597100054;
 Tue,  8 Jan 2019 18:59:02 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id P-TEw3pTDBCz; Tue,  8 Jan 2019 18:58:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id A8B8E10004D;
 Tue,  8 Jan 2019 18:58:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CbEBF0mmHepZ; Tue,  8 Jan 2019 18:58:29 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 4A5CFFFF78;
 Tue,  8 Jan 2019 18:58:26 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>,
 platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 12/15] power: supply: olpc_battery: Move priv data to a
 struct
Date: Tue,  8 Jan 2019 18:58:15 +0100
Message-Id: <20190108175818.705110-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_095905_506334_6AE1A023 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, x86@kernel.org,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The global variables for private data are not too nice. I'd like some
more, and that would clutter the global name space even further.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
Changes since v2:
- Bring the allocaton of the priv data structure here

Changes since v1:
- Split out the move to devm_* into a separate patch

 drivers/power/supply/olpc_battery.c | 73 ++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 5323987d9284..c024aae01cb1 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -53,6 +53,12 @@
 
 #define BAT_ADDR_MFR_TYPE	0x5F
 
+struct olpc_battery_data {
+	struct power_supply *olpc_ac;
+	struct power_supply *olpc_bat;
+	char bat_serial[17];
+};
+
 /*********************************************************************
  *		Power
  *********************************************************************/
@@ -91,11 +97,8 @@ static const struct power_supply_desc olpc_ac_desc = {
 	.get_property = olpc_ac_get_prop,
 };
 
-static struct power_supply *olpc_ac;
-
-static char bat_serial[17]; /* Ick */
-
-static int olpc_bat_get_status(union power_supply_propval *val, uint8_t ec_byte)
+static int olpc_bat_get_status(struct olpc_battery_data *data,
+		union power_supply_propval *val, uint8_t ec_byte)
 {
 	if (olpc_platform_info.ecver > 0x44) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
@@ -326,6 +329,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
 				 enum power_supply_property psp,
 				 union power_supply_propval *val)
 {
+	struct olpc_battery_data *data = power_supply_get_drvdata(psy);
 	int ret = 0;
 	__be16 ec_word;
 	uint8_t ec_byte;
@@ -347,7 +351,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = olpc_bat_get_status(val, ec_byte);
+		ret = olpc_bat_get_status(data, val, ec_byte);
 		if (ret)
 			return ret;
 		break;
@@ -450,8 +454,8 @@ static int olpc_bat_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		sprintf(bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
-		val->strval = bat_serial;
+		sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
+		val->strval = data->bat_serial;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		ret = olpc_bat_get_voltage_max_design(val);
@@ -579,17 +583,17 @@ static struct power_supply_desc olpc_bat_desc = {
 	.use_for_apm = 1,
 };
 
-static struct power_supply *olpc_bat;
-
 static int olpc_battery_suspend(struct platform_device *pdev,
 				pm_message_t state)
 {
-	if (device_may_wakeup(&olpc_ac->dev))
+	struct olpc_battery_data *data = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&data->olpc_ac->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_ACPWR);
 	else
 		olpc_ec_wakeup_clear(EC_SCI_SRC_ACPWR);
 
-	if (device_may_wakeup(&olpc_bat->dev))
+	if (device_may_wakeup(&data->olpc_bat->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_BATTERY | EC_SCI_SRC_BATSOC
 				   | EC_SCI_SRC_BATERR);
 	else
@@ -601,9 +605,15 @@ static int olpc_battery_suspend(struct platform_device *pdev,
 
 static int olpc_battery_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct power_supply_config psy_cfg = {};
+	struct olpc_battery_data *data;
 	uint8_t status;
 
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, data);
+
 	/*
 	 * We've seen a number of EC protocol changes; this driver requires
 	 * the latest EC protocol, supported by 0x44 and above.
@@ -620,9 +630,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
 
 	/* Ignore the status. It doesn't actually matter */
 
-	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
-	if (IS_ERR(olpc_ac))
-		return PTR_ERR(olpc_ac);
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = data;
+
+	data->olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, &psy_cfg);
+	if (IS_ERR(data->olpc_ac))
+		return PTR_ERR(data->olpc_ac);
+
 	if (of_property_match_string(pdev->dev.of_node, "compatible",
 					"olpc,xo1.5-battery") >= 0) {
 		/* XO-1.5 */
@@ -634,42 +648,45 @@ static int olpc_battery_probe(struct platform_device *pdev)
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
 
-	olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
+	data->olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
 	if (IS_ERR(olpc_bat)) {
 		ret = PTR_ERR(olpc_bat);
 		goto battery_failed;
 	}
 
-	ret = device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
+	ret = device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	if (ret)
 		goto eeprom_failed;
 
-	ret = device_create_file(&olpc_bat->dev, &olpc_bat_error);
+	ret = device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
 	if (ret)
 		goto error_failed;
 
 	if (olpc_ec_wakeup_available()) {
-		device_set_wakeup_capable(&olpc_ac->dev, true);
-		device_set_wakeup_capable(&olpc_bat->dev, true);
+		device_set_wakeup_capable(&data->olpc_ac->dev, true);
+		device_set_wakeup_capable(&data->olpc_bat->dev, true);
 	}
 
 	return 0;
 
 error_failed:
-	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
+	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 eeprom_failed:
-	power_supply_unregister(olpc_bat);
+	power_supply_unregister(data->olpc_bat);
 battery_failed:
-	power_supply_unregister(olpc_ac);
+	power_supply_unregister(data->olpc_ac);
 	return ret;
 }
 
 static int olpc_battery_remove(struct platform_device *pdev)
 {
-	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
-	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
-	power_supply_unregister(olpc_bat);
-	power_supply_unregister(olpc_ac);
+	struct olpc_battery_data *data = platform_get_drvdata(pdev);
+
+	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
+	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
+	power_supply_unregister(data->olpc_bat);
+	power_supply_unregister(data->olpc_ac);
+
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
