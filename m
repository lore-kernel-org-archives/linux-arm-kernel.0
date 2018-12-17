Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF0DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:08:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91F4217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MyH7MhX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91F4217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sUt95wdmWiJ6jnOBBKL7VxKCTFlYycvkCJg3DMK6mHY=; b=MyH7MhX8tDeZNw
	hHnlMIpDwRHk/25ZGUguMwWnvvcxjbbnZ/GcwDb6RGiFb+Sgf5x/su4LheSRP1xDvfmaN3JHObtc6
	zEFq4Tatzt0sKcfMaUtK1nqsZDnRKhVmhT8nFNX3lCrZvsvOdq6IsJ48d75yCXUzqxNKZ5CCiULzb
	GyJNhBgCaf5lvZT7pHgNY3aD+l6wG5XeHBrCe6+OAF85KM2M9l2XoFoImyu2pcGcY4dsIT8Twrxn3
	TkqjpG1dsDU1172Grz+qtZgixUKxyeg1Xql9GWfm+wiXSbjwtMXWK2EnQnyeco6VrI4TUg7PpMA8c
	FbmD9cW5ROtT5fLi+T4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkCX-0002wU-Hz; Mon, 17 Dec 2018 04:08:17 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9v-0000F2-9k
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:46 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 7619C5FDA6; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 08/15] Bluetooth: hci_bcm: Add support for LPO clock
Date: Mon, 17 Dec 2018 12:04:42 +0800
Message-Id: <20181217040449.31437-9-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_200537_143176_DABAC696 
X-CRM114-Status: GOOD (  16.70  )
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

The Broadcom Bluetooth controllers support a secondary LPO clock at
32.768 kHz. This external clock provides low power timing, and also
a way to detect the frequency of the main reference clock. On many
designs without NVRAM and a non-default reference clock, this must
be used or the controller will not function correctly.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 41 ++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1584c95c9c34..345d728a5434 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -72,7 +72,8 @@
  * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("Bluetooth Power Up")
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
  * @txco_clk: external reference frequency clock used by Bluetooth device
- * @clk_enabled: whether @txco_clk is prepared and enabled
+ * @lpo_clk: external LPO clock used by Bluetooth device
+ * @clk_enabled: whether clocks are prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
  *	the host UART is initially set to this baudrate so that
  *	it can configure the Bluetooth device for @oper_speed
@@ -103,6 +104,7 @@ struct bcm_device {
 #endif
 
 	struct clk		*txco_clk;
+	struct clk		*lpo_clk;
 	bool			clk_enabled;
 
 	u32			init_speed;
@@ -215,21 +217,34 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	int err;
 
 	if (powered && !dev->clk_enabled) {
-		err = clk_prepare_enable(dev->txco_clk);
+		/* LPO clock needs to be 32.768 kHz */
+		err = clk_set_rate(dev->lpo_clk, 32768);
+		if (err) {
+			dev_err(dev->dev, "Could not set LPO clock rate\n");
+			return err;
+		}
+
+		err = clk_prepare_enable(dev->lpo_clk);
 		if (err)
 			return err;
+
+		err = clk_prepare_enable(dev->txco_clk);
+		if (err)
+			goto err_lpo_clk_disable;
 	}
 
 	err = dev->set_shutdown(dev, powered);
 	if (err)
-		goto err_clk_disable;
+		goto err_txco_clk_disable;
 
 	err = dev->set_device_wakeup(dev, powered);
 	if (err)
 		goto err_revert_shutdown;
 
-	if (!powered && dev->clk_enabled)
+	if (!powered && dev->clk_enabled) {
 		clk_disable_unprepare(dev->txco_clk);
+		clk_disable_unprepare(dev->lpo_clk);
+	}
 
 	dev->clk_enabled = powered;
 
@@ -237,9 +252,12 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 
 err_revert_shutdown:
 	dev->set_shutdown(dev, !powered);
-err_clk_disable:
+err_txco_clk_disable:
 	if (powered && !dev->clk_enabled)
 		clk_disable_unprepare(dev->txco_clk);
+err_lpo_clk_disable:
+	if (powered && !dev->clk_enabled)
+		clk_disable_unprepare(dev->lpo_clk);
 	return err;
 }
 
@@ -934,6 +952,19 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (IS_ERR(dev->txco_clk))
 		dev->txco_clk = NULL;
 
+	dev->lpo_clk = devm_clk_get(dev->dev, "lpo");
+	if (dev->lpo_clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->lpo_clk);
+
+	if (IS_ERR(dev->lpo_clk))
+		dev->lpo_clk = NULL;
+
+	/* Check if we accidentally fetched the lpo clock twice */
+	if (dev->lpo_clk && clk_is_match(dev->lpo_clk, dev->txco_clk)) {
+		devm_clk_put(dev->dev, dev->txco_clk);
+		dev->txco_clk = NULL;
+	}
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
