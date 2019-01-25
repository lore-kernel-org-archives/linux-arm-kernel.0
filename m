Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB11C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:40:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E4C218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lr9uj66R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E4C218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bmMybbGTV0hLZZrnPRqf0X/Xbp/eKkLMw2bTPKMW0Dc=; b=lr9uj66Rmh+Nlo
	pgXBk0tUaDs1qv9tI01z2AWSKHbyQkVT6wjTYXOn+Dh7MJQZL8A3f/JC5A2izlNbNXQTt97WlpTUR
	pojuP6d4H2su4p52e9HofYBe91Yf9ymPiVsT4FSX20XY/+o+SXm7/0N2F3XykzEFKLA54QHADbchY
	3ERT335VsfxB3nwLIUtBbIr37/t8p2KYM7zfSfJ5lVSfK/eX0/8V/ZllbKOU9kFo3YjvQ1xp9gdbi
	70JBbaE10Nx3KryBIGnIvwB5QpP+iBbaOmIpcNnts4snPVS1IAA0n71Xf81WUSRNo+sE0+bB4r7sm
	GmP5cnu1RtTUlbf+yj3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyu7-0004wx-H3; Fri, 25 Jan 2019 10:40:07 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmytd-0004K2-N2
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:39:40 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5201520A18; Fri, 25 Jan 2019 11:39:36 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id DF2F8207AD;
 Fri, 25 Jan 2019 11:39:25 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 01/10] usb: core: comply to PHY framework
Date: Fri, 25 Jan 2019 11:39:15 +0100
Message-Id: <20190125103925.15753-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125103925.15753-1-miquel.raynal@bootlin.com>
References: <20190125103925.15753-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_023938_069282_476452A6 
X-CRM114-Status: GOOD (  14.87  )
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

Current implementation of the USB core does not take into account the
new PHY framework. Correct the situation by adding a call to
phy_set_mode() before phy_power_on().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/usb/core/hcd.c |  5 +++++
 drivers/usb/core/phy.c | 28 ++++++++++++++++++++++++++++
 drivers/usb/core/phy.h |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 015b126ce455..86f39e44f98a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2736,6 +2736,11 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		if (retval)
 			return retval;
 
+		retval = usb_phy_roothub_set_mode(hcd->phy_roothub,
+						  PHY_MODE_USB_HOST_SS);
+		if (retval)
+			goto err_usb_phy_roothub_power_on;
+
 		retval = usb_phy_roothub_power_on(hcd->phy_roothub);
 		if (retval)
 			goto err_usb_phy_roothub_power_on;
diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 38b2c776c4b4..7580493b867a 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -123,6 +123,34 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub)
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_exit);
 
+int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
+			     enum phy_mode mode)
+{
+	struct usb_phy_roothub *roothub_entry;
+	struct list_head *head;
+	int err;
+
+	if (!phy_roothub)
+		return 0;
+
+	head = &phy_roothub->list;
+
+	list_for_each_entry(roothub_entry, head, list) {
+		err = phy_set_mode(roothub_entry->phy, mode);
+		if (err)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	list_for_each_entry_continue_reverse(roothub_entry, head, list)
+		phy_power_off(roothub_entry->phy);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(usb_phy_roothub_set_mode);
+
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
 {
 	struct usb_phy_roothub *roothub_entry;
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index 88a3c037e9df..dad564e2d2d4 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -16,6 +16,8 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev);
 int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub);
 int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
 
+int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
+			     enum phy_mode mode);
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
 void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
