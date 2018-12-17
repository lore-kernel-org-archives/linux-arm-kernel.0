Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E778C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:07:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20465217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qWeVjNh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20465217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1KuG+I55CxGhjBVNEAo0XwN74t3VXenoC25LC+J2UV4=; b=qWeVjNh4PCWFB3
	4BqJQ5kCbaYTUnW/pnMyad6R3kuNuLT0SNsAHy9Mqnxs02wV159fkrTRwd5H7qgNiEodemLvSkYRB
	8k+VJjCr48HKyLLJ9qzlXqEfKEFWg9QigLzZ0t8WPJai+HxPbjH1nYSz25MiIXl7ZWV00QqMOrS7j
	atkpox1w9GFWptKGxHWxmmctThMecnJOdJABk5Ke9GmXq31aWZAcIm+iIPu+4oGQ/cCOpWIi1Tqxr
	GWLk37RlfUs9UFrU0IL6wZeDZ/jT9Ws5samxKMLWHXq0OGRWy6rVhMXds1Oc9rkTmT+nTC/8BHzEz
	xQ8SAVbXdyzM6B2lB/AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkBX-000237-Tm; Mon, 17 Dec 2018 04:07:15 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9v-0000FS-9X
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:44 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 703B85FD96; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 07/15] Bluetooth: hci_bcm: Use "txco" and "extclk" to get
 clock reference
Date: Mon, 17 Dec 2018 12:04:41 +0800
Message-Id: <20181217040449.31437-8-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_200536_062986_DB6FB24E 
X-CRM114-Status: GOOD (  18.97  )
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
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Loic Poulain <loic.poulain@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Originally the device tree binding only specified one clock reference,
with the name "extclk". The driver simply retrieves the clock without
bothering to specify a name.

Since we added a second clock to the binding, we need to fetch the
clocks by name now. First we try the new name "txco", then fall back
to the old name "extclk", and finally try retrieving a clock without
using any name, to cover any instances where a bad device tree or
firmware worked by accident.

In the last case, we should take care that we don't get the same
clock twice when we add support for the "lpo" clock.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ff73ecb8215f..1584c95c9c34 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -71,8 +71,8 @@
  * @btlp: Apple ACPI method to toggle BT_WAKE pin ("Bluetooth Low Power")
  * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("Bluetooth Power Up")
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
- * @clk: clock used by Bluetooth device
- * @clk_enabled: whether @clk is prepared and enabled
+ * @txco_clk: external reference frequency clock used by Bluetooth device
+ * @clk_enabled: whether @txco_clk is prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
  *	the host UART is initially set to this baudrate so that
  *	it can configure the Bluetooth device for @oper_speed
@@ -102,7 +102,7 @@ struct bcm_device {
 	int			gpio_int_idx;
 #endif
 
-	struct clk		*clk;
+	struct clk		*txco_clk;
 	bool			clk_enabled;
 
 	u32			init_speed;
@@ -215,7 +215,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	int err;
 
 	if (powered && !dev->clk_enabled) {
-		err = clk_prepare_enable(dev->clk);
+		err = clk_prepare_enable(dev->txco_clk);
 		if (err)
 			return err;
 	}
@@ -229,7 +229,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 		goto err_revert_shutdown;
 
 	if (!powered && dev->clk_enabled)
-		clk_disable_unprepare(dev->clk);
+		clk_disable_unprepare(dev->txco_clk);
 
 	dev->clk_enabled = powered;
 
@@ -239,7 +239,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	dev->set_shutdown(dev, !powered);
 err_clk_disable:
 	if (powered && !dev->clk_enabled)
-		clk_disable_unprepare(dev->clk);
+		clk_disable_unprepare(dev->txco_clk);
 	return err;
 }
 
@@ -896,6 +896,25 @@ static int bcm_gpio_set_shutdown(struct bcm_device *dev, bool powered)
 	return 0;
 }
 
+/* Try a bunch of names for TXCO */
+static struct clk *bcm_get_txco(struct device *dev)
+{
+	struct clk *clk;
+
+	/* New explicit name */
+	clk = devm_clk_get(dev, "txco");
+	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		return clk;
+
+	/* Deprecated name */
+	clk = devm_clk_get(dev, "extclk");
+	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		return clk;
+
+	/* Original code used no name at all */
+	return devm_clk_get(dev, NULL);
+}
+
 static int bcm_get_resources(struct bcm_device *dev)
 {
 	const struct dmi_system_id *dmi_id;
@@ -905,15 +924,15 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (x86_apple_machine && !bcm_apple_get_resources(dev))
 		return 0;
 
-	dev->clk = devm_clk_get(dev->dev, NULL);
+	dev->txco_clk = bcm_get_txco(dev->dev);
 
 	/* Handle deferred probing */
-	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
-		return PTR_ERR(dev->clk);
+	if (dev->txco_clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->txco_clk);
 
 	/* Ignore all other errors as before */
-	if (IS_ERR(dev->clk))
-		dev->clk = NULL;
+	if (IS_ERR(dev->txco_clk))
+		dev->txco_clk = NULL;
 
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
