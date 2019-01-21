Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D7C7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:24:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E2720663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RPwIQ5gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E2720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p5VB+b01xMz7Dm7vVZol8G+N8JDrjcD85AE2SG2qWhI=; b=RPwIQ5gh45Xa9y
	FVtkwO9q3rNmnrtjQCB5W7FAVHtKfv3nJlum+bPz3hyUsxZBQd15HMMe94Plt44DW9TtjsvY+s1It
	J3jxi7Nf6tA4NqbVapiPLxR63bHYhRHxPw0MlP/hmuXVRS28G4PDNfn3PaQDZUrvYr5NhQrHRwkxD
	dRJfybAi33Nmjel0RDMVwCcQWh38LUAyRg1yXgsdBC++z0pcp2CTJj41Ah4vVDQ8Z43AjCl6/bciC
	ny9FLIt145byVksGsxjVhtkJjf9UKfZRiKq0TXUPYUkUxdXXrTXQqRnQDV2mAORCRXh/ISQzd1+sD
	+aSPx+cx9R3luowjKJOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXgp-0001zy-2i; Mon, 21 Jan 2019 11:24:27 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXg3-0001GP-TX
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:23:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 91BEB209EF; Mon, 21 Jan 2019 12:23:38 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1EE74206A7;
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
Subject: [PATCH v3 02/10] usb: host: xhci: mvebu: add reset on resume quirk
Date: Mon, 21 Jan 2019 12:23:28 +0100
Message-Id: <20190121112336.23489-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121112336.23489-1-miquel.raynal@bootlin.com>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_032340_218880_3799F115 
X-CRM114-Status: GOOD (  19.30  )
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
 Miquel Raynal <miquel.raynal@bootlin.com>, Ofer Heifetz <oferh@marvell.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ofer Heifetz <oferh@marvell.com>

The mvebu xHCI host driver does not have suspend/resume support. Use of
the XHCI_RESET_ON_RESUME quirk is mandatory in order to avoid failures
after resume. This will work only if no USB device is plugged-in.

While at it, mention in the Kconfig file that this IP is also present
on the A3700 SoC.

Signed-off-by: Ofer Heifetz <oferh@marvell.com>
[miquel.raynal@bootlin.com: Reword the commit message]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/usb/host/Kconfig      |  4 ++--
 drivers/usb/host/xhci-mvebu.c | 11 +++++++++++
 drivers/usb/host/xhci-mvebu.h |  6 ++++++
 drivers/usb/host/xhci-plat.c  |  7 +++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 16758b12a5e9..3a32f5e45840 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -69,13 +69,13 @@ config USB_XHCI_MTK
 	  If unsure, say N.
 
 config USB_XHCI_MVEBU
-	tristate "xHCI support for Marvell Armada 375/38x"
+	tristate "xHCI support for Marvell Armada 375/38x/37xx"
 	select USB_XHCI_PLATFORM
 	depends on HAS_IOMEM
 	depends on ARCH_MVEBU || COMPILE_TEST
 	---help---
 	  Say 'Y' to enable the support for the xHCI host controller
-	  found in Marvell Armada 375/38x ARM SOCs.
+	  found in Marvell Armada 375/38x/37xx ARM SOCs.
 
 config USB_XHCI_RCAR
 	tristate "xHCI support for Renesas R-Car SoCs"
diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 32e158568788..60651a50770f 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -13,6 +13,7 @@
 #include <linux/usb/hcd.h>
 
 #include "xhci-mvebu.h"
+#include "xhci.h"
 
 #define USB3_MAX_WINDOWS	4
 #define USB3_WIN_CTRL(w)	(0x0 + ((w) * 8))
@@ -72,3 +73,13 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 
 	return 0;
 }
+
+int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	/* Without reset on resume, the HC won't work at all */
+	xhci->quirks |= XHCI_RESET_ON_RESUME;
+
+	return 0;
+}
diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
index 09791df2cec0..ca0a3a5721dd 100644
--- a/drivers/usb/host/xhci-mvebu.h
+++ b/drivers/usb/host/xhci-mvebu.h
@@ -12,10 +12,16 @@ struct usb_hcd;
 
 #if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
 int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd);
+int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd);
 #else
 static inline int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 {
 	return 0;
 }
+
+static inline int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
+{
+	return 0;
+}
 #endif
 #endif /* __LINUX_XHCI_MVEBU_H */
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index ef09cb06212f..0ac4ec975547 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -98,6 +98,10 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
 	.init_quirk = xhci_mvebu_mbus_init_quirk,
 };
 
+static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
+	.init_quirk = xhci_mvebu_a3700_init_quirk,
+};
+
 static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
 	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
 	.init_quirk = xhci_rcar_init_quirk,
@@ -123,6 +127,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "marvell,armada-380-xhci",
 		.data = &xhci_plat_marvell_armada,
+	}, {
+		.compatible = "marvell,armada3700-xhci",
+		.data = &xhci_plat_marvell_armada3700,
 	}, {
 		.compatible = "renesas,xhci-r8a7790",
 		.data = &xhci_plat_renesas_rcar_gen2,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
