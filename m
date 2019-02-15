Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE646C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5D921929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nt15v09l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5D921929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hiATYBr55eOUAzMkXesSsl7c7oj7oBeazdqifxvLlXw=; b=nt15v09lBBkJQJ2VbRZTTADA8X
	Y81eeGWU5P8NQxYG4Fq6I2x841m5oH3vmd51X1QBePV0qGanGt5+ro32D5N3pZK+OqvpMZ02NY5lI
	63GAHkFs64KtCMvd/EmkSZAwoOhB1YEurB6iKC2xHizsbY6B+V/r4bxV3fDnx8yvoVY1Z0Q1eEpoG
	IXQ7g3o6Ns2jpyraiP0rH2agh45Xl9odSg5PvsZ85bODsrPg2O5c6XF8zQW6SO21oXs7hVX5AhY+9
	idrsEr4iU0900NMlnPdmRjiDNX5CBt3wPwVc2RSMQde+b/iL8sf21PsMkQPyo1STuWTPOad0NJx0H
	GfwuKhFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guc1c-0007xG-K9; Fri, 15 Feb 2019 11:51:24 +0000
Received: from olimex.com ([2001:470:0:1f2::b869:4820])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guc1B-0007OV-Mw
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 11:51:07 +0000
Received: from localhost.localdomain ([195.238.85.143])
 by olimex.com with ESMTPSA
 (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD)
 (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 15 Feb 2019 03:50:42 -0800
From: Stefan Mavrodiev <stefan@olimex.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Lee Jones <lee.jones@linaro.org>,
 linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), 
 linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE
 DRIVERS), 
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC
 support)
Subject: [PATCH v2 2/8] mfd: axp20x: Add axp20x-led cell
Date: Fri, 15 Feb 2019 13:50:07 +0200
Message-Id: <20190215115013.11098-3-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215115013.11098-1-stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_035058_168195_28301527 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: Stefan Mavrodiev <stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add axp20x-led cell for AXP20x, AXP221, AXP223, AXP228, AXP803, AXP809
and AXP813.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/mfd/axp20x.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3c97f2c0fdfe..e6ab078f0462 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -610,6 +610,9 @@ static const struct mfd_cell axp20x_cells[] = {
 		.of_compatible	= "x-powers,axp202-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_usb_power_supply_resources),
 		.resources	= axp20x_usb_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -636,6 +639,9 @@ static const struct mfd_cell axp221_cells[] = {
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
 		.resources	= axp22x_usb_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -662,6 +668,9 @@ static const struct mfd_cell axp223_cells[] = {
 		.of_compatible	= "x-powers,axp223-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
 		.resources	= axp22x_usb_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -719,6 +728,9 @@ static const struct mfd_cell axp288_cells[] = {
 		.resources	= axp288_power_button_resources,
 	}, {
 		.name		= "axp288_pmic_acpi",
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -741,8 +753,12 @@ static const struct mfd_cell axp803_cells[] = {
 		.of_compatible	= "x-powers,axp813-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
+	}, {
+		.name		= "axp20x-regulator"
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
-	{	.name		= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
@@ -769,6 +785,9 @@ static const struct mfd_cell axp809_cells[] = {
 	}, {
 		.id		= 1,
 		.name		= "axp20x-regulator",
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -793,6 +812,9 @@ static const struct mfd_cell axp813_cells[] = {
 		.of_compatible	= "x-powers,axp813-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
