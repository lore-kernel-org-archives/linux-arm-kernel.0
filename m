Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D28C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:19:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2181F20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q2/W0o0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2181F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AUjQsFZ3L7yt1CYREwa2lbx3amprJL+qRM99IMeAcUI=; b=q2/W0o0NubCdp2
	TomdcC/vjPiznYHfmWhRg/QoRxd4ZuDOCVuh+PWwiw2ilAtVkEO/W7eaKtpTRsTblAjbzfC51uMu4
	V0uiWkWmopI97G38PUoj+3W+DpFLTzYlrNWyBYl0VpJsAjQVKOaLQEQoVghg8QPb4Pvoe3B24cNGM
	m+eff0lXfdIRsLAbsGnly5e7R2O9V/cbGOpJbC6zFHrdfcFitMbiNXQfMcGTpE0zTbqXfrPrEqm8t
	jrTbiuC9WaOOelKw+ZtYbnZOhJ0GKmtClnR/WOm2rU6eOWkW5fJSA6/5g8e0D9PxeQeEq2ahOsn8n
	ILwZHbZ9QLnG2ND95A3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkNJ-0007Em-2Q; Mon, 17 Dec 2018 04:19:25 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9v-0000F3-9m
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:44 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 693E15FD90; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 06/15] Bluetooth: hci_bcm: Simplify clk_get error handling
Date: Mon, 17 Dec 2018 12:04:40 +0800
Message-Id: <20181217040449.31437-7-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_200536_275515_7A94C6DC 
X-CRM114-Status: GOOD (  13.39  )
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

The driver currently checks the clk pointer for an error condition, as
returned by clk_get, before every invocation of the clk consumer API.
This is redundant if the goal is simply to ignore the errors, thereby
making the clk optional. The clk consumer API already checks if the
pointer is NULL or not.

Simplify the code a bit by assigning NULL to the clk pointer if the
error condition is one we want to ignore, which is every error except
deferred probing.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 800132369134..ff73ecb8215f 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -214,7 +214,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
 	int err;
 
-	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled) {
+	if (powered && !dev->clk_enabled) {
 		err = clk_prepare_enable(dev->clk);
 		if (err)
 			return err;
@@ -228,7 +228,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	if (err)
 		goto err_revert_shutdown;
 
-	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
+	if (!powered && dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
 
 	dev->clk_enabled = powered;
@@ -238,7 +238,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 err_revert_shutdown:
 	dev->set_shutdown(dev, !powered);
 err_clk_disable:
-	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
+	if (powered && !dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
 	return err;
 }
@@ -911,6 +911,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
 		return PTR_ERR(dev->clk);
 
+	/* Ignore all other errors as before */
+	if (IS_ERR(dev->clk))
+		dev->clk = NULL;
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
