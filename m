Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF82FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3D82083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CcH/bSZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3D82083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jCSBD6vd6gqqRy3lCdwzIBWeYQsmFLSBm4j5GAhh7U=; b=CcH/bSZ1o88NZC
	Fo8Uy3a+Lf+jVqoi0WGr12rvPyS1JN6Q1EsM4zv2a1wKLw3T1AGH9aTUqJ1H3GooF1zEONXblsRHf
	SL8rAvQZxNfST4zpqC4Of3W3XapcA/rMXgUatVyBWhoE9RNxBUdDRodfxHXY7fI89wR503Bx24YKo
	vc7WQUlSDY0OEn53ZU7k7BbEjDOcrb/YllVUUNi50bFuKPxwmN5buc4/XzQYjo15pIEKkXSXt0g2X
	RskuYKodpQWEwKEpVa29B6pYaRtvqCqiE2J0JLyzTSQT+60+j9niLwFr5/6Vj8iSyP9oB99mi+/vW
	jIX7K+r3rEmea8aODKRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyItd-0003uL-6f; Mon, 25 Feb 2019 16:14:25 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIta-0003sm-A6
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:14:23 +0000
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9D69CE001B;
 Mon, 25 Feb 2019 16:14:13 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 1/2] net: phy: marvell10g: Let
 genphy_c45_pma_read_abilities set Aneg bit
Date: Mon, 25 Feb 2019 17:14:06 +0100
Message-Id: <20190225161407.19510-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
References: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_081422_504556_AD759226 
X-CRM114-Status: UNSURE (   9.50  )
X-CRM114-Notice: Please train this message.
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
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The genphy_c45_pma_read_abilities helper now sets the Autoneg ability
in phydev->supported according to what the AN MMD reports.

We therefore don't need to manually do that in mv3310_get_features().

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/marvell10g.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 580e91deadbc..ab71da55c1e0 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -268,16 +268,6 @@ static int mv3310_get_features(struct phy_device *phydev)
 {
 	int ret, val;
 
-	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
-		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
-		if (val < 0)
-			return val;
-
-		if (val & MDIO_AN_STAT1_ABLE)
-			linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-					 phydev->supported);
-	}
-
 	ret = genphy_c45_pma_read_abilities(phydev);
 	if (ret)
 		return ret;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
