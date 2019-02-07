Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B8920823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WBc2DaYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B8920823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yDMYn3/Aqg7MNX7r9UwCdKRUs40sUFHCVN4g2Y/9JpE=; b=WBc2DaYqQB+D/D
	y6ol6zxJ4YkmcKc0fe16BS1/OPuAfQ2Sq09t1YMBVKdsZ3R8mG6danNjE1XDlGKHdd9QlIN/4unYV
	b4Kd7Nb0+p4cHlX91fzlUgB/xDexHlGtttdB/EPbQgL687+yTBu9pV3OOiAXsdSMtOic8iboyK21L
	TuWTj/yeKQ1o66UbAQXHPKehacF+cTQcD8RsBeOhHGT5bDuE2O4LqoSps/tAxwWe0ejCNUqqj7tLJ
	RZXdI6YQoWV5a3bmU9RepFXWO/fPwhrnLhJopelwtaCJtrpe+w+wuWG4AD7t4k/QREPKj1ov+smM5
	2DJ0FiERe5oqJho5aZAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgMM-0000XQ-2E; Thu, 07 Feb 2019 09:52:42 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgK5-0006FI-U6
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:50:31 +0000
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id E4A13100022;
 Thu,  7 Feb 2019 09:50:17 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next v2 08/10] net: phy: marvell10g: Force reading of
 2.5/5G
Date: Thu,  7 Feb 2019 10:49:37 +0100
Message-Id: <20190207094939.27369-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_015022_214134_4BFD34DE 
X-CRM114-Status: GOOD (  13.42  )
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

As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
whether or not we should read register (1.21) "2.52/5G PMA Extended
Abilities", which contains information on the support of 2.5GBASET and
5GBASET.

After testing on several variants of PHYS of this family, it appears
that bit 14 in (1.11) isn't always set when it should be.

PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
but don't have 1.11.14 set. Their register 1.21 is filled with the
correct values, indicating 2.5G and 5G support.

PHYs 88E2110 do have their 1.11.14 bit set, as it should.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1 -> V2: Use the PMA device id to identify which devices need this
	  quirk, based on Andrew's idea.

 drivers/net/phy/marvell10g.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 581b4b6e31e9..2593db608af7 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -232,6 +232,23 @@ static int mv3310_resume(struct phy_device *phydev)
 	return mv3310_hwmon_config(phydev, true);
 }
 
+/* Some PHYs in the Alaska family such as the 88X3310 and the 88E2010
+ * don't set bit 14 in PMA Extended Abilities (1.11), although they do
+ * support 2.5GBASET and 5GBASET. For these models, we can still read their
+ * 2.5G/5G extended abilities register (1.21). We detect these models based on
+ * the PMA device identifier, with a mask matching models known to have this
+ * issue
+ */
+static bool mv3310_has_pma_ngbaset_quirk(struct phy_device *phydev)
+{
+	if (!(phydev->c45_ids.devices_in_package & MDIO_DEVS_PMAPMD))
+		return false;
+
+	/* Only some revisions of the 88X3310 family PMA seem to be impacted */
+	return (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] & 0xfffffffe) ==
+	       (MARVELL_PHY_ID_88X3310 & 0xfffffffe);
+}
+
 static int mv3310_config_init(struct phy_device *phydev)
 {
 	int ret, val;
@@ -261,6 +278,20 @@ static int mv3310_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	if (mv3310_has_pma_ngbaset_quirk(phydev)) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   MDIO_PMA_NG_EXTABLE);
+		if (val < 0)
+			return val;
+
+		if (val & MDIO_PMA_NG_EXTABLE_2_5GBT)
+			__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				  phydev->supported);
+		if (val & MDIO_PMA_NG_EXTABLE_5GBT)
+			__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				  phydev->supported);
+	}
+
 	return 0;
 }
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
