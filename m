Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F64C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0132070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BidR3HuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0132070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qbJ15EV7EzqzzwknHcCy/buYZGMe+nWla6GWNrYEf3M=; b=BidR3HuEiCU84N
	sz+Qd9QAKwbzzxmds2ie6GiWFRx19NOnVkv3E/HJv6U+2Be32uPM79/wlgLPfufPwW9YTK53EW6Cw
	MC5YMSTrpK5ilm5ZADp68F3p8Z5QjnKCjl8UZj9/fIFrQMaWlu6rEHax0y6oNbGGcOx9PRH77e25v
	+WA+hHGxvpr25CGVk8KLqyqDoemknDsEwQYaF3Ag84ADpZKoHMKNHdfML1qRqnH1WWeOrKU8faSo/
	A+kWzjuDYPiNWG1pyAcGJGPyyMFlGB2M7XDwczjVvJdV1lxIdstBwdYCQQpnkO1z/9emZYujYU30n
	3wRiIZLwlE4UHZy8CrhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKOT-0002Ei-T2; Fri, 22 Feb 2019 23:38:13 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKOI-000239-7D
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:38:04 +0000
X-Originating-IP: 86.201.231.99
Received: from mc-bl-xps13.lan (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr
 [86.201.231.99])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1F5606000D;
 Fri, 22 Feb 2019 23:37:52 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next v2 1/7] net: phy: marvell10g: Use get_features to get
 the PHY abilities
Date: Sat, 23 Feb 2019 00:37:38 +0100
Message-Id: <20190222233744.25735-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_153802_413027_6237386F 
X-CRM114-Status: GOOD (  12.38  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev@vger.kernel.org, gregory.clement@bootlin.com,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 Russell King <linux@armlinux.org.uk>, stefanc@marvell.com,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Alaska family of 10G PHYs has more abilities than the ones listed in
PHY_10GBIT_FULL_FEATURES, the exact list depending on the model.

Make use of the newly introduced .get_features call to build this list,
using genphy_c45_pma_read_abilities to build the list of supported
linkmodes, and adding autoneg ability based on what's reported by the AN
MMD.

.config_init is still used to validate the interface_mode.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

V2: Added missing blank line

 drivers/net/phy/marvell10g.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 586ae1bc5a50..89920b10d75b 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -233,8 +233,6 @@ static int mv3310_resume(struct phy_device *phydev)
 
 static int mv3310_config_init(struct phy_device *phydev)
 {
-	int ret, val;
-
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
@@ -242,6 +240,13 @@ static int mv3310_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
 		return -ENODEV;
 
+	return 0;
+}
+
+static int mv3310_get_features(struct phy_device *phydev)
+{
+	int ret, val;
+
 	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
 		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
 		if (val < 0)
@@ -416,7 +421,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.phy_id		= 0x002b09aa,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x3310",
-		.features	= PHY_10GBIT_FEATURES,
+		.get_features	= mv3310_get_features,
 		.soft_reset	= gen10g_no_soft_reset,
 		.config_init	= mv3310_config_init,
 		.probe		= mv3310_probe,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
