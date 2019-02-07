Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7A9C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A66520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M2+SfsR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A66520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OFTdkmI9JV7qv62HbCboVSor7pv5flwydD0tQCpCOtM=; b=M2+SfsR1i/xDNY
	jIyfxeXoU+eVKB52UkIywc7MBSfzTCy/wEi91nKFOqqAsN6PM0Ql1zSMQji8Sdj7jQ2t4GHrxrwg8
	3A8iHtgqrxc1rwDPIm5eX1Y36R5k33CLXNv+iZir5djg2Fmyuq7HKZf9r39qLBvZQlEkH+pWTHOQ/
	jjcudn4ucdeuhtAtCbNlEDk0+Lg7kve7WkgYM5kDEb3XvJbq7DSg3ZItqBZCmgzmlKqL0Gwpp88//
	FlB9JVDmah6Y2PH9+vXThVBbQ06vblgSq5/8zYcoVq/wh8rv3BNdiIOeS9hM0d5JOG0UExmLhdGjS
	LhfJyQjrwrAfkzXoazhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgLz-000084-B4; Thu, 07 Feb 2019 09:52:19 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgJu-0005Qw-5u
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:50:19 +0000
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id AAB41100003;
 Thu,  7 Feb 2019 09:50:05 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next v2 04/10] net: phy: Automatically fill the generic TP,
 FIBRE and Backplane modes
Date: Thu,  7 Feb 2019 10:49:33 +0100
Message-Id: <20190207094939.27369-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_015010_914843_9B41804B 
X-CRM114-Status: GOOD (  14.17  )
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

PHY advertised and supported linkmodes contain both specific modes such
as 1000BASET Half/Full and generic ones such as TP that represent a
class of modes.

Since some modes such as Fibre, TP or Backplane match a wide range of
specific modes, we can automatically set these bits if one of the
specific modes it corresponds to is present in the list.

The 'TP' bit is set whenever there's a BaseT linkmode in
phydev->supported.

The 'FIBRE' bit is set for BaseL, BaseS and BaseE linkmodes.

Finally, the 'Backplane' is set whenever a BaseK mode is supported.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 67 +++++++++++++++++++++++++++++++++++-
 include/linux/linkmode.h     |  6 ++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a4cbc5a6f09d..942cfa7548c4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1066,15 +1066,80 @@ static int phy_poll_reset(struct phy_device *phydev)
  * straightforward to maintain, since PHYs and MACs are subject to quirks and
  * erratas. This function re-builds the list of the supported pause parameters
  * by taking into account the parameters expressed in the driver's features
- * list.
+ * list. It also sets the generic bits indicating Twisted Pair, Fibre and
+ * Backaplane link modes support based on the detailed list that can be built
+ * from the PHY's ability list.
  */
 static void phy_update_linkmodes(struct phy_device *phydev)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_baset_features) = { 0, };
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_fibre_features) = { 0, };
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_backplane_features) = { 0, };
 	struct device_driver *drv = phydev->mdio.dev.driver;
 	struct phy_driver *phydrv = to_phy_driver(drv);
 
+	const int phy_baset_features_array[] = {
+		ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+		ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+		ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+		ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+	};
+
+	const int phy_fibre_features_array[] = {
+		ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
+		ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
+		ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT,
+		ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT,
+		ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+		ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+		ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+		ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseER_Full_BIT,
+	};
+
+	const int phy_backplane_features_array[] = {
+		ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+		ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT,
+		ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+		ETHTOOL_LINK_MODE_56000baseKR4_Full_BIT,
+		ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+		ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+		ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+	};
+
+	linkmode_set_bit_array(phy_baset_features_array,
+			       ARRAY_SIZE(phy_baset_features_array),
+			       phy_baset_features);
+
+	linkmode_set_bit_array(phy_fibre_features_array,
+			       ARRAY_SIZE(phy_fibre_features_array),
+			       phy_fibre_features);
+
+	linkmode_set_bit_array(phy_backplane_features_array,
+			       ARRAY_SIZE(phy_backplane_features_array),
+			       phy_backplane_features);
+
 	mutex_lock(&phydev->lock);
 
+	if (linkmode_intersects(phydev->supported, phy_baset_features))
+		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+
+	if (linkmode_intersects(phydev->supported, phy_fibre_features))
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 phydev->supported);
+
+	if (linkmode_intersects(phydev->supported, phy_backplane_features))
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Backplane_BIT,
+				 phydev->supported);
+
 	/* The Pause Frame bits indicate that the PHY can support passing
 	 * pause frames. During autonegotiation, the PHYs will determine if
 	 * they should allow pause frames to pass.  The MAC driver should then
diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index a99c58866860..49ab6415e1e0 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -82,4 +82,10 @@ static inline int linkmode_equal(const unsigned long *src1,
 	return bitmap_equal(src1, src2, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
+static inline bool linkmode_intersects(const unsigned long *src1,
+				       const unsigned long *src2)
+{
+	return bitmap_intersects(src1, src2, __ETHTOOL_LINK_MODE_MASK_NBITS);
+}
+
 #endif /* __LINKMODE_H */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
