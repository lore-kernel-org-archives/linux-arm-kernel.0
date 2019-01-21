Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F1CC7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:25:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3783B20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WI2KHSta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3783B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZU2B7KAHHwD1JVqJWpnMuVz6xxOnVgix1iho7ezh0cA=; b=WI2KHStay5xOgh
	hE1hdH77ZADORs8ljPFfkOEf8uB4baEroG+HY1TRIcEjZ1To+9uxwbJKXv1DmRPyf1rzmpATyP8zX
	GS0su7plUQFMocjAH/XefRuMl6z7L7wUI9P2tvBSceOWLi5Lx4VfAzpsGvQbj+bRR6+u2FUrv115c
	PxlwuQ3t1eECaJ9Ul9nETYYg/u+oMaCB/KC6PX6eZmyc2csy1aGQn4JFlrXhVasn1rB0JLDkeCYBW
	PtrVvej/GBkiQivsgpn+u3r8RmCeRTMnmFkcCrZ/Ea59fcYznAjSAbEDcHfY4dCpEBeWZZ+/LBxAf
	ZjwHM+E92Ttj4vLF0onw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXi6-0004U5-KM; Mon, 21 Jan 2019 11:25:46 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXg4-0001Gd-9K
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:23:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id ECCA320A2E; Mon, 21 Jan 2019 12:23:38 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8339D206DC;
 Mon, 21 Jan 2019 12:23:38 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 03/10] usb: ehci-orion: avoid double PHY initialization
Date: Mon, 21 Jan 2019 12:23:29 +0100
Message-Id: <20190121112336.23489-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121112336.23489-1-miquel.raynal@bootlin.com>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_032340_454651_B8D7B78A 
X-CRM114-Status: GOOD (  14.67  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 linux-usb@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

No need to initialize the PHY from the driver's probe. It is done by
the core automatically and doing it twice would increment the
phy->powercount counter to 2 instead of 1. During later suspend
operation, the counter will be decremented to one, no phy->power_off()
will occur and worse than that, the following phy->power_on() at
resume time will also be skipped, failing the whole S2RAM operation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/usb/host/ehci-orion.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 1ad72647a069..3109f082949e 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -257,15 +257,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->phy)) {
 		err = PTR_ERR(priv->phy);
 		if (err != -ENOSYS)
-			goto err_phy_get;
-	} else {
-		err = phy_init(priv->phy);
-		if (err)
-			goto err_phy_init;
-
-		err = phy_power_on(priv->phy);
-		if (err)
-			goto err_phy_power_on;
+			goto err_dis_clk;
 	}
 
 	/*
@@ -297,19 +289,12 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err)
-		goto err_add_hcd;
+		goto err_dis_clk;
 
 	device_wakeup_enable(hcd->self.controller);
 	return 0;
 
-err_add_hcd:
-	if (!IS_ERR(priv->phy))
-		phy_power_off(priv->phy);
-err_phy_power_on:
-	if (!IS_ERR(priv->phy))
-		phy_exit(priv->phy);
-err_phy_init:
-err_phy_get:
+err_dis_clk:
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
 	usb_put_hcd(hcd);
@@ -327,11 +312,6 @@ static int ehci_orion_drv_remove(struct platform_device *pdev)
 
 	usb_remove_hcd(hcd);
 
-	if (!IS_ERR(priv->phy)) {
-		phy_power_off(priv->phy);
-		phy_exit(priv->phy);
-	}
-
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
